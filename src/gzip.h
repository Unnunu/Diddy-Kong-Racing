#ifndef _GZIP_H_
#define _GZIP_H_

#include "types.h"

typedef struct huft {
  u8 e;                /* number of extra bits or operation */
  u8 b;                /* number of bits in this code or subcode */
  union {
    u16 n;              /* literal, length base, or distance base */
    struct huft *t;     /* pointer to next level of table */
  } v;
} huft;

/* If BMAX needs to be larger than 16, then h and x[] should be ulg. */
#define BMAX 16         /* maximum bit length of any code (16 for explode) */
#define N_MAX 288       /* maximum number of codes in any set */

void gzip_init(void);
s32 byteswap32(u8 *arg0);
s32 gzip_size_uncompressed(s32 assetIndex, s32 assetOffset);
u8 *gzip_inflate(u8 *compressedInput, u8 *decompressedOutput);
void gzip_huft_build(u32 *b, u32 n, u32 s, u16 *d, u16 *e, huft **t, s32 *m);
s32 gzip_inflate_block(void);

#endif
