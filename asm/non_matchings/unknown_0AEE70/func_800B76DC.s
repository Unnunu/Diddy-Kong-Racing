glabel func_800B76DC
/* 0B82DC 800B76DC 3C02800E */  lui   $v0, %hi(D_800E3020) # $v0, 0x800e
/* 0B82E0 800B76E0 24423020 */  addiu $v0, %lo(D_800E3020) # addiu $v0, $v0, 0x3020
/* 0B82E4 800B76E4 8C430000 */  lw    $v1, ($v0)
/* 0B82E8 800B76E8 27BDF7D8 */  addiu $sp, $sp, -0x828
/* 0B82EC 800B76EC 2401FFFF */  li    $at, -1
/* 0B82F0 800B76F0 10610003 */  beq   $v1, $at, .L800B7700
/* 0B82F4 800B76F4 AFBF0014 */   sw    $ra, 0x14($sp)
/* 0B82F8 800B76F8 10000032 */  b     .L800B77C4
/* 0B82FC 800B76FC 00601025 */   move  $v0, $v1
.L800B7700:
/* 0B8300 800B7700 AC400000 */  sw    $zero, ($v0)
/* 0B8304 800B7704 0C01D637 */  jal   func_800758DC
/* 0B8308 800B7708 00002025 */   move  $a0, $zero
/* 0B830C 800B770C 14400020 */  bnez  $v0, .L800B7790
/* 0B8310 800B7710 00002025 */   move  $a0, $zero
/* 0B8314 800B7714 3C05800F */  lui   $a1, %hi(D_800E8EF4) # $a1, 0x800f
/* 0B8318 800B7718 3C06800F */  lui   $a2, %hi(D_800E8EFC) # $a2, 0x800f
/* 0B831C 800B771C 24C68EFC */  addiu $a2, %lo(D_800E8EFC) # addiu $a2, $a2, -0x7104
/* 0B8320 800B7720 24A58EF4 */  addiu $a1, %lo(D_800E8EF4) # addiu $a1, $a1, -0x710c
/* 0B8324 800B7724 0C01D93A */  jal   func_800764E8
/* 0B8328 800B7728 27A70824 */   addiu $a3, $sp, 0x824
/* 0B832C 800B772C 14400018 */  bnez  $v0, .L800B7790
/* 0B8330 800B7730 00002025 */   move  $a0, $zero
/* 0B8334 800B7734 8FA50824 */  lw    $a1, 0x824($sp)
/* 0B8338 800B7738 27A60020 */  addiu $a2, $sp, 0x20
/* 0B833C 800B773C 0C01D984 */  jal   func_80076610
/* 0B8340 800B7740 24070800 */   li    $a3, 2048
/* 0B8344 800B7744 14400012 */  bnez  $v0, .L800B7790
/* 0B8348 800B7748 27A40020 */   addiu $a0, $sp, 0x20
/* 0B834C 800B774C 3C058013 */  lui   $a1, %hi(D_80129800) # $a1, 0x8013
/* 0B8350 800B7750 24A59800 */  addiu $a1, %lo(D_80129800) # addiu $a1, $a1, -0x6800
/* 0B8354 800B7754 0C032768 */  jal   bcopy
/* 0B8358 800B7758 240601B0 */   li    $a2, 432
/* 0B835C 800B775C 3C058013 */  lui   $a1, %hi(D_801299B0) # $a1, 0x8013
/* 0B8360 800B7760 24A599B0 */  addiu $a1, %lo(D_801299B0) # addiu $a1, $a1, -0x6650
/* 0B8364 800B7764 27A40220 */  addiu $a0, $sp, 0x220
/* 0B8368 800B7768 0C032768 */  jal   bcopy
/* 0B836C 800B776C 24060200 */   li    $a2, 512
/* 0B8370 800B7770 3C058013 */  lui   $a1, %hi(D_80129BB0) # $a1, 0x8013
/* 0B8374 800B7774 24A59BB0 */  addiu $a1, %lo(D_80129BB0) # addiu $a1, $a1, -0x6450
/* 0B8378 800B7778 27A40420 */  addiu $a0, $sp, 0x420
/* 0B837C 800B777C 0C032768 */  jal   bcopy
/* 0B8380 800B7780 24060400 */   li    $a2, 1024
/* 0B8384 800B7784 240E0001 */  li    $t6, 1
/* 0B8388 800B7788 3C01800E */  lui   $at, %hi(D_800E3020) # $at, 0x800e
/* 0B838C 800B778C AC2E3020 */  sw    $t6, %lo(D_800E3020)($at)
.L800B7790:
/* 0B8390 800B7790 0C01D6BB */  jal   func_80075AEC
/* 0B8394 800B7794 00002025 */   move  $a0, $zero
/* 0B8398 800B7798 3C03800E */  lui   $v1, %hi(D_800E3020) # $v1, 0x800e
/* 0B839C 800B779C 8C633020 */  lw    $v1, %lo(D_800E3020)($v1)
/* 0B83A0 800B77A0 8FA50824 */  lw    $a1, 0x824($sp)
/* 0B83A4 800B77A4 10600007 */  beqz  $v1, .L800B77C4
/* 0B83A8 800B77A8 00601025 */   move  $v0, $v1
/* 0B83AC 800B77AC 0C01D8B2 */  jal   func_800762C8
/* 0B83B0 800B77B0 00002025 */   move  $a0, $zero
/* 0B83B4 800B77B4 3C03800E */  lui   $v1, %hi(D_800E3020) # $v1, 0x800e
/* 0B83B8 800B77B8 8C633020 */  lw    $v1, %lo(D_800E3020)($v1)
/* 0B83BC 800B77BC 00000000 */  nop   
/* 0B83C0 800B77C0 00601025 */  move  $v0, $v1
.L800B77C4:
/* 0B83C4 800B77C4 8FBF0014 */  lw    $ra, 0x14($sp)
/* 0B83C8 800B77C8 27BD0828 */  addiu $sp, $sp, 0x828
/* 0B83CC 800B77CC 03E00008 */  jr    $ra
/* 0B83D0 800B77D0 00000000 */   nop   

