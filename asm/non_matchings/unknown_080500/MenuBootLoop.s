glabel menu_boot_loop
/* 08920C 8008860C 3C0E8000 */  lui   $t6, %hi(osTvType) # $t6, 0x8000
/* 089210 80088610 8DCE0300 */  lw    $t6, %lo(osTvType)($t6)
/* 089214 80088614 27BDFFD0 */  addiu $sp, $sp, -0x30
/* 089218 80088618 AFBF0024 */  sw    $ra, 0x24($sp)
/* 08921C 8008861C 00802825 */  move  $a1, $a0
/* 089220 80088620 AFA0002C */  sw    $zero, 0x2c($sp)
/* 089224 80088624 15C00002 */  bnez  $t6, .L80088630
/* 089228 80088628 24030078 */   li    $v1, 120
/* 08922C 8008862C 24030084 */  li    $v1, 132
.L80088630:
/* 089230 80088630 3C028012 */  lui   $v0, %hi(D_80126C20) # $v0, 0x8012
/* 089234 80088634 8C426C20 */  lw    $v0, %lo(D_80126C20)($v0)
/* 089238 80088638 00603825 */  move  $a3, $v1
/* 08923C 8008863C 10400009 */  beqz  $v0, .L80088664
/* 089240 80088640 3C038012 */   lui   $v1, 0x8012
/* 089244 80088644 24010001 */  li    $at, 1
/* 089248 80088648 10410019 */  beq   $v0, $at, .L800886B0
/* 08924C 8008864C 3C038012 */   lui   $v1, %hi(D_80126C18) # $v1, 0x8012
/* 089250 80088650 24010002 */  li    $at, 2
/* 089254 80088654 10410030 */  beq   $v0, $at, .L80088718
/* 089258 80088658 3C0C800E */   lui   $t4, %hi(D_800DF47C) # $t4, 0x800e
/* 08925C 8008865C 10000043 */  b     .L8008876C
/* 089260 80088660 28E1012C */   slti  $at, $a3, 0x12c
.L80088664:
/* 089264 80088664 24636C18 */  addiu $v1, %lo(D_80126C18) # addiu $v1, $v1, 0x6c18
/* 089268 80088668 8C620000 */  lw    $v0, ($v1)
/* 08926C 8008866C 00000000 */  nop   
/* 089270 80088670 28410020 */  slti  $at, $v0, 0x20
/* 089274 80088674 10200007 */  beqz  $at, .L80088694
/* 089278 80088678 00457821 */   addu  $t7, $v0, $a1
/* 08927C 8008867C 29E10021 */  slti  $at, $t7, 0x21
/* 089280 80088680 14200039 */  bnez  $at, .L80088768
/* 089284 80088684 AC6F0000 */   sw    $t7, ($v1)
/* 089288 80088688 24190020 */  li    $t9, 32
/* 08928C 8008868C 10000036 */  b     .L80088768
/* 089290 80088690 AC790000 */   sw    $t9, ($v1)
.L80088694:
/* 089294 80088694 0C0221FA */  jal   func_800887E8
/* 089298 80088698 AFA70028 */   sw    $a3, 0x28($sp)
/* 08929C 8008869C 8FA70028 */  lw    $a3, 0x28($sp)
/* 0892A0 800886A0 24080001 */  li    $t0, 1
/* 0892A4 800886A4 3C018012 */  lui   $at, %hi(D_80126C20) # $at, 0x8012
/* 0892A8 800886A8 1000002F */  b     .L80088768
/* 0892AC 800886AC AC286C20 */   sw    $t0, %lo(D_80126C20)($at)
.L800886B0:
/* 0892B0 800886B0 24636C18 */  addiu $v1, $v1, 0x6c18
/* 0892B4 800886B4 8C620000 */  lw    $v0, ($v1)
/* 0892B8 800886B8 00000000 */  nop   
/* 0892BC 800886BC 2841008C */  slti  $at, $v0, 0x8c
/* 0892C0 800886C0 10200008 */  beqz  $at, .L800886E4
/* 0892C4 800886C4 00454821 */   addu  $t1, $v0, $a1
/* 0892C8 800886C8 2921008D */  slti  $at, $t1, 0x8d
/* 0892CC 800886CC AC690000 */  sw    $t1, ($v1)
/* 0892D0 800886D0 1420000C */  bnez  $at, .L80088704
/* 0892D4 800886D4 01201025 */   move  $v0, $t1
/* 0892D8 800886D8 2402008C */  li    $v0, 140
/* 0892DC 800886DC 10000009 */  b     .L80088704
/* 0892E0 800886E0 AC620000 */   sw    $v0, ($v1)
.L800886E4:
/* 0892E4 800886E4 0C0221F1 */  jal   func_800887C4
/* 0892E8 800886E8 AFA70028 */   sw    $a3, 0x28($sp)
/* 0892EC 800886EC 3C028012 */  lui   $v0, %hi(D_80126C18) # $v0, 0x8012
/* 0892F0 800886F0 240B0002 */  li    $t3, 2
/* 0892F4 800886F4 3C018012 */  lui   $at, %hi(D_80126C20) # $at, 0x8012
/* 0892F8 800886F8 8FA70028 */  lw    $a3, 0x28($sp)
/* 0892FC 800886FC 8C426C18 */  lw    $v0, %lo(D_80126C18)($v0)
/* 089300 80088700 AC2B6C20 */  sw    $t3, %lo(D_80126C20)($at)
.L80088704:
/* 089304 80088704 28410081 */  slti  $at, $v0, 0x81
/* 089308 80088708 14200018 */  bnez  $at, .L8008876C
/* 08930C 8008870C 28E1012C */   slti  $at, $a3, 0x12c
/* 089310 80088710 10000015 */  b     .L80088768
/* 089314 80088714 2407012C */   li    $a3, 300
.L80088718:
/* 089318 80088718 8D8CF47C */  lw    $t4, %lo(D_800DF47C)($t4)
/* 08931C 8008871C 00000000 */  nop   
/* 089320 80088720 1180000C */  beqz  $t4, .L80088754
/* 089324 80088724 2407012C */   li    $a3, 300
/* 089328 80088728 0C030063 */  jal   func_800C018C
/* 08932C 8008872C AFA50030 */   sw    $a1, 0x30($sp)
/* 089330 80088730 8FA50030 */  lw    $a1, 0x30($sp)
/* 089334 80088734 14400006 */  bnez  $v0, .L80088750
/* 089338 80088738 3C04800E */   lui   $a0, %hi(D_800DF76C) # $a0, 0x800e
/* 08933C 8008873C 2484F76C */  addiu $a0, %lo(D_800DF76C) # addiu $a0, $a0, -0x894
/* 089340 80088740 0C030076 */  jal   func_800C01D8
/* 089344 80088744 AFA50030 */   sw    $a1, 0x30($sp)
/* 089348 80088748 8FA50030 */  lw    $a1, 0x30($sp)
/* 08934C 8008874C 00000000 */  nop   
.L80088750:
/* 089350 80088750 2407012C */  li    $a3, 300
.L80088754:
/* 089354 80088754 AFA70028 */  sw    $a3, 0x28($sp)
/* 089358 80088758 0C02242B */  jal   func_800890AC
/* 08935C 8008875C 00A02025 */   move  $a0, $a1
/* 089360 80088760 8FA70028 */  lw    $a3, 0x28($sp)
/* 089364 80088764 AFA2002C */  sw    $v0, 0x2c($sp)
.L80088768:
/* 089368 80088768 28E1012C */  slti  $at, $a3, 0x12c
.L8008876C:
/* 08936C 8008876C 10200011 */  beqz  $at, .L800887B4
/* 089370 80088770 3C048012 */   lui   $a0, %hi(D_801263A0) # $a0, 0x8012
/* 089374 80088774 3C05800E */  lui   $a1, %hi(D_800DF7DC) # $a1, 0x800e
/* 089378 80088778 240D00FF */  li    $t5, 255
/* 08937C 8008877C 240E00FF */  li    $t6, 255
/* 089380 80088780 240F00FF */  li    $t7, 255
/* 089384 80088784 241800FF */  li    $t8, 255
/* 089388 80088788 AFB8001C */  sw    $t8, 0x1c($sp)
/* 08938C 8008878C AFAF0018 */  sw    $t7, 0x18($sp)
/* 089390 80088790 AFAE0014 */  sw    $t6, 0x14($sp)
/* 089394 80088794 AFAD0010 */  sw    $t5, 0x10($sp)
/* 089398 80088798 24A5F7DC */  addiu $a1, %lo(D_800DF7DC) # addiu $a1, $a1, -0x824
/* 08939C 8008879C 248463A0 */  addiu $a0, %lo(D_801263A0) # addiu $a0, $a0, 0x63a0
/* 0893A0 800887A0 0C01E2AE */  jal   func_80078AB8
/* 0893A4 800887A4 240600A0 */   li    $a2, 160
/* 0893A8 800887A8 3C048012 */  lui   $a0, %hi(D_801263A0) # $a0, 0x8012
/* 0893AC 800887AC 0C01ECF4 */  jal   func_8007B3D0
/* 0893B0 800887B0 248463A0 */   addiu $a0, %lo(D_801263A0) # addiu $a0, $a0, 0x63a0
.L800887B4:
/* 0893B4 800887B4 8FBF0024 */  lw    $ra, 0x24($sp)
/* 0893B8 800887B8 8FA2002C */  lw    $v0, 0x2c($sp)
/* 0893BC 800887BC 03E00008 */  jr    $ra
/* 0893C0 800887C0 27BD0030 */   addiu $sp, $sp, 0x30

