#include "object_models.h"
#include "asset_enums.h"
#include "asset_loading.h"
#include "common.h"
#include "gzip.h"
#include "libc/math.h"
#include "macros.h"
#include "memory.h"
#include "objects.h"
#include "racer.h"
#include "textures_sprites.h"
#include "tracks.h"

#define MODEL_LOADED_MAX 70

/************ .data ************/

s32 gRenderSceneChecksum = TractionTableChecksum;
s32 gRenderSceneFuncLength = 1980;

/*******************************/

/************ .bss ************/

s32 *gObjectModelTable;
s32 *gModelCache; // A table of two entries. The first half is the model ID, while the second half is the model data.
s32 *D_8011D628;
s32 gModelCacheCount;
s32 gNumModelIDs;
s32 D_8011D634;
s16 *gAnimationTable;
s32 *gObjectAnimationTable;
s32 gModelAnimOffsetID;
s32 D_8011D644;

/******************************/

/**
 * Allocate memory for object model ID's and animation tables.
 */
void allocate_object_model_pools(void) {
    s32 i;
    s32 checksum;

    gModelCache = mempool_alloc_safe(MODEL_LOADED_MAX * ((sizeof(uintptr_t)) * 2), COLOUR_TAG_GREEN);
    D_8011D628 = mempool_alloc_safe(100 * sizeof(uintptr_t), COLOUR_TAG_GREEN);
    gModelCacheCount = 0;
    D_8011D634 = 0;
    gObjectModelTable = (s32 *) load_asset_section_from_rom(ASSET_OBJECT_MODELS_TABLE);
    gNumModelIDs = 0;
    while (gObjectModelTable[gNumModelIDs] != -1) {
        gNumModelIDs++;
    }
    gNumModelIDs--;
    gAnimationTable = (s16 *) load_asset_section_from_rom(ASSET_ANIMATION_IDS);
    gObjectAnimationTable = (s32 *) load_asset_section_from_rom(ASSET_OBJECT_ANIMATIONS_TABLE);
    D_8011D644 = (s32) mempool_alloc_safe(0xC00, COLOUR_TAG_GREEN);
    gModelAnimOffsetID = 0;

#ifdef ANTI_TAMPER
    // Antipiracy measure
    checksum = 0;
    for (i = 0; i < gRenderSceneFuncLength; i++) {
        checksum += *(u8 *) (((s32) &render_scene) + i);
    }
    if (checksum != gRenderSceneChecksum) {
        drm_vehicle_traction();
    }
#endif
}

/**
 * Load the associated model ID and assign it to the objects gfx data.
 * Also loads textures and animations.
 * v79 and newer have a bugfix that revert the cache count if allocation fails.
 */
