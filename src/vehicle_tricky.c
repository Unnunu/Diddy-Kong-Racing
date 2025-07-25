#include "vehicle_misc.h"

#include "audio.h"
#include "audio_spatial.h"
#include "audio_vehicle.h"
#include "fade_transition.h"
#include "game.h"
#include "macros.h"
#include "math_util.h"
#include "menu.h"
#include "objects.h"
#include "particles.h"
#include "structs.h"
#include "thread3_main.h"
#include "types.h"

/************ .data ************/

// The highest index that ever seems to be read from this table is 6.
u16 gTrickyVoiceTable[16] = {
    SOUND_VOICE_BOSS_LAUGH,
    SOUND_VOICE_TRICKY_WOAH,
    SOUND_VOICE_TRICKY_WOAH2,
    SOUND_VOICE_WIZPIG_LAUGH_SHORT2,
    SOUND_VOICE_WIZPIG_LAUGH_SHORT3,
    SOUND_VOICE_TRICKY_WOAH3,
    SOUND_VOICE_TRICKY_WOAH4,
    SOUND_VOICE_TRICKY_LAUGH, // Never read from this point?
    SOUND_VOICE_TRICKY_LAUGH2,
    SOUND_VOICE_TRICKY_OW,
    SOUND_VOICE_TRICKY_OW2,
    SOUND_VOICE_CONKER_YEHAHA,
    SOUND_VOICE_TIMBER_WOW,
    SOUND_WHOOSH2,
    SOUND_NONE,
    SOUND_NONE,
};

/*******************************/

/************ .bss ************/

f32 gTrickyRacerPeakHeight;
s8 gTrickyCutsceneTimer;
u16 *gBossSoundIDOffset;
s8 gTrickyStartBoost;

/******************************/

enum TrickyAnimations { ANIM_TRICKY_IDLE, ANIM_TRICKY_RUN, ANIM_TRICKY_WALK, ANIM_TRICKY_DAMAGE };

/**
 * Overrides some basic racer properties that are either not needed or intended to work differently.
 * Also frees the engine sound data, since it won't be used.
 */
void racer_special_init(Object *object, Object_Racer *racer) {
    object->interactObj->flags = INTERACT_FLAGS_SOLID | INTERACT_FLAGS_UNK_0004;
    object->interactObj->unk11 = 0;
    object->interactObj->hitboxRadius = 30;
    object->interactObj->pushForce = 0;
    racer->animationSpeed = 0.0f;
    gTrickyRacerPeakHeight = object->trans.y_position;
    if (racer->vehicleSound) {
        racer_sound_free(object);
    }
    gTrickyCutsceneTimer = 0;
}

/**
 * Top level function for updating the Tricky vehicle as seen in the Dino Domain boss.
 */
