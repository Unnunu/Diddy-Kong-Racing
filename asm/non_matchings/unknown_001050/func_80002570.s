glabel func_80002570
/* 003170 80002570 3C0E800E */  lui   $t6, %hi(D_800DC630) # $t6, 0x800e
/* 003174 80002574 8DCEC630 */  lw    $t6, %lo(D_800DC630)($t6)
/* 003178 80002578 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 00317C 8000257C 148E000F */  bne   $a0, $t6, .L800025BC
/* 003180 80002580 AFBF0014 */   sw    $ra, 0x14($sp)
/* 003184 80002584 3C0F8011 */  lui   $t7, %hi(D_80115D40) # $t7, 0x8011
/* 003188 80002588 91EF5D40 */  lbu   $t7, %lo(D_80115D40)($t7)
/* 00318C 8000258C 00000000 */  nop   
/* 003190 80002590 11E0000A */  beqz  $t7, .L800025BC
/* 003194 80002594 00000000 */   nop   
/* 003198 80002598 0C032174 */  jal   func_800C85D0
/* 00319C 8000259C 00000000 */   nop   
/* 0031A0 800025A0 3C018011 */  lui   $at, %hi(D_80115D40) # $at, 0x8011
/* 0031A4 800025A4 A0205D40 */  sb    $zero, %lo(D_80115D40)($at)
/* 0031A8 800025A8 3C018011 */  lui   $at, %hi(D_80115D04) # $at, 0x8011
/* 0031AC 800025AC A0205D04 */  sb    $zero, %lo(D_80115D04)($at)
/* 0031B0 800025B0 3C01800E */  lui   $at, %hi(D_800DC65C) # $at, 0x800e
/* 0031B4 800025B4 10000010 */  b     .L800025F8
/* 0031B8 800025B8 A020C65C */   sb    $zero, %lo(D_800DC65C)($at)
.L800025BC:
/* 0031BC 800025BC 3C18800E */  lui   $t8, %hi(D_800DC634) # $t8, 0x800e
/* 0031C0 800025C0 8F18C634 */  lw    $t8, %lo(D_800DC634)($t8)
/* 0031C4 800025C4 3C198011 */  lui   $t9, %hi(D_80115D41) # $t9, 0x8011
/* 0031C8 800025C8 1498000C */  bne   $a0, $t8, .L800025FC
/* 0031CC 800025CC 8FBF0014 */   lw    $ra, 0x14($sp)
/* 0031D0 800025D0 93395D41 */  lbu   $t9, %lo(D_80115D41)($t9)
/* 0031D4 800025D4 00000000 */  nop   
/* 0031D8 800025D8 13200008 */  beqz  $t9, .L800025FC
/* 0031DC 800025DC 8FBF0014 */   lw    $ra, 0x14($sp)
/* 0031E0 800025E0 0C032174 */  jal   func_800C85D0
/* 0031E4 800025E4 00000000 */   nop   
/* 0031E8 800025E8 3C018011 */  lui   $at, %hi(D_80115D41) # $at, 0x8011
/* 0031EC 800025EC A0205D41 */  sb    $zero, %lo(D_80115D41)($at)
/* 0031F0 800025F0 3C01800E */  lui   $at, %hi(D_800DC660) # $at, 0x800e
/* 0031F4 800025F4 A020C660 */  sb    $zero, %lo(D_800DC660)($at)
.L800025F8:
/* 0031F8 800025F8 8FBF0014 */  lw    $ra, 0x14($sp)
.L800025FC:
/* 0031FC 800025FC 27BD0018 */  addiu $sp, $sp, 0x18
/* 003200 80002600 03E00008 */  jr    $ra
/* 003204 80002604 00000000 */   nop   