ModelInstance *object_model_init(s32 modelID, s32 flags) {
    s32 i;
    s32 cacheIndex;
    ObjectModel *objMdl;
    s32 sp48;
    s32 temp_s0;
    ModelInstance *instance;
    s8 sp3F;
#if VERSION >= VERSION_79
    s8 var_a2;
    s8 cacheChanged;
#endif
    u32 compressedData;
    s32 modelSize;

    if (modelID >= gNumModelIDs) {
        stubbed_printf("Error: Model no. out of range on load. !!\n");
        modelID = 0;
    }

    // Check if the model already exists in the cache.
    for (i = 0; i < gModelCacheCount; i++) {
        if (modelID == gModelCache[ASSETCACHE_ID(i)]) {
            objMdl = (ObjectModel *) gModelCache[ASSETCACHE_PTR(i)];
            instance = model_instance_init(objMdl, flags);
            if (instance != NULL) {
                objMdl->references++;
            }
            return instance;
        }
    }

#if VERSION >= VERSION_79
    var_a2 = FALSE;
    cacheChanged = FALSE;
#endif
    if (D_8011D634 > 0) {
        D_8011D634--;
#if VERSION >= VERSION_79
        var_a2 = TRUE;
#endif
        cacheIndex = D_8011D628[D_8011D634];
    } else {
        cacheIndex = gModelCacheCount;
#if VERSION >= VERSION_79
        cacheChanged = TRUE;
#endif
        gModelCacheCount++;
    }

    temp_s0 = gObjectModelTable[modelID];
    sp48 = gObjectModelTable[modelID + 1] - temp_s0;
    modelSize = get_asset_uncompressed_size(ASSET_OBJECT_MODELS, temp_s0) + sizeof(ObjectModel);
    objMdl = (ObjectModel *) mempool_alloc(modelSize, COLOUR_TAG_RED);
    if (objMdl == NULL) {
#if VERSION >= VERSION_79
        if (var_a2) {
            D_8011D634++;
        }
        if (cacheChanged) {
            gModelCacheCount--;
        }
#endif
        return NULL;
    }
    compressedData = (u32) ((u8 *) objMdl + modelSize) - sp48;
    load_asset_to_address(ASSET_OBJECT_MODELS, compressedData, temp_s0, sp48);
    gzip_inflate((u8 *) compressedData, (u8 *) objMdl);
    objMdl->textures = (TextureInfo *) ((s32) objMdl->textures + (u8 *) objMdl);
    objMdl->vertices = (Vertex *) ((s32) objMdl->vertices + (u8 *) objMdl);
    objMdl->triangles = (Triangle *) ((s32) objMdl->triangles + (u8 *) objMdl);
    objMdl->batches = (TriangleBatchInfo *) ((s32) objMdl->batches + (u8 *) objMdl);
    objMdl->unk14 = (s16 *) ((s32) objMdl->unk14 + (u8 *) objMdl);
    objMdl->unk1C = (s16 *) ((s32) objMdl->unk1C + (u8 *) objMdl);
    objMdl->unk4C = (s32 *) ((s32) objMdl->unk4C + (u8 *) objMdl);
    objMdl->references = 1;
    objMdl->collisionFacets = NULL;
    objMdl->collisionPlanes = NULL;
    objMdl->collisionFacetCount = 0;
    objMdl->texOffsetUpdateRate = 0;
    objMdl->normals = NULL;
    objMdl->numberOfAnimations = 0;
    objMdl->animations = NULL;
    sp3F = 0;
    for (i = 0; i < objMdl->numberOfTextures; i++) {
        objMdl->textures[i].texture = load_texture(((s32) objMdl->textures[i].texture) | 0x8000);
        if (objMdl->textures[i].texture == NULL) {
            sp3F = 1;
        }
    }
    if (!sp3F) {
        for (i = 0; i < objMdl->numberOfBatches; i++) {
            if (objMdl->batches[i].textureIndex != 0xFF &&
                objMdl->batches[i].textureIndex >= objMdl->numberOfTextures) {
                stubbed_printf("TEXTURE ERROR!!\n%d,%d\n", objMdl->batches[i].textureIndex, objMdl->numberOfTextures);
                goto block_30;
            }
        }
        if (model_init_normals(objMdl) == 0 && model_anim_init(objMdl, modelID) == 0) {
            instance = model_instance_init(objMdl, flags);
            if (instance != NULL) {
                gModelCache[ASSETCACHE_ID(cacheIndex)] = modelID;
                gModelCache[ASSETCACHE_PTR(cacheIndex)] = (s32) objMdl;
                if (gModelCacheCount < MODEL_LOADED_MAX) {
                    instance->animUpdateTimer = 0;
                    return instance;
                } else {
                    stubbed_printf("Error: Model table overflow!!\n");
                }
            }
        }
    }
block_30:
#if VERSION >= VERSION_79
    if (cacheChanged) {
        gModelCacheCount--;
    }
    if (var_a2) {
        D_8011D634++;
    }
#endif
    free_model_data(objMdl);
    return NULL;
}

/**
 * Initialises the model instance.
 * Objects that do nothing special get a standard instance assigned,
 * otherwise, ones that utilise shading or animation will have their own copies of the vertex data.
 * Returns null if it failed.
 * Official name: createModelInstance
 */
