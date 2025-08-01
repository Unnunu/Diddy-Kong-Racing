#include "weather.h"
#include "asset_loading.h"
#include "audio.h"
#include "audio_spatial.h"
#include "camera.h"
#include "common.h"
#include "f3ddkr.h"
#include "fade_transition.h"
#include "macros.h"
#include "math_util.h"
#include "objects.h"
#include "PRinternal/viint.h"
#include "structs.h"
#include "textures_sprites.h"
#include "tracks.h"
#include "types.h"
#include "video.h"

#define WEATHER_OVERRIDE_COUNT 16

/************ .data ************/

SnowGfxData gWeatherPresets[3] = {
    { 0, 0x40, { WEATHER_SNOW }, 0xFE000000, 0xFE000000, 0xFE000000, 0x03FFFFFF, 0x03FFFFFF, 0x03FFFFFF, 4, 4, 8, 8 },
    { 0, 0x100, { WEATHER_RAIN }, 0xFE000000, 0xFE000000, 0xFE000000, 0x03FFFFFF, 0x03FFFFFF, 0x03FFFFFF, 4, 4, 8, 8 },
    // Unused, game crashes with this.
    { 0, 0x08, { WEATHER_UNK }, 0xFE000000, 0xFE000000, 0xFE000000, 0x03FFFFFF, 0x03FFFFFF, 0x03FFFFFF, 4, 4, 8, 8 },
};