void update_tricky(s32 updateRate, f32 updateRateF, Object *obj, Object_Racer *racer, u32 *input, u32 *buttonsPressed,
                   s32 *startTimer) {
    s16 animID;
    s16 animFrame;
    s16 tempHeadAngle;
    f32 diffX;
    f32 diffZ;
    ObjectModel *objModel;
    s32 tempStartTimer;
    ModelInstance *modInst;
    s32 headAngleRange;
    UNUSED s32 pad;
    Object *firstRacerObj;

    set_boss_voice_clip_offset(gTrickyVoiceTable);
    *buttonsPressed &= ~R_TRIG;
    *input &= ~R_TRIG;
    animID = obj->animationID;
    animFrame = obj->animFrame;
    tempHeadAngle = racer->headAngle;
    if (racer->raceFinished == TRUE) {
        func_80021400(130);
        racer->raceFinished++;
    }
    tempStartTimer = *startTimer;
    if (racer->playerIndex == PLAYER_COMPUTER) {
        if (*startTimer != 100) {
            *startTimer -= 15;
            if (*startTimer < 0) {
                if (gTrickyStartBoost == FALSE) {
                    play_random_boss_sound(BOSS_SOUND_POSITIVE);
                    racer->boostTimer = 5;
                }
                gTrickyStartBoost = TRUE;
                *startTimer = 0;
                *input |= A_BUTTON;
            } else {
                gTrickyStartBoost = FALSE;
            }
        }
    }

    func_8004F7F4(updateRate, updateRateF, obj, racer);
    *startTimer = tempStartTimer;
    racer->lateral_velocity = 0.0f;
    racer->headAngle = tempHeadAngle;
    obj->animationID = animID;
    obj->animFrame = animFrame;
    if (racer->attackType != ATTACK_NONE && obj->animationID != ANIM_TRICKY_DAMAGE) {
        racer->unk1CD = obj->animationID;
        obj->animationID = ANIM_TRICKY_DAMAGE;
        obj->y_velocity += 7.5;
        play_random_boss_sound(BOSS_SOUND_NEGATIVE);
        sound_play(SOUND_EXPLOSION, NULL);
        set_camera_shake(12.0f);
        racer->velocity *= 0.3;
        racer->animationSpeed = 0.0f;
    }
    racer->attackType = ATTACK_NONE;
    if (racer->approachTarget != NULL) {
        diffX = obj->x_velocity * obj->x_velocity;
        diffZ = obj->z_velocity * obj->z_velocity;
        racer->velocity = -sqrtf((diffX * diffX) + (diffZ * diffZ));
    }
    modInst = obj->modelInstances[0];
    objModel = modInst->objModel;
    diffX = (objModel->animations[obj->animationID].animLength * 16) - 17;
    if (obj->animationID != ANIM_TRICKY_DAMAGE) {
        if (racer->velocity < -2.0) {
            obj->animationID = ANIM_TRICKY_RUN;
            racer->animationSpeed -= (racer->velocity * updateRateF) * 0.5;
        } else if (racer->velocity < -0.1 || racer->velocity > 0.1) {
            obj->animationID = ANIM_TRICKY_WALK;
            racer->animationSpeed -= (racer->velocity * updateRateF) * 2;
        } else {
            obj->animationID = ANIM_TRICKY_IDLE;
            racer->animationSpeed += 1.0 * updateRateF;
        }
    } else {
        racer->animationSpeed += 2.0 * updateRateF;
    }
    while (racer->animationSpeed < 0.0f) {
        racer->animationSpeed += diffX;
        modInst->animationID = -1;
    }
    while (diffX < racer->animationSpeed) {
        racer->animationSpeed -= diffX;
        modInst->animationID = -1;
    }
    if (modInst->animationID == -1 && obj->animationID == ANIM_TRICKY_DAMAGE) {
        obj->animationID = racer->unk1CD;
    }
    animFrame = obj->animFrame;
    obj->animFrame = racer->animationSpeed;
    obj->particleEmittersEnabled = OBJ_EMIT_NONE;
    if (obj->animationID == ANIM_TRICKY_RUN) {
        play_footstep_sounds(obj, 2, animFrame, SOUND_STOMP2, SOUND_STOMP3);
        obj->particleEmittersEnabled |= OBJ_EMIT_1 | OBJ_EMIT_2;
    }
    obj_spawn_particle(obj, updateRate);
    fade_when_near_camera(obj, racer, 120);
    switch (obj->animationID) {
        case ANIM_TRICKY_RUN:
            headAngleRange = 0x2500;
            break;
        case ANIM_TRICKY_WALK:
            headAngleRange = 0x100;
            break;
        default:
            headAngleRange = 0x1500;
            break;
    }
    firstRacerObj = get_racer_object(PLAYER_ONE);
    diffX = firstRacerObj->trans.x_position - obj->trans.x_position;
    diffZ = firstRacerObj->trans.z_position - obj->trans.z_position;
    if (sqrtf((diffX * diffX) + (diffZ * diffZ)) < 700.0) {
        tempStartTimer = (arctan2_f(diffX, diffZ) - (obj->trans.rotation.y_rotation & 0xFFFF)) + 0x8000;
        WRAP(tempStartTimer, -0x8000, 0x8000);
        CLAMP(tempStartTimer, -headAngleRange, headAngleRange);
        racer->headAngleTarget = tempStartTimer;
    }
    if (obj->animationID == ANIM_TRICKY_RUN) {
        if ((racer->miscAnimCounter & 0x1F) < 10) {
            racer->headAngleTarget >>= 1;
        }
    }
    // Record the players height record. Falling 400 units below that will trigger a warp.
    racer = firstRacerObj->racer;
    if (gTrickyRacerPeakHeight < firstRacerObj->trans.y_position) {
        gTrickyRacerPeakHeight = firstRacerObj->trans.y_position;
    }
    if (firstRacerObj->trans.y_position + 400.0 < gTrickyRacerPeakHeight) {
        if (check_fadeout_transition() == 0 && is_in_two_player_adventure()) {
            swap_lead_player();
        }
        level_transition_begin(1);
    }
    if (obj == firstRacerObj->interactObj->obj && firstRacerObj->interactObj->flags & INTERACT_FLAGS_PUSHING &&
        obj->animationID == ANIM_TRICKY_RUN) {
        racer->attackType = ATTACK_SQUISHED;
    }
    if (racer->raceFinished != FALSE) {
        if (gTrickyCutsceneTimer == 0) {
            gTrickyCutsceneTimer = 1;
            racer_boss_finish(racer, &gTrickyCutsceneTimer);
        }
    }
}