ModelInstance *model_instance_init(ObjectModel *model, s32 flags) {
    s32 temp;
    ModelInstance *result;
    Vertex *var_v1;
    Vertex *vertex;
    Vertex *mdlVertex;

    if (model == NULL) {
        stubbed_printf("WARNING :: createModelInstance called with NULL pointer\n");
    }

    if (model->numberOfAnimations != 0 && (flags & OBJECT_BEHAVIOUR_ANIMATION)) {
        temp = ((model->numberOfVertices * 2) * sizeof(Vertex)) + sizeof(ModelInstance);
        result = (ModelInstance *) mempool_alloc((model->unk4A * 6) + temp, COLOUR_TAG_BLUE);
        if (result == NULL) {
            return NULL;
        }
        result->vertices[0] = (Vertex *) ((u8 *) result + sizeof(ModelInstance));
        result->vertices[1] =
            (Vertex *) ((u8 *) result + (model->numberOfVertices * sizeof(Vertex)) + sizeof(ModelInstance));
        result->vertices[2] = (Vertex *) ((u8 *) result + temp);
        result->modelType = MODELTYPE_ANIMATED;
    } else if (model->normals != NULL && (flags & OBJECT_BEHAVIOUR_SHADED)) {
        temp = (model->numberOfVertices * sizeof(Vertex)) + sizeof(ModelInstance);
        result = (ModelInstance *) mempool_alloc(temp, COLOUR_TAG_BLUE);
        if (result == NULL) {
            return NULL;
        }
        var_v1 = (Vertex *) ((u8 *) result + sizeof(ModelInstance));
        result->vertices[0] = var_v1;
        result->vertices[1] = var_v1;
        result->vertices[2] = NULL;
        result->modelType = MODELTYPE_SHADE;
    } else {
        result = (ModelInstance *) mempool_alloc(sizeof(ModelInstance), COLOUR_TAG_BLUE);
        if (result == NULL) {
            return NULL;
        }
        result->vertices[0] = model->vertices;
        result->vertices[1] = model->vertices;
        result->vertices[2] = NULL;
        result->modelType = MODELTYPE_BASIC;
    }
    result->offsetX = 0;
    result->offsetY = 0;
    result->offsetZ = 0;
    result->objModel = model;
    result->animationID = -1;
    result->animationFrame = -1;
    result->animationTaskNum = 0;
    // Shaded models need to be double buffered, so duplicate them.
    if (result->modelType != MODELTYPE_BASIC) {
        temp = 0;
        vertex = result->vertices[0];
        mdlVertex = &model->vertices[0];
        do {
            vertex->x = mdlVertex->x;
            vertex->y = mdlVertex->y;
            vertex->z = mdlVertex->z;
            vertex->r = mdlVertex->r;
            vertex->g = mdlVertex->g;
            vertex->b = mdlVertex->b;
            vertex->a = mdlVertex->a;
            vertex++;
            mdlVertex++;
            temp++;
        } while (temp < model->numberOfVertices);

        temp = 0;
        vertex = result->vertices[1];
        mdlVertex = &model->vertices[0];
        do {
            vertex->x = mdlVertex->x;
            vertex->y = mdlVertex->y;
            vertex->z = mdlVertex->z;
            vertex->r = mdlVertex->r;
            vertex->g = mdlVertex->g;
            vertex->b = mdlVertex->b;
            vertex->a = mdlVertex->a;
            vertex++;
            mdlVertex++;
            temp++;
        } while (temp < model->numberOfVertices);
    }
    return result;
}

/**
 * Attempts to free the object model from RAM.
 * Official name: ModFreeModel
 */
void free_3d_model(ModelInstance *modInst) {
    UNUSED s32 pad;
    s32 modelIndex;
    ObjectModel *model;
    s32 i;

    if (modInst == NULL) {
        stubbed_printf("ModFreeModel : NULL mod_inst!!\n");
        return;
    }

    model = modInst->objModel;
    model->references--;
    if (model->references > 0) { // Model is still used, so free the reference and return.
        mempool_free(modInst);
        return;
    }

    modelIndex = -1;
    for (i = 0; i < gModelCacheCount; i++) {
        if (model == (ObjectModel *) gModelCache[ASSETCACHE_PTR(i)]) {
            modelIndex = i;
        }
    }

    if (modelIndex != -1) {
        free_model_data(model);
        D_8011D628[D_8011D634] = modelIndex;
        D_8011D634++;
        gModelCache[ASSETCACHE_ID(modelIndex)] = -1;
        gModelCache[ASSETCACHE_PTR(modelIndex)] = -1;
        mempool_free(modInst);
    }
}

/**
 * Frees all associated meshes, textures and animations from the model.
 */
