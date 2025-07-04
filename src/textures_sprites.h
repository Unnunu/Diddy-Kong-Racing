#ifndef _TEXTURES_SPRITES_H_
#define _TEXTURES_SPRITES_H_

#include "types.h"
#include "f3ddkr.h"
#include "structs.h"

#define TEX_TABLE_2D 0
#define TEX_TABLE_3D 1

// Gets the texture type. E.g: rgba16
#define TEX_FORMAT(x) (x & 0xF)
// Gets the texture render mode type. E.g: transparent
#define TEX_RENDERMODE(x) ((x >> 4) & 0xF)

/**
 * First two entries are combine mode.
 * Third entry is othermode high word. (Most importantly, the cycle mode and texture filter settings)
 * Fourth and fifth entries are render modes.
*/
#define DRAW_TABLE_ENTRY(combine1, combine2, cycleMode, renderMode1, renderMode2) { \
    gsDPSetCombineLERP(combine1, combine2), \
    gsDPSetOtherMode(cycleMode, DKR_OML_COMMON | renderMode1 | renderMode2), \
}

/**
 * Diddy Kong Racing sets up many of the rendermode tables with a certain pattern.
 * First two entries are combine mode.
 * Third entry is othermode high word. (Most importantly, the cycle mode and texture filter settings)
 * Fourth and fifth entries are render modes for no AA or ZB
 * Sixth and seventh entries are render modes for for AA, but no ZB
 * Eighth and ninth entries are render modes for for ZB, but no AA
 * Tenth and eleventh entries are render modes for for AA and ZB
*/
#define DRAW_TABLE_GROUP(combine1, combine2, cycleMode, renderMode1, renderMode2, renderMode1AA, rendermode2AA, renderMode1ZB, rendermode2ZB, renderMode1ZBAA, renderMode2ZBAA) \
{gsDPSetCombineLERP(combine1, combine2), gsDPSetOtherMode(cycleMode, DKR_OML_COMMON | renderMode1 | renderMode2), }, \
{gsDPSetCombineLERP(combine1, combine2), gsDPSetOtherMode(cycleMode, DKR_OML_COMMON | renderMode1AA | rendermode2AA), }, \
{gsDPSetCombineLERP(combine1, combine2), gsDPSetOtherMode(cycleMode, DKR_OML_COMMON | renderMode1ZB | rendermode2ZB), }, \
{gsDPSetCombineLERP(combine1, combine2), gsDPSetOtherMode(cycleMode, DKR_OML_COMMON | renderMode1ZBAA | renderMode2ZBAA), }

enum RenderFlags {
    RENDER_NONE,
    RENDER_VEHICLE_PART =       (1 << 0), // Shares a spot with RENDER_ANTI_ALIASING, since TEX_EDGE enforces anti aliasing unconditionally.
    RENDER_ANTI_ALIASING =      (1 << 0), // Smooths the edges to improve visual quality.
    RENDER_Z_COMPARE =          (1 << 1), // Compares depth values with existing geometry to prevent rendering errors.
    RENDER_SEMI_TRANSPARENT =   (1 << 2), // Renders with translucency enabled, blending with existing geometry.
    RENDER_FOG_ACTIVE =         (1 << 3), // Applies fog to the geometry.
    RENDER_CUTOUT =             (1 << 4), // A surface with 1 bit alpha cut out for quick transparency.
    RENDER_COLOUR_INDEX =       (1 << 5), // Enables palleted textures.
    RENDER_CLAMP_X =            (1 << 6), // Prevent texture repeating on the X axis.
    RENDER_CLAMP_Y =            (1 << 7), // Prevent texture repeating on the Y axis.
    RENDER_Z_UPDATE =           (1 << 8), // Updates the depth buffer when rendering.
    RENDER_HIDDEN =             (1 << 8), // Shares a spot with Z update, as that's generally a given with level geometry.
    RENDER_PRESERVE_COVERAGE =  (1 << 9), // Coverage is used to help smooth the image. This won't write over existing coverage values.
    RENDER_NO_COLLISION =       (1 << 9), // Shares a slot with coverage, being normal geometry doesn't care about coverage.
    RENDER_LINE_SWAP =          (1 << 10), // Texture has swapped lines, for speed. Makes the load process slightly different.
    RENDER_DECAL =              (1 << 11), // Projects a surface on existing geometry, taking precedent to not zfight.
    RENDER_UNK_0001000 =        (1 << 12),
    RENDER_WATER =              (1 << 13), // Marks geometry as water. Not rendered if the block is utilising wavegen.
    RENDER_NO_SHADOW =          (1 << 14), // Do not render shadows on this geometry.
    RENDER_ENVMAP =             (1 << 15), // Calculate envmaps on this geometry.
    RENDER_TEX_ANIM =           (1 << 16), // Animated textures.
    RENDER_UNK_0020000 =        (1 << 17),
    RENDER_PULSING_LIGHTS =     (1 << 18), // Use a different material to apply a pulsating colour effect.
    RENDER_UNK_0080000 =        (1 << 19),
    RENDER_UNK_0100000 =        (1 << 20),
    RENDER_UNK_0200000 =        (1 << 21),
    RENDER_UNK_0400000 =        (1 << 22),
    RENDER_UNK_0800000 =        (1 << 23),
    RENDER_UNK_1000000 =        (1 << 24),
    RENDER_UNK_2000000 =        (1 << 25),
    RENDER_UNK_4000000 =        (1 << 26),
    RENDER_VTX_ALPHA   =        (1 << 27),  // Allows use of vertex alpha, disabling fog if necessary.
    RENDER_UNK_10000000 =       (1 << 28),
    RENDER_UNK_20000000 =       (1 << 29),
    RENDER_UNK_40000000 =       (1 << 30),
    RENDER_UNK_80000000 =       (1 << 31),
    RENDER_ALL =                0xFFFFFFFF
};