/**
 * Set the sound ID offset for a given boss clip.
 */
void set_boss_voice_clip_offset(u16 *soundID) {
    gBossSoundIDOffset = soundID;
}

/**
 * Add a random amount to offset, then play a random voice clip within that range.
 * Also has worldspace values.
 */
void racer_boss_sound_spatial(f32 x, f32 y, f32 z, s32 offset) {
    s8 randomOffset = rand_range(0, 1);
    if (offset == 0) {
        randomOffset = 0;
    }
    offset += randomOffset;
    audspat_play_sound_at_position(gBossSoundIDOffset[offset], x, y, z, AUDIO_POINT_FLAG_ONE_TIME_TRIGGER, NULL);
}

/**
 * Add a random amount to offset, then play a random voice clip within that range.
 */
void play_random_boss_sound(s32 offset) {
    s8 randomOffset = rand_range(0, 1);
    if (offset == 0) {
        randomOffset = 0;
    }
    offset += randomOffset;
    sound_play(gBossSoundIDOffset[offset], NULL);
}

/**
 * Trigger a post-race cutscene that depends on which boss was fought, which attempt it was and if the player won or
 * not. Save the game afterwards, writing the victory, and the cutscene having been seen.
 */
void racer_boss_finish(Object_Racer *racer, s8 *sceneTimer) {
    Settings *settings;
    s8 arg1_ret;
    s8 *asset;
    s32 worldBit;
    s32 finishPos;
    UNUSED s32 pad;
    s32 miscAsset68Byte5;
    s32 miscAsset68Byte6;
    s32 miscAsset68Byte7;
    s32 i;

    arg1_ret = *sceneTimer;
    settings = get_settings();
    worldBit = (1 << settings->worldId);
    /*
        ASSET_MISC_68[] =
        ASSET_LEVELNAME_DINODOMAINTROPHYANIM,
        ASSET_LEVELNAME_SHERBETISLANDTROPHYANIM
        ASSET_LEVELNAME_SNOWFLAKEMOUNTAINTROPHYANIM,
        ASSET_LEVELNAME_DRAGONFORESTTROPHYANIM,
        ASSET_LEVELNAME_WIZPIGMOUTHSEQUENCE,
        ASSET_LEVELNAME_PARTYSEQUENCE,
        ASSET_LEVELNAME_LASTBIT,
        ASSET_LEVELNAME_LASTBITB
    */
    asset =
        (s8 *) get_misc_asset(ASSET_MISC_68); // 8 bytes - 2F 31 30 32 2A 38 3F 40 - LevelIds for the world animations?
    miscAsset68Byte5 = asset[5];              // 0x38 - 56 - ASSET_LEVELNAME_PARTYSEQUENCE?
    miscAsset68Byte6 = asset[6];              // 0x3F - 63 - ASSET_LEVELNAME_LASTBIT?
    miscAsset68Byte7 = asset[7];              // 0x40 - 64 - ASSET_LEVELNAME_LASTBITB?
    asset = (s8 *) get_misc_asset(ASSET_MISC_67); // 20 bytes - course id's array with world id index?
    for (i = 0; settings->courseId != asset[i]; i += 2) {}
    i = asset[i + 1];
    finishPos = racer->finishPosition;
    if (arg1_ret == 1) {
        if (finishPos == 1) {
            music_play(SEQUENCE_BATTLE_VICTORY);
        } else {
            music_play(SEQUENCE_BATTLE_LOSE);
        }
        if (settings->worldId == WORLD_CENTRAL_AREA || settings->worldId == WORLD_FUTURE_FUN_LAND) {
            if (finishPos == 1) {
                settings->bosses |= worldBit;
                settings->courseFlagsPtr[settings->courseId] |= 2;
            }
            if (settings->worldId == WORLD_CENTRAL_AREA) {
                if (finishPos == 1) {
                    level_properties_push(SPECIAL_MAP_ID_UNK_NEG2, 0, VEHICLE_CAR, 0);
                    level_properties_push(miscAsset68Byte5, 0, -1, 0);
                    level_properties_push(i, 0, -1, 1);
                } else {
                    level_properties_push(SPECIAL_MAP_ID_UNK_NEG10, 0, VEHICLE_CAR, 0);
                    level_properties_push(i, 0, -1, 2);
                }
            } else if (finishPos == 1) {
                set_eeprom_settings_value(1); // Set Adventure Two Unlocked
                level_properties_push(SPECIAL_MAP_ID_UNK_NEG2, 0, VEHICLE_CAR, 0);
                level_properties_push(miscAsset68Byte7, 0, -1, 0);
                level_properties_push(miscAsset68Byte6, 0, -1, 0);
                level_properties_push(i, 0, -1, 1);
            } else {
                level_properties_push(SPECIAL_MAP_ID_UNK_NEG10, 0, VEHICLE_CAR, 0);
                level_properties_push(i, 0, -1, 2);
            }
            if (finishPos == 1) {
                level_transition_begin(4);
            } else {
                level_transition_begin(3);
            }
            arg1_ret++;
            *sceneTimer = arg1_ret;
            return;
        }
        if (settings->courseFlagsPtr[settings->courseId] & 2) {
            if (finishPos == 1) {
                level_transition_begin(4);
                instShowBearBar();
            } else {
                level_transition_begin(3);
                if (is_in_two_player_adventure()) {
                    swap_lead_player();
                }
            }
            arg1_ret++;
            *sceneTimer = arg1_ret;
            return;
        }
        if (finishPos == 1) {
            settings->courseFlagsPtr[settings->courseId] |= 2;
            if (!(settings->bosses & worldBit)) {
                settings->bosses |= worldBit;
                level_properties_push(SPECIAL_MAP_ID_NO_LEVEL, 0, VEHICLE_CAR, 0);
                level_properties_push(i, 4, -1, 4);
            } else {
                worldBit <<= 6;
                if (!(settings->bosses & worldBit)) {
                    settings->bosses |= worldBit;
                    worldBit = 0;
                    if (settings->worldId > 0 && settings->worldId < 5) {
                        worldBit = settings->wizpigAmulet;
                        worldBit++;
                        if (worldBit >= 5) {
                            worldBit = 4;
                        }
                        settings->wizpigAmulet = worldBit;
                    }
                    if (worldBit != 0) {
                        level_properties_push(SPECIAL_MAP_ID_NO_LEVEL, 0, VEHICLE_CAR, 0);
                        level_properties_push(ASSET_LEVEL_WIZPIGAMULETSEQUENCE_NAME, 0, -1, settings->wizpigAmulet - 1);
                        level_properties_push(i, 6, -1, 6);
                    } else {
                        level_properties_push(SPECIAL_MAP_ID_NO_LEVEL, 0, VEHICLE_CAR, 0);
                        level_properties_push(i, 4, -1, 4);
                    }
                } else {
                    level_properties_push(SPECIAL_MAP_ID_NO_LEVEL, 0, VEHICLE_CAR, 0);
                    level_properties_push(i, 4, -1, 4);
                }
            }
            level_transition_begin(4);
            instShowBearBar();
        } else {
            level_properties_push(SPECIAL_MAP_ID_UNK_NEG10, 0, VEHICLE_CAR, 0);
            level_properties_push(i, 5, -1, 5);
            level_transition_begin(3);
        }
        arg1_ret++;
        safe_mark_write_save_file(get_save_file_index());
    }
    *sceneTimer = arg1_ret;
}

/**
 * When close to the camera, fade the object so it doesn't block the screen.
 */
void fade_when_near_camera(Object *object, Object_Racer *racer, s32 distance) {
    Object *player = get_racer_object(PLAYER_ONE);
    racer->transparency = 255;
    if (!get_race_countdown()) {
        if ((object->distanceToCamera + distance) < player->distanceToCamera) {
            racer->transparency = 64;
        }
    }
}