void free_model_data(ObjectModel *mdl) {
    s16 numTextures;

    if (mdl == NULL) {
        stubbed_printf("MOD Error: Tryed to deallocate non-existent model!!\n");
    }

    numTextures = mdl->numberOfTextures;
    if (numTextures > 0) {
        s32 texturesFreed = 0;
        s32 textureIndex = 0;
        do {
            TextureHeader *header = mdl->textures[textureIndex].texture;
            if (header != NULL) {
                tex_free(header);
                numTextures = mdl->numberOfTextures;
            }
            texturesFreed++;
            textureIndex++;
        } while (texturesFreed < numTextures);
    }

    if (mdl->collisionFacets != NULL) {
        mempool_free(mdl->collisionFacets);
    }

    if (mdl->collisionPlanes != NULL) {
        mempool_free(mdl->collisionPlanes);
    }

    if (mdl->normals != NULL) {
        mempool_free(mdl->normals);
    }
    // free the animations
    if (mdl->animations != NULL) {
        s32 animsFreed = 0;
        s32 animIndex = 0;
        if (mdl->numberOfAnimations != 0) {
            do {
                mempool_free(mdl->animations[animIndex].anim - 1);
                animsFreed++;
                animIndex++;
            } while (animsFreed < mdl->numberOfAnimations);
            mempool_free(mdl->animations);
        }
    }
    // free the model itself
    mempool_free(mdl);
}

void model_init_collision(ObjectModel *model) {
    s32 facesOffset;
    s32 verticesOffset;
    s32 nextFacesOffset;
    s32 s4;
    s32 i;
    s32 j;
    Vertex *v;
    s32 v1, v2;
    f32 x5, y5, z5;
    f32 x1, y1, z1;
    f32 x2, y2, z2;
    f32 x3, y3, z3;
    f32 nx, ny, nz;
    f32 mag;
    s32 s3;
    s32 k;
    s32 l;
    s32 index;
    s32 temp1, temp2;

    if (model->collisionFacets != NULL) {
        return;
    }

    s4 = 0;
    for (i = 0; i < model->numberOfBatches; i++) {
        facesOffset = model->batches[i].facesOffset;
        nextFacesOffset = model->batches[i + 1].facesOffset;
        if (model->batches[i].flags & RENDER_NO_COLLISION) {
            continue;
        }
        s4 += nextFacesOffset - facesOffset;
    }

    model->collisionFacets = (CollisionFacetPlanes *) mempool_alloc(s4 * sizeof(CollisionFacetPlanes), COLOUR_TAG_RED);

    if (model->collisionFacets == NULL) {
        return;
    }

    model->collisionPlanes = (f32 *) mempool_alloc(s4 * (sizeof(f32) * 16), COLOUR_TAG_RED);
    if (model->collisionPlanes == NULL) {
        mempool_free(model->collisionFacets);
        model->collisionFacets = NULL;
        return;
    }

    s4 = 0;
    for (i = 0; i < model->numberOfBatches; i++) {
        facesOffset = model->batches[i].facesOffset;
        verticesOffset = model->batches[i].verticesOffset;
        nextFacesOffset = model->batches[i + 1].facesOffset;
        if (model->batches[i].flags & RENDER_NO_COLLISION) {
            nextFacesOffset = facesOffset - 1;
        }

        for (j = facesOffset; j < nextFacesOffset; j++) {
            v = &model->vertices[model->triangles[j].vi0 + verticesOffset];
            x1 = v->x;
            y1 = v->y;
            z1 = v->z;

            v = &model->vertices[model->triangles[j].vi1 + verticesOffset];
            x2 = v->x;
            y2 = v->y;
            z2 = v->z;

            v = &model->vertices[model->triangles[j].vi2 + verticesOffset];
            x3 = v->x;
            y3 = v->y;
            z3 = v->z;

            nx = y1 * (z2 - z3) + y2 * (z3 - z1) + y3 * (z1 - z2);
            ny = z1 * (x2 - x3) + z2 * (x3 - x1) + z3 * (x1 - x2);
            nz = x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2);

            mag = sqrtf(nx * nx + ny * ny + nz * nz);
            if (mag > 0.0) {
                nx /= mag;
                ny /= mag;
                nz /= mag;
            }

            temp1 = s4 << 2;
            *(model->collisionPlanes + temp1 + 0) = nx;
            *(model->collisionPlanes + temp1 + 1) = ny;
            *(model->collisionPlanes + temp1 + 2) = nz;
            *(model->collisionPlanes + temp1 + 3) = -(x1 * nx + y1 * ny + z1 * nz);

            model->collisionFacets[s4].basePlaneIndex = s4;
            model->collisionFacets[s4].edgeBisectorPlane[0] = s4;
            model->collisionFacets[s4].edgeBisectorPlane[1] = s4;
            model->collisionFacets[s4].edgeBisectorPlane[2] = s4;

            s4++;
        }
    }

    model->collisionFacetCount = s4;

    func_80060910(model);

    s3 = 0;
    for (i = 0; i < model->numberOfBatches; i++) {
        facesOffset = model->batches[i].facesOffset;
        verticesOffset = model->batches[i].verticesOffset;
        nextFacesOffset = model->batches[i + 1].facesOffset;
        if (model->batches[i].flags & RENDER_NO_COLLISION) {
            nextFacesOffset = facesOffset - 1;
        }

        for (j = facesOffset; j < nextFacesOffset; j++, s3++) {
            index = model->collisionFacets[s3].basePlaneIndex << 2;
            nx = *(model->collisionPlanes + index + 0);
            ny = *(model->collisionPlanes + index + 1);
            nz = *(model->collisionPlanes + index + 2);

            for (k = 0; k < 3; k++) {
                l = k + 1;
                if (l >= 3) {
                    l = 0;
                }

                v1 = model->triangles[j].verticesArray[1 + k] + verticesOffset;
                v2 = model->triangles[j].verticesArray[1 + l] + verticesOffset;

                index = model->collisionFacets[s3].edgeBisectorPlane[k] << 2;
                x5 = nx + *(model->collisionPlanes + index + 0);
                y5 = ny + *(model->collisionPlanes + index + 1);
                z5 = nz + *(model->collisionPlanes + index + 2);

                v = &model->vertices[v1];
                x1 = v->x;
                y1 = v->y;
                z1 = v->z;

                v = &model->vertices[v2];
                x2 = v->x;
                y2 = v->y;
                z2 = v->z;

                x3 = x5 * 10.0f + x1;
                y3 = y5 * 10.0f + y1;
                z3 = z5 * 10.0f + z1;

                x5 = y1 * (z2 - z3) + y2 * (z3 - z1) + y3 * (z1 - z2);
                y5 = z1 * (x2 - x3) + z2 * (x3 - x1) + z3 * (x1 - x2);
                z5 = x1 * (y2 - y3) + x2 * (y3 - y1) + x3 * (y1 - y2);

                mag = sqrtf(x5 * x5 + y5 * y5 + z5 * z5);
                if (mag > 0.0) {
                    x5 /= mag;
                    y5 /= mag;
                    z5 /= mag;
                }

                model->collisionFacets[s3].edgeBisectorPlane[k] = s4;

                temp2 = s4 << 2;
                *(model->collisionPlanes + temp2 + 0) = x5;
                *(model->collisionPlanes + temp2 + 1) = y5;
                *(model->collisionPlanes + temp2 + 2) = z5;
                *(model->collisionPlanes + temp2 + 3) = -(x1 * x5 + y1 * y5 + z1 * z5);

                s4++;
            }
        }
    }
}

