.late_rodata
glabel jpt_800E8508
.word L80094DD0, L80094FB0, L80095084, L80095588, L80095110, L800951CC
glabel D_800E8520
.float 1.2

.text
glabel func_80094D28
/* 095928 80094D28 27BDFFA0 */  addiu $sp, $sp, -0x60
/* 09592C 80094D2C AFBF002C */  sw    $ra, 0x2c($sp)
/* 095930 80094D30 AFB30028 */  sw    $s3, 0x28($sp)
/* 095934 80094D34 AFB20024 */  sw    $s2, 0x24($sp)
/* 095938 80094D38 AFB10020 */  sw    $s1, 0x20($sp)
/* 09593C 80094D3C AFB0001C */  sw    $s0, 0x1c($sp)
/* 095940 80094D40 0C01BAA4 */  jal   get_settings
/* 095944 80094D44 AFA40060 */   sw    $a0, 0x60($sp)
/* 095948 80094D48 3C0E800E */  lui   $t6, %hi(gNumberOfActivePlayers) # $t6, 0x800e
/* 09594C 80094D4C 8DCEF4BC */  lw    $t6, %lo(gNumberOfActivePlayers)($t6)
/* 095950 80094D50 24010001 */  li    $at, 1
/* 095954 80094D54 15C10006 */  bne   $t6, $at, .L80094D70
/* 095958 80094D58 00408025 */   move  $s0, $v0
/* 09595C 80094D5C 3C048012 */  lui   $a0, %hi(sMenuCurrDisplayList) # $a0, 0x8012
/* 095960 80094D60 3C058012 */  lui   $a1, %hi(sMenuCurrHudMat) # $a1, 0x8012
/* 095964 80094D64 24A563A8 */  addiu $a1, %lo(sMenuCurrHudMat) # addiu $a1, $a1, 0x63a8
/* 095968 80094D68 0C019FCB */  jal   set_ortho_matrix_view
/* 09596C 80094D6C 248463A0 */   addiu $a0, %lo(sMenuCurrDisplayList) # addiu $a0, $a0, 0x63a0
.L80094D70:
/* 095970 80094D70 00002025 */  move  $a0, $zero
/* 095974 80094D74 0C019A25 */  jal   camDisableUserView
/* 095978 80094D78 24050001 */   li    $a1, 1
/* 09597C 80094D7C 3C138012 */  lui   $s3, %hi(gOptionBlinkTimer) # $s3, 0x8012
/* 095980 80094D80 8E7363BC */  lw    $s3, %lo(gOptionBlinkTimer)($s3)
/* 095984 80094D84 3C198012 */  lui   $t9, %hi(gMenuOptionCount) # $t9, 0x8012
/* 095988 80094D88 001378C0 */  sll   $t7, $s3, 3
/* 09598C 80094D8C 29E10100 */  slti  $at, $t7, 0x100
/* 095990 80094D90 14200003 */  bnez  $at, .L80094DA0
/* 095994 80094D94 01E09825 */   move  $s3, $t7
/* 095998 80094D98 241801FF */  li    $t8, 511
/* 09599C 80094D9C 03139823 */  subu  $s3, $t8, $s3
.L80094DA0:
/* 0959A0 80094DA0 8F3963E0 */  lw    $t9, %lo(gMenuOptionCount)($t9)
/* 0959A4 80094DA4 00000000 */  nop   
/* 0959A8 80094DA8 272AFFFF */  addiu $t2, $t9, -1
/* 0959AC 80094DAC 2D410006 */  sltiu $at, $t2, 6
/* 0959B0 80094DB0 102001F5 */  beqz  $at, .L80095588
/* 0959B4 80094DB4 000A5080 */   sll   $t2, $t2, 2
/* 0959B8 80094DB8 3C01800F */  lui   $at, %hi(jpt_800E8508) # $at, 0x800f
/* 0959BC 80094DBC 002A0821 */  addu  $at, $at, $t2
/* 0959C0 80094DC0 8C2A8508 */  lw    $t2, %lo(jpt_800E8508)($at)
/* 0959C4 80094DC4 00000000 */  nop   
/* 0959C8 80094DC8 01400008 */  jr    $t2
/* 0959CC 80094DCC 00000000 */   nop   
glabel L80094DD0
/* 0959D0 80094DD0 3C108012 */  lui   $s0, %hi(D_80126A94) # $s0, 0x8012
/* 0959D4 80094DD4 8E106A94 */  lw    $s0, %lo(D_80126A94)($s0)
/* 0959D8 80094DD8 3C118012 */  lui   $s1, %hi(gTrackSelectViewPortHalfY) # $s1, 0x8012
/* 0959DC 80094DDC 2A01003D */  slti  $at, $s0, 0x3d
/* 0959E0 80094DE0 14200002 */  bnez  $at, .L80094DEC
/* 0959E4 80094DE4 26316478 */   addiu $s1, %lo(gTrackSelectViewPortHalfY) # addiu $s1, $s1, 0x6478
/* 0959E8 80094DE8 2410003C */  li    $s0, 60
.L80094DEC:
/* 0959EC 80094DEC 8E220000 */  lw    $v0, ($s1)
/* 0959F0 80094DF0 24090005 */  li    $t1, 5
/* 0959F4 80094DF4 00025880 */  sll   $t3, $v0, 2
/* 0959F8 80094DF8 0169001A */  div   $zero, $t3, $t1
/* 0959FC 80094DFC 2403003C */  li    $v1, 60
/* 095A00 80094E00 15200002 */  bnez  $t1, .L80094E0C
/* 095A04 80094E04 00000000 */   nop   
/* 095A08 80094E08 0007000D */  break 7
.L80094E0C:
/* 095A0C 80094E0C 2401FFFF */  li    $at, -1
/* 095A10 80094E10 15210004 */  bne   $t1, $at, .L80094E24
/* 095A14 80094E14 3C018000 */   lui   $at, 0x8000
/* 095A18 80094E18 15610002 */  bne   $t3, $at, .L80094E24
/* 095A1C 80094E1C 00000000 */   nop   
/* 095A20 80094E20 0006000D */  break 6
.L80094E24:
/* 095A24 80094E24 3C0F8012 */  lui   $t7, %hi(gTrackSelectViewportY) # $t7, 0x8012
/* 095A28 80094E28 8DEF6480 */  lw    $t7, %lo(gTrackSelectViewportY)($t7)
/* 095A2C 80094E2C 00002025 */  move  $a0, $zero
/* 095A30 80094E30 00006012 */  mflo  $t4
/* 095A34 80094E34 004C6823 */  subu  $t5, $v0, $t4
/* 095A38 80094E38 00106080 */  sll   $t4, $s0, 2
/* 095A3C 80094E3C 01B00019 */  multu $t5, $s0
/* 095A40 80094E40 01906021 */  addu  $t4, $t4, $s0
/* 095A44 80094E44 000C6100 */  sll   $t4, $t4, 4
/* 095A48 80094E48 240D0140 */  li    $t5, 320
/* 095A4C 80094E4C 00007012 */  mflo  $t6
/* 095A50 80094E50 00000000 */  nop   
/* 095A54 80094E54 00000000 */  nop   
/* 095A58 80094E58 01C3001A */  div   $zero, $t6, $v1
/* 095A5C 80094E5C 14600002 */  bnez  $v1, .L80094E68
/* 095A60 80094E60 00000000 */   nop   
/* 095A64 80094E64 0007000D */  break 7
.L80094E68:
/* 095A68 80094E68 2401FFFF */  li    $at, -1
/* 095A6C 80094E6C 14610004 */  bne   $v1, $at, .L80094E80
/* 095A70 80094E70 3C018000 */   lui   $at, 0x8000
/* 095A74 80094E74 15C10002 */  bne   $t6, $at, .L80094E80
/* 095A78 80094E78 00000000 */   nop   
/* 095A7C 80094E7C 0006000D */  break 6
.L80094E80:
/* 095A80 80094E80 00009012 */  mflo  $s2
/* 095A84 80094E84 02403025 */  move  $a2, $s2
/* 095A88 80094E88 00000000 */  nop   
/* 095A8C 80094E8C 0049001A */  div   $zero, $v0, $t1
/* 095A90 80094E90 15200002 */  bnez  $t1, .L80094E9C
/* 095A94 80094E94 00000000 */   nop   
/* 095A98 80094E98 0007000D */  break 7
.L80094E9C:
/* 095A9C 80094E9C 2401FFFF */  li    $at, -1
/* 095AA0 80094EA0 15210004 */  bne   $t1, $at, .L80094EB4
/* 095AA4 80094EA4 3C018000 */   lui   $at, 0x8000
/* 095AA8 80094EA8 14410002 */  bne   $v0, $at, .L80094EB4
/* 095AAC 80094EAC 00000000 */   nop   
/* 095AB0 80094EB0 0006000D */  break 6
.L80094EB4:
/* 095AB4 80094EB4 0000C012 */  mflo  $t8
/* 095AB8 80094EB8 0058C823 */  subu  $t9, $v0, $t8
/* 095ABC 80094EBC 00000000 */  nop   
/* 095AC0 80094EC0 03300019 */  multu $t9, $s0
/* 095AC4 80094EC4 00005012 */  mflo  $t2
/* 095AC8 80094EC8 00000000 */  nop   
/* 095ACC 80094ECC 00000000 */  nop   
/* 095AD0 80094ED0 0143001A */  div   $zero, $t2, $v1
/* 095AD4 80094ED4 14600002 */  bnez  $v1, .L80094EE0
/* 095AD8 80094ED8 00000000 */   nop   
/* 095ADC 80094EDC 0007000D */  break 7
.L80094EE0:
/* 095AE0 80094EE0 2401FFFF */  li    $at, -1
/* 095AE4 80094EE4 14610004 */  bne   $v1, $at, .L80094EF8
/* 095AE8 80094EE8 3C018000 */   lui   $at, 0x8000
/* 095AEC 80094EEC 15410002 */  bne   $t2, $at, .L80094EF8
/* 095AF0 80094EF0 00000000 */   nop   
/* 095AF4 80094EF4 0006000D */  break 6
.L80094EF8:
/* 095AF8 80094EF8 00005812 */  mflo  $t3
/* 095AFC 80094EFC 01EB4023 */  subu  $t0, $t7, $t3
/* 095B00 80094F00 AFA80010 */  sw    $t0, 0x10($sp)
/* 095B04 80094F04 0183001A */  div   $zero, $t4, $v1
/* 095B08 80094F08 AFA80050 */  sw    $t0, 0x50($sp)
/* 095B0C 80094F0C 14600002 */  bnez  $v1, .L80094F18
/* 095B10 80094F10 00000000 */   nop   
/* 095B14 80094F14 0007000D */  break 7
.L80094F18:
/* 095B18 80094F18 2401FFFF */  li    $at, -1
/* 095B1C 80094F1C 14610004 */  bne   $v1, $at, .L80094F30
/* 095B20 80094F20 3C018000 */   lui   $at, 0x8000
/* 095B24 80094F24 15810002 */  bne   $t4, $at, .L80094F30
/* 095B28 80094F28 00000000 */   nop   
/* 095B2C 80094F2C 0006000D */  break 6
.L80094F30:
/* 095B30 80094F30 00002812 */  mflo  $a1
/* 095B34 80094F34 01A53823 */  subu  $a3, $t5, $a1
/* 095B38 80094F38 0C019A50 */  jal   resize_viewport
/* 095B3C 80094F3C 00000000 */   nop   
/* 095B40 80094F40 3C02800E */  lui   $v0, %hi(gMenuImageStack) # $v0, 0x800e
/* 095B44 80094F44 44905000 */  mtc1  $s0, $f10
/* 095B48 80094F48 2442F75C */  addiu $v0, %lo(gMenuImageStack) # addiu $v0, $v0, -0x8a4
/* 095B4C 80094F4C 8C4E0000 */  lw    $t6, ($v0)
/* 095B50 80094F50 44802000 */  mtc1  $zero, $f4
/* 095B54 80094F54 46805420 */  cvt.s.w $f16, $f10
/* 095B58 80094F58 3C014270 */  li    $at, 0x42700000 # 60.000000
/* 095B5C 80094F5C 44819000 */  mtc1  $at, $f18
/* 095B60 80094F60 E5C4008C */  swc1  $f4, 0x8c($t6)
/* 095B64 80094F64 46128103 */  div.s $f4, $f16, $f18
/* 095B68 80094F68 8FB90050 */  lw    $t9, 0x50($sp)
/* 095B6C 80094F6C 8E380000 */  lw    $t8, ($s1)
/* 095B70 80094F70 02595021 */  addu  $t2, $s2, $t9
/* 095B74 80094F74 000A7843 */  sra   $t7, $t2, 1
/* 095B78 80094F78 030F5823 */  subu  $t3, $t8, $t7
/* 095B7C 80094F7C 448B3000 */  mtc1  $t3, $f6
/* 095B80 80094F80 8C4C0000 */  lw    $t4, ($v0)
/* 095B84 80094F84 3C014000 */  li    $at, 0x40000000 # 2.000000
/* 095B88 80094F88 46803220 */  cvt.s.w $f8, $f6
/* 095B8C 80094F8C 44813000 */  mtc1  $at, $f6
/* 095B90 80094F90 3C01800E */  lui   $at, %hi(sMenuImageProperties+0x88) # $at, 0x800e
/* 095B94 80094F94 E5880090 */  swc1  $f8, 0x90($t4)
/* 095B98 80094F98 C42AF598 */  lwc1  $f10, %lo(sMenuImageProperties+0x88)($at)
/* 095B9C 80094F9C 46043201 */  sub.s $f8, $f6, $f4
/* 095BA0 80094FA0 8C4D0000 */  lw    $t5, ($v0)
/* 095BA4 80094FA4 46085402 */  mul.s $f16, $f10, $f8
/* 095BA8 80094FA8 10000177 */  b     .L80095588
/* 095BAC 80094FAC E5B00088 */   swc1  $f16, 0x88($t5)
glabel L80094FB0
/* 095BB0 80094FB0 3C02800E */  lui   $v0, %hi(gRaceResultsMenuElements) # $v0, 0x800e
/* 095BB4 80094FB4 24420BEC */  addiu $v0, %lo(gRaceResultsMenuElements) # addiu $v0, $v0, 0xbec
/* 095BB8 80094FB8 00002825 */  move  $a1, $zero
/* 095BBC 80094FBC 240800FF */  li    $t0, 255
/* 095BC0 80094FC0 240700FF */  li    $a3, 255
/* 095BC4 80094FC4 240600C0 */  li    $a2, 192
/* 095BC8 80094FC8 240400C0 */  li    $a0, 192
/* 095BCC 80094FCC 24030003 */  li    $v1, 3
.L80094FD0:
/* 095BD0 80094FD0 820E0117 */  lb    $t6, 0x117($s0)
/* 095BD4 80094FD4 240A0001 */  li    $t2, 1
/* 095BD8 80094FD8 11C0000E */  beqz  $t6, .L80095014
/* 095BDC 80094FDC 00000000 */   nop   
/* 095BE0 80094FE0 82190058 */  lb    $t9, 0x58($s0)
/* 095BE4 80094FE4 00AAC004 */  sllv  $t8, $t2, $a1
/* 095BE8 80094FE8 03387824 */  and   $t7, $t9, $t8
/* 095BEC 80094FEC 11E00009 */  beqz  $t7, .L80095014
/* 095BF0 80094FF0 00000000 */   nop   
/* 095BF4 80094FF4 02630019 */  multu $s3, $v1
/* 095BF8 80094FF8 01137023 */  subu  $t6, $t0, $s3
/* 095BFC 80094FFC A04E006E */  sb    $t6, 0x6e($v0)
/* 095C00 80095000 00005812 */  mflo  $t3
/* 095C04 80095004 000B6083 */  sra   $t4, $t3, 2
/* 095C08 80095008 008C6823 */  subu  $t5, $a0, $t4
/* 095C0C 8009500C 10000003 */  b     .L8009501C
/* 095C10 80095010 A04D006D */   sb    $t5, 0x6d($v0)
.L80095014:
/* 095C14 80095014 A046006D */  sb    $a2, 0x6d($v0)
/* 095C18 80095018 A047006E */  sb    $a3, 0x6e($v0)
.L8009501C:
/* 095C1C 8009501C 24A50001 */  addiu $a1, $a1, 1
/* 095C20 80095020 14A3FFEB */  bne   $a1, $v1, .L80094FD0
/* 095C24 80095024 24420020 */   addiu $v0, $v0, 0x20
/* 095C28 80095028 820A0117 */  lb    $t2, 0x117($s0)
/* 095C2C 8009502C 00000000 */  nop   
/* 095C30 80095030 1140000D */  beqz  $t2, .L80095068
/* 095C34 80095034 00000000 */   nop   
/* 095C38 80095038 82190058 */  lb    $t9, 0x58($s0)
/* 095C3C 8009503C 3C02800E */  lui   $v0, %hi(gRaceResultsMenuElements) # $v0, 0x800e
/* 095C40 80095040 33380080 */  andi  $t8, $t9, 0x80
/* 095C44 80095044 13000008 */  beqz  $t8, .L80095068
/* 095C48 80095048 24420BEC */   addiu $v0, %lo(gRaceResultsMenuElements) # addiu $v0, $v0, 0xbec
/* 095C4C 8009504C 00137843 */  sra   $t7, $s3, 1
/* 095C50 80095050 25EB0080 */  addiu $t3, $t7, 0x80
/* 095C54 80095054 01131823 */  subu  $v1, $t0, $s3
/* 095C58 80095058 A04B00CC */  sb    $t3, 0xcc($v0)
/* 095C5C 8009505C A04300CD */  sb    $v1, 0xcd($v0)
/* 095C60 80095060 10000149 */  b     .L80095588
/* 095C64 80095064 A04300CE */   sb    $v1, 0xce($v0)
.L80095068:
/* 095C68 80095068 3C02800E */  lui   $v0, %hi(gRaceResultsMenuElements) # $v0, 0x800e
/* 095C6C 8009506C 24420BEC */  addiu $v0, %lo(gRaceResultsMenuElements) # addiu $v0, $v0, 0xbec
/* 095C70 80095070 240C0080 */  li    $t4, 128
/* 095C74 80095074 A04C00CC */  sb    $t4, 0xcc($v0)
/* 095C78 80095078 A04700CD */  sb    $a3, 0xcd($v0)
/* 095C7C 8009507C 10000142 */  b     .L80095588
/* 095C80 80095080 A04700CE */   sb    $a3, 0xce($v0)
glabel L80095084
/* 095C84 80095084 3C06800E */  lui   $a2, %hi(gRaceOrderMenuElements+224) # $a2, 0x800e
/* 095C88 80095088 24C60DCC */  addiu $a2, %lo(gRaceOrderMenuElements+224) # addiu $a2, $a2, 0xdcc
/* 095C8C 8009508C 00002825 */  move  $a1, $zero
/* 095C90 80095090 24110008 */  li    $s1, 8
.L80095094:
/* 095C94 80095094 240300FF */  li    $v1, 255
/* 095C98 80095098 AFA3003C */  sw    $v1, 0x3c($sp)
/* 095C9C 8009509C AFA50040 */  sw    $a1, 0x40($sp)
/* 095CA0 800950A0 AFA50044 */  sw    $a1, 0x44($sp)
/* 095CA4 800950A4 0C027B20 */  jal   is_in_two_player_adventure
/* 095CA8 800950A8 AFA60034 */   sw    $a2, 0x34($sp)
/* 095CAC 800950AC 8FA3003C */  lw    $v1, 0x3c($sp)
/* 095CB0 800950B0 8FA40040 */  lw    $a0, 0x40($sp)
/* 095CB4 800950B4 8FA50044 */  lw    $a1, 0x44($sp)
/* 095CB8 800950B8 8FA60034 */  lw    $a2, 0x34($sp)
/* 095CBC 800950BC 10400007 */  beqz  $v0, .L800950DC
/* 095CC0 800950C0 00000000 */   nop   
/* 095CC4 800950C4 820D0072 */  lb    $t5, 0x72($s0)
/* 095CC8 800950C8 24A4FFFF */  addiu $a0, $a1, -1
/* 095CCC 800950CC 148D0003 */  bne   $a0, $t5, .L800950DC
/* 095CD0 800950D0 00000000 */   nop   
/* 095CD4 800950D4 00131843 */  sra   $v1, $s3, 1
/* 095CD8 800950D8 24630080 */  addiu $v1, $v1, 0x80
.L800950DC:
/* 095CDC 800950DC 820E005A */  lb    $t6, 0x5a($s0)
/* 095CE0 800950E0 24A50001 */  addiu $a1, $a1, 1
/* 095CE4 800950E4 148E0003 */  bne   $a0, $t6, .L800950F4
/* 095CE8 800950E8 00000000 */   nop   
/* 095CEC 800950EC 00131843 */  sra   $v1, $s3, 1
/* 095CF0 800950F0 24630080 */  addiu $v1, $v1, 0x80
.L800950F4:
/* 095CF4 800950F4 24C6FFE0 */  addiu $a2, $a2, -0x20
/* 095CF8 800950F8 A0C3002C */  sb    $v1, 0x2c($a2)
/* 095CFC 800950FC A0C3002D */  sb    $v1, 0x2d($a2)
/* 095D00 80095100 14B1FFE4 */  bne   $a1, $s1, .L80095094
/* 095D04 80095104 A0C3002E */   sb    $v1, 0x2e($a2)
/* 095D08 80095108 1000011F */  b     .L80095588
/* 095D0C 8009510C 00000000 */   nop   
glabel L80095110
/* 095D10 80095110 820A0117 */  lb    $t2, 0x117($s0)
/* 095D14 80095114 3C02800E */  lui   $v0, %hi(gRecordTimesMenuElements) # $v0, 0x800e
/* 095D18 80095118 11400014 */  beqz  $t2, .L8009516C
/* 095D1C 8009511C 24420E4C */   addiu $v0, %lo(gRecordTimesMenuElements) # addiu $v0, $v0, 0xe4c
/* 095D20 80095120 82190058 */  lb    $t9, 0x58($s0)
/* 095D24 80095124 24030003 */  li    $v1, 3
/* 095D28 80095128 3338007F */  andi  $t8, $t9, 0x7f
/* 095D2C 8009512C 13000010 */  beqz  $t8, .L80095170
/* 095D30 80095130 240700FF */   li    $a3, 255
/* 095D34 80095134 02630019 */  multu $s3, $v1
/* 095D38 80095138 3C02800E */  lui   $v0, %hi(gRecordTimesMenuElements) # $v0, 0x800e
/* 095D3C 8009513C 24420E4C */  addiu $v0, %lo(gRecordTimesMenuElements) # addiu $v0, $v0, 0xe4c
/* 095D40 80095140 240400C0 */  li    $a0, 192
/* 095D44 80095144 240800FF */  li    $t0, 255
/* 095D48 80095148 240700FF */  li    $a3, 255
/* 095D4C 8009514C 01136823 */  subu  $t5, $t0, $s3
/* 095D50 80095150 A04700CC */  sb    $a3, 0xcc($v0)
/* 095D54 80095154 A04D00CE */  sb    $t5, 0xce($v0)
/* 095D58 80095158 00007812 */  mflo  $t7
/* 095D5C 8009515C 000F5883 */  sra   $t3, $t7, 2
/* 095D60 80095160 008B6023 */  subu  $t4, $a0, $t3
/* 095D64 80095164 10000007 */  b     .L80095184
/* 095D68 80095168 A04C00CD */   sb    $t4, 0xcd($v0)
.L8009516C:
/* 095D6C 8009516C 240700FF */  li    $a3, 255
.L80095170:
/* 095D70 80095170 240600C0 */  li    $a2, 192
/* 095D74 80095174 A04700CC */  sb    $a3, 0xcc($v0)
/* 095D78 80095178 A04600CD */  sb    $a2, 0xcd($v0)
/* 095D7C 8009517C A04700CE */  sb    $a3, 0xce($v0)
/* 095D80 80095180 240800FF */  li    $t0, 255
.L80095184:
/* 095D84 80095184 820E0117 */  lb    $t6, 0x117($s0)
/* 095D88 80095188 240B0080 */  li    $t3, 128
/* 095D8C 8009518C 11C0000B */  beqz  $t6, .L800951BC
/* 095D90 80095190 00000000 */   nop   
/* 095D94 80095194 820A0058 */  lb    $t2, 0x58($s0)
/* 095D98 80095198 0013C043 */  sra   $t8, $s3, 1
/* 095D9C 8009519C 31590080 */  andi  $t9, $t2, 0x80
/* 095DA0 800951A0 13200006 */  beqz  $t9, .L800951BC
/* 095DA4 800951A4 270F0080 */   addiu $t7, $t8, 0x80
/* 095DA8 800951A8 01131823 */  subu  $v1, $t0, $s3
/* 095DAC 800951AC A04F006C */  sb    $t7, 0x6c($v0)
/* 095DB0 800951B0 A043006D */  sb    $v1, 0x6d($v0)
/* 095DB4 800951B4 100000F4 */  b     .L80095588
/* 095DB8 800951B8 A043006E */   sb    $v1, 0x6e($v0)
.L800951BC:
/* 095DBC 800951BC A04B006C */  sb    $t3, 0x6c($v0)
/* 095DC0 800951C0 A047006D */  sb    $a3, 0x6d($v0)
/* 095DC4 800951C4 100000F0 */  b     .L80095588
/* 095DC8 800951C8 A047006E */   sb    $a3, 0x6e($v0)
glabel L800951CC
/* 095DCC 800951CC 0C0315B4 */  jal   clear_dialogue_box_open_flag
/* 095DD0 800951D0 24040007 */   li    $a0, 7
/* 095DD4 800951D4 0C031525 */  jal   assign_dialogue_box_id
/* 095DD8 800951D8 24040007 */   li    $a0, 7
/* 095DDC 800951DC 24040007 */  li    $a0, 7
/* 095DE0 800951E0 0C0313DF */  jal   set_dialogue_font
/* 095DE4 800951E4 00002825 */   move  $a1, $zero
/* 095DE8 800951E8 24040007 */  li    $a0, 7
/* 095DEC 800951EC 00002825 */  move  $a1, $zero
/* 095DF0 800951F0 00003025 */  move  $a2, $zero
/* 095DF4 800951F4 00003825 */  move  $a3, $zero
/* 095DF8 800951F8 0C031414 */  jal   set_current_text_background_colour
/* 095DFC 800951FC AFA00010 */   sw    $zero, 0x10($sp)
/* 095E00 80095200 3C118012 */  lui   $s1, %hi(D_80126A98) # $s1, 0x8012
/* 095E04 80095204 26316A98 */  addiu $s1, %lo(D_80126A98) # addiu $s1, $s1, 0x6a98
/* 095E08 80095208 8E2C0000 */  lw    $t4, ($s1)
/* 095E0C 8009520C 24040007 */  li    $a0, 7
/* 095E10 80095210 11800003 */  beqz  $t4, .L80095220
/* 095E14 80095214 00002825 */   move  $a1, $zero
/* 095E18 80095218 1000000C */  b     .L8009524C
/* 095E1C 8009521C 24100001 */   li    $s0, 1
.L80095220:
/* 095E20 80095220 3C0D8012 */  lui   $t5, %hi(D_80126C1C) # $t5, 0x8012
/* 095E24 80095224 8DAD6C1C */  lw    $t5, %lo(D_80126C1C)($t5)
/* 095E28 80095228 3C108012 */  lui   $s0, %hi(gResultOptionCount) # $s0, 0x8012
/* 095E2C 8009522C 11A00005 */  beqz  $t5, .L80095244
/* 095E30 80095230 00000000 */   nop   
/* 095E34 80095234 3C108012 */  lui   $s0, %hi(D_80126C24) # $s0, 0x8012
/* 095E38 80095238 8E106C24 */  lw    $s0, %lo(D_80126C24)($s0)
/* 095E3C 8009523C 10000004 */  b     .L80095250
/* 095E40 80095240 2A010005 */   slti  $at, $s0, 5
.L80095244:
/* 095E44 80095244 8E106C14 */  lw    $s0, %lo(gResultOptionCount)($s0)
/* 095E48 80095248 00000000 */  nop   
.L8009524C:
/* 095E4C 8009524C 2A010005 */  slti  $at, $s0, 5
.L80095250:
/* 095E50 80095250 14200005 */  bnez  $at, .L80095268
/* 095E54 80095254 24070140 */   li    $a3, 320
/* 095E58 80095258 240E000D */  li    $t6, 13
/* 095E5C 8009525C 24020002 */  li    $v0, 2
/* 095E60 80095260 10000004 */  b     .L80095274
/* 095E64 80095264 AFAE0050 */   sw    $t6, 0x50($sp)
.L80095268:
/* 095E68 80095268 240A0010 */  li    $t2, 16
/* 095E6C 8009526C 00001025 */  move  $v0, $zero
/* 095E70 80095270 AFAA0050 */  sw    $t2, 0x50($sp)
.L80095274:
/* 095E74 80095274 8FB90050 */  lw    $t9, 0x50($sp)
/* 095E78 80095278 3C0F8000 */  lui   $t7, %hi(osTvType) # $t7, 0x8000
/* 095E7C 8009527C 02190019 */  multu $s0, $t9
/* 095E80 80095280 8DEF0300 */  lw    $t7, %lo(osTvType)($t7)
/* 095E84 80095284 241000C0 */  li    $s0, 192
/* 095E88 80095288 00009012 */  mflo  $s2
/* 095E8C 8009528C 26520001 */  addiu $s2, $s2, 1
/* 095E90 80095290 0012C043 */  sra   $t8, $s2, 1
/* 095E94 80095294 15E00002 */  bnez  $t7, .L800952A0
/* 095E98 80095298 03009025 */   move  $s2, $t8
/* 095E9C 8009529C 241000DA */  li    $s0, 218
.L800952A0:
/* 095EA0 800952A0 02126021 */  addu  $t4, $s0, $s2
/* 095EA4 800952A4 01826821 */  addu  $t5, $t4, $v0
/* 095EA8 800952A8 02125823 */  subu  $t3, $s0, $s2
/* 095EAC 800952AC 01623023 */  subu  $a2, $t3, $v0
/* 095EB0 800952B0 25AE0004 */  addiu $t6, $t5, 4
/* 095EB4 800952B4 AFAE0010 */  sw    $t6, 0x10($sp)
/* 095EB8 800952B8 0C0313B7 */  jal   set_current_dialogue_box_coords
/* 095EBC 800952BC 24C6FFFC */   addiu $a2, $a2, -4
/* 095EC0 800952C0 24040007 */  li    $a0, 7
/* 095EC4 800952C4 24050040 */  li    $a1, 64
/* 095EC8 800952C8 24060040 */  li    $a2, 64
/* 095ECC 800952CC 240700FF */  li    $a3, 255
/* 095ED0 800952D0 0C0313EF */  jal   set_current_dialogue_background_colour
/* 095ED4 800952D4 AFA00010 */   sw    $zero, 0x10($sp)
/* 095ED8 800952D8 240A0040 */  li    $t2, 64
/* 095EDC 800952DC 241900FF */  li    $t9, 255
/* 095EE0 800952E0 AFB90014 */  sw    $t9, 0x14($sp)
/* 095EE4 800952E4 AFAA0010 */  sw    $t2, 0x10($sp)
/* 095EE8 800952E8 24040007 */  li    $a0, 7
/* 095EEC 800952EC 240500FF */  li    $a1, 255
/* 095EF0 800952F0 00003025 */  move  $a2, $zero
/* 095EF4 800952F4 0C031400 */  jal   set_current_text_colour
/* 095EF8 800952F8 240700FF */   li    $a3, 255
/* 095EFC 800952FC 8E380000 */  lw    $t8, ($s1)
/* 095F00 80095300 3C028012 */  lui   $v0, %hi(D_80126C1C) # $v0, 0x8012
/* 095F04 80095304 1300000E */  beqz  $t8, .L80095340
/* 095F08 80095308 24426C1C */   addiu $v0, %lo(D_80126C1C) # addiu $v0, $v0, 0x6c1c
/* 095F0C 8009530C 3C0F800E */  lui   $t7, %hi(gMenuText) # $t7, 0x800e
/* 095F10 80095310 8DEFF4A0 */  lw    $t7, %lo(gMenuText)($t7)
/* 095F14 80095314 240B0001 */  li    $t3, 1
/* 095F18 80095318 8DE701F0 */  lw    $a3, 0x1f0($t7)
/* 095F1C 8009531C 240C000C */  li    $t4, 12
/* 095F20 80095320 AFAC0014 */  sw    $t4, 0x14($sp)
/* 095F24 80095324 AFAB0010 */  sw    $t3, 0x10($sp)
/* 095F28 80095328 24040007 */  li    $a0, 7
/* 095F2C 8009532C 24058000 */  li    $a1, -32768
/* 095F30 80095330 0C03145A */  jal   render_dialogue_text
/* 095F34 80095334 2406000C */   li    $a2, 12
/* 095F38 80095338 10000091 */  b     .L80095580
/* 095F3C 8009533C 00000000 */   nop   
.L80095340:
/* 095F40 80095340 8C4D0000 */  lw    $t5, ($v0)
/* 095F44 80095344 3C11800E */  lui   $s1, %hi(gMenuSubOption) # $s1, 0x800e
/* 095F48 80095348 11A00020 */  beqz  $t5, .L800953CC
/* 095F4C 8009534C 26310988 */   addiu $s1, %lo(gMenuSubOption) # addiu $s1, $s1, 0x988
/* 095F50 80095350 3C0E8012 */  lui   $t6, %hi(D_80126C24) # $t6, 0x8012
/* 095F54 80095354 8DCE6C24 */  lw    $t6, %lo(D_80126C24)($t6)
/* 095F58 80095358 2412000C */  li    $s2, 12
/* 095F5C 8009535C 19C00088 */  blez  $t6, .L80095580
/* 095F60 80095360 00008025 */   move  $s0, $zero
/* 095F64 80095364 8FB10050 */  lw    $s1, 0x50($sp)
/* 095F68 80095368 00001825 */  move  $v1, $zero
.L8009536C:
/* 095F6C 8009536C 3C028012 */  lui   $v0, %hi(D_80126C1C) # $v0, 0x8012
/* 095F70 80095370 24426C1C */  addiu $v0, %lo(D_80126C1C) # addiu $v0, $v0, 0x6c1c
/* 095F74 80095374 8C4A0000 */  lw    $t2, ($v0)
/* 095F78 80095378 24180001 */  li    $t8, 1
/* 095F7C 8009537C 0143C821 */  addu  $t9, $t2, $v1
/* 095F80 80095380 8F270000 */  lw    $a3, ($t9)
/* 095F84 80095384 240F000C */  li    $t7, 12
/* 095F88 80095388 AFAF0014 */  sw    $t7, 0x14($sp)
/* 095F8C 8009538C AFA30034 */  sw    $v1, 0x34($sp)
/* 095F90 80095390 AFB80010 */  sw    $t8, 0x10($sp)
/* 095F94 80095394 24040007 */  li    $a0, 7
/* 095F98 80095398 24058000 */  li    $a1, -32768
/* 095F9C 8009539C 0C03145A */  jal   render_dialogue_text
/* 095FA0 800953A0 02403025 */   move  $a2, $s2
/* 095FA4 800953A4 3C0B8012 */  lui   $t3, %hi(D_80126C24) # $t3, 0x8012
/* 095FA8 800953A8 8D6B6C24 */  lw    $t3, %lo(D_80126C24)($t3)
/* 095FAC 800953AC 8FA30034 */  lw    $v1, 0x34($sp)
/* 095FB0 800953B0 26100001 */  addiu $s0, $s0, 1
/* 095FB4 800953B4 020B082A */  slt   $at, $s0, $t3
/* 095FB8 800953B8 02519021 */  addu  $s2, $s2, $s1
/* 095FBC 800953BC 1420FFEB */  bnez  $at, .L8009536C
/* 095FC0 800953C0 24630004 */   addiu $v1, $v1, 4
/* 095FC4 800953C4 1000006E */  b     .L80095580
/* 095FC8 800953C8 00000000 */   nop   
.L800953CC:
/* 095FCC 800953CC 8E2C0000 */  lw    $t4, ($s1)
/* 095FD0 800953D0 2652FFE8 */  addiu $s2, $s2, -0x18
/* 095FD4 800953D4 1180003E */  beqz  $t4, .L800954D0
/* 095FD8 800953D8 3C0F8012 */   lui   $t7, %hi(gResultOptionCount) # $t7, 0x8012
/* 095FDC 800953DC 3C0D800E */  lui   $t5, %hi(gMenuText) # $t5, 0x800e
/* 095FE0 800953E0 8DADF4A0 */  lw    $t5, %lo(gMenuText)($t5)
/* 095FE4 800953E4 240E0001 */  li    $t6, 1
/* 095FE8 800953E8 8DA70210 */  lw    $a3, 0x210($t5)
/* 095FEC 800953EC 240A000C */  li    $t2, 12
/* 095FF0 800953F0 AFAA0014 */  sw    $t2, 0x14($sp)
/* 095FF4 800953F4 AFAE0010 */  sw    $t6, 0x10($sp)
/* 095FF8 800953F8 24040007 */  li    $a0, 7
/* 095FFC 800953FC 24058000 */  li    $a1, -32768
/* 096000 80095400 0C03145A */  jal   render_dialogue_text
/* 096004 80095404 26460008 */   addiu $a2, $s2, 8
/* 096008 80095408 8E390000 */  lw    $t9, ($s1)
/* 09600C 8009540C 24010001 */  li    $at, 1
/* 096010 80095410 17210002 */  bne   $t9, $at, .L8009541C
/* 096014 80095414 00008025 */   move  $s0, $zero
/* 096018 80095418 02608025 */  move  $s0, $s3
.L8009541C:
/* 09601C 8009541C AFB00010 */  sw    $s0, 0x10($sp)
/* 096020 80095420 241800FF */  li    $t8, 255
/* 096024 80095424 AFB80014 */  sw    $t8, 0x14($sp)
/* 096028 80095428 00008025 */  move  $s0, $zero
/* 09602C 8009542C 24040007 */  li    $a0, 7
/* 096030 80095430 240500FF */  li    $a1, 255
/* 096034 80095434 240600FF */  li    $a2, 255
/* 096038 80095438 0C031400 */  jal   set_current_text_colour
/* 09603C 8009543C 240700FF */   li    $a3, 255
/* 096040 80095440 3C0F800E */  lui   $t7, %hi(gMenuText) # $t7, 0x800e
/* 096044 80095444 8DEFF4A0 */  lw    $t7, %lo(gMenuText)($t7)
/* 096048 80095448 240B0001 */  li    $t3, 1
/* 09604C 8009544C 8DE70218 */  lw    $a3, 0x218($t7)
/* 096050 80095450 240C000C */  li    $t4, 12
/* 096054 80095454 AFAC0014 */  sw    $t4, 0x14($sp)
/* 096058 80095458 AFAB0010 */  sw    $t3, 0x10($sp)
/* 09605C 8009545C 24040007 */  li    $a0, 7
/* 096060 80095460 24058000 */  li    $a1, -32768
/* 096064 80095464 0C03145A */  jal   render_dialogue_text
/* 096068 80095468 2646001A */   addiu $a2, $s2, 0x1a
/* 09606C 8009546C 8E2D0000 */  lw    $t5, ($s1)
/* 096070 80095470 24010002 */  li    $at, 2
/* 096074 80095474 15A10002 */  bne   $t5, $at, .L80095480
/* 096078 80095478 24040007 */   li    $a0, 7
/* 09607C 8009547C 02608025 */  move  $s0, $s3
.L80095480:
/* 096080 80095480 240E00FF */  li    $t6, 255
/* 096084 80095484 AFAE0014 */  sw    $t6, 0x14($sp)
/* 096088 80095488 240500FF */  li    $a1, 255
/* 09608C 8009548C 240600FF */  li    $a2, 255
/* 096090 80095490 240700FF */  li    $a3, 255
/* 096094 80095494 0C031400 */  jal   set_current_text_colour
/* 096098 80095498 AFB00010 */   sw    $s0, 0x10($sp)
/* 09609C 8009549C 3C0A800E */  lui   $t2, %hi(gMenuText) # $t2, 0x800e
/* 0960A0 800954A0 8D4AF4A0 */  lw    $t2, %lo(gMenuText)($t2)
/* 0960A4 800954A4 24190001 */  li    $t9, 1
/* 0960A8 800954A8 8D470154 */  lw    $a3, 0x154($t2)
/* 0960AC 800954AC 2418000C */  li    $t8, 12
/* 0960B0 800954B0 AFB80014 */  sw    $t8, 0x14($sp)
/* 0960B4 800954B4 AFB90010 */  sw    $t9, 0x10($sp)
/* 0960B8 800954B8 24040007 */  li    $a0, 7
/* 0960BC 800954BC 24058000 */  li    $a1, -32768
/* 0960C0 800954C0 0C03145A */  jal   render_dialogue_text
/* 0960C4 800954C4 2646002A */   addiu $a2, $s2, 0x2a
/* 0960C8 800954C8 1000002D */  b     .L80095580
/* 0960CC 800954CC 00000000 */   nop   
.L800954D0:
/* 0960D0 800954D0 8DEF6C14 */  lw    $t7, %lo(gResultOptionCount)($t7)
/* 0960D4 800954D4 2412000C */  li    $s2, 12
/* 0960D8 800954D8 19E00029 */  blez  $t7, .L80095580
/* 0960DC 800954DC 00008025 */   move  $s0, $zero
/* 0960E0 800954E0 3C118012 */  lui   $s1, %hi(gResultOptionText) # $s1, 0x8012
/* 0960E4 800954E4 26316BF0 */  addiu $s1, %lo(gResultOptionText) # addiu $s1, $s1, 0x6bf0
.L800954E8:
/* 0960E8 800954E8 3C0B8012 */  lui   $t3, %hi(gMenuOption) # $t3, 0x8012
/* 0960EC 800954EC 8D6B6A68 */  lw    $t3, %lo(gMenuOption)($t3)
/* 0960F0 800954F0 24040007 */  li    $a0, 7
/* 0960F4 800954F4 160B000B */  bne   $s0, $t3, .L80095524
/* 0960F8 800954F8 240500FF */   li    $a1, 255
/* 0960FC 800954FC 240C00FF */  li    $t4, 255
/* 096100 80095500 AFAC0014 */  sw    $t4, 0x14($sp)
/* 096104 80095504 24040007 */  li    $a0, 7
/* 096108 80095508 240500FF */  li    $a1, 255
/* 09610C 8009550C 240600FF */  li    $a2, 255
/* 096110 80095510 240700FF */  li    $a3, 255
/* 096114 80095514 0C031400 */  jal   set_current_text_colour
/* 096118 80095518 AFB30010 */   sw    $s3, 0x10($sp)
/* 09611C 8009551C 10000008 */  b     .L80095540
/* 096120 80095520 8E270000 */   lw    $a3, ($s1)
.L80095524:
/* 096124 80095524 240D00FF */  li    $t5, 255
/* 096128 80095528 AFAD0014 */  sw    $t5, 0x14($sp)
/* 09612C 8009552C 240600FF */  li    $a2, 255
/* 096130 80095530 240700FF */  li    $a3, 255
/* 096134 80095534 0C031400 */  jal   set_current_text_colour
/* 096138 80095538 AFA00010 */   sw    $zero, 0x10($sp)
/* 09613C 8009553C 8E270000 */  lw    $a3, ($s1)
.L80095540:
/* 096140 80095540 240E0001 */  li    $t6, 1
/* 096144 80095544 240A000C */  li    $t2, 12
/* 096148 80095548 AFAA0014 */  sw    $t2, 0x14($sp)
/* 09614C 8009554C AFAE0010 */  sw    $t6, 0x10($sp)
/* 096150 80095550 24040007 */  li    $a0, 7
/* 096154 80095554 240500A0 */  li    $a1, 160
/* 096158 80095558 0C03145A */  jal   render_dialogue_text
/* 09615C 8009555C 02403025 */   move  $a2, $s2
/* 096160 80095560 3C188012 */  lui   $t8, %hi(gResultOptionCount) # $t8, 0x8012
/* 096164 80095564 8F186C14 */  lw    $t8, %lo(gResultOptionCount)($t8)
/* 096168 80095568 8FB90050 */  lw    $t9, 0x50($sp)
/* 09616C 8009556C 26100001 */  addiu $s0, $s0, 1
/* 096170 80095570 0218082A */  slt   $at, $s0, $t8
/* 096174 80095574 26310004 */  addiu $s1, $s1, 4
/* 096178 80095578 1420FFDB */  bnez  $at, .L800954E8
/* 09617C 8009557C 02599021 */   addu  $s2, $s2, $t9
.L80095580:
/* 096180 80095580 0C03157D */  jal   open_dialogue_box
/* 096184 80095584 24040007 */   li    $a0, 7
.L80095588:
glabel L80095588
/* 096188 80095588 0C01B683 */  jal   get_game_mode
/* 09618C 8009558C 00000000 */   nop   
/* 096190 80095590 1440001D */  bnez  $v0, .L80095608
/* 096194 80095594 3C0F800E */   lui   $t7, %hi(gNumberOfActivePlayers) # $t7, 0x800e
/* 096198 80095598 8DEFF4BC */  lw    $t7, %lo(gNumberOfActivePlayers)($t7)
/* 09619C 8009559C 24010001 */  li    $at, 1
/* 0961A0 800955A0 15E10019 */  bne   $t7, $at, .L80095608
/* 0961A4 800955A4 3C0B800E */   lui   $t3, %hi(gTrophyRaceWorldId) # $t3, 0x800e
/* 0961A8 800955A8 8D6B0FE8 */  lw    $t3, %lo(gTrophyRaceWorldId)($t3)
/* 0961AC 800955AC 00002025 */  move  $a0, $zero
/* 0961B0 800955B0 15600016 */  bnez  $t3, .L8009560C
/* 0961B4 800955B4 8FBF002C */   lw    $ra, 0x2c($sp)
/* 0961B8 800955B8 0C019A06 */  jal   camEnableUserView
/* 0961BC 800955BC 24050001 */   li    $a1, 1
/* 0961C0 800955C0 3C0C8000 */  lui   $t4, %hi(osTvType) # $t4, 0x8000
/* 0961C4 800955C4 8D8C0300 */  lw    $t4, %lo(osTvType)($t4)
/* 0961C8 800955C8 3C01800F */  lui   $at, %hi(D_800E8520) # $at, 0x800f
/* 0961CC 800955CC 15800004 */  bnez  $t4, .L800955E0
/* 0961D0 800955D0 3C0D8012 */   lui   $t5, %hi(gMenuOptionCount) # $t5, 0x8012
/* 0961D4 800955D4 C4328520 */  lwc1  $f18, %lo(D_800E8520)($at)
/* 0961D8 800955D8 3C01800E */  lui   $at, %hi(gTrackSelectWoodFrameHeightScale) # $at, 0x800e
/* 0961DC 800955DC E432F454 */  swc1  $f18, %lo(gTrackSelectWoodFrameHeightScale)($at)
.L800955E0:
/* 0961E0 800955E0 8DAD63E0 */  lw    $t5, %lo(gMenuOptionCount)($t5)
/* 0961E4 800955E4 00000000 */  nop   
/* 0961E8 800955E8 19A00004 */  blez  $t5, .L800955FC
/* 0961EC 800955EC 3C013F80 */   lui   $at, 0x3f80
/* 0961F0 800955F0 0C027298 */  jal   func_8009CA60
/* 0961F4 800955F4 24040004 */   li    $a0, 4
/* 0961F8 800955F8 3C013F80 */  li    $at, 0x3F800000 # 1.000000
.L800955FC:
/* 0961FC 800955FC 44813000 */  mtc1  $at, $f6
/* 096200 80095600 3C01800E */  lui   $at, %hi(gTrackSelectWoodFrameHeightScale) # $at, 0x800e
/* 096204 80095604 E426F454 */  swc1  $f6, %lo(gTrackSelectWoodFrameHeightScale)($at)
.L80095608:
/* 096208 80095608 8FBF002C */  lw    $ra, 0x2c($sp)
.L8009560C:
/* 09620C 8009560C 8FB0001C */  lw    $s0, 0x1c($sp)
/* 096210 80095610 8FB10020 */  lw    $s1, 0x20($sp)
/* 096214 80095614 8FB20024 */  lw    $s2, 0x24($sp)
/* 096218 80095618 8FB30028 */  lw    $s3, 0x28($sp)
/* 09621C 8009561C 03E00008 */  jr    $ra
/* 096220 80095620 27BD0060 */   addiu $sp, $sp, 0x60

