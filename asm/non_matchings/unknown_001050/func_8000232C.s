glabel func_8000232C
/* 002F2C 8000232C 27BDFFD8 */  addiu $sp, $sp, -0x28
/* 002F30 80002330 AFBF0024 */  sw    $ra, 0x24($sp)
/* 002F34 80002334 AFB30020 */  sw    $s3, 0x20($sp)
/* 002F38 80002338 AFB2001C */  sw    $s2, 0x1c($sp)
/* 002F3C 8000233C AFB10018 */  sw    $s1, 0x18($sp)
/* 002F40 80002340 AFB00014 */  sw    $s0, 0x14($sp)
/* 002F44 80002344 00808025 */  move  $s0, $a0
/* 002F48 80002348 00A08825 */  move  $s1, $a1
/* 002F4C 8000234C 00E09025 */  move  $s2, $a3
/* 002F50 80002350 0C031E94 */  jal   func_800C7A50
/* 002F54 80002354 00C09825 */   move  $s3, $a2
/* 002F58 80002358 1440007F */  bnez  $v0, .L80002558
/* 002F5C 8000235C 8FBF0024 */   lw    $ra, 0x24($sp)
/* 002F60 80002360 926E0000 */  lbu   $t6, ($s3)
/* 002F64 80002364 24040027 */  li    $a0, 39
/* 002F68 80002368 11C0007B */  beqz  $t6, .L80002558
/* 002F6C 8000236C 8FBF0024 */   lw    $ra, 0x24($sp)
/* 002F70 80002370 0C01DBBA */  jal   func_80076EE8
/* 002F74 80002374 00002825 */   move  $a1, $zero
/* 002F78 80002378 92630000 */  lbu   $v1, ($s3)
/* 002F7C 8000237C 3C0F8011 */  lui   $t7, %hi(D_80115CF8) # $t7, 0x8011
/* 002F80 80002380 8DEF5CF8 */  lw    $t7, %lo(D_80115CF8)($t7)
/* 002F84 80002384 3C098011 */  lui   $t1, %hi(D_80115D0C) # $t1, 0x8011
/* 002F88 80002388 8D295D0C */  lw    $t1, %lo(D_80115D0C)($t1)
/* 002F8C 8000238C 0003C0C0 */  sll   $t8, $v1, 3
/* 002F90 80002390 00035080 */  sll   $t2, $v1, 2
/* 002F94 80002394 01F8C821 */  addu  $t9, $t7, $t8
/* 002F98 80002398 8F280004 */  lw    $t0, 4($t9)
/* 002F9C 8000239C 012A5821 */  addu  $t3, $t1, $t2
/* 002FA0 800023A0 8D670000 */  lw    $a3, ($t3)
/* 002FA4 800023A4 24040027 */  li    $a0, 39
/* 002FA8 800023A8 02202825 */  move  $a1, $s1
/* 002FAC 800023AC 0C01DB9A */  jal   func_80076E68
/* 002FB0 800023B0 01023023 */   subu  $a2, $t0, $v0
/* 002FB4 800023B4 02402025 */  move  $a0, $s2
/* 002FB8 800023B8 0C031FFF */  jal   func_800C7FFC
/* 002FBC 800023BC 02202825 */   move  $a1, $s1
/* 002FC0 800023C0 02002025 */  move  $a0, $s0
/* 002FC4 800023C4 0C032158 */  jal   func_800C8560
/* 002FC8 800023C8 02402825 */   move  $a1, $s2
/* 002FCC 800023CC 0C032168 */  jal   func_800C85A0
/* 002FD0 800023D0 02002025 */   move  $a0, $s0
/* 002FD4 800023D4 3C0C800E */  lui   $t4, %hi(D_800DC630) # $t4, 0x800e
/* 002FD8 800023D8 8D8CC630 */  lw    $t4, %lo(D_800DC630)($t4)
/* 002FDC 800023DC 00000000 */  nop   
/* 002FE0 800023E0 160C0041 */  bne   $s0, $t4, .L800024E8
/* 002FE4 800023E4 00000000 */   nop   
/* 002FE8 800023E8 926E0000 */  lbu   $t6, ($s3)
/* 002FEC 800023EC 24110003 */  li    $s1, 3
/* 002FF0 800023F0 01D10019 */  multu $t6, $s1
/* 002FF4 800023F4 3C108011 */  lui   $s0, %hi(D_80115D1C) # $s0, 0x8011
/* 002FF8 800023F8 26105D1C */  addiu $s0, %lo(D_80115D1C) # addiu $s0, $s0, 0x5d1c
/* 002FFC 800023FC 8E0D0000 */  lw    $t5, ($s0)
/* 003000 80002400 00007812 */  mflo  $t7
/* 003004 80002404 01AFC021 */  addu  $t8, $t5, $t7
/* 003008 80002408 93040000 */  lbu   $a0, ($t8)
/* 00300C 8000240C 0C000664 */  jal   func_80001990
/* 003010 80002410 00000000 */   nop   
/* 003014 80002414 92790000 */  lbu   $t9, ($s3)
/* 003018 80002418 8E020000 */  lw    $v0, ($s0)
/* 00301C 8000241C 03310019 */  multu $t9, $s1
/* 003020 80002420 240AFFFF */  li    $t2, -1
/* 003024 80002424 3C018011 */  lui   $at, %hi(D_80115D30) # $at, 0x8011
/* 003028 80002428 00004012 */  mflo  $t0
/* 00302C 8000242C 00484821 */  addu  $t1, $v0, $t0
/* 003030 80002430 91240001 */  lbu   $a0, 1($t1)
/* 003034 80002434 00000000 */  nop   
/* 003038 80002438 10800007 */  beqz  $a0, .L80002458
/* 00303C 8000243C 00000000 */   nop   
/* 003040 80002440 0C00054D */  jal   func_80001534
/* 003044 80002444 00000000 */   nop   
/* 003048 80002448 3C028011 */  lui   $v0, %hi(D_80115D1C) # $v0, 0x8011
/* 00304C 8000244C 8C425D1C */  lw    $v0, %lo(D_80115D1C)($v0)
/* 003050 80002450 10000003 */  b     .L80002460
/* 003054 80002454 926B0000 */   lbu   $t3, ($s3)
.L80002458:
/* 003058 80002458 A42A5D30 */  sh    $t2, %lo(D_80115D30)($at)
/* 00305C 8000245C 926B0000 */  lbu   $t3, ($s3)
.L80002460:
/* 003060 80002460 00000000 */  nop   
/* 003064 80002464 01710019 */  multu $t3, $s1
/* 003068 80002468 00006012 */  mflo  $t4
/* 00306C 8000246C 004C7021 */  addu  $t6, $v0, $t4
/* 003070 80002470 91C40002 */  lbu   $a0, 2($t6)
/* 003074 80002474 0C000982 */  jal   func_80002608
/* 003078 80002478 00000000 */   nop   
/* 00307C 8000247C 926D0000 */  lbu   $t5, ($s3)
/* 003080 80002480 3C118011 */  lui   $s1, %hi(D_80115F7C) # $s1, 0x8011
/* 003084 80002484 3C018011 */  lui   $at, %hi(D_80115D04) # $at, 0x8011
/* 003088 80002488 26315F7C */  addiu $s1, %lo(D_80115F7C) # addiu $s1, $s1, 0x5f7c
/* 00308C 8000248C A02D5D04 */  sb    $t5, %lo(D_80115D04)($at)
/* 003090 80002490 8E2F0000 */  lw    $t7, ($s1)
/* 003094 80002494 2401FFFF */  li    $at, -1
/* 003098 80002498 11E1002D */  beq   $t7, $at, .L80002550
/* 00309C 8000249C 00008025 */   move  $s0, $zero
/* 0030A0 800024A0 24120010 */  li    $s2, 16
.L800024A4:
/* 0030A4 800024A4 8E280000 */  lw    $t0, ($s1)
/* 0030A8 800024A8 24180001 */  li    $t8, 1
/* 0030AC 800024AC 0218C804 */  sllv  $t9, $t8, $s0
/* 0030B0 800024B0 03284824 */  and   $t1, $t9, $t0
/* 0030B4 800024B4 11200005 */  beqz  $t1, .L800024CC
/* 0030B8 800024B8 00000000 */   nop   
/* 0030BC 800024BC 0C00045C */  jal   func_80001170
/* 0030C0 800024C0 320400FF */   andi  $a0, $s0, 0xff
/* 0030C4 800024C4 10000004 */  b     .L800024D8
/* 0030C8 800024C8 26100001 */   addiu $s0, $s0, 1
.L800024CC:
/* 0030CC 800024CC 0C000445 */  jal   func_80001114
/* 0030D0 800024D0 320400FF */   andi  $a0, $s0, 0xff
/* 0030D4 800024D4 26100001 */  addiu $s0, $s0, 1
.L800024D8:
/* 0030D8 800024D8 1612FFF2 */  bne   $s0, $s2, .L800024A4
/* 0030DC 800024DC 00000000 */   nop   
/* 0030E0 800024E0 1000001C */  b     .L80002554
/* 0030E4 800024E4 A2600000 */   sb    $zero, ($s3)
.L800024E8:
/* 0030E8 800024E8 926B0000 */  lbu   $t3, ($s3)
/* 0030EC 800024EC 24110003 */  li    $s1, 3
/* 0030F0 800024F0 01710019 */  multu $t3, $s1
/* 0030F4 800024F4 3C108011 */  lui   $s0, %hi(D_80115D1C) # $s0, 0x8011
/* 0030F8 800024F8 26105D1C */  addiu $s0, %lo(D_80115D1C) # addiu $s0, $s0, 0x5d1c
/* 0030FC 800024FC 8E0A0000 */  lw    $t2, ($s0)
/* 003100 80002500 00006012 */  mflo  $t4
/* 003104 80002504 014C7021 */  addu  $t6, $t2, $t4
/* 003108 80002508 91C40000 */  lbu   $a0, ($t6)
/* 00310C 8000250C 0C0006C3 */  jal   func_80001B0C
/* 003110 80002510 00000000 */   nop   
/* 003114 80002514 92630000 */  lbu   $v1, ($s3)
/* 003118 80002518 8E0D0000 */  lw    $t5, ($s0)
/* 00311C 8000251C 00710019 */  multu $v1, $s1
/* 003120 80002520 00007812 */  mflo  $t7
/* 003124 80002524 01AFC021 */  addu  $t8, $t5, $t7
/* 003128 80002528 93040001 */  lbu   $a0, 1($t8)
/* 00312C 8000252C 00000000 */  nop   
/* 003130 80002530 10800005 */  beqz  $a0, .L80002548
/* 003134 80002534 00000000 */   nop   
/* 003138 80002538 0C0005F5 */  jal   func_800017D4
/* 00313C 8000253C 00000000 */   nop   
/* 003140 80002540 92630000 */  lbu   $v1, ($s3)
/* 003144 80002544 00000000 */  nop   
.L80002548:
/* 003148 80002548 3C018011 */  lui   $at, %hi(D_80115D05) # $at, 0x8011
/* 00314C 8000254C A0235D05 */  sb    $v1, %lo(D_80115D05)($at)
.L80002550:
/* 003150 80002550 A2600000 */  sb    $zero, ($s3)
.L80002554:
/* 003154 80002554 8FBF0024 */  lw    $ra, 0x24($sp)
.L80002558:
/* 003158 80002558 8FB00014 */  lw    $s0, 0x14($sp)
/* 00315C 8000255C 8FB10018 */  lw    $s1, 0x18($sp)
/* 003160 80002560 8FB2001C */  lw    $s2, 0x1c($sp)
/* 003164 80002564 8FB30020 */  lw    $s3, 0x20($sp)
/* 003168 80002568 03E00008 */  jr    $ra
/* 00316C 8000256C 27BD0028 */   addiu $sp, $sp, 0x28

