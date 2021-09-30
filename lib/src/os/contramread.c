/* The comment below is needed for this file to be picked up by generate_ld */
/* RAM_POS: 0x800CDCA0 */

#include "macros.h"
#include "libultra_internal.h"
#include "controller.h"
#include "siint.h"

#if 0
GLOBAL_ASM("lib/asm/non_matchings/unknown_0CE8A0/__osContRamRead.s")
GLOBAL_ASM("lib/asm/non_matchings/unknown_0CE8A0/__osPackRamReadData.s")
#else
extern s32 D_8012CE1C;
static void __osPackRamReadData(int channel, u16 address);
s32 __osContRamRead(OSMesgQueue *mq, int channel, u16 address, u8 *buffer) {
    s32 ret;
    int i;
    u8 *ptr;
    __OSContRamReadFormat ramreadformat;
    int retry;
    ret = 0;
    ptr = (u8 *)&__osPfsPifRam;
    retry = 2;
    __osSiGetAccess();
    __osContLastCmd = CONT_CMD_READ_MEMPACK;
    __osPackRamReadData(channel, address);
    ret = __osSiRawStartDma(OS_WRITE, &__osPfsPifRam);
    osRecvMesg(mq, NULL, OS_MESG_BLOCK);
    do {
		for (i = 0; i < ARRLEN(__osPfsPifRam.ramarray) + 1; i++) { // also clear pifstatus
			__osPfsPifRam.ramarray[i] = 0xFFU;
		}
		D_8012CE1C = 0;
        ret = __osSiRawStartDma(OS_READ, &__osPfsPifRam);
        osRecvMesg(mq, NULL, OS_MESG_BLOCK);
        ptr = (u8 *)&__osPfsPifRam;
        if (channel != 0) {
            for (i = 0; i < channel; i++) {
                ptr++;
            }
        }
        ramreadformat = *(__OSContRamReadFormat *)ptr;
        ret = CHNL_ERR(ramreadformat);
        if (ret == 0) {
            u8 c;
            c = __osContDataCrc((u8*)&ramreadformat.data);
            if (c != ramreadformat.datacrc) {
                ret = __osPfsGetStatus(mq, channel);
                if (ret != 0) {
                    __osSiRelAccess();
                    return ret;
                }
                ret = PFS_ERR_CONTRFAIL;
            } else {
                for (i = 0; i < ARRLEN(ramreadformat.data); i++) {
                    *buffer++ = ramreadformat.data[i];
                }
            }
        }
        if (ret != PFS_ERR_CONTRFAIL)
            break;
    } while (retry-- >= 0);
    __osSiRelAccess();
    return ret;
}

static void __osPackRamReadData(int channel, u16 address) {
    u8 *ptr;
    __OSContRamReadFormat ramreadformat;
    int i;

    ptr = (u8 *)__osPfsPifRam.ramarray;

    for (i = 0; i < ARRLEN(__osPfsPifRam.ramarray) + 1; i++) { // also clear pifstatus
        __osPfsPifRam.ramarray[i] = 0;
    }
	
    __osPfsPifRam.pifstatus = CONT_CMD_EXE;
    ramreadformat.dummy = CONT_CMD_NOP;
    ramreadformat.txsize = CONT_CMD_READ_MEMPACK_TX;
    ramreadformat.rxsize = CONT_CMD_READ_MEMPACK_RX;
    ramreadformat.cmd = CONT_CMD_READ_MEMPACK;
    ramreadformat.address = (address << 0x5) | __osContAddressCrc(address);
    ramreadformat.datacrc = CONT_CMD_NOP;
    for (i = 0; i < ARRLEN(ramreadformat.data); i++) {
        ramreadformat.data[i] = CONT_CMD_NOP;
    }
    if (channel != 0) {
        for (i = 0; i < channel; i++) {
            *ptr++ = 0;
        }
    }
    *(__OSContRamReadFormat *)ptr = ramreadformat;
    ptr += sizeof(__OSContRamReadFormat);
    ptr[0] = CONT_CMD_END;
}
#endif
