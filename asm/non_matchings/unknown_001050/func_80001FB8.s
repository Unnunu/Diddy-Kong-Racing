glabel func_80001FB8
/* 002BB8 80001FB8 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 002BBC 80001FBC 308EFFFF */  andi  $t6, $a0, 0xffff
/* 002BC0 80001FC0 000EC880 */  sll   $t9, $t6, 2
/* 002BC4 80001FC4 3C188011 */  lui   $t8, %hi(D_80115D18) # $t8, 0x8011
/* 002BC8 80001FC8 8F185D18 */  lw    $t8, %lo(D_80115D18)($t8)
/* 002BCC 80001FCC 032EC821 */  addu  $t9, $t9, $t6
/* 002BD0 80001FD0 0019C840 */  sll   $t9, $t9, 1
/* 002BD4 80001FD4 AFBF0014 */  sw    $ra, 0x14($sp)
/* 002BD8 80001FD8 AFA40018 */  sw    $a0, 0x18($sp)
/* 002BDC 80001FDC AFA5001C */  sw    $a1, 0x1c($sp)
/* 002BE0 80001FE0 AFA60020 */  sw    $a2, 0x20($sp)
/* 002BE4 80001FE4 03194021 */  addu  $t0, $t8, $t9
/* 002BE8 80001FE8 91090002 */  lbu   $t1, 2($t0)
/* 002BEC 80001FEC 30CF00FF */  andi  $t7, $a2, 0xff
/* 002BF0 80001FF0 44892000 */  mtc1  $t1, $f4
/* 002BF4 80001FF4 01E03025 */  move  $a2, $t7
/* 002BF8 80001FF8 05210005 */  bgez  $t1, .L80002010
/* 002BFC 80001FFC 468021A0 */   cvt.s.w $f6, $f4
/* 002C00 80002000 3C014F80 */  li    $at, 0x4F800000 # 4294967296.000000
/* 002C04 80002004 44814000 */  mtc1  $at, $f8
/* 002C08 80002008 00000000 */  nop   
/* 002C0C 8000200C 46083180 */  add.s $f6, $f6, $f8
.L80002010:
/* 002C10 80002010 44865000 */  mtc1  $a2, $f10
/* 002C14 80002014 04C10005 */  bgez  $a2, .L8000202C
/* 002C18 80002018 46805420 */   cvt.s.w $f16, $f10
/* 002C1C 8000201C 3C014F80 */  li    $at, 0x4F800000 # 4294967296.000000
/* 002C20 80002020 44819000 */  mtc1  $at, $f18
/* 002C24 80002024 00000000 */  nop   
/* 002C28 80002028 46128400 */  add.s $f16, $f16, $f18
.L8000202C:
/* 002C2C 8000202C 3C0142FE */  li    $at, 0x42FE0000 # 127.000000
/* 002C30 80002030 44812000 */  mtc1  $at, $f4
/* 002C34 80002034 8FAC001C */  lw    $t4, 0x1c($sp)
/* 002C38 80002038 46048203 */  div.s $f8, $f16, $f4
/* 002C3C 8000203C 24050008 */  li    $a1, 8
/* 002C40 80002040 01802025 */  move  $a0, $t4
/* 002C44 80002044 46083282 */  mul.s $f10, $f6, $f8
/* 002C48 80002048 444AF800 */  cfc1  $t2, $31
/* 002C4C 8000204C 00000000 */  nop   
/* 002C50 80002050 35410003 */  ori   $at, $t2, 3
/* 002C54 80002054 38210002 */  xori  $at, $at, 2
/* 002C58 80002058 44C1F800 */  ctc1  $at, $31
/* 002C5C 8000205C 00000000 */  nop   
/* 002C60 80002060 460054A4 */  cvt.w.s $f18, $f10
/* 002C64 80002064 44079000 */  mfc1  $a3, $f18
/* 002C68 80002068 44CAF800 */  ctc1  $t2, $31
/* 002C6C 8000206C 11800003 */  beqz  $t4, .L8000207C
/* 002C70 80002070 00075A00 */   sll   $t3, $a3, 8
/* 002C74 80002074 0C00127E */  jal   func_800049F8
/* 002C78 80002078 01603025 */   move  $a2, $t3
.L8000207C:
/* 002C7C 8000207C 8FBF0014 */  lw    $ra, 0x14($sp)
/* 002C80 80002080 27BD0018 */  addiu $sp, $sp, 0x18
/* 002C84 80002084 03E00008 */  jr    $ra
/* 002C88 80002088 00000000 */   nop   

/* 002C8C 8000208C 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 002C90 80002090 AFBF0014 */  sw    $ra, 0x14($sp)
/* 002C94 80002094 AFA5001C */  sw    $a1, 0x1c($sp)
/* 002C98 80002098 10800004 */  beqz  $a0, .L800020AC
/* 002C9C 8000209C 30A700FF */   andi  $a3, $a1, 0xff
/* 002CA0 800020A0 24050008 */  li    $a1, 8
/* 002CA4 800020A4 0C00127E */  jal   func_800049F8
/* 002CA8 800020A8 00073200 */   sll   $a2, $a3, 8
.L800020AC:
/* 002CAC 800020AC 8FBF0014 */  lw    $ra, 0x14($sp)
/* 002CB0 800020B0 27BD0018 */  addiu $sp, $sp, 0x18
/* 002CB4 800020B4 03E00008 */  jr    $ra
/* 002CB8 800020B8 00000000 */   nop   

/* 002CBC 800020BC 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 002CC0 800020C0 AFBF0014 */  sw    $ra, 0x14($sp)
/* 002CC4 800020C4 10800004 */  beqz  $a0, .L800020D8
/* 002CC8 800020C8 AFA5001C */   sw    $a1, 0x1c($sp)
/* 002CCC 800020CC 8FA6001C */  lw    $a2, 0x1c($sp)
/* 002CD0 800020D0 0C00127E */  jal   func_800049F8
/* 002CD4 800020D4 24050010 */   li    $a1, 16
.L800020D8:
/* 002CD8 800020D8 8FBF0014 */  lw    $ra, 0x14($sp)
/* 002CDC 800020DC 27BD0018 */  addiu $sp, $sp, 0x18
/* 002CE0 800020E0 03E00008 */  jr    $ra
/* 002CE4 800020E4 00000000 */   nop   

