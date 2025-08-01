#ifndef _OBJECTS_H_
#define _OBJECTS_H_

#include "structs.h"
#include "f3ddkr.h"
#include "object_functions.h"
#include "particles.h"
#include "save_data.h"

#define NEW_OBJECT_ENTRY(entryVar, entryId, entrySize, xPos, yPos, zPos) \
    {                                                                    \
        entryVar.x = (xPos);                                             \
        entryVar.y = (yPos);                                             \
        entryVar.z = (zPos);                                             \
        entryVar.size = ((((entryId) >> 1) & 0x80) | (entrySize));       \
        entryVar.objectID = (s8) (entryId);                              \
    }

#define NODE_NONE 255

#define BOOST_DEFAULT -1

enum ObjectBehaviours {
    BHV_NONE,
    BHV_RACER,
    BHV_SCENERY,
    BHV_FISH,
    BHV_ANIMATOR,
    BHV_WEAPON,
    BHV_SMOKE,
    BHV_EXIT,
    BHV_AUDIO,
    BHV_AUDIO_LINE,
    BHV_CAMERA_CONTROL,
    BHV_SETUP_POINT,
    BHV_DINO_WHALE,
    BHV_CHECKPOINT,
    BHV_DOOR,
    BHV_FOG_CHANGER,
    BHV_AINODE,
    BHV_WEAPON_BALLOON,
    BHV_WEAPON_2,
    BHV_AUDIO_LINE_2,
    BHV_UNK_14,
    BHV_UNK_15,
    BHV_BOMB_EXPLOSION,
    BHV_BALLOON_POP,
    BHV_UNK_18,
    BHV_UNK_19,
    BHV_SKY_CONTROL,
    BHV_AUDIO_REVERB,
    BHV_TORCH_MIST,
    BHV_TEXTURE_SCROLL,
    BHV_MODECHANGE,
    BHV_STOPWATCH_MAN,
    BHV_BANANA,
    BHV_LIGHT_RGBA,
    BHV_UNK_22,
    BHV_UNK_23,
    BHV_BUOY_PIRATE_SHIP,
    BHV_WEATHER,
    BHV_BRIDGE_WHALE_RAMP,
    BHV_RAMP_SWITCH,
    BHV_SEA_MONSTER,
    BHV_BONUS,
    BHV_UNK_2A,
    BHV_LENS_FLARE,
    BHV_LENS_FLARE_SWITCH,
    BHV_COLLECT_EGG,
    BHV_EGG_CREATOR,
    BHV_CHARACTER_FLAG,
    BHV_UNK_30,
    BHV_ANIMATION,
    BHV_ANIMATED_OBJECT,
    BHV_CAMERA_ANIMATION,
    BHV_INFO_POINT,
    BHV_CAR_ANIMATION,
    BHV_CHARACTER_SELECT,
    BHV_TRIGGER,
    BHV_VEHICLE_ANIMATION,
    BHV_ZIPPER_WATER,
    BHV_TIMETRIAL_GHOST,
    BHV_WAVE_GENERATOR,
    BHV_WAVE_POWER,
    BHV_BUTTERFLY,
    BHV_PARK_WARDEN,
    BHV_UNK_3F,
    BHV_WORLD_KEY,
    BHV_BANANA_SPAWNER,
    BHV_TREASURE_SUCKER,
    BHV_LOG,
    BHV_LAVA_SPURT,
    BHV_POS_ARROW,
    BHV_HIT_TESTER,
    BHV_MIDI_FADE,
    BHV_HIT_TESTER_2,
    BHV_EFFECT_BOX,
    BHV_TROPHY_CABINET,
    BHV_BUBBLER,
    BHV_FLY_COIN,
    BHV_GOLDEN_BALLOON,
    BHV_LASER_BOLT,
    BHV_LASER_GUN,
    BHV_PARK_WARDEN_2,
    BHV_ANIMATED_OBJECT_2,
    BHV_ZIPPER_GROUND,
    BHV_OVERRIDE_POS,
    BHV_WIZPIG_SHIP,
    BHV_ANIMATED_OBJECT_3,
    BHV_ANIMATED_OBJECT_4,
    BHV_TAJ_TELEPOINT,
    BHV_SILVER_COIN,
    BHV_BOOST,
    BHV_WARDEN_SMOKE,
    BHV_UNK_5B,
    BHV_UNK_5C,
    BHV_ZIPPER_AIR,
    BHV_UNK_5E,
    BHV_DYNAMIC_LIGHT_OBJECT_2,
    BHV_SNOWBALL,
    BHV_SNOWBALL_2,
    BHV_TELEPORT,
    BHV_ROCKET_SIGNPOST,
    BHV_ROCKET_SIGNPOST_2,
    BHV_SNOWBALL_3,
    BHV_SNOWBALL_4,
    BHV_HIT_TESTER_3,
    BHV_HIT_TESTER_4,
    BHV_RANGE_TRIGGER,
    BHV_UNK_6A,
    BHV_BOSS_HAZARD_TRIGGER,
    BHV_FIREBALL_OCTOWEAPON,
    BHV_FROG,
    BHV_SILVER_COIN_2,
    BHV_TT_DOOR,
    BHV_MIDI_FADE_POINT,
    BHV_DOOR_OPENER,
    BHV_UNK_72,
    BHV_PIG_ROCKETEER,
    BHV_FIREBALL_OCTOWEAPON_2,
    BHV_LEVEL_NAME,
    BHV_MIDI_CHANNEL_SET,
    BHV_WIZPIG_GHOSTS,
    BHV_UNK_78,
    BHV_UNK_79,
    BHV_UNK_7A,
    BHV_UNK_7B,
    BHV_UNK_7C,
    BHV_UNK_7D,
    BHV_UNK_7E,
    BHV_UNK_7F
};

