glabel __scHandleRetrace
/* 07A418 80079818 27BDFFB8 */  addiu $sp, $sp, -0x48
/* 07A41C 8007981C AFBF001C */  sw    $ra, 0x1c($sp)
/* 07A420 80079820 AFB10018 */  sw    $s1, 0x18($sp)
/* 07A424 80079824 AFB00014 */  sw    $s0, 0x14($sp)
/* 07A428 80079828 AFA00044 */  sw    $zero, 0x44($sp)
/* 07A42C 8007982C AFA00038 */  sw    $zero, 0x38($sp)
/* 07A430 80079830 AFA00034 */  sw    $zero, 0x34($sp)
/* 07A434 80079834 A3A00032 */  sb    $zero, 0x32($sp)
/* 07A438 80079838 8C8E0274 */  lw    $t6, 0x274($a0)
/* 07A43C 8007983C 00808825 */  move  $s1, $a0
/* 07A440 80079840 11C00007 */  beqz  $t6, .L80079860
/* 07A444 80079844 00008025 */  move  $s0, $zero
/* 07A448 80079848 3C03800E */  lui   $v1, %hi(gCurRSPTaskCounter) # $v1, 0x800e
/* 07A44C 8007984C 2463E754 */  addiu $v1, %lo(gCurRSPTaskCounter) # addiu $v1, $v1, -0x18ac
/* 07A450 80079850 8C6F0000 */  lw    $t7, ($v1)
/* 07A454 80079854 00000000 */  nop   
/* 07A458 80079858 25F80001 */  addiu $t8, $t7, 1
/* 07A45C 8007985C AC780000 */  sw    $t8, ($v1)
.L80079860:
/* 07A460 80079860 8E390278 */  lw    $t9, 0x278($s1)
/* 07A464 80079864 3C03800E */  lui   $v1, %hi(gCurRSPTaskCounter) # $v1, 0x800e
/* 07A468 80079868 13200006 */  beqz  $t9, .L80079884
/* 07A46C 8007986C 2463E754 */  addiu $v1, %lo(gCurRSPTaskCounter) # addiu $v1, $v1, -0x18ac
/* 07A470 80079870 3C08800E */  lui   $t0, %hi(gCurRDPTaskCounter) # $t0, 0x800e
/* 07A474 80079874 8D08E758 */  lw    $t0, %lo(gCurRDPTaskCounter)($t0)
/* 07A478 80079878 3C01800E */  lui   $at, %hi(gCurRDPTaskCounter) # $at, 0x800e
/* 07A47C 8007987C 25090001 */  addiu $t1, $t0, 1
/* 07A480 80079880 AC29E758 */  sw    $t1, %lo(gCurRDPTaskCounter)($at)
.L80079884:
/* 07A484 80079884 8C6A0000 */  lw    $t2, ($v1)
/* 07A488 80079888 8E220274 */  lw    $v0, 0x274($s1)
/* 07A48C 8007988C 2941000B */  slti  $at, $t2, 0xb
/* 07A490 80079890 14200009 */  bnez  $at, .L800798B8
/* 07A494 80079894 00000000 */  nop
/* 07A498 80079898 10400007 */  beqz  $v0, .L800798B8
/* 07A49C 8007989C 3C0400AA */  lui   $a0, (0x00AAAA82 >> 16) # lui $a0, 0xaa
/* 07A4A0 800798A0 AC600000 */  sw    $zero, ($v1)
/* 07A4A4 800798A4 24100001 */  li    $s0, 1
/* 07A4A8 800798A8 0C033490 */  jal   __osSpSetStatus
/* 07A4AC 800798AC 3484AA82 */  ori   $a0, (0x00AAAA82 & 0xFFFF) # ori $a0, $a0, 0xaa82
/* 07A4B0 800798B0 10000005 */  b     .L800798C8
/* 07A4B4 800798B4 00000000 */  nop
.L800798B8:
/* 07A4B8 800798B8 10400003 */  beqz  $v0, .L800798C8
/* 07A4BC 800798BC 240B0001 */  li    $t3, 1
/* 07A4C0 800798C0 3C018012 */  lui   $at, %hi(gCurRSPTaskIsSet) # $at, 0x8012
/* 07A4C4 800798C4 AC2B6110 */  sw    $t3, %lo(gCurRSPTaskIsSet)($at)
.L800798C8:
/* 07A4C8 800798C8 3C0C800E */  lui   $t4, %hi(gCurRDPTaskCounter) # $t4, 0x800e
/* 07A4CC 800798CC 8D8CE758 */  lw    $t4, %lo(gCurRDPTaskCounter)($t4)
/* 07A4D0 800798D0 8E220278 */  lw    $v0, 0x278($s1)
/* 07A4D4 800798D4 2981000B */  slti  $at, $t4, 0xb
/* 07A4D8 800798D8 14200016 */  bnez  $at, .L80079934
/* 07A4DC 800798DC 00000000 */  nop
/* 07A4E0 800798E0 10400014 */  beqz  $v0, .L80079934
/* 07A4E4 800798E4 00000000 */  nop
/* 07A4E8 800798E8 8C4D0068 */  lw    $t5, 0x68($v0)
/* 07A4EC 800798EC 3C05800E */  lui   $a1, %hi(D_800DE738) # $a1, 0x800e
/* 07A4F0 800798F0 15A00004 */  bnez  $t5, .L80079904
/* 07A4F4 800798F4 24A5E738 */  addiu $a1, %lo(D_800DE738) # addiu $a1, $a1, -0x18c8
/* 07A4F8 800798F8 8C440050 */  lw    $a0, 0x50($v0)
/* 07A4FC 800798FC 0C03238C */  jal   osSendMesg
/* 07A500 80079900 24060001 */  li    $a2, 1
.L80079904:
/* 07A504 80079904 240E0001 */  li    $t6, 1
/* 07A508 80079908 A3AE0032 */  sb    $t6, 0x32($sp)
/* 07A50C 8007990C AE200280 */  sw    $zero, 0x280($s1)
/* 07A510 80079910 3C01800E */  lui   $at, %hi(gCurRDPTaskCounter) # $at, 0x800e
/* 07A514 80079914 3C0400AA */  lui   $a0, (0x00AAAA82 >> 16) # lui $a0, 0xaa
/* 07A518 80079918 AC20E758 */  sw    $zero, %lo(gCurRDPTaskCounter)($at)
/* 07A51C 8007991C 0C033490 */  jal   __osSpSetStatus
/* 07A520 80079920 3484AA82 */  ori   $a0, (0x00AAAA82 & 0xFFFF) # ori $a0, $a0, 0xaa82
/* 07A524 80079924 0C033494 */  jal   osDpSetStatus
/* 07A528 80079928 240401D6 */  li    $a0, 470
/* 07A52C 8007992C 10000005 */  b     .L80079944
/* 07A530 80079930 00000000 */  nop
.L80079934:
/* 07A534 80079934 10400003 */  beqz  $v0, .L80079944
/* 07A538 80079938 240F0001 */  li    $t7, 1
/* 07A53C 8007993C 3C018012 */  lui   $at, %hi(gCurRDPTaskIsSet) # $at, 0x8012
/* 07A540 80079940 AC2F6114 */  sw    $t7, %lo(gCurRDPTaskIsSet)($at)
.L80079944:
/* 07A544 80079944 12000002 */  beqz  $s0, .L80079950
/* 07A548 80079948 26240078 */  addiu $a0, $s1, 0x78
/* 07A54C 8007994C AE200274 */  sw    $zero, 0x274($s1)
.L80079950:
/* 07A550 80079950 93B80032 */  lbu   $t8, 0x32($sp)
/* 07A554 80079954 27A50044 */  addiu $a1, $sp, 0x44
/* 07A558 80079958 13000002 */  beqz  $t8, .L80079964
/* 07A55C 8007995C 00003025 */  move  $a2, $zero
/* 07A560 80079960 AE200278 */  sw    $zero, 0x278($s1)
.L80079964:
/* 07A564 80079964 0C0322EC */  jal   osRecvMesg
/* 07A568 80079968 AFA40028 */  sw    $a0, 0x28($sp)
/* 07A56C 8007996C 2410FFFF */  li    $s0, -1
/* 07A570 80079970 1050000A */  beq   $v0, $s0, .L8007999C
/* 07A574 80079974 00000000 */  nop
/* 07A578 80079978 8FA50044 */  lw    $a1, 0x44($sp)
.L8007997C:
/* 07A57C 8007997C 0C01E7D0 */  jal   __scAppendList
/* 07A580 80079980 02202025 */  move  $a0, $s1
/* 07A584 80079984 8FA40028 */  lw    $a0, 0x28($sp)
/* 07A588 80079988 27A50044 */  addiu $a1, $sp, 0x44
/* 07A58C 8007998C 0C0322EC */  jal   osRecvMesg
/* 07A590 80079990 00003025 */  move  $a2, $zero
/* 07A594 80079994 1450FFF9 */  bne   $v0, $s0, .L8007997C
/* 07A598 80079998 8FA50044 */  lw    $a1, 0x44($sp)
.L8007999C:
/* 07A59C 8007999C 8E390274 */  lw    $t9, 0x274($s1)
/* 07A5A0 800799A0 8E2A0278 */  lw    $t2, 0x278($s1)
/* 07A5A4 800799A4 2F280001 */  sltiu $t0, $t9, 1
/* 07A5A8 800799A8 00084840 */  sll   $t1, $t0, 1
/* 07A5AC 800799AC 2D4B0001 */  sltiu $t3, $t2, 1
/* 07A5B0 800799B0 012B8025 */  or    $s0, $t1, $t3
/* 07A5B4 800799B4 02003825 */  move  $a3, $s0
/* 07A5B8 800799B8 02202025 */  move  $a0, $s1
/* 07A5BC 800799BC 27A50038 */  addiu $a1, $sp, 0x38
/* 07A5C0 800799C0 0C01E835 */  jal   __scSchedule
/* 07A5C4 800799C4 27A60034 */  addiu $a2, $sp, 0x34
/* 07A5C8 800799C8 10500005 */  beq   $v0, $s0, .L800799E0
/* 07A5CC 800799CC 00000000 */  nop
/* 07A5D0 800799D0 8FA50038 */  lw    $a1, 0x38($sp)
/* 07A5D4 800799D4 8FA60034 */  lw    $a2, 0x34($sp)
/* 07A5D8 800799D8 0C01E7EA */  jal   __scExec
/* 07A5DC 800799DC 02202025 */  move  $a0, $s1
.L800799E0:
/* 07A5E0 800799E0 3C0D800E */  lui   $t5, %hi(gRetraceCounter64) # $t5, 0x800e
/* 07A5E4 800799E4 8DADE764 */  lw    $t5, %lo(gRetraceCounter64+4)($t5)
/* 07A5E8 800799E8 3C0C800E */  lui   $t4, %hi(gRetraceCounter64) # $t4, 0x800e
/* 07A5EC 800799EC 8D8CE760 */  lw    $t4, %lo(gRetraceCounter64)($t4)
/* 07A5F0 800799F0 25AF0001 */  addiu $t7, $t5, 1
/* 07A5F4 800799F4 2DE10001 */  sltiu $at, $t7, 1
/* 07A5F8 800799F8 01817021 */  addu  $t6, $t4, $at
/* 07A5FC 800799FC 3C01800E */  lui   $at, %hi(gRetraceCounter64) # $at, 0x800e
/* 07A600 80079A00 3C02800E */  lui   $v0, %hi(gRetraceCounter32) # $v0, 0x800e
/* 07A604 80079A04 2442E750 */  addiu $v0, %lo(gRetraceCounter32) # addiu $v0, $v0, -0x18b0
/* 07A608 80079A08 AC2EE760 */  sw    $t6, %lo(gRetraceCounter64)($at)
/* 07A60C 80079A0C AC2FE764 */  sw    $t7, %lo(gRetraceCounter64+4)($at)
/* 07A610 80079A10 8C580000 */  lw    $t8, ($v0)
/* 07A614 80079A14 00000000 */  nop
/* 07A618 80079A18 27190001 */  addiu $t9, $t8, 1
/* 07A61C 80079A1C AC590000 */  sw    $t9, ($v0)
/* 07A620 80079A20 8E280280 */  lw    $t0, 0x280($s1)
/* 07A624 80079A24 8E23027C */  lw    $v1, 0x27c($s1)
/* 07A628 80079A28 250A0001 */  addiu $t2, $t0, 1
/* 07A62C 80079A2C 10600019 */  beqz  $v1, .L80079A94
/* 07A630 80079A30 AE2A0280 */  sw    $t2, 0x280($s1)
/* 07A634 80079A34 2D410002 */  sltiu $at, $t2, 2
/* 07A638 80079A38 14200016 */  bnez  $at, .L80079A94
/* 07A63C 80079A3C 00000000 */  nop
/* 07A640 80079A40 8C640050 */  lw    $a0, 0x50($v1)
/* 07A644 80079A44 00601025 */  move  $v0, $v1
/* 07A648 80079A48 10800010 */  beqz  $a0, .L80079A8C
/* 07A64C 80079A4C 00000000 */  nop
/* 07A650 80079A50 8C6B0068 */  lw    $t3, 0x68($v1)
/* 07A654 80079A54 00000000 */  nop
/* 07A658 80079A58 15600005 */  bnez  $t3, .L80079A70
/* 07A65C 80079A5C 00000000 */  nop   
/* 07A660 80079A60 8C6C0054 */  lw    $t4, 0x54($v1)
/* 07A664 80079A64 3C05800E */  lui   $a1, %hi(D_800DE730) # $a1, 0x800e
/* 07A668 80079A68 11800006 */  beqz  $t4, .L80079A84
/* 07A66C 80079A6C 24A5E730 */   addiu $a1, %lo(D_800DE730) # addiu $a1, $a1, -0x18d0
.L80079A70:
/* 07A670 80079A70 8C450054 */  lw    $a1, 0x54($v0)
/* 07A674 80079A74 0C03238C */  jal   osSendMesg
/* 07A678 80079A78 24060001 */  li    $a2, 1
/* 07A67C 80079A7C 10000004 */  b     .L80079A90
/* 07A680 80079A80 AE200280 */  sw    $zero, 0x280($s1)
.L80079A84:
/* 07A684 80079A84 0C03238C */  jal   osSendMesg
/* 07A688 80079A88 24060001 */  li    $a2, 1
.L80079A8C:
/* 07A68C 80079A8C AE200280 */  sw    $zero, 0x280($s1)
.L80079A90:
/* 07A690 80079A90 AE20027C */  sw    $zero, 0x27c($s1)
.L80079A94:
/* 07A694 80079A94 8E300260 */  lw    $s0, 0x260($s1)
/* 07A698 80079A98 00000000 */  nop   
/* 07A69C 80079A9C 12000025 */  beqz  $s0, .L80079B34
/* 07A6A0 80079AA0 8FBF001C */  lw    $ra, 0x1c($sp)
.L80079AA4:
/* 07A6A4 80079AA4 92020000 */  lbu   $v0, ($s0)
/* 07A6A8 80079AA8 24010001 */  li    $at, 1
/* 07A6AC 80079AAC 14410016 */  bne   $v0, $at, .L80079B08
/* 07A6B0 80079AB0 3C04800E */  lui   $a0, %hi(gRetraceCounter64) # $a0, 0x800e
/* 07A6B4 80079AB4 3C05800E */  lui   $a1, %hi(gRetraceCounter64) # $a1, 0x800e
/* 07A6B8 80079AB8 8CA5E764 */  lw    $a1, %lo(gRetraceCounter64+4)($a1)
/* 07A6BC 80079ABC 8C84E760 */  lw    $a0, %lo(gRetraceCounter64)($a0)
/* 07A6C0 80079AC0 24060000 */  li    $a2, 0
/* 07A6C4 80079AC4 0C033AA3 */  jal   __ull_rem
/* 07A6C8 80079AC8 24070002 */  li    $a3, 2
/* 07A6CC 80079ACC 14400014 */  bnez  $v0, .L80079B20
/* 07A6D0 80079AD0 00000000 */  nop
/* 07A6D4 80079AD4 14600012 */  bnez  $v1, .L80079B20
/* 07A6D8 80079AD8 02202825 */  move  $a1, $s1
/* 07A6DC 80079ADC 8E040008 */  lw    $a0, 8($s0)
/* 07A6E0 80079AE0 0C03238C */  jal   osSendMesg
/* 07A6E4 80079AE4 00003025 */  move  $a2, $zero
/* 07A6E8 80079AE8 8E2D0264 */  lw    $t5, 0x264($s1)
/* 07A6EC 80079AEC 00000000 */  nop   
/* 07A6F0 80079AF0 11A0000B */  beqz  $t5, .L80079B20
/* 07A6F4 80079AF4 00000000 */  nop
/* 07A6F8 80079AF8 0C01E5D8 */  jal   func_80079760
/* 07A6FC 80079AFC 02202025 */  move  $a0, $s1
/* 07A700 80079B00 10000008 */  b     .L80079B24
/* 07A704 80079B04 8E100004 */  lw    $s0, 4($s0)
.L80079B08:
/* 07A708 80079B08 24010002 */  li    $at, 2
/* 07A70C 80079B0C 14410004 */  bne   $v0, $at, .L80079B20
/* 07A710 80079B10 02202825 */  move  $a1, $s1
/* 07A714 80079B14 8E040008 */  lw    $a0, 8($s0)
/* 07A718 80079B18 0C03238C */  jal   osSendMesg
/* 07A71C 80079B1C 00003025 */  move  $a2, $zero
.L80079B20:
/* 07A720 80079B20 8E100004 */  lw    $s0, 4($s0)
.L80079B24:
/* 07A724 80079B24 00000000 */  nop
/* 07A728 80079B28 1600FFDE */  bnez  $s0, .L80079AA4
/* 07A72C 80079B2C 00000000 */  nop
/* 07A730 80079B30 8FBF001C */  lw    $ra, 0x1c($sp)
.L80079B34:
/* 07A734 80079B34 8FB00014 */  lw    $s0, 0x14($sp)
/* 07A738 80079B38 8FB10018 */  lw    $s1, 0x18($sp)
/* 07A73C 80079B3C 03E00008 */  jr    $ra
/* 07A740 80079B40 27BD0048 */  addiu $sp, $sp, 0x48

