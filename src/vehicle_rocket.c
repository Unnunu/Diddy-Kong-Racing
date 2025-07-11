#include "vehicle_misc.h"

#include "audio.h"
#include "camera.h"
#include "macros.h"
#include "objects.h"
#include "particles.h"
#include "racer.h"
#include "types.h"

/************ .data ************/

// The highest index that ever seems to be read from this table is 6.
u16 gRocketVoiceTable[16] = {
    SOUND_VOICE_BOSS_LAUGH2,
    SOUND_VOICE_TRICKY_HM,
    SOUND_VOICE_TRICKY_HMMM,
    SOUND_VOICE_WIZPIG_LAUGH4,
    SOUND_VOICE_WIZPIG_LAUGH2,
    SOUND_VOICE_WIZPIG_GROAN,
    SOUND_VOICE_WIZPIG_LAUGH3,
    SOUND_VOICE_SMOKEY_HAH, // Never read from this point?
    SOUND_VOICE_SMOKEY_LAUGH,
    SOUND_VOICE_SMOKEY_HM,
    SOUND_VOICE_SMOKEY_HM2,
    SOUND_VOICE_CONKER_YEHAHA,
    SOUND_VOICE_TIMBER_WOW,
    SOUND_WHOOSH2,
    SOUND_NONE,
    SOUND_NONE,
};

/*******************************/

/************ .bss ************/

s8 gRocketCutsceneTimer;
s8 gRocketStartBoost;

/******************************/

enum RocketAnimations { ANIM_ROCKET_IDLE, ANIM_ROCKET_DAMAGE };

/**
 * Top level update function for the Wizpig Rocket vehicle, used in the Wizpig rematch.
 */
void update_rocket(s32 updateRate, f32 updateRateF, Object *obj, Object_Racer *racer, u32 *input, u32 *buttonsPressed,
                   s32 *startTimer) {
    s16 animID;
    s16 animFrame;
    s16 tempHeadAngle;
    f32 diffZ;
    f32 diffX;
    s32 tempStartTimer;
    Object *someObj;
    Object *firstRacerObj;
    Object_Boost *boost;
    ModelInstance *modInst;
    ObjectModel *objModel;

    set_boss_voice_clip_offset(gRocketVoiceTable);
    racer->tappedR = 0;
    animID = obj->animationID;
    animFrame = obj->animFrame;
    tempHeadAngle = racer->headAngle;
    if (racer->velocity < 0.3 && -0.3 < racer->velocity) {
        *buttonsPressed = 0;
    }
    if (racer->raceFinished == TRUE && func_80023568()) {
        func_80021400(130);
        racer->raceFinished++;
    }
    tempStartTimer = *startTimer;
    if (tempStartTimer == 100) {
        gRocketCutsceneTimer = 0;
    }
    racer->zipperDirCorrection = FALSE;
    if (racer->playerIndex == PLAYER_COMPUTER) {
        if (*startTimer != 100) {
            *startTimer -= 30;
            if (*startTimer < 0) {
                if (gRocketStartBoost == FALSE) {
                    play_random_boss_sound(BOSS_SOUND_POSITIVE);
                }
                gRocketStartBoost = TRUE;
                *startTimer = 0;
                *input |= A_BUTTON;
            } else {
                gRocketStartBoost = FALSE;
            }
        }
    }
    racer->vehicleID = VEHICLE_CARPET;
    func_80049794(updateRate, updateRateF, obj, racer);
    racer->vehicleID = racer->vehicleIDPrev;
    *startTimer = tempStartTimer;
    obj->particleEmittersEnabled = OBJ_EMIT_NONE;
    racer->headAngle = tempHeadAngle;
    obj->animationID = animID;
    obj->animFrame = animFrame;
    if (racer->attackType != ATTACK_NONE && obj->animationID != ANIM_ROCKET_DAMAGE) {
        play_random_boss_sound(BOSS_SOUND_NEGATIVE);
        sound_play(SOUND_EXPLOSION, NULL);
        set_camera_shake(12.0f);
        obj->x_velocity *= 0.4;
        obj->animationID = ANIM_ROCKET_DAMAGE;
        obj->z_velocity *= 0.4;
        racer->animationSpeed = 0.0f;
        obj->y_velocity += 4.0;
    }
    racer->attackType = ATTACK_NONE;
    if (racer->approachTarget != NULL) {
        diffX = obj->x_velocity * obj->x_velocity;
        diffZ = obj->z_velocity * obj->z_velocity;
        racer->velocity = -sqrtf((diffX * diffX) + (diffZ * diffZ));
        if (racer->velocity > -0.5) {
            racer->velocity = 0.0f;
            obj->x_velocity = 0.0f;
            obj->y_velocity = 0.0f;
            obj->z_velocity = 0.0f;
        }
    }
    racer->animationSpeed += 2.0 * updateRateF;
    modInst = obj->modelInstances[0];
    objModel = modInst->objModel;
    diffX = (objModel->animations[obj->animationID].animLength * 16) - 17;
    while (diffX <= racer->animationSpeed) {
        racer->animationSpeed -= diffX;
        modInst->animationID = -1;
    }
    while (racer->animationSpeed <= 0.0f) {
        racer->animationSpeed += diffX;
        modInst->animationID = -1;
    }
    if (obj->animationID == ANIM_ROCKET_DAMAGE && modInst->animationID == -1) {
        obj->animationID = ANIM_ROCKET_IDLE;
        racer->animationSpeed = 0.0f;
    }
    obj->animFrame = racer->animationSpeed;
    obj->particleEmittersEnabled = OBJ_EMIT_NONE;
    update_vehicle_particles(obj, updateRate);
    fade_when_near_camera(obj, racer, 40);
    if (*startTimer != 100) {
        someObj = racerfx_get_boost(BOOST_DEFAULT);
        if (someObj != NULL) {
            boost = someObj->boost;
            someObj->properties.common.unk0 = 0;
            if (boost != NULL) {
                boost->unk72 += updateRate;
                boost->unk70 = 2;
                boost->unk74 = 1.0f;
                func_8000B750(obj, -1, 2, 1, 1);
            }
        }
    }
    firstRacerObj = get_racer_object(PLAYER_ONE);
    racer = firstRacerObj->racer;
    if (obj == firstRacerObj->interactObj->obj && firstRacerObj->interactObj->flags & INTERACT_FLAGS_PUSHING &&
        obj->animationID == ANIM_ROCKET_DAMAGE) {
        racer->attackType = ATTACK_SQUISHED;
    }
    if (racer->raceFinished != 0) {
        if (gRocketCutsceneTimer == 0) {
            gRocketCutsceneTimer = 1;
            racer_boss_finish(racer, &gRocketCutsceneTimer);
        }
    }
}