enum ObjectInteractionFlags {
    INTERACT_FLAGS_NONE,
    INTERACT_FLAGS_SOLID = (1 << 0),
    INTERACT_FLAGS_TANGIBLE = (1 << 1),
    INTERACT_FLAGS_UNK_0004 = (1 << 2),
    INTERACT_FLAGS_PUSHING = (1 << 3),
    INTERACT_FLAGS_UNK_0010 = (1 << 4),
    INTERACT_FLAGS_UNK_0020 = (1 << 5),
    INTERACT_FLAGS_COLLIDED = (1 << 6),
    INTERACT_FLAGS_UNK_0080 = (1 << 7),
    INTERACT_FLAGS_UNK_0100 = (1 << 8),
    INTERACT_FLAGS_UNK_0200 = (1 << 9),
    INTERACT_FLAGS_UNK_0400 = (1 << 10),
    INTERACT_FLAGS_UNK_0800 = (1 << 11),
    INTERACT_FLAGS_UNK_1000 = (1 << 12),
    INTERACT_FLAGS_UNK_2000 = (1 << 13),
    INTERACT_FLAGS_UNK_4000 = (1 << 14),
    INTERACT_FLAGS_UNK_8000 = (1 << 15),
};

enum ObjectSpawnFlags {
    OBJECT_SPAWN_NONE,
    OBJECT_SPAWN_UNK01 = (1 << 0),
    OBJECT_SPAWN_UNK02 = (1 << 1),
    OBJECT_SPAWN_UNK04 = (1 << 2),
    OBJECT_SPAWN_UNK08 = (1 << 3),
    OBJECT_SPAWN_NO_LODS = (1 << 4) // Forces the object to have 1 model associate. Used to prevent LoD models of player model racers spawning.
};

enum ObjectHeaderFlags {
    OBJECT_HEADER_NONE,
    OBJECT_HEADER_UNK01 = (1 << 0),
    OBJECT_HEADER_UNK02 = (1 << 1),
    OBJECT_HEADER_UNK04 = (1 << 2),
    OBJECT_HEADER_UNK08 = (1 << 3),
    OBJECT_HEADER_UNK10 = (1 << 4),
    OBJECT_HEADER_NO_TIME_TRIAL = (1 << 5), // Disable object in time trial mode.
    OBJECT_HEADER_NO_MULTIPLATER = (1 << 6) // Disable object in multiplayer.
};