typedef enum  TextureRenderModes {
    TRANSPARENT,
    OPAQUE, 
    TRANSPARENT_2, 
    OPAQUE_2
} TextureRenderModes;

typedef enum TransFlags {
    OBJ_FLAGS_NONE,
    OBJ_FLAGS_UNK_0001 =            (1 << 0),
    OBJ_FLAGS_UNK_0002 =            (1 << 1),
    OBJ_FLAGS_UNK_0004 =            (1 << 2),
    OBJ_FLAGS_UNK_0008 =            (1 << 3),
    OBJ_FLAGS_UNK_0010 =            (1 << 4),
    OBJ_FLAGS_DESPAWN_TIME_TRIAL =  (1 << 5),  // Don't show up in time trial.
    OBJ_FLAGS_DESPAWN_MULTIPLAYER = (1 << 6),  // Don't show up in 3/4 player.
    OBJ_FLAGS_UNK_0080 =            (1 << 7),
    OBJ_FLAGS_UNK_0100 =            (1 << 8),
    OBJ_FLAGS_INVIS_PLAYER1 =       (1 << 9),  // Player 1 cannot see this.
    OBJ_FLAGS_INVIS_PLAYER2 =       (1 << 10), // Player 2 cannot see this.
    OBJ_FLAGS_UNK_0800 =            (1 << 11),
    OBJ_FLAGS_SHADOW_ONLY =         (1 << 12), // Still has a shadow, but the model is invisible.
    OBJ_FLAGS_UNK_2000 =            (1 << 13),
    OBJ_FLAGS_INVISIBLE =           (1 << 14), // Invisible, and hidden shadow too.
    OBJ_FLAGS_PARTICLE =            (1 << 15)  // Object is a particle.
} TransFlags;

typedef enum HeaderFlags {
    HEADER_FLAGS_NONE,
    HEADER_FLAGS_UNK_0001 = (1 << 0),
    HEADER_FLAGS_WATER_EFFECT = (1 << 4),
    HEADER_FLAGS_UNK_0080 = (1 << 7),
} HeaderFlags;

typedef enum BasicRenderIDs {
    DRAW_BASIC_ZB_OFF,
    DRAW_BASIC_1CYCLE,
    DRAW_BASIC_2CYCLE,

    DRAW_BASIC_IDS
} BasicRenderIDs;

typedef struct TextureCacheEntry {
    s32 id;
    TextureHeader *texture;
} TextureCacheEntry;

typedef struct SpriteCacheEntry {
    s32 id;
    Sprite *sprite;
} SpriteCacheEntry;

/* Size: 0x28 bytes */
typedef struct TempTexHeader {
/* 0x00 */ TextureHeader header;
/* 0x20 */ u32 uncompressedSize; // Little endian
/* 0x24 */ u8 gzipLevel; // Always 9.
/* 0x25 */ u8 pad25[3]; // padding
} TempTexHeader;

void tex_disable_modes(s32 flags);
void tex_enable_modes(s32 flags);
s32 tex_get_table_2D(void);
s32 tex_get_table_3D(void);
s32 sprite_table_size(void);
void set_texture_colour_tag(s32 tagID);
void rendermode_reset(Gfx **dList);
void directional_lighting_on(void);
void directional_lighting_off(void);
void material_set_no_tex_offset(Gfx **dList, TextureHeader *texhead, u32 flags);
void sprite_opaque(s32 setting);
s32 tex_palette_id(s16 paletteID);
void material_set(Gfx **dList, TextureHeader *texhead, s32 flags, s32 texOffset);
void sprite_free(Sprite *sprite);
void tex_free(TextureHeader *tex);
void material_load_simple(Gfx **dList, s32 flags);

// There might be a file boundary here.
void tex_animate_texture(TextureHeader *texture, u32 *triangleBatchInfoFlags, s32 *arg2, s32 updateRate);
void func_8007F1E8(LevelHeader_70 *arg0);
void init_pulsating_light_data(PulsatingLightData *data);
void update_pulsating_light_data(PulsatingLightData *data, s32 timeDelta);
TextureHeader *set_animated_texture_header(TextureHeader *texHead, s32 offset);
TextureHeader *load_texture(s32 id);
s32 tex_asset_size(s32 id); 
s32 tex_cache_asset_id(s32 cacheID);
s32 load_sprite_info(s32 spriteIndex, s32 *anchorXOut, s32 *anchorYOut, s32 *numFramesOut, s32 *formatOut,
                     s32 *sizeOut);
void gfx_init_basic_xlu(Gfx **dList, u32 index, u32 primitiveColor, u32 environmentColor);
void func_8007CA68(s32 arg0, s32 arg1, s32 *arg2, s32 *arg3, s32 *arg4);
Sprite *tex_load_sprite(s32 spriteID, s32 arg1);
void tex_init_textures(void);
void material_set_blinking_lights(Gfx **dList, TextureHeader *texture_list, u32 flags,
                                  s32 texture_index);       
void material_init(TextureHeader *tex, Gfx *_dList);
void sprite_init_frame(SpriteAsset *spriteAsset, Sprite *sprite, s32 frameId);

#endif