void func_80060910(ObjectModel *mdl) {
    s32 count;
    s32 i;
    s32 vertOffset;
    s32 triIndex;
    s32 startTri;
    s32 endTri;
    s32 nextVertIndex;
    s32 vertIndex;
    s32 vertIndex0;
    s32 vertIndex1;
    s32 result;
    s32 sp60;
    s32 sp5C;

    count = 0;
    for (i = 0; i < mdl->numberOfBatches; i++) {
        startTri = mdl->batches[i].facesOffset;
        vertOffset = mdl->batches[i].verticesOffset;
        endTri = mdl->batches[i + 1].facesOffset;
        if (mdl->batches[i].flags & RENDER_NO_COLLISION) {
            endTri = startTri - 1;
        }

        for (triIndex = startTri; triIndex < endTri; triIndex++, count++) {
            mdl->collisionFacets[count].basePlaneIndex = count;

            for (vertIndex = 0; vertIndex < 3; vertIndex++) {
                nextVertIndex = vertIndex + 1;
                if (nextVertIndex >= 3) {
                    nextVertIndex = 0;
                }

                vertIndex0 = mdl->triangles[triIndex].verticesArray[vertIndex + 1] + vertOffset;
                vertIndex1 = mdl->triangles[triIndex].verticesArray[nextVertIndex + 1] + vertOffset;

                result = func_80060AC8(mdl, triIndex, vertIndex0, vertIndex1, &sp5C, &sp60);
                if (result != -1) {
                    mdl->collisionFacets[count].edgeBisectorPlane[vertIndex] = result;
                } else {
                    mdl->collisionFacets[count].edgeBisectorPlane[vertIndex] = count;
                }
            }
        }
    }
}