enum ObjectBehaviourFlags {
    OBJECT_BEHAVIOUR_NONE,
    OBJECT_BEHAVIOUR_SHADED = (1 << 0),
    OBJECT_BEHAVIOUR_SHADOW = (1 << 1),
    OBJECT_BEHAVIOUR_WATER_EFFECT = (1 << 2),
    OBJECT_BEHAVIOUR_ANIMATION = (1 << 3),
    OBJECT_BEHAVIOUR_INTERACTIVE = (1 << 4),
    OBJECT_BEHAVIOUR_COLLIDABLE = (1 << 5)
};

enum ContPakErrors {
    CONTPAK_ERROR_MISSING = -1,
    CONTPAK_ERROR_NONE,
    CONTPAK_ERROR_UNKNOWN, // Time trial ghost has reached its size limit?
    CONTPAK_ERROR_FULL,
    CONTPAK_ERROR_DAMAGED
};

enum TajChallengeReasons {
    CHALLENGE_END_FINISH,
    CHALLENGE_END_QUIT,
    CHALLENGE_END_OOB // out of bounds
};

typedef struct RacerShieldGfx {
    s16 x_position;
    s16 y_position;
    s16 z_position;
    s16 y_offset;
    f32 scale;
    f32 turnSpeed;
} RacerShieldGfx;

typedef struct BossRaceVehicles {
    s8 playerVehicle;
    s8 bossVehicle;
} BossRaceVehicles;

/* Size: 0x3C bytes */
typedef struct CheckpointNode {
    /* 0x00 */ f32 rotationXFrac;
    /* 0x04 */ f32 rotationYFrac;
    /* 0x08 */ f32 rotationZFrac;
    /* 0x0C */ f32 unkC;
    /* 0x10 */ f32 x;
    /* 0x14 */ f32 y;
    /* 0x18 */ f32 z;
    /* 0x1C */ f32 scale;
    /* 0x20 */ f32 distance;
    /* 0x24 */ f32 altDistance; // Appears to be exactly the same as distance?
    /* 0x28 */ Object *obj;
    /* 0x2C */ s16 checkpointID;
    /* 0x2E */ s8 unk2E[4];
    /* 0x32 */ s8 unk32[4];
    /* 0x36 */ s8 unk36[4];   // Appear to be flags of some sort?
    /* 0x3A */ s8 altRouteID; // -1 if there's none to be found.
    /* 0x3B */ u8 unk3B;
} CheckpointNode;

/* Size: 0x40 bytes */
typedef struct unk800179D0 {
    s32 unk0;
    Object *unk04;
    Object *unk08;
    f32 unk0C[12];
    u32 unk3C;
} unk800179D0;

typedef struct TTGhostTable {
    u8 mapId;
    u8 defaultVehicleId;
    s32 ghostOffset;
} TTGhostTable;

typedef struct ObjectTransformExt {
    ObjectTransform trans;
    s16 animFrame;
    s16 unk1A;
} ObjectTransformExt;

/* Size: 0x1A bytes */
typedef struct ObjectTransform_800135B8 {
    ObjectTransform trans;
    s16 unk18;
} ObjectTransform_800135B8;

typedef struct unk800149C0 {
    u8 pad0[4];
    u8 unk4;
    u8 pad5;
    s16 unk6;
} unk800149C0;

typedef struct RacerFXData {
    u8 unk0;
    u8 unk1;
    u8 unk2;
    u8 unk3;
} RacerFXData;

extern s32 osCicId; // Used for an Anti-Piracy check in render_3d_model

