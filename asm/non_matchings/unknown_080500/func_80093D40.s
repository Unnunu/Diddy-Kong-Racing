glabel func_80093D40
/* 094940 80093D40 27BDFFB8 */  addiu $sp, $sp, -0x48
/* 094944 80093D44 AFB3002C */  sw    $s3, 0x2c($sp)
/* 094948 80093D48 3C13800E */  lui   $s3, %hi(D_800E0984) # $s3, 0x800e
/* 09494C 80093D4C 26730984 */  addiu $s3, %lo(D_800E0984) # addiu $s3, $s3, 0x984
/* 094950 80093D50 8E620000 */  lw    $v0, ($s3)
/* 094954 80093D54 AFB10024 */  sw    $s1, 0x24($sp)
/* 094958 80093D58 AFBF0034 */  sw    $ra, 0x34($sp)
/* 09495C 80093D5C AFB40030 */  sw    $s4, 0x30($sp)
/* 094960 80093D60 AFB20028 */  sw    $s2, 0x28($sp)
/* 094964 80093D64 AFB00020 */  sw    $s0, 0x20($sp)
/* 094968 80093D68 AFA40048 */  sw    $a0, 0x48($sp)
/* 09496C 80093D6C 00008825 */  move  $s1, $zero
/* 094970 80093D70 18400013 */  blez  $v0, .L80093DC0
/* 094974 80093D74 240800A0 */   li    $t0, 160
/* 094978 80093D78 3C108012 */  lui   $s0, %hi(D_80126A40) # $s0, 0x8012
/* 09497C 80093D7C 26106A40 */  addiu $s0, %lo(D_80126A40) # addiu $s0, $s0, 0x6a40
.L80093D80:
/* 094980 80093D80 8E040000 */  lw    $a0, ($s0)
/* 094984 80093D84 00002825 */  move  $a1, $zero
/* 094988 80093D88 00003025 */  move  $a2, $zero
/* 09498C 80093D8C 0C031368 */  jal   func_800C4DA0
/* 094990 80093D90 AFA80038 */   sw    $t0, 0x38($sp)
/* 094994 80093D94 8FA80038 */  lw    $t0, 0x38($sp)
/* 094998 80093D98 24430008 */  addiu $v1, $v0, 8
/* 09499C 80093D9C 0103082A */  slt   $at, $t0, $v1
/* 0949A0 80093DA0 10200002 */  beqz  $at, .L80093DAC
/* 0949A4 80093DA4 00000000 */   nop   
/* 0949A8 80093DA8 00604025 */  move  $t0, $v1
.L80093DAC:
/* 0949AC 80093DAC 8E620000 */  lw    $v0, ($s3)
/* 0949B0 80093DB0 26310001 */  addiu $s1, $s1, 1
/* 0949B4 80093DB4 0222082A */  slt   $at, $s1, $v0
/* 0949B8 80093DB8 1420FFF1 */  bnez  $at, .L80093D80
/* 0949BC 80093DBC 26100004 */   addiu $s0, $s0, 4
.L80093DC0:
/* 0949C0 80093DC0 3C0E8000 */  lui   $t6, %hi(osTvType) # $t6, 0x8000
/* 0949C4 80093DC4 8DCE0300 */  lw    $t6, %lo(osTvType)($t6)
/* 0949C8 80093DC8 00028900 */  sll   $s1, $v0, 4
/* 0949CC 80093DCC 15C00003 */  bnez  $t6, .L80093DDC
/* 0949D0 80093DD0 2631001C */   addiu $s1, $s1, 0x1c
/* 0949D4 80093DD4 10000002 */  b     .L80093DE0
/* 0949D8 80093DD8 24120084 */   li    $s2, 132
.L80093DDC:
/* 0949DC 80093DDC 24120078 */  li    $s2, 120
.L80093DE0:
/* 0949E0 80093DE0 24040007 */  li    $a0, 7
/* 0949E4 80093DE4 0C0315B4 */  jal   func_800C56D0
/* 0949E8 80093DE8 AFA80038 */   sw    $t0, 0x38($sp)
/* 0949EC 80093DEC 0C031525 */  jal   func_800C5494
/* 0949F0 80093DF0 24040007 */   li    $a0, 7
/* 0949F4 80093DF4 8FA80038 */  lw    $t0, 0x38($sp)
/* 0949F8 80093DF8 00118043 */  sra   $s0, $s1, 1
/* 0949FC 80093DFC 0212C021 */  addu  $t8, $s0, $s2
/* 094A00 80093E00 240F00A0 */  li    $t7, 160
/* 094A04 80093E04 00081043 */  sra   $v0, $t0, 1
/* 094A08 80093E08 01E22823 */  subu  $a1, $t7, $v0
/* 094A0C 80093E0C 244700A0 */  addiu $a3, $v0, 0xa0
/* 094A10 80093E10 AFB80010 */  sw    $t8, 0x10($sp)
/* 094A14 80093E14 02503023 */  subu  $a2, $s2, $s0
/* 094A18 80093E18 0C0313B7 */  jal   func_800C4EDC
/* 094A1C 80093E1C 24040007 */   li    $a0, 7
/* 094A20 80093E20 3C11800E */  lui   $s1, %hi(D_800E098C) # $s1, 0x800e
/* 094A24 80093E24 2631098C */  addiu $s1, %lo(D_800E098C) # addiu $s1, $s1, 0x98c
/* 094A28 80093E28 8E240000 */  lw    $a0, ($s1)
/* 094A2C 80093E2C 0C01A93E */  jal   func_8006A4F8
/* 094A30 80093E30 00000000 */   nop   
/* 094A34 80093E34 3C09800E */  lui   $t1, %hi(D_800E0990) # $t1, 0x800e
/* 094A38 80093E38 25290990 */  addiu $t1, %lo(D_800E0990) # addiu $t1, $t1, 0x990
/* 094A3C 80093E3C 0002C880 */  sll   $t9, $v0, 2
/* 094A40 80093E40 03291821 */  addu  $v1, $t9, $t1
/* 094A44 80093E44 906A0003 */  lbu   $t2, 3($v1)
/* 094A48 80093E48 90650000 */  lbu   $a1, ($v1)
/* 094A4C 80093E4C 90660001 */  lbu   $a2, 1($v1)
/* 094A50 80093E50 90670002 */  lbu   $a3, 2($v1)
/* 094A54 80093E54 24040007 */  li    $a0, 7
/* 094A58 80093E58 0C0313EF */  jal   func_800C4FBC
/* 094A5C 80093E5C AFAA0010 */   sw    $t2, 0x10($sp)
/* 094A60 80093E60 24040007 */  li    $a0, 7
/* 094A64 80093E64 0C0313DF */  jal   func_800C4F7C
/* 094A68 80093E68 00002825 */   move  $a1, $zero
/* 094A6C 80093E6C 24040007 */  li    $a0, 7
/* 094A70 80093E70 24050080 */  li    $a1, 128
/* 094A74 80093E74 24060080 */  li    $a2, 128
/* 094A78 80093E78 240700FF */  li    $a3, 255
/* 094A7C 80093E7C 0C031414 */  jal   func_800C5050
/* 094A80 80093E80 AFA00010 */   sw    $zero, 0x10($sp)
/* 094A84 80093E84 8E240000 */  lw    $a0, ($s1)
/* 094A88 80093E88 0C01A93E */  jal   func_8006A4F8
/* 094A8C 80093E8C 00000000 */   nop   
/* 094A90 80093E90 3C0C800E */  lui   $t4, %hi(D_800E09A0) # $t4, 0x800e
/* 094A94 80093E94 258C09A0 */  addiu $t4, %lo(D_800E09A0) # addiu $t4, $t4, 0x9a0
/* 094A98 80093E98 00025880 */  sll   $t3, $v0, 2
/* 094A9C 80093E9C 016C1821 */  addu  $v1, $t3, $t4
/* 094AA0 80093EA0 906D0003 */  lbu   $t5, 3($v1)
/* 094AA4 80093EA4 90650000 */  lbu   $a1, ($v1)
/* 094AA8 80093EA8 90660001 */  lbu   $a2, 1($v1)
/* 094AAC 80093EAC 90670002 */  lbu   $a3, 2($v1)
/* 094AB0 80093EB0 240E00FF */  li    $t6, 255
/* 094AB4 80093EB4 AFAE0014 */  sw    $t6, 0x14($sp)
/* 094AB8 80093EB8 24040007 */  li    $a0, 7
/* 094ABC 80093EBC 0C031400 */  jal   func_800C5000
/* 094AC0 80093EC0 AFAD0010 */   sw    $t5, 0x10($sp)
/* 094AC4 80093EC4 3C148012 */  lui   $s4, %hi(D_801263BC) # $s4, 0x8012
/* 094AC8 80093EC8 8E9463BC */  lw    $s4, %lo(D_801263BC)($s4)
/* 094ACC 80093ECC 3C12800E */  lui   $s2, %hi(D_800E0988) # $s2, 0x800e
/* 094AD0 80093ED0 001478C0 */  sll   $t7, $s4, 3
/* 094AD4 80093ED4 29E10100 */  slti  $at, $t7, 0x100
/* 094AD8 80093ED8 14200003 */  bnez  $at, .L80093EE8
/* 094ADC 80093EDC 01E0A025 */   move  $s4, $t7
/* 094AE0 80093EE0 241801FF */  li    $t8, 511
/* 094AE4 80093EE4 030FA023 */  subu  $s4, $t8, $t7
.L80093EE8:
/* 094AE8 80093EE8 26520988 */  addiu $s2, %lo(D_800E0988) # addiu $s2, $s2, 0x988
/* 094AEC 80093EEC 8E590000 */  lw    $t9, ($s2)
/* 094AF0 80093EF0 24040007 */  li    $a0, 7
/* 094AF4 80093EF4 13200060 */  beqz  $t9, .L80094078
/* 094AF8 80093EF8 24058000 */   li    $a1, -32768
/* 094AFC 80093EFC 3C09800E */  lui   $t1, %hi(D_800E0FE8) # $t1, 0x800e
/* 094B00 80093F00 8D290FE8 */  lw    $t1, %lo(D_800E0FE8)($t1)
/* 094B04 80093F04 24040007 */  li    $a0, 7
/* 094B08 80093F08 1120000F */  beqz  $t1, .L80093F48
/* 094B0C 80093F0C 24058000 */   li    $a1, -32768
/* 094B10 80093F10 3C0A800E */  lui   $t2, %hi(D_800DF4A0) # $t2, 0x800e
/* 094B14 80093F14 8D4AF4A0 */  lw    $t2, %lo(D_800DF4A0)($t2)
/* 094B18 80093F18 2611FFE6 */  addiu $s1, $s0, -0x1a
/* 094B1C 80093F1C 8D470208 */  lw    $a3, 0x208($t2)
/* 094B20 80093F20 240B0001 */  li    $t3, 1
/* 094B24 80093F24 240C000C */  li    $t4, 12
/* 094B28 80093F28 AFAC0014 */  sw    $t4, 0x14($sp)
/* 094B2C 80093F2C AFAB0010 */  sw    $t3, 0x10($sp)
/* 094B30 80093F30 26260008 */  addiu $a2, $s1, 8
/* 094B34 80093F34 24040007 */  li    $a0, 7
/* 094B38 80093F38 0C03145A */  jal   func_800C5168
/* 094B3C 80093F3C 24058000 */   li    $a1, -32768
/* 094B40 80093F40 1000000C */  b     .L80093F74
/* 094B44 80093F44 8E580000 */   lw    $t8, ($s2)
.L80093F48:
/* 094B48 80093F48 3C0D800E */  lui   $t5, %hi(D_800DF4A0) # $t5, 0x800e
/* 094B4C 80093F4C 8DADF4A0 */  lw    $t5, %lo(D_800DF4A0)($t5)
/* 094B50 80093F50 2611FFE6 */  addiu $s1, $s0, -0x1a
/* 094B54 80093F54 8DA70210 */  lw    $a3, 0x210($t5)
/* 094B58 80093F58 240E0001 */  li    $t6, 1
/* 094B5C 80093F5C 240F000C */  li    $t7, 12
/* 094B60 80093F60 AFAF0014 */  sw    $t7, 0x14($sp)
/* 094B64 80093F64 AFAE0010 */  sw    $t6, 0x10($sp)
/* 094B68 80093F68 0C03145A */  jal   func_800C5168
/* 094B6C 80093F6C 26260008 */   addiu $a2, $s1, 8
/* 094B70 80093F70 8E580000 */  lw    $t8, ($s2)
.L80093F74:
/* 094B74 80093F74 24010001 */  li    $at, 1
/* 094B78 80093F78 1701000B */  bne   $t8, $at, .L80093FA8
/* 094B7C 80093F7C 24040007 */   li    $a0, 7
/* 094B80 80093F80 241900FF */  li    $t9, 255
/* 094B84 80093F84 AFB90014 */  sw    $t9, 0x14($sp)
/* 094B88 80093F88 24040007 */  li    $a0, 7
/* 094B8C 80093F8C 240500FF */  li    $a1, 255
/* 094B90 80093F90 240600FF */  li    $a2, 255
/* 094B94 80093F94 240700FF */  li    $a3, 255
/* 094B98 80093F98 0C031400 */  jal   func_800C5000
/* 094B9C 80093F9C AFB40010 */   sw    $s4, 0x10($sp)
/* 094BA0 80093FA0 10000008 */  b     .L80093FC4
/* 094BA4 80093FA4 00000000 */   nop   
.L80093FA8:
/* 094BA8 80093FA8 240900FF */  li    $t1, 255
/* 094BAC 80093FAC AFA90014 */  sw    $t1, 0x14($sp)
/* 094BB0 80093FB0 240500FF */  li    $a1, 255
/* 094BB4 80093FB4 240600FF */  li    $a2, 255
/* 094BB8 80093FB8 240700FF */  li    $a3, 255
/* 094BBC 80093FBC 0C031400 */  jal   func_800C5000
/* 094BC0 80093FC0 AFA00010 */   sw    $zero, 0x10($sp)
.L80093FC4:
/* 094BC4 80093FC4 3C0A800E */  lui   $t2, %hi(D_800DF4A0) # $t2, 0x800e
/* 094BC8 80093FC8 8D4AF4A0 */  lw    $t2, %lo(D_800DF4A0)($t2)
/* 094BCC 80093FCC 240B0001 */  li    $t3, 1
/* 094BD0 80093FD0 8D470218 */  lw    $a3, 0x218($t2)
/* 094BD4 80093FD4 240C000C */  li    $t4, 12
/* 094BD8 80093FD8 AFAC0014 */  sw    $t4, 0x14($sp)
/* 094BDC 80093FDC AFAB0010 */  sw    $t3, 0x10($sp)
/* 094BE0 80093FE0 24040007 */  li    $a0, 7
/* 094BE4 80093FE4 24058000 */  li    $a1, -32768
/* 094BE8 80093FE8 0C03145A */  jal   func_800C5168
/* 094BEC 80093FEC 2626001C */   addiu $a2, $s1, 0x1c
/* 094BF0 80093FF0 8E4D0000 */  lw    $t5, ($s2)
/* 094BF4 80093FF4 24010002 */  li    $at, 2
/* 094BF8 80093FF8 15A1000B */  bne   $t5, $at, .L80094028
/* 094BFC 80093FFC 24040007 */   li    $a0, 7
/* 094C00 80094000 240E00FF */  li    $t6, 255
/* 094C04 80094004 AFAE0014 */  sw    $t6, 0x14($sp)
/* 094C08 80094008 24040007 */  li    $a0, 7
/* 094C0C 8009400C 240500FF */  li    $a1, 255
/* 094C10 80094010 240600FF */  li    $a2, 255
/* 094C14 80094014 240700FF */  li    $a3, 255
/* 094C18 80094018 0C031400 */  jal   func_800C5000
/* 094C1C 8009401C AFB40010 */   sw    $s4, 0x10($sp)
/* 094C20 80094020 10000008 */  b     .L80094044
/* 094C24 80094024 00000000 */   nop   
.L80094028:
/* 094C28 80094028 240F00FF */  li    $t7, 255
/* 094C2C 8009402C AFAF0014 */  sw    $t7, 0x14($sp)
/* 094C30 80094030 240500FF */  li    $a1, 255
/* 094C34 80094034 240600FF */  li    $a2, 255
/* 094C38 80094038 240700FF */  li    $a3, 255
/* 094C3C 8009403C 0C031400 */  jal   func_800C5000
/* 094C40 80094040 AFA00010 */   sw    $zero, 0x10($sp)
.L80094044:
/* 094C44 80094044 3C18800E */  lui   $t8, %hi(D_800DF4A0) # $t8, 0x800e
/* 094C48 80094048 8F18F4A0 */  lw    $t8, %lo(D_800DF4A0)($t8)
/* 094C4C 8009404C 24190001 */  li    $t9, 1
/* 094C50 80094050 8F070154 */  lw    $a3, 0x154($t8)
/* 094C54 80094054 2409000C */  li    $t1, 12
/* 094C58 80094058 AFA90014 */  sw    $t1, 0x14($sp)
/* 094C5C 8009405C AFB90010 */  sw    $t9, 0x10($sp)
/* 094C60 80094060 24040007 */  li    $a0, 7
/* 094C64 80094064 24058000 */  li    $a1, -32768
/* 094C68 80094068 0C03145A */  jal   func_800C5168
/* 094C6C 8009406C 2626002C */   addiu $a2, $s1, 0x2c
/* 094C70 80094070 10000035 */  b     .L80094148
/* 094C74 80094074 00000000 */   nop   
.L80094078:
/* 094C78 80094078 3C0A800E */  lui   $t2, %hi(D_800DF4A0) # $t2, 0x800e
/* 094C7C 8009407C 8D4AF4A0 */  lw    $t2, %lo(D_800DF4A0)($t2)
/* 094C80 80094080 8E2B0000 */  lw    $t3, ($s1)
/* 094C84 80094084 8D470214 */  lw    $a3, 0x214($t2)
/* 094C88 80094088 240D000C */  li    $t5, 12
/* 094C8C 8009408C 256C0001 */  addiu $t4, $t3, 1
/* 094C90 80094090 AFAC0010 */  sw    $t4, 0x10($sp)
/* 094C94 80094094 AFAD0014 */  sw    $t5, 0x14($sp)
/* 094C98 80094098 0C03145A */  jal   func_800C5168
/* 094C9C 8009409C 2406000C */   li    $a2, 12
/* 094CA0 800940A0 8E6E0000 */  lw    $t6, ($s3)
/* 094CA4 800940A4 00008825 */  move  $s1, $zero
/* 094CA8 800940A8 19C00027 */  blez  $t6, .L80094148
/* 094CAC 800940AC 24120020 */   li    $s2, 32
/* 094CB0 800940B0 3C108012 */  lui   $s0, %hi(D_80126A40) # $s0, 0x8012
/* 094CB4 800940B4 26106A40 */  addiu $s0, %lo(D_80126A40) # addiu $s0, $s0, 0x6a40
.L800940B8:
/* 094CB8 800940B8 3C0F8012 */  lui   $t7, %hi(D_80126A68) # $t7, 0x8012
/* 094CBC 800940BC 8DEF6A68 */  lw    $t7, %lo(D_80126A68)($t7)
/* 094CC0 800940C0 24040007 */  li    $a0, 7
/* 094CC4 800940C4 162F000B */  bne   $s1, $t7, .L800940F4
/* 094CC8 800940C8 240500FF */   li    $a1, 255
/* 094CCC 800940CC 241800FF */  li    $t8, 255
/* 094CD0 800940D0 AFB80014 */  sw    $t8, 0x14($sp)
/* 094CD4 800940D4 24040007 */  li    $a0, 7
/* 094CD8 800940D8 240500FF */  li    $a1, 255
/* 094CDC 800940DC 240600FF */  li    $a2, 255
/* 094CE0 800940E0 240700FF */  li    $a3, 255
/* 094CE4 800940E4 0C031400 */  jal   func_800C5000
/* 094CE8 800940E8 AFB40010 */   sw    $s4, 0x10($sp)
/* 094CEC 800940EC 10000008 */  b     .L80094110
/* 094CF0 800940F0 8E070000 */   lw    $a3, ($s0)
.L800940F4:
/* 094CF4 800940F4 241900FF */  li    $t9, 255
/* 094CF8 800940F8 AFB90014 */  sw    $t9, 0x14($sp)
/* 094CFC 800940FC 240600FF */  li    $a2, 255
/* 094D00 80094100 240700FF */  li    $a3, 255
/* 094D04 80094104 0C031400 */  jal   func_800C5000
/* 094D08 80094108 AFA00010 */   sw    $zero, 0x10($sp)
/* 094D0C 8009410C 8E070000 */  lw    $a3, ($s0)
.L80094110:
/* 094D10 80094110 24090001 */  li    $t1, 1
/* 094D14 80094114 240A000C */  li    $t2, 12
/* 094D18 80094118 AFAA0014 */  sw    $t2, 0x14($sp)
/* 094D1C 8009411C AFA90010 */  sw    $t1, 0x10($sp)
/* 094D20 80094120 24040007 */  li    $a0, 7
/* 094D24 80094124 24058000 */  li    $a1, -32768
/* 094D28 80094128 0C03145A */  jal   func_800C5168
/* 094D2C 8009412C 02403025 */   move  $a2, $s2
/* 094D30 80094130 8E6B0000 */  lw    $t3, ($s3)
/* 094D34 80094134 26310001 */  addiu $s1, $s1, 1
/* 094D38 80094138 022B082A */  slt   $at, $s1, $t3
/* 094D3C 8009413C 26100004 */  addiu $s0, $s0, 4
/* 094D40 80094140 1420FFDD */  bnez  $at, .L800940B8
/* 094D44 80094144 26520010 */   addiu $s2, $s2, 0x10
.L80094148:
/* 094D48 80094148 0C03157D */  jal   func_800C55F4
/* 094D4C 8009414C 24040007 */   li    $a0, 7
/* 094D50 80094150 8FBF0034 */  lw    $ra, 0x34($sp)
/* 094D54 80094154 8FB00020 */  lw    $s0, 0x20($sp)
/* 094D58 80094158 8FB10024 */  lw    $s1, 0x24($sp)
/* 094D5C 8009415C 8FB20028 */  lw    $s2, 0x28($sp)
/* 094D60 80094160 8FB3002C */  lw    $s3, 0x2c($sp)
/* 094D64 80094164 8FB40030 */  lw    $s4, 0x30($sp)
/* 094D68 80094168 03E00008 */  jr    $ra
/* 094D6C 8009416C 27BD0048 */   addiu $sp, $sp, 0x48

