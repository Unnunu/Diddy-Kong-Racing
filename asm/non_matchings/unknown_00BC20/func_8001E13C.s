glabel func_8001E13C
/* 01ED3C 8001E13C 27BDFFF0 */  addiu $sp, $sp, -0x10
/* 01ED40 8001E140 3C0B8012 */  lui   $t3, %hi(objCount) # $t3, 0x8012
/* 01ED44 8001E144 256BAE5C */  addiu $t3, %lo(objCount) # addiu $t3, $t3, -0x51a4
/* 01ED48 8001E148 AFB00008 */  sw    $s0, 8($sp)
/* 01ED4C 8001E14C 8D630000 */  lw    $v1, ($t3)
/* 01ED50 8001E150 00048400 */  sll   $s0, $a0, 0x10
/* 01ED54 8001E154 00107403 */  sra   $t6, $s0, 0x10
/* 01ED58 8001E158 AFB1000C */  sw    $s1, 0xc($sp)
/* 01ED5C 8001E15C 00A08825 */  move  $s1, $a1
/* 01ED60 8001E160 01C08025 */  move  $s0, $t6
/* 01ED64 8001E164 AFA40010 */  sw    $a0, 0x10($sp)
/* 01ED68 8001E168 18600048 */  blez  $v1, .L8001E28C
/* 01ED6C 8001E16C 00001025 */   move  $v0, $zero
/* 01ED70 8001E170 3C0C8012 */  lui   $t4, %hi(objPtrList) # $t4, 0x8012
/* 01ED74 8001E174 8FAA0028 */  lw    $t2, 0x28($sp)
/* 01ED78 8001E178 8FA90024 */  lw    $t1, 0x24($sp)
/* 01ED7C 8001E17C 8FA80020 */  lw    $t0, 0x20($sp)
/* 01ED80 8001E180 258CAE58 */  addiu $t4, %lo(objPtrList) # addiu $t4, $t4, -0x51a8
/* 01ED84 8001E184 240D0001 */  li    $t5, 1
.L8001E188:
/* 01ED88 8001E188 8D8F0000 */  lw    $t7, ($t4)
/* 01ED8C 8001E18C 0002C080 */  sll   $t8, $v0, 2
/* 01ED90 8001E190 01F8C821 */  addu  $t9, $t7, $t8
/* 01ED94 8001E194 8F240000 */  lw    $a0, ($t9)
/* 01ED98 8001E198 00000000 */  nop   
/* 01ED9C 8001E19C 848E0006 */  lh    $t6, 6($a0)
/* 01EDA0 8001E1A0 00000000 */  nop   
/* 01EDA4 8001E1A4 31CF8000 */  andi  $t7, $t6, 0x8000
/* 01EDA8 8001E1A8 15E00034 */  bnez  $t7, .L8001E27C
/* 01EDAC 8001E1AC 00000000 */   nop   
/* 01EDB0 8001E1B0 84980048 */  lh    $t8, 0x48($a0)
/* 01EDB4 8001E1B4 00000000 */  nop   
/* 01EDB8 8001E1B8 15B80030 */  bne   $t5, $t8, .L8001E27C
/* 01EDBC 8001E1BC 00000000 */   nop   
/* 01EDC0 8001E1C0 8C850064 */  lw    $a1, 0x64($a0)
/* 01EDC4 8001E1C4 00000000 */  nop   
/* 01EDC8 8001E1C8 84B90000 */  lh    $t9, ($a1)
/* 01EDCC 8001E1CC 00000000 */  nop   
/* 01EDD0 8001E1D0 1619002B */  bne   $s0, $t9, .L8001E280
/* 01EDD4 8001E1D4 24420001 */   addiu $v0, $v0, 1
/* 01EDD8 8001E1D8 444EF800 */  cfc1  $t6, $31
/* 01EDDC 8001E1DC C484000C */  lwc1  $f4, 0xc($a0)
/* 01EDE0 8001E1E0 35C10003 */  ori   $at, $t6, 3
/* 01EDE4 8001E1E4 38210002 */  xori  $at, $at, 2
/* 01EDE8 8001E1E8 44C1F800 */  ctc1  $at, $31
/* 01EDEC 8001E1EC 00000000 */  nop   
/* 01EDF0 8001E1F0 460021A4 */  cvt.w.s $f6, $f4
/* 01EDF4 8001E1F4 44CEF800 */  ctc1  $t6, $31
/* 01EDF8 8001E1F8 440F3000 */  mfc1  $t7, $f6
/* 01EDFC 8001E1FC 00000000 */  nop   
/* 01EE00 8001E200 4458F800 */  cfc1  $t8, $31
/* 01EE04 8001E204 A62F0000 */  sh    $t7, ($s1)
/* 01EE08 8001E208 37010003 */  ori   $at, $t8, 3
/* 01EE0C 8001E20C 38210002 */  xori  $at, $at, 2
/* 01EE10 8001E210 44C1F800 */  ctc1  $at, $31
/* 01EE14 8001E214 C4880010 */  lwc1  $f8, 0x10($a0)
/* 01EE18 8001E218 35C10003 */  ori   $at, $t6, 3
/* 01EE1C 8001E21C 460042A4 */  cvt.w.s $f10, $f8
/* 01EE20 8001E220 38210002 */  xori  $at, $at, 2
/* 01EE24 8001E224 44195000 */  mfc1  $t9, $f10
/* 01EE28 8001E228 44D8F800 */  ctc1  $t8, $31
/* 01EE2C 8001E22C A4D90000 */  sh    $t9, ($a2)
/* 01EE30 8001E230 C4900014 */  lwc1  $f16, 0x14($a0)
/* 01EE34 8001E234 44C1F800 */  ctc1  $at, $31
/* 01EE38 8001E238 00000000 */  nop   
/* 01EE3C 8001E23C 460084A4 */  cvt.w.s $f18, $f16
/* 01EE40 8001E240 440F9000 */  mfc1  $t7, $f18
/* 01EE44 8001E244 44CEF800 */  ctc1  $t6, $31
/* 01EE48 8001E248 A4EF0000 */  sh    $t7, ($a3)
/* 01EE4C 8001E24C 84980004 */  lh    $t8, 4($a0)
/* 01EE50 8001E250 00000000 */  nop   
/* 01EE54 8001E254 A5180000 */  sh    $t8, ($t0)
/* 01EE58 8001E258 84990002 */  lh    $t9, 2($a0)
/* 01EE5C 8001E25C 00000000 */  nop   
/* 01EE60 8001E260 A5390000 */  sh    $t9, ($t1)
/* 01EE64 8001E264 848E0000 */  lh    $t6, ($a0)
/* 01EE68 8001E268 00000000 */  nop   
/* 01EE6C 8001E26C A54E0000 */  sh    $t6, ($t2)
/* 01EE70 8001E270 8D630000 */  lw    $v1, ($t3)
/* 01EE74 8001E274 00000000 */  nop   
/* 01EE78 8001E278 00601025 */  move  $v0, $v1
.L8001E27C:
/* 01EE7C 8001E27C 24420001 */  addiu $v0, $v0, 1
.L8001E280:
/* 01EE80 8001E280 0043082A */  slt   $at, $v0, $v1
/* 01EE84 8001E284 1420FFC0 */  bnez  $at, .L8001E188
/* 01EE88 8001E288 00000000 */   nop   
.L8001E28C:
/* 01EE8C 8001E28C 8FB00008 */  lw    $s0, 8($sp)
/* 01EE90 8001E290 8FB1000C */  lw    $s1, 0xc($sp)
/* 01EE94 8001E294 03E00008 */  jr    $ra
/* 01EE98 8001E298 27BD0010 */   addiu $sp, $sp, 0x10
