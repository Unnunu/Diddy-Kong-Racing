#ifndef _AUDIO_H_
#define _AUDIO_H_

#include "sched.h"
#include "audiosfx.h"

#define AUDIO_CHANNELS 16
#define MUSIC_CHAN_MASK_NONE 0xFFFFFFFF

enum AudioVolumeBehaviour {
    VOLUME_NORMAL,
    VOLUME_LOWER,
    VOLUME_LOWER_AMBIENT,
    VOLUME_UNK03,
};

/* Size: 0x0A bytes */
typedef struct SoundData {
 u16 soundBite; // Audio file index.
 u8 volume; // Multiplied by 256. 128 = 32768, max volume.
 u8 minVolume;
 u8 pitch; // Fractional. 100 = 1.0f.
 u8 unk5;
 u16 range; // Ingame units distance, same as any other.
 u8 priority;
 u8 unk9;
} SoundData;

/* Size: 0x03 bytes */
typedef struct MusicData {
    u8 volume;
    u8 tempo;
    u8 reverb;
} MusicData;

/* Size: 0x08 bytes */
typedef struct DelayedSound {
    /* 0x00 */ u16 soundId;
    /* 0x02 */ s16 timer;
    /* 0x04 */ SoundHandle *handlePtr;
} DelayedSound;

// These are all functions in libultra that seem to have been created by Rare, so they're not in the standard headers.
extern void set_voice_limit(ALCSPlayer *seqp, u8 voiceLimit); // seqplayer.c
extern void alCSPSetFadeIn(ALCSPlayer *seqp, u8 chan, ALPan pan); // cspsetfadein.c
extern void alFxReverbSet(u8 setting); // reverb.c
extern u8 alCSPGetFadeIn(ALCSPlayer *seqp, u8 chan); // cspgetfadein.c

void audio_init(OSSched *sc);
void sound_volume_reset(u8 skipReset);
void sound_volume_change(s32 behaviour);
void music_change_off(void);
void music_change_on(void);
void music_play(u8 seqID);
void music_voicelimit_set(u8 voiceLimit);
void music_voicelimit_change_off(void);
void music_voicelimit_change_on(void);
void music_jingle_voicelimit_set(u8 voiceLimit);
void music_fade(s32 time);
void music_volume_reset(void);
void sound_update_queue(u8 updateRate);
void sound_play_delayed(u16 soundId, SoundHandle *handlePtr, f32 delayTime);
void sound_clear_delayed(void);
u16 music_channel_get_mask(void);
void music_dynamic_set(u16 channelMask);
void music_channel_off(u8 channel);
s32 music_channel_active(s32 channel);
void music_channel_on(u8 channel);
void music_channel_pan_set(u8 channel, ALPan pan);
void music_channel_volume_set(u8 channel, u8 volume);
void music_channel_fade_set(u8 channel, ALPan fade);
u8 music_channel_fade(u8 channel);
void music_channel_reset_all(void);
void music_tempo_set_relative(f32 tempo);
void music_tempo_set(s32 tempo);
s16 music_tempo(void);
u8 music_is_playing(void);
void music_jingle_play_safe(u8 jingleID);
void sound_jingle_tempo_set(s32 tempo);
void music_stop(void);
u8 music_can_play(void);
void music_jingle_stop(void);
u8 music_current_sequence(void);
u8 music_jingle_current(void);
void music_volume_set(u8 volume);
void music_volume_config_set(u32 slider_val);
u8 music_volume(void);
s32 music_volume_config(void);
void music_jingle_volume_set(u8 arg0);
void music_jingle_pan_set(ALPan pan);
void music_jingle_play(u8 seqID);
u32 music_jingle_playing(void);
u16 sound_distance(u16 soundId);
void sound_play_spatial(u16 soundID, f32 x, f32 y, f32 z, SoundHandle *handlePtr);
void sound_play_direct(u16 soundID, SoundHandle *handlePtr);
u16 sound_count(void);
u8 music_sequence_count(void);
void sound_table_properties(SoundData **table, s32 *size, s32 *count);
u8 sound_is_looped(u16 soundID);
ALCSPlayer *sound_seqplayer_init(s32 maxVoices, s32 maxEvents);
void music_sequence_start(u8 seqID, ALCSPlayer *seqPlayer);
void music_sequence_stop(ALCSPlayer *seqPlayer);
void sound_reverb_set(u8 setting);
void func_80063A90(ALCSPlayer *seqp, u8 channel);
void sound_volume_set_relative(u16 soundID, SoundHandle soundHandle, u8 volume);
void music_sequence_init(ALCSPlayer *seqp, void *sequence, u8 *seqID, ALCSeq *seq);
void sound_play(u16 soundID, SoundHandle* handlePtr);
f32 music_animation_fraction(void);

#endif
