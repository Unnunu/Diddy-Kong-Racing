.late_rodata
glabel D_800E5668
.double 0.1

.text
glabel func_8001EFA4
/* 01FBA4 8001EFA4 27BDFFD8 */  addiu $sp, $sp, -0x28
/* 01FBA8 8001EFA8 AFBF0024 */  sw    $ra, 0x24($sp)
/* 01FBAC 8001EFAC AFB20020 */  sw    $s2, 0x20($sp)
/* 01FBB0 8001EFB0 AFB1001C */  sw    $s1, 0x1c($sp)
/* 01FBB4 8001EFB4 AFB00018 */  sw    $s0, 0x18($sp)
/* 01FBB8 8001EFB8 8C91003C */  lw    $s1, 0x3c($a0)
/* 01FBBC 8001EFBC 3C013F80 */  li    $at, 0x3F800000 # 1.000000
/* 01FBC0 8001EFC0 922F000B */  lbu   $t7, 0xb($s1)
/* 01FBC4 8001EFC4 44811000 */  mtc1  $at, $f2
/* 01FBC8 8001EFC8 448F2000 */  mtc1  $t7, $f4
/* 01FBCC 8001EFCC 3C014280 */  li    $at, 0x42800000 # 64.000000
/* 01FBD0 8001EFD0 46802020 */  cvt.s.w $f0, $f4
/* 01FBD4 8001EFD4 8CB00064 */  lw    $s0, 0x64($a1)
/* 01FBD8 8001EFD8 44813000 */  mtc1  $at, $f6
/* 01FBDC 8001EFDC 4602003C */  c.lt.s $f0, $f2
/* 01FBE0 8001EFE0 00809025 */  move  $s2, $a0
/* 01FBE4 8001EFE4 45000003 */  bc1f  .L8001EFF4
/* 01FBE8 8001EFE8 00000000 */   nop   
/* 01FBEC 8001EFEC 46001006 */  mov.s $f0, $f2
/* 01FBF0 8001EFF0 00000000 */  nop   
.L8001EFF4:
/* 01FBF4 8001EFF4 46060003 */  div.s $f0, $f0, $f6
/* 01FBF8 8001EFF8 8CB80040 */  lw    $t8, 0x40($a1)
/* 01FBFC 8001EFFC 00000000 */  nop   
/* 01FC00 8001F000 C708000C */  lwc1  $f8, 0xc($t8)
/* 01FC04 8001F004 ACA00078 */  sw    $zero, 0x78($a1)
/* 01FC08 8001F008 ACA0007C */  sw    $zero, 0x7c($a1)
/* 01FC0C 8001F00C 46004282 */  mul.s $f10, $f8, $f0
/* 01FC10 8001F010 E4AA0008 */  swc1  $f10, 8($a1)
/* 01FC14 8001F014 82220022 */  lb    $v0, 0x22($s1)
/* 01FC18 8001F018 00000000 */  nop   
/* 01FC1C 8001F01C 28410002 */  slti  $at, $v0, 2
/* 01FC20 8001F020 14200006 */  bnez  $at, .L8001F03C
/* 01FC24 8001F024 2841000A */   slti  $at, $v0, 0xa
/* 01FC28 8001F028 10200004 */  beqz  $at, .L8001F03C
/* 01FC2C 8001F02C 2459FFFF */   addiu $t9, $v0, -1
/* 01FC30 8001F030 ACB90078 */  sw    $t9, 0x78($a1)
/* 01FC34 8001F034 82220022 */  lb    $v0, 0x22($s1)
/* 01FC38 8001F038 00000000 */  nop   
.L8001F03C:
/* 01FC3C 8001F03C 2841000A */  slti  $at, $v0, 0xa
/* 01FC40 8001F040 14200004 */  bnez  $at, .L8001F054
/* 01FC44 8001F044 28410012 */   slti  $at, $v0, 0x12
/* 01FC48 8001F048 10200002 */  beqz  $at, .L8001F054
/* 01FC4C 8001F04C 2448FFF7 */   addiu $t0, $v0, -9
/* 01FC50 8001F050 ACA80078 */  sw    $t0, 0x78($a1)
.L8001F054:
/* 01FC54 8001F054 C650000C */  lwc1  $f16, 0xc($s2)
/* 01FC58 8001F058 3C01800E */  lui   $at, %hi(D_800E5668) # $at, 0x800e
/* 01FC5C 8001F05C E4B0000C */  swc1  $f16, 0xc($a1)
/* 01FC60 8001F060 C6520010 */  lwc1  $f18, 0x10($s2)
/* 01FC64 8001F064 00000000 */  nop   
/* 01FC68 8001F068 E4B20010 */  swc1  $f18, 0x10($a1)
/* 01FC6C 8001F06C C6440014 */  lwc1  $f4, 0x14($s2)
/* 01FC70 8001F070 00000000 */  nop   
/* 01FC74 8001F074 E4A40014 */  swc1  $f4, 0x14($a1)
/* 01FC78 8001F078 86490000 */  lh    $t1, ($s2)
/* 01FC7C 8001F07C 00000000 */  nop   
/* 01FC80 8001F080 A4A90000 */  sh    $t1, ($a1)
/* 01FC84 8001F084 864A0004 */  lh    $t2, 4($s2)
/* 01FC88 8001F088 00000000 */  nop   
/* 01FC8C 8001F08C A4AA0004 */  sh    $t2, 4($a1)
/* 01FC90 8001F090 864B0002 */  lh    $t3, 2($s2)
/* 01FC94 8001F094 00000000 */  nop   
/* 01FC98 8001F098 A4AB0002 */  sh    $t3, 2($a1)
/* 01FC9C 8001F09C A6000026 */  sh    $zero, 0x26($s0)
/* 01FCA0 8001F0A0 822C0021 */  lb    $t4, 0x21($s1)
/* 01FCA4 8001F0A4 00000000 */  nop   
/* 01FCA8 8001F0A8 A20C003D */  sb    $t4, 0x3d($s0)
/* 01FCAC 8001F0AC 822D0010 */  lb    $t5, 0x10($s1)
/* 01FCB0 8001F0B0 00000000 */  nop   
/* 01FCB4 8001F0B4 A60D0028 */  sh    $t5, 0x28($s0)
/* 01FCB8 8001F0B8 822E0014 */  lb    $t6, 0x14($s1)
/* 01FCBC 8001F0BC C430566C */  lwc1  $f16, %lo(D_800E566C)($at)
/* 01FCC0 8001F0C0 448E3000 */  mtc1  $t6, $f6
/* 01FCC4 8001F0C4 C4315668 */  lwc1  $f17, %lo(D_800E5668)($at)
/* 01FCC8 8001F0C8 46803220 */  cvt.s.w $f8, $f6
/* 01FCCC 8001F0CC 460042A1 */  cvt.d.s $f10, $f8
/* 01FCD0 8001F0D0 46305482 */  mul.d $f18, $f10, $f16
/* 01FCD4 8001F0D4 46209120 */  cvt.s.d $f4, $f18
/* 01FCD8 8001F0D8 E6040008 */  swc1  $f4, 8($s0)
/* 01FCDC 8001F0DC 8624000E */  lh    $a0, 0xe($s1)
/* 01FCE0 8001F0E0 0C00322D */  jal   func_8000C8B4
/* 01FCE4 8001F0E4 AFA5002C */   sw    $a1, 0x2c($sp)
/* 01FCE8 8001F0E8 8FA5002C */  lw    $a1, 0x2c($sp)
/* 01FCEC 8001F0EC A602002A */  sh    $v0, 0x2a($s0)
/* 01FCF0 8001F0F0 822F0012 */  lb    $t7, 0x12($s1)
/* 01FCF4 8001F0F4 44800000 */  mtc1  $zero, $f0
/* 01FCF8 8001F0F8 A0AF003B */  sb    $t7, 0x3b($a1)
/* 01FCFC 8001F0FC 92380016 */  lbu   $t8, 0x16($s1)
/* 01FD00 8001F100 00000000 */  nop   
/* 01FD04 8001F104 A4B80018 */  sh    $t8, 0x18($a1)
/* 01FD08 8001F108 82390017 */  lb    $t9, 0x17($s1)
/* 01FD0C 8001F10C E6000010 */  swc1  $f0, 0x10($s0)
/* 01FD10 8001F110 44993000 */  mtc1  $t9, $f6
/* 01FD14 8001F114 00000000 */  nop   
/* 01FD18 8001F118 46803220 */  cvt.s.w $f8, $f6
/* 01FD1C 8001F11C E6080014 */  swc1  $f8, 0x14($s0)
/* 01FD20 8001F120 92280018 */  lbu   $t0, 0x18($s1)
/* 01FD24 8001F124 00000000 */  nop   
/* 01FD28 8001F128 A208002C */  sb    $t0, 0x2c($s0)
/* 01FD2C 8001F12C 92290019 */  lbu   $t1, 0x19($s1)
/* 01FD30 8001F130 00000000 */  nop   
/* 01FD34 8001F134 A209002E */  sb    $t1, 0x2e($s0)
/* 01FD38 8001F138 822A002C */  lb    $t2, 0x2c($s1)
/* 01FD3C 8001F13C 00000000 */  nop   
/* 01FD40 8001F140 A20A003E */  sb    $t2, 0x3e($s0)
/* 01FD44 8001F144 822B002D */  lb    $t3, 0x2d($s1)
/* 01FD48 8001F148 00000000 */  nop   
/* 01FD4C 8001F14C A20B003F */  sb    $t3, 0x3f($s0)
/* 01FD50 8001F150 822C001A */  lb    $t4, 0x1a($s1)
/* 01FD54 8001F154 00000000 */  nop   
/* 01FD58 8001F158 A20C0031 */  sb    $t4, 0x31($s0)
/* 01FD5C 8001F15C 822D001B */  lb    $t5, 0x1b($s1)
/* 01FD60 8001F160 00000000 */  nop   
/* 01FD64 8001F164 A20D0032 */  sb    $t5, 0x32($s0)
/* 01FD68 8001F168 822E001C */  lb    $t6, 0x1c($s1)
/* 01FD6C 8001F16C 00000000 */  nop   
/* 01FD70 8001F170 A20E0033 */  sb    $t6, 0x33($s0)
/* 01FD74 8001F174 822F0020 */  lb    $t7, 0x20($s1)
/* 01FD78 8001F178 A200002D */  sb    $zero, 0x2d($s0)
/* 01FD7C 8001F17C E6000004 */  swc1  $f0, 4($s0)
/* 01FD80 8001F180 E6000000 */  swc1  $f0, ($s0)
/* 01FD84 8001F184 A20F0034 */  sb    $t7, 0x34($s0)
/* 01FD88 8001F188 AE40006C */  sw    $zero, 0x6c($s2)
/* 01FD8C 8001F18C 86240024 */  lh    $a0, 0x24($s1)
/* 01FD90 8001F190 0C00322D */  jal   func_8000C8B4
/* 01FD94 8001F194 00000000 */   nop   
/* 01FD98 8001F198 A6020036 */  sh    $v0, 0x36($s0)
/* 01FD9C 8001F19C 82380026 */  lb    $t8, 0x26($s1)
/* 01FDA0 8001F1A0 00000000 */  nop   
/* 01FDA4 8001F1A4 A218003A */  sb    $t8, 0x3a($s0)
/* 01FDA8 8001F1A8 82230013 */  lb    $v1, 0x13($s1)
/* 01FDAC 8001F1AC 00000000 */  nop   
/* 01FDB0 8001F1B0 04600002 */  bltz  $v1, .L8001F1BC
/* 01FDB4 8001F1B4 00000000 */   nop   
/* 01FDB8 8001F1B8 A203002F */  sb    $v1, 0x2f($s0)
.L8001F1BC:
/* 01FDBC 8001F1BC 8239001F */  lb    $t9, 0x1f($s1)
/* 01FDC0 8001F1C0 8E040018 */  lw    $a0, 0x18($s0)
/* 01FDC4 8001F1C4 A2190039 */  sb    $t9, 0x39($s0)
/* 01FDC8 8001F1C8 9228001E */  lbu   $t0, 0x1e($s1)
/* 01FDCC 8001F1CC 240D00FF */  li    $t5, 255
/* 01FDD0 8001F1D0 A2080038 */  sb    $t0, 0x38($s0)
/* 01FDD4 8001F1D4 82290029 */  lb    $t1, 0x29($s1)
/* 01FDD8 8001F1D8 00000000 */  nop   
/* 01FDDC 8001F1DC A209003B */  sb    $t1, 0x3b($s0)
/* 01FDE0 8001F1E0 822A002E */  lb    $t2, 0x2e($s1)
/* 01FDE4 8001F1E4 00000000 */  nop   
/* 01FDE8 8001F1E8 A20A0040 */  sb    $t2, 0x40($s0)
/* 01FDEC 8001F1EC 822B002F */  lb    $t3, 0x2f($s1)
/* 01FDF0 8001F1F0 00000000 */  nop   
/* 01FDF4 8001F1F4 A20B0041 */  sb    $t3, 0x41($s0)
/* 01FDF8 8001F1F8 822C002B */  lb    $t4, 0x2b($s1)
/* 01FDFC 8001F1FC A20D0042 */  sb    $t5, 0x42($s0)
/* 01FE00 8001F200 10800003 */  beqz  $a0, .L8001F210
/* 01FE04 8001F204 A20C003C */   sb    $t4, 0x3c($s0)
/* 01FE08 8001F208 0C001223 */  jal   func_8000488C
/* 01FE0C 8001F20C 00000000 */   nop   
.L8001F210:
/* 01FE10 8001F210 AE000018 */  sw    $zero, 0x18($s0)
/* 01FE14 8001F214 822E0030 */  lb    $t6, 0x30($s1)
/* 01FE18 8001F218 AE12001C */  sw    $s2, 0x1c($s0)
/* 01FE1C 8001F21C A2000045 */  sb    $zero, 0x45($s0)
/* 01FE20 8001F220 A20E0043 */  sb    $t6, 0x43($s0)
/* 01FE24 8001F224 8FBF0024 */  lw    $ra, 0x24($sp)
/* 01FE28 8001F228 8FB20020 */  lw    $s2, 0x20($sp)
/* 01FE2C 8001F22C 8FB1001C */  lw    $s1, 0x1c($sp)
/* 01FE30 8001F230 8FB00018 */  lw    $s0, 0x18($sp)
/* 01FE34 8001F234 03E00008 */  jr    $ra
/* 01FE38 8001F238 27BD0028 */   addiu $sp, $sp, 0x28