s32 func_80060AC8(ObjectModel *mdl, s32 arg1, s32 arg2, s32 arg3, s32 *outBatchIndex, s32 *outVertexIndex) {
    s32 i;
    s32 endTri;
    s32 count;
    Triangle *tri;
    s16 vertOffset;
    s16 startTri;
    s32 triIndex;
    s32 nextVertIndex;
    s32 vertIndex;
    s32 vertIndex0;
    s32 vertIndex1;

    count = 0;
    for (i = 0; i < mdl->numberOfBatches; i++) {
        startTri = mdl->batches[i].facesOffset;
        vertOffset = mdl->batches[i].verticesOffset;
        endTri = mdl->batches[i + 1].facesOffset;
        if (mdl->batches[i].flags & RENDER_NO_COLLISION) {
            endTri = startTri - 1;
        }
        for (triIndex = startTri; triIndex < endTri; triIndex++, count++) {
            if (triIndex != arg1) {
                for (vertIndex = 0; vertIndex < 3; vertIndex++) {
                    nextVertIndex = vertIndex + 1;
                    if (nextVertIndex >= 3) {
                        nextVertIndex = 0;
                    }

                    vertIndex0 = mdl->triangles[triIndex].verticesArray[vertIndex + 1] + vertOffset;
                    vertIndex1 = mdl->triangles[triIndex].verticesArray[nextVertIndex + 1] + vertOffset;
                    if (func_80060C58(mdl->vertices, arg2, arg3, vertIndex0, vertIndex1) != 0) {
                        *outVertexIndex = vertIndex;
                        *outBatchIndex = i;
                        return count;
                    }
                }
            }
        }
    }

    return -1;
}

s32 func_80060C58(Vertex *vertices, s32 i1, s32 i2, s32 i3, s32 i4) {
    Vertex *a;
    Vertex *b;
    Vertex *c;
    Vertex *d;

#define NEARBY(a, b, x) (b->x - 4 < a->x && a->x < b->x + 4)

    if ((i1 == i3 && i2 == i4) || (i1 == i4 && i2 == i3)) {
        return 1;
    }

    a = &vertices[i1];
    b = &vertices[i2];
    c = &vertices[i3];
    d = &vertices[i4];

    if (NEARBY(a, c, x) && NEARBY(a, c, y) && NEARBY(a, c, z)) {
        if (NEARBY(b, d, x) && NEARBY(b, d, y) && NEARBY(b, d, z)) {
            return 2;
        }
    } else if (NEARBY(a, d, x) && NEARBY(a, d, y) && NEARBY(a, d, z)) {
        if (NEARBY(b, c, x) && NEARBY(b, c, y) && NEARBY(b, c, z)) {
            return 2;
        }
    }

    return 0;

#undef NEARBY
}