Object *racerfx_get_boost(s32 boostID);
void allocate_object_pools(void);
void clear_object_pointers(void);
void free_all_objects(void);
s32 normalise_time(s32 timer);
void func_8000CBC0(void);
s32 func_8000CC20(Object *obj);
s32 get_contpak_error(void);
void instShowBearBar(void);
s8 func_8000E138(void);
s8 racetype_demo(void);
s8 is_race_started_by_player_two(void);
s8 is_player_two_in_control(void);
void toggle_lead_player_index(void);
void reset_lead_player_index(void);
s8 find_non_car_racers(void);
s8 check_if_silver_coin_race(void);
void despawn_player_racer(Object *obj, s32 vehicleID);
void set_time_trial_enabled(s32 status);
u8 is_time_trial_enabled(void);
u8 is_in_time_trial(void);
Object *get_object(s32 index);
Object **objGetObjList(s32 *arg0, s32 *cnt);
s32 obj_count(void);
s32 particle_count(void);
void add_particle_to_entity_list(Object *obj);
void free_object(Object *);
s32 obj_table_ids(void);
s32 obj_id_valid(s32 arg0);
void path_enable(void);
s32 get_race_countdown(void);
s32 get_race_start_timer(void);
void ignore_bounds_check(void);
void func_80012C30(void);
void func_80012C3C(Gfx **dList);
void func_80012C98(Gfx **dList);
void func_80012CE8(Gfx **dList);
void render_object(Gfx **dList, Mtx **mtx, Vertex **verts, Object *obj);
void object_undo_player_tumble(Object *obj);
void render_object_parts(Object *obj);
void unset_temp_model_transforms(Object *obj);
void obj_tick_anims(void);
u32 func_800179D0(void);
void set_taj_challenge_type(s32 vehicleID);
s16 get_taj_challenge_type(void);
Object *find_taj_object(void);
void race_finish_adventure(s32 unusedArg);
s16 race_finish_timer(void);
u32 get_balloon_cutscene_timer(void);
s32 timetrial_valid_player_ghost(void);
Object *timetrial_player_ghost(void);
s32 timetrial_staff_ghost_check(Object *obj);
Object *timetrial_ghost_staff(void);
s32 timetrial_staff_unbeaten(void);
SIDeviceStatus timetrial_save_player_ghost(s32 controllerIndex);
u8 has_ghost_to_save(void);
void set_ghost_none(void);
f32 racer_calc_distance_to_opponent(Object_Racer *racer1, Object_Racer *racer2);
CheckpointNode *get_checkpoint_node(s32 checkpointID);
CheckpointNode *find_next_checkpoint_node(s32 splinePos, s32 arg1);
s32 get_checkpoint_count(void);
Object **get_racer_objects(s32 *numRacers);
Object **get_racer_objects_by_port(s32 *numRacers);
Object **get_racer_objects_by_position(s32 *numRacers);
Object *get_racer_object(s32 index);
void debug_render_checkpoint_node(s32 checkpointID, s32 pathID, Gfx **dList, Mtx **mtx, Vertex **vtx);
Object *spectate_object(s32 cameraIndex);
void ainode_enable(void);
void ainode_tail_set(s32 nodeID);
Object *ainode_tail(s32 *nodeID);
Object *ainode_get(s32 nodeID);
void set_world_shading(f32 ambient, f32 diffuse, s16 angleX, s16 angleY, s16 angleZ);
void set_shading_properties(ShadeProperties *arg0, f32 ambient, f32 diffuse, s16 angleX, s16 angleY, s16 angleZ);
void obj_shade_fancy(ObjectModel *model, Object *object, s32 arg2, f32 intensity);
s32 *get_misc_asset(s32 index);
s32 is_bridge_raised(s32 arg0);
void start_bridge_timer(s32 arg0);
void obj_bridge_pos(s32 timing, f32 *x, f32 *y, f32 *z);
s16 cutscene_id(void);
void cutscene_id_set(s32 cutsceneID);
void func_8001E45C(s32 cutsceneID);
s32 get_object_list_index(void);
s8 func_8001F3B8(void);
void func_8001F3C8(s32 arg0);
void func_8001F450(void);
s32 func_800210CC(s8 arg0);
s8 func_800214C4(void);
f32 lerp(f32 *data, u32 index, f32 t);
void func_800228DC(s32 arg0, s32 arg1, s32 arg2);
void init_racer_for_challenge(s32 vehicleID);
s8 is_taj_challenge(void);
s32 func_80023568(void);
s8 obj_door_override(void);
void obj_door_open(s32 setting);
void run_object_init_func(Object *obj, void *entry, s32 param);
void run_object_loop_func(Object *obj, s32 updateRate);
s16 *func_80024594(s32 *currentCount, s32 *maxCount);
void func_800245B4(s16 arg0);
void object_do_player_tumble(Object *this);
f32 catmull_rom_interpolation(f32 *data, s32 index, f32 x);
f32 cubic_spline_interpolation(f32 *data, s32 index, f32 x, f32 *derivative);
s16 obj_elevation(f32 yPos);
void func_80021400(s32 arg0);
s32 timetrial_init_player_ghost(s32 playerID);
s32 move_object(Object *obj, f32 xPos, f32 yPos, f32 zPos);
Object *get_racer_object_by_port(s32 index);
void render_racer_shield(Gfx **dList, Mtx **mtx, Vertex **vtxList, Object *obj);
void render_racer_magnet(Gfx **dList, Mtx **mtx, Vertex **vtxList, Object *obj);
void update_envmap_position(f32 x, f32 y, f32 z);
s32 init_object_water_effect(Object *obj, WaterEffect *waterEffect);
s32 timetrial_load_staff_ghost(s32 mapId);
void render_3d_billboard(Object *obj);
void render_misc_model(Object *obj, Vertex *verts, u32 numVertices, Triangle *triangles, u32 numTriangles,
                       TextureHeader *tex, u32 flags, u32 texOffset, f32 scaleY);