SnowPosData *gSnowPhysics = NULL;
SnowGfxData gSnowGfx = { NULL, 0, { NULL }, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

Vertex *gSnowVerts = NULL;
s32 gSnowVertCount = 0;
Triangle *gSnowTriangles = NULL;
s16 *gSnowTriIndices = NULL;
Vertex *gSnowVertexData[2] = { NULL, NULL };
s32 *gWeatherAssetTable = NULL;   // List of Ids
s32 gWeatherAssetTableLength = 0; // Set, but never read.

Gfx dLensFlare[] = {
    gsDPPipeSync(),
    gsDPSetCycleType(G_CYC_1CYCLE),
    gsDPSetTextureLOD(G_TL_TILE),
    gsDPSetTextureLUT(G_TT_NONE),
    gsDPSetTextureDetail(G_TD_CLAMP),
    gsDPSetTexturePersp(G_TP_NONE),
    gsDPSetTextureFilter(G_TF_BILERP),
    gsDPSetTextureConvert(G_TC_FILT),
    gsDPSetAlphaCompare(G_AC_NONE),
    gsDPSetRenderMode(G_RM_CLD_SURF, G_RM_CLD_SURF2),
    gsSPEndDisplayList(),
};

LensFlareData gLensPresetLarge[2] = { { 1, { { { 255, 255, 192, 144 } } }, 3.0f, 0.0f }, { NULL } };

LensFlareData gLensPreset1[4] = { { 3, { { { 255, 255, 0, 144 } } }, 0.75f, -32.0f },
                                  { 2, { { { 0, 80, 255, 96 } } }, 0.8f, -96.0f },
                                  { 2, { { { 0, 255, 0, 144 } } }, 0.75f, -192.0f },
                                  { NULL } };

LensFlareData gLensPreset2[5] = { { 3, { { { 255, 128, 20, 144 } } }, 0.65f, -64.0f },
                                  { 2, { { { 255, 255, 255, 144 } } }, 1.0f, -128.0f },
                                  { 3, { { { 255, 255, 128, 144 } } }, 0.5f, -176.0f },
                                  { 3, { { { 255, 40, 40, 144 } } }, 0.75f, -224.0f },
                                  { NULL } };

LensFlareData gLensPreset3[5] = { { 3, { { { 255, 128, 255, 128 } } }, 0.5f, -64.0f },
                                  { 1, { { { 255, 255, 192, 144 } } }, 0.75f, -128.0f },
                                  { 2, { { { 255, 40, 0, 128 } } }, 0.6f, -176.0f },
                                  { 1, { { { 255, 192, 255, 144 } } }, 0.75f, -224.0f },
                                  { NULL } };

Object *gLensFlare = NULL;
s32 gLensFlareOff = TRUE;
s32 gLensFlareOverrideObjs = 0;
Vec2f gRainQuad[4] = {
    { { { -200.0f, 200.0f } } },
    { { { 200.0f, 200.0f } } },
    { { { 200.0f, -200.0f } } },
    { { { -200.0f, -200.0f } } },
};

Vertex gRainVertices[16] = {
    { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 },
    { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 },
    { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 },
    { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 },
    { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 }, { 0, 0, 0, 255, 255, 255, 255 },
    { 0, 0, 0, 255, 255, 255, 255 },
};

RainPosData gRainSplashSegments[8] = {
    { { { { { 0, 0, 0 } } }, { 0 }, 1.0f, { { { { 0.0f, 0.0f, 0.0f } } } } }, 0, 0 },
    { { { { { 0, 0, 0 } } }, { 0 }, 1.0f, { { { { 0.0f, 0.0f, 0.0f } } } } }, 0, 0 },
    { { { { { 0, 0, 0 } } }, { 0 }, 1.0f, { { { { 0.0f, 0.0f, 0.0f } } } } }, 0, 0 },
    { { { { { 0, 0, 0 } } }, { 0 }, 1.0f, { { { { 0.0f, 0.0f, 0.0f } } } } }, 0, 0 },
    { { { { { 0, 0, 0 } } }, { 0 }, 1.0f, { { { { 0.0f, 0.0f, 0.0f } } } } }, 0, 0 },
    { { { { { 0, 0, 0 } } }, { 0 }, 1.0f, { { { { 0.0f, 0.0f, 0.0f } } } } }, 0, 0 },
    { { { { { 0, 0, 0 } } }, { 0 }, 1.0f, { { { { 0.0f, 0.0f, 0.0f } } } } }, 0, 0 },
    { { { { { 0, 0, 0 } } }, { 0 }, 1.0f, { { { { 0.0f, 0.0f, 0.0f } } } } }, 0, 0 },
};

RainGfxData gRainGfx[2] = {
    { 0, 0, 0x400, 0x400, 0x000A, 0xFFC4, NULL, 128, 255, 255, 128, 128, 255, 128 },
    { 0, 0, 0x600, 0x600, 0x0020, 0xFF40, NULL, 255, 255, 255, 0, 128, 255, 255 },
};

s32 gWeatherType = WEATHER_SNOW;
s32 gLightningFrequency = 0x10000;
s32 gLightningFrequencyStep = 0;
s32 gLightningFrequencyTarget = 0x10000;
s32 gRainOpacity = 0x10000;
s32 gRainOpacityStep = 0;
s32 gRainOpacityTarget = 0x10000;
s32 gRainHiddenTimer = 0;
s32 gLightningTimer = 0;
s32 gThunderTimer = 0;
s32 gRainSplashDelay = 0;
TextureHeader *gRainOverlayUnusedValue = NULL; // Set, but never read.
Sprite *gRainSplashGfx = NULL;
s32 gRainVertexFlip = 0;
AudioPoint *gWeatherSoundMask = NULL;

FadeTransition gThunderTransition = FADE_TRANSITION(FADE_FULLSCREEN, FADE_FLAG_INVERT, FADE_COLOR_WHITE, 5, 2);

/*******************************/

/************ .bss ************/

s32 gSnowDensity;
s32 gSnowParticleCount;
WeatherData gWeather;
SnowLimits gSnowPlane; // Uses negative values, so all distances will be checked in reverse.
s32 gSnowVertOffset;
s32 gSnowTriCount;
s32 gSnowVertexFlip;
Gfx *gCurrWeatherDisplayList;
Mtx *gCurrWeatherMatrix;
Vertex *gCurrWeatherVertexList;
Triangle *gCurrWeatherTriList;
Camera *gWeatherCamera;
MtxF *gWeatherCameraMatrix;
LensFlareData *gLensFlareSet1;
LensFlareData *gLensFlareSet2;
LensFlareData *gLensFlareLarge;
Vec3f gLensFlarePos;
Object *gLensFlareSwitches[WEATHER_OVERRIDE_COUNT];

/******************************/

/**
 * Zero out all the weather data.
 * Load the weather table into memory.
 * Official Name: initWeather
 */
void weather_init(void) {
    gSnowGfx.pos = NULL;
    gSnowGfx.size = 0;
    gSnowPhysics = NULL;
    gSnowDensity = 0;
    gSnowVertOffset = 6;
    gSnowVertOffset <<= 2;
    gSnowTriCount = gSnowVertOffset >> 1; // One triangle per two verts
    gSnowVertexData[0] = 0;
    gSnowVertexData[1] = 0;
    gSnowTriangles = 0;
    gSnowPlane.near = -1;
    gSnowPlane.far = -512;
    gLensFlare = NULL;
    gLensFlareOff = TRUE;
    gLensFlareOverrideObjs = 0;
    if (gWeatherAssetTable == NULL) {
        gWeatherAssetTable = (s32 *) asset_table_load(ASSET_WEATHER_PARTICLES);
        gWeatherAssetTableLength = 0;
        while ((s32) gWeatherAssetTable[gWeatherAssetTableLength] != -1) {
            gWeatherAssetTableLength++;
        }
    }
    gSnowVertexFlip = 0;
}

/**
 * Set the near and far culling distances for the weather effects.
 * Official Name: setWeatherLimits
 */
void weather_clip_planes(s16 near, s16 far) {
    if (gSnowPlane.far < gSnowPlane.near) {
        gSnowPlane.near = near;
        gSnowPlane.far = far;
    } else {
        gSnowPlane.near = far;
        gSnowPlane.far = near;
    }
}

#define FREE_MEM(mem)          \
    tempMem = (s32 *) mem;     \
    if (tempMem != NULL) {     \
        mempool_free(tempMem); \
        mem = NULL;            \
    }
#define FREE_TEX(tex)      \
    tempTex = tex;         \
    if (tempTex != NULL) { \
        tex_free(tempTex); \
        tex = NULL;        \
    }

/**
 * Free the weather assets from memory.
 * If it's raining, then free those too.
 * Official Name: freeWeather
 */
void weather_free(void) {
    TextureHeader *tempTex;
    s32 *tempMem;

    FREE_MEM(gSnowTriangles);
    FREE_MEM(gSnowVertexData[0]);
    FREE_MEM(gSnowVertexData[1]);
    FREE_MEM(gSnowPhysics);
    FREE_MEM(gSnowGfx.pos);
    FREE_TEX(gSnowGfx.texture);
    FREE_MEM(gSnowTriIndices);

    gLensFlareOverrideObjs = 0;
    gLensFlare = NULL;
    gLensFlareOff = TRUE;
    if (gWeatherType != WEATHER_SNOW) {
        free_rain_memory();
    }
}

/**
 * Free all existing weather data.
 * If the weather type allows rain, then allocate and initialise rain.
 * Afterwards, allocate and set the defaults for snow model data.
 */
void weather_reset(s32 weatherType, s32 density, s32 velX, s32 velY, s32 velZ, s32 intensity, s32 opacity) {
    s16 width;
    s16 height;
    s32 numOfElements;
    s32 allocSize;
    s32 i;
    s32 j;
    Vec3i *pos;

    weather_free();
    gWeather.velX = velX;
    gWeather.velXStep = 0;
    gWeather.velXTarget = velX;
    gWeather.velY = velY;
    gWeather.velYStep = 0;
    gWeather.velYTarget = velY;
    gWeather.velZStep = 0;
    gWeather.intensityStep = 0;
    gWeather.opacityStep = 0;
    gWeather.shiftTime = 0;
    gWeather.velZ = velZ;
    gWeather.velZTarget = velZ;
    gWeather.intensity = intensity;
    gWeather.intensityTarget = intensity;
    gWeather.opacity = opacity;
    gWeather.opacityTarget = opacity;
    if (weatherType > WEATHER_RAIN) {
        weatherType = WEATHER_RAIN;
    }
    if (gWeatherPresets[weatherType].type == WEATHER_RAIN) {
        rain_init(intensity + 1, opacity + 1);
        return;
    }
    pos = (Vec3i *) mempool_alloc_safe(gWeatherPresets[weatherType].size * (sizeof(Vec3i)), COLOUR_TAG_LIGHT_ORANGE);
    gSnowGfx.pos = pos;
    gSnowGfx.size = gWeatherPresets[weatherType].size;
    gSnowGfx.offsetX = gWeatherPresets[weatherType].offsetX;
    gSnowGfx.offsetY = gWeatherPresets[weatherType].offsetY;
    gSnowGfx.offsetZ = gWeatherPresets[weatherType].offsetZ;
    gSnowGfx.radiusX = gWeatherPresets[weatherType].radiusX;
    gSnowGfx.radiusY = gWeatherPresets[weatherType].radiusY;
    gSnowGfx.radiusZ = gWeatherPresets[weatherType].radiusZ;
    gSnowGfx.vertOffsetW = gWeatherPresets[weatherType].vertOffsetW;
    gSnowGfx.vertOffsetH = gWeatherPresets[weatherType].vertOffsetH;
    gSnowGfx.vertWidth = gSnowGfx.vertOffsetW * 2;
    gSnowGfx.vertHeight = gSnowGfx.vertOffsetH * 2;
    if (gWeatherPresets[weatherType].type == WEATHER_SNOW) {
        snow_init();
    }
    numOfElements = density;
    gSnowDensity = numOfElements;
    gSnowTriIndices = (s16 *) mempool_alloc_safe(numOfElements * (sizeof(s16)), COLOUR_TAG_LIGHT_ORANGE);
    gSnowPhysics = (SnowPosData *) mempool_alloc_safe(numOfElements * (sizeof(SnowPosData)), COLOUR_TAG_LIGHT_ORANGE);
    for (i = 0; i < gSnowDensity; i++) {
        gSnowPhysics[i].x_position = rand_range(0, gSnowGfx.radiusX);
        gSnowPhysics[i].y_position = rand_range(0, gSnowGfx.radiusY);
        gSnowPhysics[i].z_position = rand_range(0, gSnowGfx.radiusZ);
        gSnowPhysics[i].unused_C = 1 << (rand_range(0, 32) + 5);
        gSnowPhysics[i].unused_D = 1 << (rand_range(0, 32) + 5);
        gSnowPhysics[i].unused_E = 1 << (rand_range(0, 32) + 5);
        gSnowPhysics[i].index = rand_range(0, gSnowGfx.size - 1);
    }

    numOfElements = numOfElements * 4;
    allocSize = sizeof(Vertex);
    allocSize *= numOfElements;
    gSnowVertexData[0] = mempool_alloc_safe(allocSize, COLOUR_TAG_LIGHT_ORANGE);
    gSnowVertexData[1] = mempool_alloc_safe(allocSize, COLOUR_TAG_LIGHT_ORANGE);
    for (j = 0; j < 2; j++) {
        gSnowVerts = gSnowVertexData[j];
        for (i = 0; i < numOfElements; i++) {
            gSnowVerts[i].r = 255;
            gSnowVerts[i].g = 255;
            gSnowVerts[i].b = 255;
            gSnowVerts[i].a = 255;
        }
    }

    width = (gSnowGfx.texture->width << 5) - 1;
    height = (gSnowGfx.texture->height << 5) - 1;
    gSnowTriangles = (Triangle *) mempool_alloc_safe(gSnowTriCount * (sizeof(Triangle)), COLOUR_TAG_LIGHT_ORANGE);
    for (i = 0; i < gSnowTriCount; i += 2) {
        gSnowTriangles[i].flags = 0;
        gSnowTriangles[i].vi0 = (i << 1) + 3;
        gSnowTriangles[i].uv0.u = 0;
        gSnowTriangles[i].uv0.v = height;
        gSnowTriangles[i].vi1 = (i << 1) + 1;
        gSnowTriangles[i].uv1.u = width;
        gSnowTriangles[i].uv1.v = 0;
        gSnowTriangles[i].vi2 = (i << 1) + 0;
        gSnowTriangles[i].uv2.u = 0;
        gSnowTriangles[i].uv2.v = 0;
        gSnowTriangles[i + 1].flags = 0;
        gSnowTriangles[i + 1].vi0 = (i << 1) + 3;
        gSnowTriangles[i + 1].uv0.u = 0;
        gSnowTriangles[i + 1].uv0.v = height;
        gSnowTriangles[i + 1].vi1 = (i << 1) + 2;
        gSnowTriangles[i + 1].uv1.u = width;
        gSnowTriangles[i + 1].uv1.v = height;
        gSnowTriangles[i + 1].vi2 = (i << 1) + 1;
        gSnowTriangles[i + 1].uv2.u = width;
        gSnowTriangles[i + 1].uv2.v = 0;
    }

    gSnowVertexFlip = 0;
}

/**
 * Set the initial positions of all the snow particles by making a circle.
 * Load the snow texture into memory.
 */
void snow_init(void) {
    s32 step;
    s32 offset;
    s32 i;

    step = 0x10000 / gSnowGfx.size;
    offset = 0;

    for (i = 0; i < gSnowGfx.size; i++) {
        gSnowGfx.pos[i].x = coss_s16(offset & 0xFFFF) << 3;
        gSnowGfx.pos[i].y = 0xFFFC0000;
        gSnowGfx.pos[i].z = sins_s16(offset & 0xFFFF) << 1;
        offset += step;
    }

    gSnowGfx.texture = load_texture(*gWeatherAssetTable);
}

/**
 * Change the current properties of the weather.
 * Will start a timer that means it will gradually shift from the current to the new.
 * Official name: changeWeather
 */
void weather_set(s32 velX, s32 velY, s32 velZ, s32 intensity, s32 opacity, s32 time) {
    if (time > 0 && (velX != gWeather.velXTarget || velY != gWeather.velYTarget || velZ != gWeather.velZTarget ||
                     intensity != gWeather.intensity || opacity != gWeather.opacity)) {
        gWeather.velXTarget = velX;
        gWeather.velYTarget = velY;
        gWeather.velZTarget = velZ;
        gWeather.velXStep = (velX - gWeather.velX) / time;
        gWeather.velYStep = (velY - gWeather.velY) / time;
        gWeather.velZStep = (velZ - gWeather.velZ) / time;
        if (gWeatherType == WEATHER_SNOW) {
            gWeather.intensityStep = (intensity - gWeather.intensity) / time;
            gWeather.opacityStep = (opacity - gWeather.opacity) / time;
            gWeather.intensityTarget = intensity;
            gWeather.opacityTarget = opacity;
            gWeather.shiftTime = time;
        } else {
            gWeather.intensity = intensity;
            gWeather.opacity = opacity;
            gWeather.shiftTime = 0;
            rain_set(intensity + 1, opacity + 1, time / 60.0f);
        }
    }
}

/**
 * The root function for handling all weather.
 * Decide whether to perform rain or snow logic, execute it, then set it to render right after.
 */
void weather_update(Gfx **currDisplayList, Mtx **currHudMat, Vertex **currHudVerts, Triangle **currHudTris,
                    s32 updateRate) {
    UNUSED s32 unused;
    gCurrWeatherDisplayList = *currDisplayList;
    gCurrWeatherMatrix = *currHudMat;
    gCurrWeatherVertexList = *currHudVerts;
    gCurrWeatherTriList = *currHudTris;
    gWeatherCamera = cam_get_active_camera();
    gWeatherCameraMatrix = get_camera_matrix();
    if (gWeatherType != WEATHER_SNOW) {
        rain_update(updateRate);
    } else {
        if (gWeather.shiftTime > 0) {
            if (updateRate < gWeather.shiftTime) {
                gWeather.intensity += gWeather.intensityStep * updateRate;
                gWeather.velX += gWeather.velXStep * updateRate;
                gWeather.velY += gWeather.velYStep * updateRate;
                gWeather.velZ += gWeather.velZStep * updateRate;
                gWeather.opacity += gWeather.opacityStep * updateRate;
                gWeather.shiftTime -= updateRate;
            } else {
                gWeather.intensity = gWeather.intensityTarget;
                gWeather.velX = gWeather.velXTarget;
                gWeather.velY = gWeather.velYTarget;
                gWeather.velZ = gWeather.velZTarget;
                gWeather.opacity = gWeather.opacityTarget;
                gWeather.shiftTime = 0;
            }
        }
        gSnowParticleCount = (gSnowDensity * gWeather.intensity) >> (unused = 16);
        gSnowPlane.current =
            (gSnowPlane.near + ((gSnowPlane.far - gSnowPlane.near) * gWeather.opacity)) >> (unused = 16);

        snow_update(updateRate);
        if (gSnowParticleCount > 0 && gSnowPlane.current < gSnowPlane.near) {
            gSnowVerts = gSnowVertexData[gSnowVertexFlip];
            snow_vertices();
            snow_render();
            gSnowVertexFlip = 1 - gSnowVertexFlip;
        }
    }
    *currDisplayList = gCurrWeatherDisplayList;
    *currHudMat = gCurrWeatherMatrix;
    *currHudVerts = gCurrWeatherVertexList;
    *currHudTris = gCurrWeatherTriList;
}

/**
 * Update the positions of all the snow particles.
 * Make any far particles wrap around the boundaries.
 */
void snow_update(s32 updateRate) {
    Vec3i *snowPos;
    s32 i;

    for (i = 0; i < gSnowDensity; i++) {
        snowPos = &gSnowGfx.pos[gSnowPhysics[i].index];
        gSnowPhysics[i].x_position =
            ((((snowPos->x + (gWeather.velX * 2)) * updateRate) >> 1) + gSnowPhysics[i].x_position) & gSnowGfx.radiusX;
        gSnowPhysics[i].y_position =
            ((((snowPos->y + (gWeather.velY * 2)) * updateRate) >> 1) + gSnowPhysics[i].y_position) & gSnowGfx.radiusY;
        gSnowPhysics[i].z_position =
            ((((snowPos->z + (gWeather.velZ * 2)) * updateRate) >> 1) + gSnowPhysics[i].z_position) & gSnowGfx.radiusZ;
        gSnowPhysics[i].index++;
        if (gSnowPhysics[i].index >= gSnowGfx.size) {
            gSnowPhysics[i].index -= gSnowGfx.size;
        }
    }
}

/**
 * Update the position of each vertex for snow.
 * This starts from the camera position then
 */
void snow_vertices(void) {
    s16 pos[3];
    Vec3f posF;
    s32 i;
    Vertex *verts;
    s32 camX;
    s32 camy;
    s32 camz;

    camX = gWeatherCamera->trans.x_position * 65536.0f;
    camy = gWeatherCamera->trans.y_position * 65536.0f;
    camz = gWeatherCamera->trans.z_position * 65536.0f;
    gSnowVertCount = 0;
    verts = gSnowVerts;
    for (i = 0; i < gSnowParticleCount; i++) {
        posF.f[0] = (((gSnowPhysics[i].x_position - camX) & gSnowGfx.radiusX) + gSnowGfx.offsetX) * (1.0f / 65536.0f);
        posF.f[1] = (((gSnowPhysics[i].y_position - camy) & gSnowGfx.radiusY) + gSnowGfx.offsetY) * (1.0f / 65536.0f);
        posF.f[2] = (((gSnowPhysics[i].z_position - camz) & gSnowGfx.radiusZ) + gSnowGfx.offsetZ) * (1.0f / 65536.0f);
        mtxf_transform_dir(gWeatherCameraMatrix, &posF, &posF);
        pos[2] = posF.f[2];
        if (pos[2] < gSnowPlane.near && gSnowPlane.current < pos[2]) {
            pos[0] = posF.f[0];
            pos[1] = posF.f[1];
            verts[0].x = pos[0] - gSnowGfx.vertOffsetW;
            verts[0].y = pos[1] + gSnowGfx.vertOffsetH;
            verts[0].z = pos[2];
            verts[1].x = pos[0] + gSnowGfx.vertOffsetW;
            verts[1].y = pos[1] + gSnowGfx.vertOffsetH;
            verts[1].z = pos[2];
            verts[2].x = pos[0] + gSnowGfx.vertOffsetW;
            verts[2].y = pos[1] - gSnowGfx.vertOffsetH;
            verts[2].z = pos[2];
            verts[3].x = pos[0] - gSnowGfx.vertOffsetW;
            verts[3].y = pos[1] - gSnowGfx.vertOffsetH;
            verts[3].z = pos[2];
            verts += 4;
            gSnowVertCount += 4;
            gSnowTriIndices[gSnowVertCount >> 2] = i;
        }
    }
}

/**
 * Load and execute the draw commands for the falling snowflakes, seen with snowy weather enabled.
 */
void snow_render(void) {
    s32 i;
    Mtx *mtx;
    Vertex *vtx;

    if (gSnowGfx.texture != NULL) {
        gSnowVertOffset = 4;
        gSnowTriCount = 2;
        if (gSnowVertCount >= 4) {
            i = 0;
            mtx = get_projection_matrix_s16();
            gSPMatrixDKR(gCurrWeatherDisplayList++, OS_K0_TO_PHYSICAL(mtx), G_MTX_DKR_INDEX_0);
            gSPSelectMatrixDKR(gCurrWeatherDisplayList++, G_MTX_DKR_INDEX_0);
            material_set_no_tex_offset(&gCurrWeatherDisplayList, gSnowGfx.texture, RENDER_Z_COMPARE);
            while (i + gSnowVertOffset < gSnowVertCount) {
                vtx = &gSnowVerts[i];
                gSPVertexDKR(gCurrWeatherDisplayList++, OS_K0_TO_PHYSICAL(vtx), gSnowVertOffset, 0);
                gSPPolygon(gCurrWeatherDisplayList++, OS_K0_TO_PHYSICAL(gSnowTriangles), gSnowTriCount, 1);
                i += gSnowVertOffset;
            }
            vtx = &gSnowVerts[i];
            gSPVertexDKR(gCurrWeatherDisplayList++, OS_K0_TO_PHYSICAL(vtx), (gSnowVertCount - i), 0);
            gSPPolygon(gCurrWeatherDisplayList++, OS_K0_TO_PHYSICAL(gSnowTriangles), ((s32) (gSnowVertCount - i) >> 1),
                       1);
        }
    }
}

/**
 * Disable lens flare rendering.
 */
UNUSED void lensflare_off(void) {
    gLensFlareOff = TRUE;
}

/**
 * Enable lens flare rendering, if possible.
 */
UNUSED void lensflare_on(void) {
    if (gLensFlare != NULL) {
        gLensFlareOff = FALSE;
    }
}

/**
 * Removes the lens flare object from the weather system,
 * meaning it won't be seen anymore. Also disables lens flare rendering.
 */
void lensflare_remove(Object *obj) {
    if (obj == gLensFlare) {
        gLensFlare = NULL;
        gLensFlareOff = TRUE;
    }
}

/**
 * Sets the weather systems' lens flare object to this.
 * Afterwards, assigns presets based on the spawn parameters.
 * Finally, set the screenspace matrix position.
 */
void lensflare_init(Object *obj) {
    LevelObjectEntry_LensFlare *entry;
    Vec3s angle;

    gLensFlare = obj;
    gLensFlareOff = FALSE;
    entry = &gLensFlare->level_entry->lensFlare;

    switch (entry->set1) {
        default:
            gLensFlareSet1 = NULL;
            break;
        case 1:
            gLensFlareSet1 = gLensPreset1;
            break;
        case 2:
            gLensFlareSet1 = gLensPreset2;
            break;
        case 3:
            gLensFlareSet1 = gLensPreset3;
            break;
    }

    switch (entry->set2) {
        default:
            gLensFlareSet2 = NULL;
            break;
        case 1:
            gLensFlareSet2 = gLensPreset1;
            break;
        case 2:
            gLensFlareSet2 = gLensPreset2;
            break;
        case 3:
            gLensFlareSet2 = gLensPreset3;
            break;
    }

    if (entry->largeShine == 1) {
        gLensFlareLarge = gLensPresetLarge;
    } else {
        gLensFlareLarge = NULL;
    }

    angle.y_rotation = entry->angleY;
    angle.x_rotation = entry->angleX;
    angle.z_rotation = 0;
    gLensFlarePos.x = 0;
    gLensFlarePos.y = 0;
    gLensFlarePos.z = -1.0f;
    vec3f_rotate_py(&angle, &gLensFlarePos);
    gLensFlarePos.x = -gLensFlarePos.x;
    gLensFlarePos.y = -gLensFlarePos.y;
    gLensFlarePos.z = -gLensFlarePos.z;
}

/**
 * Based on face direction, start rendering lens flare effects on screen.
 * Each element is shifted based on the preset to create the effect of the sun shining in your face.
 */
void lensflare_render(Gfx **dList, Mtx **mats, Vertex **verts, Camera *camera) {
    u16 height;
    f32 mag2;
    UNUSED s32 pad;
    Vec3f pos[2];
    f32 magnitude;
    f32 magSquared;
    f32 magSquareSquared;
    LensFlareData *lensFlareData;
    ObjectTransform trans;
    Gfx *gfxTemp;
    s32 width;
    LevelObjectEntry_LensFlare *lensFlareEntry;
    s32 i;

    if (gLensFlare != NULL && gLensFlareOff == 0) {
        if (cam_get_viewport_layout() == 0) {
            lensFlareEntry = &gLensFlare->level_entry->lensFlare;
            pos[1].x = 0.0f;
            pos[1].y = 0.0f;
            pos[1].z = -1.0f;
            mtxf_transform_dir(get_projection_matrix_f32(), &pos[1], &pos[1]);
            magnitude = ((gLensFlarePos.x * pos[1].x) + (gLensFlarePos.y * pos[1].y)) + (gLensFlarePos.z * pos[1].z);
            if (magnitude > 0.0f) {
                viewport_main(dList, mats);
                mtx_world_origin(dList, mats);
                pos[0].x = (gLensFlarePos.x * 256.0f) + camera->trans.x_position;
                pos[0].y = (gLensFlarePos.y * 256.0f) + camera->trans.y_position;
                pos[0].z = (gLensFlarePos.z * 256.0f) + camera->trans.z_position;
                magSquared = magnitude * magnitude;
                magSquareSquared = magSquared * magSquared;
                trans.rotation.y_rotation = 0;
                trans.rotation.x_rotation = 0;
                trans.rotation.z_rotation = 0;
                pos[1].x = (pos[1].x * (0, (2 * magnitude))) - gLensFlarePos.x;
                pos[1].y = (pos[1].y * (0, (2 * magnitude))) - gLensFlarePos.y;
                pos[1].z = (pos[1].z * (0, (2 * magnitude))) - gLensFlarePos.z;
                for (i = 0; i < 3; i++) {
                    if (i == 0) {
                        lensFlareData = gLensFlareLarge;
                    } else if (i == 1) {
                        lensFlareData = gLensFlareSet1;
                    } else {
                        lensFlareData = gLensFlareSet2;
                    }
                    if (lensFlareData != NULL) {
                        while (lensFlareData->count > 0) {
                            trans.x_position = pos[0].x;
                            trans.y_position = pos[0].y;
                            trans.z_position = pos[0].z;
                            if (i != 0) {
                                trans.x_position = (lensFlareData->offset * pos[1].x) + pos[0].x;
                                trans.y_position = (lensFlareData->offset * pos[1].y) + pos[0].y;
                                trans.z_position = (lensFlareData->offset * pos[1].z) + pos[0].z;
                            }
                            trans.scale = lensFlareData->scale * magSquared;
                            gDPSetPrimColor((*dList)++, 0, 0, lensFlareData->colour.r, lensFlareData->colour.g,
                                            lensFlareData->colour.b,
                                            (s32) (lensFlareData->colour.a * magSquareSquared));
                            render_sprite_billboard(dList, mats, verts, (Object *) &trans,
                                                    gLensFlare->sprites[lensFlareData->count],
                                                    (RENDER_SEMI_TRANSPARENT | RENDER_Z_UPDATE));
                            lensFlareData++;
                        }
                    }
                    if (i == 1) {
                        mag2 = (((pos[1].x * gLensFlarePos.x) + (pos[1].y * gLensFlarePos.y)) +
                                (pos[1].z * ((0, gLensFlarePos.z)))) *
                               2;
                        pos[1].x = (mag2 * gLensFlarePos.x) - pos[1].x;
                        pos[1].y = (mag2 * gLensFlarePos.y) - pos[1].y;
                        pos[1].z = (mag2 * gLensFlarePos.z) - pos[1].z;
                    }
                }
                width = fb_size();
                height = GET_VIDEO_HEIGHT(width);
                width = GET_VIDEO_WIDTH(width);
                gfxTemp = (*dList);
                gSPDisplayList(gfxTemp++, dLensFlare);
                gDPSetPrimColor(gfxTemp++, 0, 0, lensFlareEntry->red, lensFlareEntry->green, lensFlareEntry->blue,
                                (s32) (lensFlareEntry->alpha * magSquareSquared));
                gDPSetCombineMode(gfxTemp++, G_CC_PRIMITIVE, G_CC_PRIMITIVE);
                gDPFillRectangle(gfxTemp++, 0, 0, width, height);
                gDPPipeSync(gfxTemp++);
                *dList = gfxTemp;
                rendermode_reset(dList);
            }
        }
    }
}

/**
 * Adds the new override object to the end of the list,
 * so the game can use it for applying overrides.
 */
void lensflare_override_add(Object *obj) {
    if (gLensFlareOverrideObjs < WEATHER_OVERRIDE_COUNT) {
        gLensFlareSwitches[gLensFlareOverrideObjs] = obj;
        gLensFlareOverrideObjs++;
    } else {
        stubbed_printf("\nMaximum limit of %d lens flare switches, per level, has been exceeded.",
                       WEATHER_OVERRIDE_COUNT);
    }
}

/**
 * Check if the lens flare switch object is registered.
 * If so, remove it from the list, then move any further objects forward to fill the gap.
 */
void lensflare_override_remove(Object *obj) {
    s32 i;
    s32 isFound = FALSE;

    for (i = 0; i < gLensFlareOverrideObjs && !isFound; i++) {
        if (gLensFlareSwitches[i] == obj) {
            isFound = TRUE;
        }
    }

    if (isFound) {
        gLensFlareOverrideObjs--;
        i--;
        for (; i < gLensFlareOverrideObjs; i++) {
            gLensFlareSwitches[i] = gLensFlareSwitches[i + 1];
        }
    }
}

/**
 * Check if the camera is inside the radius of a lens flare override.
 * If so, disable the lens flare effect while it remains inside.
 */
void lensflare_override(Camera *cameraSegment) {
    LevelObjectEntry_LensFlareSwitch *lensFlare;
    f32 xDiff;
    f32 zDiff;
    f32 yDiff;
    s32 i;

    gLensFlareOff = FALSE;
    if (gLensFlareOverrideObjs > 0 && gLensFlare != 0) {
        if (gLensFlareSwitches[0]) {} // Fakematch
        for (i = 0; i < gLensFlareOverrideObjs; i++) {
            xDiff = cameraSegment->trans.x_position - gLensFlareSwitches[i]->trans.x_position;
            yDiff = cameraSegment->trans.y_position - gLensFlareSwitches[i]->trans.y_position;
            zDiff = cameraSegment->trans.z_position - gLensFlareSwitches[i]->trans.z_position;
            lensFlare = &gLensFlareSwitches[i]->level_entry->lensFlareSwitch;
            if (sqrtf((xDiff * xDiff) + (yDiff * yDiff) + (zDiff * zDiff)) < lensFlare->radius) {
                gLensFlareOff = TRUE;
            }
        }
    }
}

/**
 * Set all rain related values to the default.
 * Load the overlay and splash textures then set the initial opacity and lightning frequency.
 */
void rain_init(s32 intensity, s32 opacity) {
    gLightningFrequency = intensity;
    gLightningFrequencyStep = 0;
    gLightningFrequencyTarget = gLightningFrequency;
    gRainOpacity = opacity;
    gRainOpacityStep = 0;
    gRainOpacityTarget = gRainOpacity;
    gRainHiddenTimer = 0;
    gLightningTimer = 0;
    gThunderTimer = 0;
    gRainSplashDelay = 0;
    gRainVertexFlip = 0;
    gRainGfx[0].tex = load_texture(gWeatherAssetTable[1]);
    gRainGfx[1].tex = load_texture(gWeatherAssetTable[1]);
    gRainSplashGfx = (Sprite *) tex_load_sprite(gWeatherAssetTable[3], 0);
    gWeatherType = WEATHER_RAIN;
}

/**
 * Free the rain overlay and splash asset data from memory.
 * Clear the soundmask too, stopping any ongoing audio.
 */
void free_rain_memory(void) {
    if (gRainGfx[0].tex != NULL) {
        tex_free(gRainGfx[0].tex);
        gRainOverlayUnusedValue = NULL;
    }

    if (gRainGfx[1].tex != NULL) {
        tex_free(gRainGfx[1].tex);
        gRainOverlayUnusedValue = NULL;
    }

    if (gRainSplashGfx != NULL) {
        sprite_free(gRainSplashGfx);
        gRainSplashGfx = NULL;
    }

    if (gWeatherSoundMask != NULL) {
        audspat_point_stop(gWeatherSoundMask);
        gWeatherSoundMask = NULL;
    }

    gWeatherType = WEATHER_SNOW;
}

/**
 * Sets the fade times for the rain visuals and how long to take to fade in.
 * The game will slowly ease into the intended values.
 */
void rain_set(s32 lightningFrequency, s32 opacity, f32 time) {
    gRainHiddenTimer = osTvType == OS_TV_TYPE_PAL ? 50.0 * time : 60.0 * time;
    gLightningFrequencyTarget = lightningFrequency;
    gLightningFrequencyStep = (gLightningFrequencyTarget - gLightningFrequency) / gRainHiddenTimer;
    gRainOpacityTarget = opacity;
    gRainOpacityStep = (gRainOpacityTarget - gRainOpacity) / gRainHiddenTimer;
}

/**
 * If it's currently raining, update the fog levels to match the intensity of the storm.
 * Official Name: rainSetFog
 */
void rain_fog(void) {
    s32 a, b;
    if (gWeatherType != WEATHER_SNOW && cam_get_viewport_layout() == VIEWPORT_LAYOUT_1_PLAYER) {
        a = ((gLightningFrequency * -38) >> 16) + 1018;
        b = ((gLightningFrequency * -20) >> 16) + 1023;
        set_fog(0, a, b, 28, 15, 36);
    }
}

/**
 * Set the current opacity of the rain overlay. Ranges from 0 - 0xFFFF.
 */
UNUSED void rain_opacity_set(s32 opacity) {
    gRainOpacity = opacity;
}

/**
 * When active, (Single player only) Call all the functions related to the behaviour and rendering of
 * rain, and if necessary, thunder.
 */
void rain_update(s32 updateRate) {
    s32 i;

    if (cam_get_viewport_layout() == VIEWPORT_LAYOUT_1_PLAYER && gWeatherType != WEATHER_SNOW) {
        if (gRainHiddenTimer > 0) {
            if (updateRate < gRainHiddenTimer) {
                gRainHiddenTimer -= updateRate;
                gLightningFrequency += gLightningFrequencyStep * updateRate;
                gRainOpacity += gRainOpacityStep * updateRate;
            } else {
                gRainHiddenTimer = 0;
                gLightningFrequency = gLightningFrequencyTarget;
                gRainOpacity = gRainOpacityTarget;
            }
        }
        rain_sound(updateRate);
        rain_render_splashes(updateRate);
        rain_lightning(updateRate);
        if (gLightningFrequency > 255) {
            mtx_ortho(&gCurrWeatherDisplayList, &gCurrWeatherMatrix);
            for (i = 0; i < 2; i++) {
                rain_render(&gRainGfx[i], updateRate);
            }
            gDPSetPrimColor(gCurrWeatherDisplayList++, 0, 0, 255, 255, 255, 255);
            gDPSetEnvColor(gCurrWeatherDisplayList++, 255, 255, 255, 0);
            rendermode_reset(&gCurrWeatherDisplayList);
            viewport_reset(&gCurrWeatherDisplayList);
        }
    }
}

/**
 * If it's raining hard enough, then start generating rain splash particles.
 * Set position to be a random spot near the camera and account for wave height.
 * Every existing splash particle gets rendered as a billboard.
 */
void rain_render_splashes(s32 updateRate) {
    s32 temp_t0;
    s32 i;
    f32 var_f2;
    s32 firstIndexWithoutFlags;
    s32 randYRot;
    s32 setEnvColor;
    s32 waveIndex;
    f32 var_f0;
    f32 randFloat;
    f32 xPos;
    f32 zPos;
    Object *racer;
    WaterProperties **waterProps;

    setEnvColor = TRUE;
    if (gRainSplashGfx != NULL) {
        temp_t0 = ((gRainOpacity >> 2) * gLightningFrequency) >> 14;
        if (temp_t0 > 0x4000) {
            racer = get_racer_object_by_port(0);
            gRainSplashDelay -= updateRate;
            if (gRainSplashDelay <= 0) {
                i = 0;
                if (racer != NULL) {
                    firstIndexWithoutFlags = -1;
                    for (; i < ARRAY_COUNT(gRainSplashSegments) && firstIndexWithoutFlags < 0; i++) {
                        if (gRainSplashSegments[i].trans.flags == OBJ_FLAGS_NONE) {
                            firstIndexWithoutFlags = i;
                        }
                    }
                    if (firstIndexWithoutFlags >= 0) {
                        randYRot = rand_range(-0x2000, 0x2000) + racer->trans.rotation.y_rotation + 0x8000;
                        randFloat = (f32) rand_range(50, 500);
                        xPos = (sins_f(randYRot) * randFloat) + racer->trans.x_position;
                        zPos = (coss_f(randYRot) * randFloat) + racer->trans.z_position;
                        i = func_8002B0F4(get_level_segment_index_from_position(xPos, racer->trans.y_position, zPos),
                                          xPos, zPos, &waterProps);
                        if (i != 0) {
                            var_f2 = 1000.0f;
                            waveIndex = 0;
                            if (i >= 2) {
                                while (waveIndex < (i - 1) &&
                                       racer->trans.y_position < waterProps[waveIndex]->waveHeight) {
                                    waveIndex++;
                                }
                                if (waveIndex > 0) {
                                    var_f2 = racer->trans.y_position - waterProps[waveIndex]->waveHeight;
                                    if (var_f2 < 0.0f) {
                                        var_f2 = -var_f2;
                                    }
                                    waveIndex--;
                                }
                            }
                            var_f0 = racer->trans.y_position - waterProps[waveIndex]->waveHeight;
                            if (var_f0 < 0.0f) {
                                var_f0 = -var_f0;
                            }
                            if (var_f0 < var_f2) {
                                if (var_f0 > 200.0f) {
                                    firstIndexWithoutFlags = -1;
                                }
                            } else {
                                waveIndex++;
                                if (var_f2 > 200.0f) {
                                    firstIndexWithoutFlags = -1;
                                }
                            }
                            if (firstIndexWithoutFlags >= 0) {
                                gRainSplashSegments[firstIndexWithoutFlags].trans.x_position = xPos;
                                gRainSplashSegments[firstIndexWithoutFlags].trans.y_position =
                                    waterProps[waveIndex]->waveHeight;
                                gRainSplashSegments[firstIndexWithoutFlags].trans.z_position = zPos;
                                gRainSplashSegments[firstIndexWithoutFlags].animFrame = 0;
                                gRainSplashSegments[firstIndexWithoutFlags].trans.flags = OBJ_FLAGS_UNK_0001;
                                gRainSplashSegments[firstIndexWithoutFlags].opacity =
                                    rand_range(128, (temp_t0 >> 10) + 191);
                                gRainSplashDelay = (gRainSplashDelay - (temp_t0 >> 10)) + 64;
                                if (gRainSplashDelay < 0) {
                                    gRainSplashDelay = 0;
                                }
                            }
                        }
                    }
                }
            }
        }
        for (i = 0; i < ARRAY_COUNT(gRainSplashSegments); i++) {
            if (gRainSplashSegments[i].trans.flags != 0) {
                gRainSplashSegments[i].animFrame += updateRate * 16;
                if (gRainSplashSegments[i].animFrame > 255) {
                    gRainSplashSegments[i].trans.flags = 0;
                } else {
                    if (setEnvColor) {
                        setEnvColor = FALSE;
                        gDPSetEnvColor(gCurrWeatherDisplayList++, 255, 255, 255, 0);
                    }

                    gDPSetPrimColor(gCurrWeatherDisplayList++, 0, 0, 192, 192, 255, gRainSplashSegments[i].opacity);
                    render_sprite_billboard(&gCurrWeatherDisplayList, &gCurrWeatherMatrix, &gCurrWeatherVertexList,
                                            (Object *) &gRainSplashSegments[i], gRainSplashGfx,
                                            RENDER_Z_COMPARE | RENDER_SEMI_TRANSPARENT | RENDER_FOG_ACTIVE |
                                                RENDER_Z_UPDATE);
                }
            }
        }

        gDPSetPrimColor(gCurrWeatherDisplayList++, 0, 0, 255, 255, 255, 255);
    }
}

/**
 * On a randomly set timer, based on the weather intensity, count down and make the sound of thunder.
 * Set a second timer, that then counts down to zero and creates a flash of lightning in the form of a screen
 * transition. Afterwards, set the thunder timer back.
 */
void rain_lightning(s32 updateRate) {
    if (gThunderTimer > 0) {
        gThunderTimer -= updateRate;
        if (gThunderTimer <= 0) {
            if (gRainOpacity > 0x8000 && check_fadeout_transition() == 0) {
                transition_begin(&gThunderTransition);
            }
            sound_play(SOUND_LIGHTNING, NULL);
            gThunderTimer = 0;
        }
    } else if (gLightningFrequency >= 48000) {
        if (gLightningTimer > 0) {
            gLightningTimer -= updateRate;
        } else {
            sound_play(SOUND_THUNDER, NULL);
            gThunderTimer = 600 - ((gLightningFrequency + -48000) >> 5);
            gLightningTimer = rand_range(900, 1140) - ((gLightningFrequency + -48000) >> 5);
        }
    }
}

/**
 * Emit looping rain sound, using the camera position and direction as reference.
 */
void rain_sound(UNUSED s32 updateRate) {
    f32 xPos;
    f32 yPos;
    f32 zPos;
    f32 length;
    f32 cosOffset;
    f32 sineOffset;

    length = 1152.0f - (f32) (gLightningFrequency >> 6);
    cosOffset = sins_f(gWeatherCamera->trans.rotation.y_rotation) * length;
    sineOffset = coss_f(gWeatherCamera->trans.rotation.y_rotation) * length;
    xPos = gWeatherCamera->trans.x_position + (sineOffset - cosOffset);
    yPos = gWeatherCamera->trans.y_position;
    zPos = gWeatherCamera->trans.z_position + (-sineOffset - cosOffset);
    if (gWeatherSoundMask) {
        audspat_point_set_position(gWeatherSoundMask, xPos, yPos, zPos);
    } else {
        audspat_play_sound_at_position(SOUND_RAIN, xPos, yPos, zPos, AUDIO_POINT_FLAG_1, &gWeatherSoundMask);
    }
}

/**
 * Set the intended UV coordinates for the current rain plane, then render it onscreen.
 */
void rain_render(RainGfxData *rainGfx, s32 time) {
    s32 u0;
    s32 v0;
    s32 vertical;
    s32 horizontal;
    s32 maskU;
    s32 maskV;
    s32 opacity;
    s32 i;
    f32 zSin;
    f32 zCos;
    UNUSED s32 pad[2];
    TextureHeader *tex;
    Gfx *curDL;
    Triangle *tri;

    if (rainGfx->tex == NULL) {
        return;
    }
    tex = rainGfx->tex;

    horizontal = tex->width << 5;
    vertical = tex->height << 5;
    maskU = (horizontal * 2) - 1;
    maskV = (vertical * 2) - 1;

    rainGfx->offsetU = (normalise_time(rainGfx->scrollSpeedU * time) + rainGfx->offsetU) & maskU;
    rainGfx->offsetV = (normalise_time(rainGfx->scrollSpeedV * time) + rainGfx->offsetV) & maskV;

    horizontal = (rainGfx->scaleU * horizontal) >> 8;
    vertical = (rainGfx->scaleV * vertical) >> 8;

    opacity = ((gRainOpacity >> 2) * gLightningFrequency) >> 14;
    opacity = (opacity * rainGfx->opacity) >> 16;
    if (opacity <= 0) {
        return;
    }

    u0 = (rainGfx->offsetU + ((horizontal * 6 * gWeatherCamera->trans.rotation.x) >> 0x10)) & maskU;
    v0 = rainGfx->offsetV;

    horizontal += u0;
    vertical += v0;

    zSin = sins_f(gWeatherCamera->trans.rotation.z);
    zCos = coss_f(gWeatherCamera->trans.rotation.z);

    for (i = 0; i < ARRAY_COUNT(gRainQuad); i++) {
        gRainVertices[gRainVertexFlip + i].x = gRainQuad[i].x * zCos - gRainQuad[i].y * zSin;
        gRainVertices[gRainVertexFlip + i].y = gRainQuad[i].y * zCos + gRainQuad[i].x * zSin;
    }

    curDL = gCurrWeatherDisplayList;
    tri = gCurrWeatherTriList;

    tri->vertices = DKR_TRIANGLE(BACKFACE_DRAW, 0, 1, 2);
    tri->uv0.u = u0;
    tri->uv0.v = v0;
    tri->uv1.u = horizontal;
    tri->uv1.v = v0;
    tri->uv2.u = horizontal;
    tri->uv2.v = vertical;
    tri++;

    tri->vertices = DKR_TRIANGLE(BACKFACE_DRAW, 2, 3, 0);
    tri->uv0.u = horizontal;
    tri->uv0.v = vertical;
    tri->uv1.u = u0;
    tri->uv1.v = vertical;
    tri->uv2.u = u0;
    tri->uv2.v = v0;
    tri++;

    gfx_init_basic_xlu(&curDL, 0,
                       COLOUR_RGBA32(rainGfx->primitiveRed, rainGfx->primitiveGreen, rainGfx->primitiveBlue, opacity),
                       COLOUR_RGBA32(rainGfx->environmentRed, rainGfx->environmentGreen, rainGfx->environmentBlue, 0));
    gDkrDmaDisplayList(curDL++, OS_K0_TO_PHYSICAL(tex->cmd), tex->numberOfCommands);
    gSPVertexDKR(curDL++, OS_K0_TO_PHYSICAL(gRainVertices + gRainVertexFlip), 4, 0);
    gSPPolygon(curDL++, OS_K0_TO_PHYSICAL(gCurrWeatherTriList), 2, 1);
    gDPPipeSync(curDL++);
    gRainVertexFlip = (gRainVertexFlip + 4) & 0xF;
    gCurrWeatherDisplayList = curDL;
    gCurrWeatherTriList = tri;
}