// Returns 0 if successful, or 1 if an error occured.
s32 model_init_normals(ObjectModel *model) {
    Vertex *vertices;
    Triangle *triangles;
    Vec3f *floatNorms;
    s16 i;
    TriangleBatchInfo *batches;
    Vec3s *normals;
    s16 s6;
    s16 l;
    s16 q;
    s16 k;
    s16 a2;
    s16 j;
    s16 a0;
    s16 vertOffset;
    f32 length;
    Vec3f *v06;
    s16 *v0;
    s16 vx, vy, vz;

    batches = model->batches;
    model->normals = NULL;

    k = 0;
    for (i = 0; i < model->numberOfBatches; i++) {
        if (batches[i].miscData != BATCH_VTX_COL || (batches[i].flags & RENDER_ENVMAP)) {
            k += batches[i + 1].verticesOffset - batches[i].verticesOffset;
        }
    }

    if (k > 0) {
        vertices = model->vertices;
        triangles = model->triangles;

        floatNorms = (Vec3f *) mempool_alloc(model->numberOfTriangles * sizeof(Vec3f), COLOUR_TAG_ORANGE);
        if (floatNorms == NULL) {
            return 1;
        }

        normals = (Vec3s *) mempool_alloc(k * sizeof(Vec3s), COLOUR_TAG_ORANGE);
        if (normals == NULL) {
            mempool_free(floatNorms);
            return 1;
        }

        // Calculate vertex normals and store them as floating point.
        for (i = 0; i < model->numberOfBatches; i++) {
            vertOffset = batches[i].verticesOffset;
            for (j = batches[i].facesOffset; j < batches[i + 1].facesOffset; j++) {
                f32 sp70[3];
                f32 sp64[3];
                f32 sp58[3];
                for (k = 0; k < 3; k++) {
                    a2 = triangles[j].verticesArray[k + 1] + vertOffset;
                    sp70[k] = vertices[a2].x;
                    sp64[k] = vertices[a2].y;
                    sp58[k] = vertices[a2].z;
                }

                floatNorms[j].x = (sp58[0] - sp58[2]) * (sp64[0] - sp64[1]) - (sp64[0] - sp64[2]) * (sp58[0] - sp58[1]);
                floatNorms[j].y = (sp58[0] - sp58[1]) * (sp70[0] - sp70[2]) - (sp70[0] - sp70[1]) * (sp58[0] - sp58[2]);
                floatNorms[j].z = (sp70[0] - sp70[1]) * (sp64[0] - sp64[2]) - (sp70[0] - sp70[2]) * (sp64[0] - sp64[1]);
                length = sqrtf(floatNorms[j].x * floatNorms[j].x + floatNorms[j].y * floatNorms[j].y +
                               floatNorms[j].z * floatNorms[j].z);
                if (length != 0.0f) {
                    floatNorms[j].x /= length;
                    floatNorms[j].y /= length;
                    floatNorms[j].z /= length;
                }
            }
        }

        v0 = (s16 *) mempool_alloc(model->numberOfVertices * sizeof(s16), COLOUR_TAG_ORANGE);
        if (v0 == NULL) {
            mempool_free(floatNorms);
            mempool_free(normals);
            return 1;
        }

        s6 = 0;

        for (i = 0; i < model->numberOfBatches; i++) {
            for (l = batches[i].verticesOffset; l < batches[i + 1].verticesOffset; l++) {
                if (batches[i].miscData < 0xFE) {
                    a2 = -1;
                    vx = vertices[l].x;
                    vy = vertices[l].y;
                    vz = vertices[l].z;

                    for (q = 0; q <= i && a2 < 0; q++) {
                        if (batches[i].miscData == batches[q].miscData) {
                            a0 = batches[q].verticesOffset;
                            while (((q == i && a0 < l) || (q != i && a0 < batches[q + 1].verticesOffset)) && a2 < 0) {
                                if (vx == vertices[a0].x && vy == vertices[a0].y && vz == vertices[a0].z) {
                                    a2 = v0[a0];
                                }
                                a0++;
                            }
                        }
                    }
                    if (a2 < 0) {
                        v0[l] = s6++;
                    } else {
                        v0[l] = a2;
                    }
                } else if (batches[i].miscData == 0xFE) {
                    v0[l] = s6++;
                } else if (batches[i].flags & RENDER_ENVMAP) {
                    a2 = -1;
                    vx = vertices[l].x;
                    vy = vertices[l].y;
                    vz = vertices[l].z;
                    for (q = 0; q <= i && a2 < 0; q++) {
                        if (batches[q].flags & RENDER_ENVMAP) {
                            a0 = batches[q].verticesOffset;
                            while (((q == i && a0 < l) || (q != i && a0 < batches[q + 1].verticesOffset)) && a2 < 0) {
                                if (vx == vertices[a0].x && vy == vertices[a0].y && vz == vertices[a0].z) {
                                    a2 = v0[a0];
                                }
                                a0++;
                            }
                        }
                    }

                    if (a2 < 0) {
                        v0[l] = s6++;
                    } else {
                        v0[l] = a2;
                    }
                } else {
                    v0[l] = -1;
                }
            }
        }

        v06 = (Vec3f *) mempool_alloc(s6 * sizeof(Vec3f), COLOUR_TAG_ORANGE);
        if (v06 == NULL) {
            mempool_free(floatNorms);
            mempool_free(normals);
            mempool_free(v0);
            return 1;
        }

        for (k = 0; k < s6; k++) {
            v06[k].x = 0.0f;
            v06[k].y = 0.0f;
            v06[k].z = 0.0f;
        }

        for (i = 0; i < model->numberOfBatches; i++) {
            if (batches[i].miscData != BATCH_VTX_COL || (batches[i].flags & RENDER_ENVMAP)) {
                vertOffset = batches[i].verticesOffset;
                for (j = batches[i].facesOffset; j < batches[i + 1].facesOffset; j++) {
                    for (k = 0; k < 3; k++) {
                        a2 = triangles[j].verticesArray[k + 1] + vertOffset;
                        a2 = v0[a2];

                        if (a2 >= 0) {
                            v06[a2].x += floatNorms[j].x;
                            v06[a2].y += floatNorms[j].y;
                            v06[a2].z += floatNorms[j].z;
                        }
                    }
                }
            }
        }

        for (k = 0; k < s6; k++) {
            length = sqrtf(v06[k].x * v06[k].x + v06[k].y * v06[k].y + v06[k].z * v06[k].z);
            if (length != 0.0f) {
                v06[k].x /= length * (1.0f / 0x2000);
                v06[k].y /= length * (1.0f / 0x2000);
                v06[k].z /= length * (1.0f / 0x2000);
            }
        }

        a0 = 0;
        for (k = 0; k < model->numberOfVertices; k++) {
            a2 = v0[k];
            if (a2 >= 0) {
                normals[a0].x = v06[a2].x;
                normals[a0].y = v06[a2].y;
                normals[a0].z = v06[a2].z;
                a0++;
            }
        }

        model->normals = normals;
        mempool_free(v0);
        mempool_free(v06);
        mempool_free(floatNorms);
    }
    return 0;
}