void racerfx_free(void);
void func_80016BC4(Object *obj);
s32 ainode_register(Object *obj);
void obj_taj_create_balloon(s32 blockID, f32 x, f32 y, f32 z);
Object *racer_find_nearest_opponent_relative(Object_Racer *racer, s32 position, f32 *distance);
s32 obj_init_collision(Object *obj, ObjectCollision *colData);
void func_8000E4E8(s32 index);
void objFreeAssets(Object *obj, s32 count, s32 objType);
void obj_collision_transform(Object *obj);
s32 play_footstep_sounds(Object *obj, s32 arg1, s32 frame, s32 oddSoundId, s32 evenSoundId);
void render_3d_misc(Object *obj);
Object *spectate_nearest(Object *obj, s32 *cameraId);
s32 init_object_shadow(Object *obj, ShadowData *shadow);
s32 render_mesh(ObjectModel *objModel, Object *obj, s32 startIndex, s32 flags, s32 overrideVerts);
void render_bubble_trap(ObjectTransform *trans, Sprite *gfxData, Object *obj, s32 flags);
void gParticlePtrList_flush(void);
s32 init_object_shading(Object *obj, ShadeProperties *shadeData);
ObjectHeader *load_object_header(s32 index);
s32 obj_init_attachpoint(Object *);
void try_free_object_header(s32 index);
s32 get_object_property_size(Object *obj, void *obj64);
void light_setup_light_sources(Object *obj);
s32 init_object_interaction_data(Object *obj, ObjectInteraction *interactObj);
s32 obj_init_emitter(Object *obj, ParticleEmitter *emitter);
s32 obj_init_property_flags(s32 behaviorId);
void tt_ghost_beaten(s32 arg0, s16 *playerId);
void obj_init_animobject(Object *, Object *);
Object *obj_butterfly_node(f32 x, f32 y, f32 z, f32 maxDistCheck, s32 dontCheckYAxis);
void func_8002125C(Object *obj, LevelObjectEntry_Animation *entry, Object_AnimatedObject *animObj, UNUSED s32 index);
void func_80021104(Object *obj, Object_AnimatedObject *animObj, LevelObjectEntry_Animation *entry);
s32 homing_rocket_get_next_direction(Object *obj, s32 checkpoint, u8 arg2, s32 arg3, s32 arg4, f32 checkpointDist, f32 *outX, f32 *outY,
                  f32 *outZ);
