glabel func_800B3358
/* 0B3F58 800B3358 27BDFFB8 */  addiu $sp, $sp, -0x48
/* 0B3F5C 800B335C AFB20024 */  sw    $s2, 0x24($sp)
/* 0B3F60 800B3360 3C128012 */  lui   $s2, %hi(D_80127C80) # $s2, 0x8012
/* 0B3F64 800B3364 26527C80 */  addiu $s2, %lo(D_80127C80) # addiu $s2, $s2, 0x7c80
/* 0B3F68 800B3368 8E420000 */  lw    $v0, ($s2)
/* 0B3F6C 800B336C AFB10020 */  sw    $s1, 0x20($sp)
/* 0B3F70 800B3370 AFB0001C */  sw    $s0, 0x1c($sp)
/* 0B3F74 800B3374 0002702A */  slt   $t6, $zero, $v0
/* 0B3F78 800B3378 00808025 */  move  $s0, $a0
/* 0B3F7C 800B337C AFBF002C */  sw    $ra, 0x2c($sp)
/* 0B3F80 800B3380 AFB30028 */  sw    $s3, 0x28($sp)
/* 0B3F84 800B3384 E7B50010 */  swc1  $f21, 0x10($sp)
/* 0B3F88 800B3388 E7B40014 */  swc1  $f20, 0x14($sp)
/* 0B3F8C 800B338C 11C0003F */  beqz  $t6, .L800B348C
/* 0B3F90 800B3390 24110001 */   li    $s1, 1
/* 0B3F94 800B3394 4480A000 */  mtc1  $zero, $f20
/* 0B3F98 800B3398 27B30038 */  addiu $s3, $sp, 0x38
.L800B339C:
/* 0B3F9C 800B339C C604000C */  lwc1  $f4, 0xc($s0)
/* 0B3FA0 800B33A0 C606001C */  lwc1  $f6, 0x1c($s0)
/* 0B3FA4 800B33A4 C60A0010 */  lwc1  $f10, 0x10($s0)
/* 0B3FA8 800B33A8 C6100020 */  lwc1  $f16, 0x20($s0)
/* 0B3FAC 800B33AC 46062200 */  add.s $f8, $f4, $f6
/* 0B3FB0 800B33B0 C6060024 */  lwc1  $f6, 0x24($s0)
/* 0B3FB4 800B33B4 46105480 */  add.s $f18, $f10, $f16
/* 0B3FB8 800B33B8 C6040014 */  lwc1  $f4, 0x14($s0)
/* 0B3FBC 800B33BC C6100028 */  lwc1  $f16, 0x28($s0)
/* 0B3FC0 800B33C0 C60A0008 */  lwc1  $f10, 8($s0)
/* 0B3FC4 800B33C4 860F0000 */  lh    $t7, ($s0)
/* 0B3FC8 800B33C8 86180062 */  lh    $t8, 0x62($s0)
/* 0B3FCC 800B33CC 86080002 */  lh    $t0, 2($s0)
/* 0B3FD0 800B33D0 86090064 */  lh    $t1, 0x64($s0)
/* 0B3FD4 800B33D4 860B0004 */  lh    $t3, 4($s0)
/* 0B3FD8 800B33D8 860C0066 */  lh    $t4, 0x66($s0)
/* 0B3FDC 800B33DC E608000C */  swc1  $f8, 0xc($s0)
/* 0B3FE0 800B33E0 E6120010 */  swc1  $f18, 0x10($s0)
/* 0B3FE4 800B33E4 46062200 */  add.s $f8, $f4, $f6
/* 0B3FE8 800B33E8 01F8C821 */  addu  $t9, $t7, $t8
/* 0B3FEC 800B33EC 46105480 */  add.s $f18, $f10, $f16
/* 0B3FF0 800B33F0 01095021 */  addu  $t2, $t0, $t1
/* 0B3FF4 800B33F4 016C6821 */  addu  $t5, $t3, $t4
/* 0B3FF8 800B33F8 E6080014 */  swc1  $f8, 0x14($s0)
/* 0B3FFC 800B33FC E6120008 */  swc1  $f18, 8($s0)
/* 0B4000 800B3400 A6190000 */  sh    $t9, ($s0)
/* 0B4004 800B3404 A60A0002 */  sh    $t2, 2($s0)
/* 0B4008 800B3408 A60D0004 */  sh    $t5, 4($s0)
/* 0B400C 800B340C E7B40038 */  swc1  $f20, 0x38($sp)
/* 0B4010 800B3410 C6040058 */  lwc1  $f4, 0x58($s0)
/* 0B4014 800B3414 E7B40040 */  swc1  $f20, 0x40($sp)
/* 0B4018 800B3418 46002187 */  neg.s $f6, $f4
/* 0B401C 800B341C E7A6003C */  swc1  $f6, 0x3c($sp)
/* 0B4020 800B3420 02002025 */  move  $a0, $s0
/* 0B4024 800B3424 0C01C0C8 */  jal   func_80070320
/* 0B4028 800B3428 02602825 */   move  $a1, $s3
/* 0B402C 800B342C C608001C */  lwc1  $f8, 0x1c($s0)
/* 0B4030 800B3430 C7AA0038 */  lwc1  $f10, 0x38($sp)
/* 0B4034 800B3434 C6120020 */  lwc1  $f18, 0x20($s0)
/* 0B4038 800B3438 460A4400 */  add.s $f16, $f8, $f10
/* 0B403C 800B343C C60A0068 */  lwc1  $f10, 0x68($s0)
/* 0B4040 800B3440 E610001C */  swc1  $f16, 0x1c($s0)
/* 0B4044 800B3444 C7A4003C */  lwc1  $f4, 0x3c($sp)
/* 0B4048 800B3448 00000000 */  nop   
/* 0B404C 800B344C 46049180 */  add.s $f6, $f18, $f4
/* 0B4050 800B3450 C6120024 */  lwc1  $f18, 0x24($s0)
/* 0B4054 800B3454 E6060020 */  swc1  $f6, 0x20($s0)
/* 0B4058 800B3458 C6080020 */  lwc1  $f8, 0x20($s0)
/* 0B405C 800B345C 00000000 */  nop   
/* 0B4060 800B3460 460A4401 */  sub.s $f16, $f8, $f10
/* 0B4064 800B3464 E6100020 */  swc1  $f16, 0x20($s0)
/* 0B4068 800B3468 C7A40040 */  lwc1  $f4, 0x40($sp)
/* 0B406C 800B346C 00000000 */  nop   
/* 0B4070 800B3470 46049180 */  add.s $f6, $f18, $f4
/* 0B4074 800B3474 E6060024 */  swc1  $f6, 0x24($s0)
/* 0B4078 800B3478 8E4E0000 */  lw    $t6, ($s2)
/* 0B407C 800B347C 00000000 */  nop   
/* 0B4080 800B3480 022E102A */  slt   $v0, $s1, $t6
/* 0B4084 800B3484 1440FFC5 */  bnez  $v0, .L800B339C
/* 0B4088 800B3488 26310001 */   addiu $s1, $s1, 1
.L800B348C:
/* 0B408C 800B348C 8FBF002C */  lw    $ra, 0x2c($sp)
/* 0B4090 800B3490 C7B50010 */  lwc1  $f21, 0x10($sp)
/* 0B4094 800B3494 C7B40014 */  lwc1  $f20, 0x14($sp)
/* 0B4098 800B3498 8FB0001C */  lw    $s0, 0x1c($sp)
/* 0B409C 800B349C 8FB10020 */  lw    $s1, 0x20($sp)
/* 0B40A0 800B34A0 8FB20024 */  lw    $s2, 0x24($sp)
/* 0B40A4 800B34A4 8FB30028 */  lw    $s3, 0x28($sp)
/* 0B40A8 800B34A8 03E00008 */  jr    $ra
/* 0B40AC 800B34AC 27BD0048 */   addiu $sp, $sp, 0x48