/**
 * Sets the animation end offset for new models when loading.
 * This lets you choose to load more animations than the model normally would.
 */
void model_anim_offset(s32 offset) {
    gModelAnimOffsetID = offset;
}

/**
 * Checks the animation table for the model ID for animation entries.
 * Zero entries just set the anim count to zero and return early.
 * Otherwise, allocate space for animation data for each animation and loads each into each data slot.
 * Returns nonzero if something went wrong.
 */
s32 model_anim_init(ObjectModel *model, s32 modelID) {
    s32 j;
    s32 end;
    ObjectModel_44 *allocAnimData;
    s32 start;
    s32 size;
    s32 assetOffset;
    s32 assetSize;
    s32 i;
    s32 i2;
    u32 animAddress;
    s32 *temp;

    start = gAnimationTable[modelID];
    end = gAnimationTable[modelID + 1];
    if (start == end) {
        model->numberOfAnimations = 0;
        return 0;
    }
    if (gModelAnimOffsetID != 0) {
        if (start + gModelAnimOffsetID < end) {
            end = start + gModelAnimOffsetID;
        }
    }
    model->numberOfAnimations = end - start;
    allocAnimData = (ObjectModel_44 *) mempool_alloc(model->numberOfAnimations * 8, COLOUR_TAG_RED);
    model->animations = allocAnimData;
    if (allocAnimData == NULL) {
        return 1;
    }
    i = 0;
    i2 = 0;
    do {
        assetOffset = gObjectAnimationTable[start];
        animAddress = gObjectAnimationTable[start + 1] - assetOffset;
        assetSize = animAddress;
        size = get_asset_uncompressed_size(ASSET_OBJECT_ANIMATIONS, assetOffset) + 0x80;
        model->animations[i].animData = (u8 *) mempool_alloc(size, COLOUR_TAG_RED);
        if (model->animations[i].animData == NULL) {
            for (j = 0; j < i2; j++) {
                mempool_free(model->animations[j].animData);
            }
            mempool_free(model->animations);
            model->animations = NULL;
            return 1;
        }
        animAddress = (u32) (model->animations[i].animData + size) - assetSize;
        load_asset_to_address(ASSET_OBJECT_ANIMATIONS, animAddress, assetOffset, assetSize);
        gzip_inflate((u8 *) animAddress, (u8 *) model->animations[i].anim);
        temp = model->animations[i].anim;
        model->animations[i].animLength = *temp;
        model->animations[i].anim++;
        i++;
        start++;
        i2++;
    } while (start < end);

    return 0;
}

void func_80061C0C(Object *obj) {
    ObjectModel *mdl;
    ModelInstance *modInst;
    s32 var_v1;

    if (obj->modelIndex < 0) {
        obj->modelIndex = 0;
    }
    var_v1 = obj->header->numberOfModelIds - 1;
    if (var_v1 < obj->modelIndex) {
        obj->modelIndex = var_v1;
    }
    modInst = obj->modelInstances[obj->modelIndex];
    mdl = modInst->objModel;
    if (modInst->objModel->animations != NULL) {
        if (obj->animationID < 0) {
            obj->animationID = 0;
        }
        if (obj->animationID >= mdl->numberOfAnimations) {
            obj->animationID = mdl->numberOfAnimations - 1;
        }
        if (mdl->numberOfAnimations > 0) {
            var_v1 = mdl->animations[obj->animationID].animLength - 2;
        } else {
            var_v1 = 0;
        }
        if (obj->animFrame >> 4 < 0) {
            obj->animFrame = var_v1;
        }
        if (var_v1 < obj->animFrame >> 4) {
            obj->animFrame = 0;
            modInst->animationID = -1;
        }
    }
}