void func_80016500(Object *obj, Object_Racer *racer);
void track_spawn_objects(s32, s32);
u8 timetrial_init_staff_ghost(s32 trackId);
s8 set_course_finish_flags(Settings *settings);
void process_object_interactions(void);
void render_3d_model(Object *obj);
void mode_end_taj_race(s32 reason);
void ainode_update(void);
void func_8001E6EC(s8);
Object *obj_spawn_attachment(s32 objID);
void sort_objects_by_dist(s32 startIndex, s32 lastIndex);
void func_80016748(Object *obj0, Object *obj1);
void race_finish_time_trial(void);
s32 obj_dist_racer(f32 x, f32 y, f32 z, f32 radius, s32 is2dCheck, Object **sortObj);
void mode_init_taj_race(void);
void racerfx_update(s32 updateRate);
f32 catmull_rom_derivative(f32 *data, s32 index, f32 x);
void race_transition_adventure(s32 updateRate);
void func_8001E4C4(void);
void racerfx_alloc(s32 numberOfVertices, s32 numberOfTriangles);
s32 func_80014B50(s32 arg0, s32 arg1, f32 arg2, u32 arg3);
s32 ainode_find_next(s32 nodeId, s32 nextNodeId, s32 direction);
unk800179D0 *func_8001790C(Object *arg0, Object *arg1);
unk800179D0 *func_80017978(Object *obj1, Object *obj2);
s8 func_800214E4(Object *obj, s32 updateRate);
f32 lerp_and_get_derivative(f32 *data, u32 index, f32 t, f32 *derivative);
void race_check_finish(s32 updateRate);

/**
 * Faster variant of the shading function for objects.
 * Unlike the fancy option, does not calculate envmaps.
 */
void obj_shade_fast(ObjectModel *model, Object *obj, f32 intensity);

/**
 * Animation function for objects. Does per-vertex transformation.
 */
s32 obj_animate(Object *obj);

// Non Matching
void calc_dynamic_lighting_for_object_1(Object *, ObjectModel *, s16, Object *, f32, f32);
void calc_dynamic_lighting_for_object_2(Object *, ObjectModel *, s16, f32);
void decrypt_magic_codes(s32 *data, s32 length);
s32 get_first_active_object(s32 *);
Object *spawn_object(LevelObjectEntryCommon *entry, s32);
s32 func_8001F460(Object *, s32, Object *);
void func_8000B750(Object *racerObj, s32 racerIndex, s32 vehicleIDPrev, s32 boostType, s32 arg4);
void func_80018CE0(Object *racerObj, f32 xPos, f32 yPos, f32 zPos, s32 updateRate);
s32 checkpoint_is_passed(s32 checkpointIndex, Object *obj, f32 objX, f32 objY, f32 objZ, f32 *arg5, u8 *arg6);
void obj_tex_animate(Object *, s32);
Object *find_furthest_telepoint(f32 x, f32 z);
void model_init_collision(ObjectModel *);
void set_temp_model_transforms(Object *);
void obj_destroy(Object *, s32);
void func_800135B8(Object *);
void track_setup_racers(Vehicle, u32, s32);
void checkpoint_update_all(void);
void spectate_update(void);
void func_8001E93C(void);
void func_80019808(s32 updateRate);
void func_80014090(Object *, s32);
void audspat_update_all(Object **, s32, s32);
void func_8001E89C(void);
CheckpointNode *func_800230D0(Object *, Object_Racer *);
void obj_update(s32 updateRate);
void func_800159C8(Object *, Object *);
void obj_door_number(ObjectModel *, Object *);
s16 func_8001CD28(s32 arg0, s32 arg1, s32 arg2, s32 arg3); // NON MATCHING
f32 func_8001C6C4(Object_NPC *, Object *, f32, f32, s32);
s32 collision_objectmodel(Object *obj, s32 arg1, s32* arg2, Vec3f *arg3, f32* arg4, f32* arg5, s8* surface);
s32 func_80017A18(ObjectModel *, s32, s32 *, f32 *, f32 *, f32 *, f32 *, f32 *, f32 *, f32 *, s8 *argA,
                  f32); // NON EQUIVALENT
#endif
