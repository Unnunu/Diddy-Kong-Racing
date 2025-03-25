.include "macro.inc"

/* assembler directives */
.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */
.set gp=64     /* allow use of 64-bit general purpose registers */

.section .text, "ax"

/* Generated by spimdisasm 1.30.0 */

leaf object_animate
/* 62930 80061D30 27BDFFF8 */  addiu      $sp, $sp, -0x8
/* 62934 80061D34 AFB10004 */  sw         $s1, 0x4($sp)
/* 62938 80061D38 AFB00000 */  sw         $s0, 0x0($sp)
/* 6293C 80061D3C 8088003A */  lb         $t0, 0x3A($a0)
/* 62940 80061D40 05030003 */  bgezl      $t0, .L80061D50
/* 62944 80061D44 8C890040 */   lw        $t1, 0x40($a0)
/* 62948 80061D48 00004025 */  or         $t0, $zero, $zero
/* 6294C 80061D4C 8C890040 */  lw         $t1, 0x40($a0)
.L80061D50:
/* 62950 80061D50 812A0055 */  lb         $t2, 0x55($t1)
/* 62954 80061D54 010A082A */  slt        $at, $t0, $t2
/* 62958 80061D58 54200003 */  bnel       $at, $zero, .L80061D68
/* 6295C 80061D5C 8C890068 */   lw        $t1, 0x68($a0)
/* 62960 80061D60 01404025 */  or         $t0, $t2, $zero
/* 62964 80061D64 8C890068 */  lw         $t1, 0x68($a0)
.L80061D68:
/* 62968 80061D68 00084080 */  sll        $t0, $t0, 2
/* 6296C 80061D6C 01284820 */  add        $t1, $t1, $t0 /* handwritten instruction */
/* 62970 80061D70 8D250000 */  lw         $a1, 0x0($t1)
/* 62974 80061D74 8CA60000 */  lw         $a2, 0x0($a1)
/* 62978 80061D78 8CC80044 */  lw         $t0, 0x44($a2)
/* 6297C 80061D7C 55000004 */  bnel       $t0, $zero, .L80061D90
/* 62980 80061D80 84990018 */   lh        $t9, 0x18($a0)
/* 62984 80061D84 1000013D */  b          .L8006227C
/* 62988 80061D88 00001025 */   or        $v0, $zero, $zero
/* 6298C 80061D8C 84990018 */  lh         $t9, 0x18($a0)
.L80061D90:
/* 62990 80061D90 84A80014 */  lh         $t0, 0x14($a1)
/* 62994 80061D94 8087003B */  lb         $a3, 0x3B($a0)
/* 62998 80061D98 17280006 */  bne        $t9, $t0, .L80061DB4
/* 6299C 80061D9C 00000000 */   nop
/* 629A0 80061DA0 84A80010 */  lh         $t0, 0x10($a1)
/* 629A4 80061DA4 14E80003 */  bne        $a3, $t0, .L80061DB4
/* 629A8 80061DA8 00000000 */   nop
/* 629AC 80061DAC 10000133 */  b          .L8006227C
/* 629B0 80061DB0 00001025 */   or        $v0, $zero, $zero
.L80061DB4:
/* 629B4 80061DB4 04E30003 */  bgezl      $a3, .L80061DC4
/* 629B8 80061DB8 84C80048 */   lh        $t0, 0x48($a2)
/* 629BC 80061DBC 00003825 */  or         $a3, $zero, $zero
/* 629C0 80061DC0 84C80048 */  lh         $t0, 0x48($a2)
.L80061DC4:
/* 629C4 80061DC4 00E8082A */  slt        $at, $a3, $t0
/* 629C8 80061DC8 14200002 */  bnez       $at, .L80061DD4
/* 629CC 80061DCC 00000000 */   nop
/* 629D0 80061DD0 2507FFFF */  addiu      $a3, $t0, -0x1
.L80061DD4:
/* 629D4 80061DD4 19000006 */  blez       $t0, .L80061DF0
/* 629D8 80061DD8 00005025 */   or        $t2, $zero, $zero
/* 629DC 80061DDC 8CC90044 */  lw         $t1, 0x44($a2)
/* 629E0 80061DE0 000710C0 */  sll        $v0, $a3, 3
/* 629E4 80061DE4 01224820 */  add        $t1, $t1, $v0 /* handwritten instruction */
/* 629E8 80061DE8 8D2A0004 */  lw         $t2, 0x4($t1)
/* 629EC 80061DEC 214AFFFE */  addi       $t2, $t2, -0x2 /* handwritten instruction */
.L80061DF0:
/* 629F0 80061DF0 00192102 */  srl        $a0, $t9, 4
/* 629F4 80061DF4 04830004 */  bgezl      $a0, .L80061E08
/* 629F8 80061DF8 0144082A */   slt       $at, $t2, $a0
/* 629FC 80061DFC 0140C825 */  or         $t9, $t2, $zero
/* 62A00 80061E00 000A2102 */  srl        $a0, $t2, 4
/* 62A04 80061E04 0144082A */  slt        $at, $t2, $a0
.L80061E08:
/* 62A08 80061E08 50200006 */  beql       $at, $zero, .L80061E24
/* 62A0C 80061E0C 84A80010 */   lh        $t0, 0x10($a1)
/* 62A10 80061E10 2408FFFF */  addiu      $t0, $zero, -0x1
/* 62A14 80061E14 0000C825 */  or         $t9, $zero, $zero
/* 62A18 80061E18 00002025 */  or         $a0, $zero, $zero
/* 62A1C 80061E1C A4A80010 */  sh         $t0, 0x10($a1)
/* 62A20 80061E20 84A80010 */  lh         $t0, 0x10($a1)
.L80061E24:
/* 62A24 80061E24 8CB1000C */  lw         $s1, 0xC($a1)
/* 62A28 80061E28 50E80004 */  beql       $a3, $t0, .L80061E3C
/* 62A2C 80061E2C 84B00012 */   lh        $s0, 0x12($a1)
/* 62A30 80061E30 10000002 */  b          .L80061E3C
/* 62A34 80061E34 2410FFFF */   addiu     $s0, $zero, -0x1
/* 62A38 80061E38 84B00012 */  lh         $s0, 0x12($a1)
.L80061E3C:
/* 62A3C 80061E3C A4A70010 */  sh         $a3, 0x10($a1)
/* 62A40 80061E40 A4B90014 */  sh         $t9, 0x14($a1)
/* 62A44 80061E44 A4A40012 */  sh         $a0, 0x12($a1)
/* 62A48 80061E48 10800006 */  beqz       $a0, .L80061E64
/* 62A4C 80061E4C 3338000F */   andi      $t8, $t9, 0xF
/* 62A50 80061E50 2401FFFF */  addiu      $at, $zero, -0x1
/* 62A54 80061E54 52010004 */  beql       $s0, $at, .L80061E68
/* 62A58 80061E58 8CC20044 */   lw        $v0, 0x44($a2)
/* 62A5C 80061E5C 10000026 */  b          .L80061EF8
/* 62A60 80061E60 84C3004A */   lh        $v1, 0x4A($a2)
.L80061E64:
/* 62A64 80061E64 8CC20044 */  lw         $v0, 0x44($a2)
.L80061E68:
/* 62A68 80061E68 000718C0 */  sll        $v1, $a3, 3
/* 62A6C 80061E6C 8CCD004C */  lw         $t5, 0x4C($a2)
/* 62A70 80061E70 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62A74 80061E74 8C4E0000 */  lw         $t6, 0x0($v0)
/* 62A78 80061E78 84C20024 */  lh         $v0, 0x24($a2)
/* 62A7C 80061E7C 8CCF0004 */  lw         $t7, 0x4($a2)
/* 62A80 80061E80 25CE000C */  addiu      $t6, $t6, 0xC
/* 62A84 80061E84 00021040 */  sll        $v0, $v0, 1
/* 62A88 80061E88 01A25820 */  add        $t3, $t5, $v0 /* handwritten instruction */
.L80061E8C:
/* 62A8C 80061E8C 85A20000 */  lh         $v0, 0x0($t5)
/* 62A90 80061E90 2401FFFF */  addiu      $at, $zero, -0x1
/* 62A94 80061E94 50410013 */  beql       $v0, $at, .L80061EE4
/* 62A98 80061E98 25AD0002 */   addiu     $t5, $t5, 0x2
/* 62A9C 80061E9C 00021880 */  sll        $v1, $v0, 2
/* 62AA0 80061EA0 00021040 */  sll        $v0, $v0, 1
/* 62AA4 80061EA4 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62AA8 80061EA8 02221820 */  add        $v1, $s1, $v0 /* handwritten instruction */
/* 62AAC 80061EAC 01C21020 */  add        $v0, $t6, $v0 /* handwritten instruction */
/* 62AB0 80061EB0 85E80000 */  lh         $t0, 0x0($t7)
/* 62AB4 80061EB4 84490000 */  lh         $t1, 0x0($v0)
/* 62AB8 80061EB8 01095020 */  add        $t2, $t0, $t1 /* handwritten instruction */
/* 62ABC 80061EBC A46A0000 */  sh         $t2, 0x0($v1)
/* 62AC0 80061EC0 85E80002 */  lh         $t0, 0x2($t7)
/* 62AC4 80061EC4 84490002 */  lh         $t1, 0x2($v0)
/* 62AC8 80061EC8 01095020 */  add        $t2, $t0, $t1 /* handwritten instruction */
/* 62ACC 80061ECC A46A0002 */  sh         $t2, 0x2($v1)
/* 62AD0 80061ED0 85E80004 */  lh         $t0, 0x4($t7)
/* 62AD4 80061ED4 84490004 */  lh         $t1, 0x4($v0)
/* 62AD8 80061ED8 01095020 */  add        $t2, $t0, $t1 /* handwritten instruction */
/* 62ADC 80061EDC A46A0004 */  sh         $t2, 0x4($v1)
/* 62AE0 80061EE0 25AD0002 */  addiu      $t5, $t5, 0x2
.L80061EE4:
/* 62AE4 80061EE4 01AB082A */  slt        $at, $t5, $t3
/* 62AE8 80061EE8 1420FFE8 */  bnez       $at, .L80061E8C
/* 62AEC 80061EEC 25EF000A */   addiu     $t7, $t7, 0xA
/* 62AF0 80061EF0 00008025 */  or         $s0, $zero, $zero
/* 62AF4 80061EF4 84C3004A */  lh         $v1, 0x4A($a2)
.L80061EF8:
/* 62AF8 80061EF8 0204082A */  slt        $at, $s0, $a0
/* 62AFC 80061EFC 00631020 */  add        $v0, $v1, $v1 /* handwritten instruction */
/* 62B00 80061F00 00436020 */  add        $t4, $v0, $v1 /* handwritten instruction */
/* 62B04 80061F04 10200026 */  beqz       $at, .L80061FA0
/* 62B08 80061F08 258C000C */   addiu     $t4, $t4, 0xC
/* 62B0C 80061F0C 8CC20044 */  lw         $v0, 0x44($a2)
/* 62B10 80061F10 000718C0 */  sll        $v1, $a3, 3
/* 62B14 80061F14 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62B18 80061F18 26030002 */  addiu      $v1, $s0, 0x2
/* 62B1C 80061F1C 01830019 */  multu      $t4, $v1
/* 62B20 80061F20 8C4A0000 */  lw         $t2, 0x0($v0)
/* 62B24 80061F24 00001812 */  mflo       $v1
/* 62B28 80061F28 01435020 */  add        $t2, $t2, $v1 /* handwritten instruction */
/* 62B2C 80061F2C 00000000 */  nop
/* 62B30 80061F30 84C2004A */  lh         $v0, 0x4A($a2)
.L80061F34:
/* 62B34 80061F34 01407025 */  or         $t6, $t2, $zero
/* 62B38 80061F38 02206825 */  or         $t5, $s1, $zero
/* 62B3C 80061F3C 00021880 */  sll        $v1, $v0, 2
/* 62B40 80061F40 00021040 */  sll        $v0, $v0, 1
/* 62B44 80061F44 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62B48 80061F48 014C5020 */  add        $t2, $t2, $t4 /* handwritten instruction */
/* 62B4C 80061F4C 01A25820 */  add        $t3, $t5, $v0 /* handwritten instruction */
.L80061F50:
/* 62B50 80061F50 85A80000 */  lh         $t0, 0x0($t5)
/* 62B54 80061F54 81C90000 */  lb         $t1, 0x0($t6)
/* 62B58 80061F58 25AD0006 */  addiu      $t5, $t5, 0x6
/* 62B5C 80061F5C 01AB082A */  slt        $at, $t5, $t3
/* 62B60 80061F60 01094020 */  add        $t0, $t0, $t1 /* handwritten instruction */
/* 62B64 80061F64 A5A8FFFA */  sh         $t0, -0x6($t5)
/* 62B68 80061F68 85A8FFFC */  lh         $t0, -0x4($t5)
/* 62B6C 80061F6C 81C90001 */  lb         $t1, 0x1($t6)
/* 62B70 80061F70 25CE0003 */  addiu      $t6, $t6, 0x3
/* 62B74 80061F74 01094020 */  add        $t0, $t0, $t1 /* handwritten instruction */
/* 62B78 80061F78 A5A8FFFC */  sh         $t0, -0x4($t5)
/* 62B7C 80061F7C 85A8FFFE */  lh         $t0, -0x2($t5)
/* 62B80 80061F80 81C9FFFF */  lb         $t1, -0x1($t6)
/* 62B84 80061F84 01094020 */  add        $t0, $t0, $t1 /* handwritten instruction */
/* 62B88 80061F88 1420FFF1 */  bnez       $at, .L80061F50
/* 62B8C 80061F8C A5A8FFFE */   sh        $t0, -0x2($t5)
/* 62B90 80061F90 26100001 */  addiu      $s0, $s0, 0x1
/* 62B94 80061F94 0204082A */  slt        $at, $s0, $a0
/* 62B98 80061F98 5420FFE6 */  bnel       $at, $zero, .L80061F34
/* 62B9C 80061F9C 84C2004A */   lh        $v0, 0x4A($a2)
.L80061FA0:
/* 62BA0 80061FA0 0090082A */  slt        $at, $a0, $s0
/* 62BA4 80061FA4 50200027 */  beql       $at, $zero, .L80062044
/* 62BA8 80061FA8 8CC20044 */   lw        $v0, 0x44($a2)
/* 62BAC 80061FAC 8CC20044 */  lw         $v0, 0x44($a2)
/* 62BB0 80061FB0 000718C0 */  sll        $v1, $a3, 3
/* 62BB4 80061FB4 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62BB8 80061FB8 26030002 */  addiu      $v1, $s0, 0x2
/* 62BBC 80061FBC 01830019 */  multu      $t4, $v1
/* 62BC0 80061FC0 8C4A0000 */  lw         $t2, 0x0($v0)
/* 62BC4 80061FC4 00001812 */  mflo       $v1
/* 62BC8 80061FC8 01435020 */  add        $t2, $t2, $v1 /* handwritten instruction */
/* 62BCC 80061FCC 00000000 */  nop
/* 62BD0 80061FD0 84C2004A */  lh         $v0, 0x4A($a2)
.L80061FD4:
/* 62BD4 80061FD4 014C5022 */  sub        $t2, $t2, $t4 /* handwritten instruction */
/* 62BD8 80061FD8 02206825 */  or         $t5, $s1, $zero
/* 62BDC 80061FDC 00021880 */  sll        $v1, $v0, 2
/* 62BE0 80061FE0 00021040 */  sll        $v0, $v0, 1
/* 62BE4 80061FE4 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62BE8 80061FE8 2610FFFF */  addiu      $s0, $s0, -0x1
/* 62BEC 80061FEC 01407025 */  or         $t6, $t2, $zero
/* 62BF0 80061FF0 01A25820 */  add        $t3, $t5, $v0 /* handwritten instruction */
.L80061FF4:
/* 62BF4 80061FF4 85A80000 */  lh         $t0, 0x0($t5)
/* 62BF8 80061FF8 81C90000 */  lb         $t1, 0x0($t6)
/* 62BFC 80061FFC 25AD0006 */  addiu      $t5, $t5, 0x6
/* 62C00 80062000 01AB082A */  slt        $at, $t5, $t3
/* 62C04 80062004 01094022 */  sub        $t0, $t0, $t1 /* handwritten instruction */
/* 62C08 80062008 A5A8FFFA */  sh         $t0, -0x6($t5)
/* 62C0C 8006200C 85A8FFFC */  lh         $t0, -0x4($t5)
/* 62C10 80062010 81C90001 */  lb         $t1, 0x1($t6)
/* 62C14 80062014 25CE0003 */  addiu      $t6, $t6, 0x3
/* 62C18 80062018 01094022 */  sub        $t0, $t0, $t1 /* handwritten instruction */
/* 62C1C 8006201C A5A8FFFC */  sh         $t0, -0x4($t5)
/* 62C20 80062020 85A8FFFE */  lh         $t0, -0x2($t5)
/* 62C24 80062024 81C9FFFF */  lb         $t1, -0x1($t6)
/* 62C28 80062028 01094022 */  sub        $t0, $t0, $t1 /* handwritten instruction */
/* 62C2C 8006202C 1420FFF1 */  bnez       $at, .L80061FF4
/* 62C30 80062030 A5A8FFFE */   sh        $t0, -0x2($t5)
/* 62C34 80062034 0090082A */  slt        $at, $a0, $s0
/* 62C38 80062038 5420FFE6 */  bnel       $at, $zero, .L80061FD4
/* 62C3C 8006203C 84C2004A */   lh        $v0, 0x4A($a2)
/* 62C40 80062040 8CC20044 */  lw         $v0, 0x44($a2)
.L80062044:
/* 62C44 80062044 000718C0 */  sll        $v1, $a3, 3
/* 62C48 80062048 3C0D8012 */  lui        $t5, %hi(D_8011D644)
/* 62C4C 8006204C 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62C50 80062050 8C4E0000 */  lw         $t6, 0x0($v0)
/* 62C54 80062054 26020002 */  addiu      $v0, $s0, 0x2
/* 62C58 80062058 01820019 */  multu      $t4, $v0
/* 62C5C 8006205C 84C2004A */  lh         $v0, 0x4A($a2)
/* 62C60 80062060 8DADD644 */  lw         $t5, %lo(D_8011D644)($t5)
/* 62C64 80062064 00001812 */  mflo       $v1
/* 62C68 80062068 01C37020 */  add        $t6, $t6, $v1 /* handwritten instruction */
/* 62C6C 8006206C 00021880 */  sll        $v1, $v0, 2
/* 62C70 80062070 00021040 */  sll        $v0, $v0, 1
/* 62C74 80062074 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62C78 80062078 01A25820 */  add        $t3, $t5, $v0 /* handwritten instruction */
.L8006207C:
/* 62C7C 8006207C 81C80000 */  lb         $t0, 0x0($t6)
/* 62C80 80062080 25AD0006 */  addiu      $t5, $t5, 0x6
/* 62C84 80062084 01AB082A */  slt        $at, $t5, $t3
/* 62C88 80062088 01180019 */  multu      $t0, $t8
/* 62C8C 8006208C 25CE0003 */  addiu      $t6, $t6, 0x3
/* 62C90 80062090 00004012 */  mflo       $t0
/* 62C94 80062094 00084102 */  srl        $t0, $t0, 4
/* 62C98 80062098 A5A8FFFA */  sh         $t0, -0x6($t5)
/* 62C9C 8006209C 81C9FFFE */  lb         $t1, -0x2($t6)
/* 62CA0 800620A0 01380019 */  multu      $t1, $t8
/* 62CA4 800620A4 00004812 */  mflo       $t1
/* 62CA8 800620A8 00094902 */  srl        $t1, $t1, 4
/* 62CAC 800620AC A5A9FFFC */  sh         $t1, -0x4($t5)
/* 62CB0 800620B0 81CAFFFF */  lb         $t2, -0x1($t6)
/* 62CB4 800620B4 01580019 */  multu      $t2, $t8
/* 62CB8 800620B8 00005012 */  mflo       $t2
/* 62CBC 800620BC 000A5102 */  srl        $t2, $t2, 4
/* 62CC0 800620C0 1420FFEE */  bnez       $at, .L8006207C
/* 62CC4 800620C4 A5AAFFFE */   sh        $t2, -0x2($t5)
/* 62CC8 800620C8 8CC20044 */  lw         $v0, 0x44($a2)
/* 62CCC 800620CC 000718C0 */  sll        $v1, $a3, 3
/* 62CD0 800620D0 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62CD4 800620D4 10800006 */  beqz       $a0, .L800620F0
/* 62CD8 800620D8 8C4E0000 */   lw        $t6, 0x0($v0)
/* 62CDC 800620DC 24820001 */  addiu      $v0, $a0, 0x1
/* 62CE0 800620E0 01820019 */  multu      $t4, $v0
/* 62CE4 800620E4 00001812 */  mflo       $v1
/* 62CE8 800620E8 01C37020 */  add        $t6, $t6, $v1 /* handwritten instruction */
/* 62CEC 800620EC 25CEFFF4 */  addiu      $t6, $t6, -0xC
.L800620F0:
/* 62CF0 800620F0 81C20000 */  lb         $v0, 0x0($t6)
/* 62CF4 800620F4 91C30001 */  lbu        $v1, 0x1($t6)
/* 62CF8 800620F8 00021200 */  sll        $v0, $v0, 8
/* 62CFC 800620FC 00434025 */  or         $t0, $v0, $v1
/* 62D00 80062100 81C20002 */  lb         $v0, 0x2($t6)
/* 62D04 80062104 91C30003 */  lbu        $v1, 0x3($t6)
/* 62D08 80062108 00021200 */  sll        $v0, $v0, 8
/* 62D0C 8006210C 00434825 */  or         $t1, $v0, $v1
/* 62D10 80062110 81C20004 */  lb         $v0, 0x4($t6)
/* 62D14 80062114 91C30005 */  lbu        $v1, 0x5($t6)
/* 62D18 80062118 00021200 */  sll        $v0, $v0, 8
/* 62D1C 8006211C 00435025 */  or         $t2, $v0, $v1
/* 62D20 80062120 81C2000A */  lb         $v0, 0xA($t6)
/* 62D24 80062124 91C3000B */  lbu        $v1, 0xB($t6)
/* 62D28 80062128 01CC7020 */  add        $t6, $t6, $t4 /* handwritten instruction */
/* 62D2C 8006212C 00021200 */  sll        $v0, $v0, 8
/* 62D30 80062130 14800003 */  bnez       $a0, .L80062140
/* 62D34 80062134 00435825 */   or        $t3, $v0, $v1
/* 62D38 80062138 01CC7020 */  add        $t6, $t6, $t4 /* handwritten instruction */
/* 62D3C 8006213C 25CEFFF4 */  addiu      $t6, $t6, -0xC
.L80062140:
/* 62D40 80062140 81C20000 */  lb         $v0, 0x0($t6)
/* 62D44 80062144 91C30001 */  lbu        $v1, 0x1($t6)
/* 62D48 80062148 3C198012 */  lui        $t9, %hi(D_8011D644)
/* 62D4C 8006214C 00021200 */  sll        $v0, $v0, 8
/* 62D50 80062150 00431025 */  or         $v0, $v0, $v1
/* 62D54 80062154 00481022 */  sub        $v0, $v0, $t0 /* handwritten instruction */
/* 62D58 80062158 00580019 */  multu      $v0, $t8
/* 62D5C 8006215C 00001012 */  mflo       $v0
/* 62D60 80062160 00021102 */  srl        $v0, $v0, 4
/* 62D64 80062164 01024020 */  add        $t0, $t0, $v0 /* handwritten instruction */
/* 62D68 80062168 A4A80016 */  sh         $t0, 0x16($a1)
/* 62D6C 8006216C 81C20002 */  lb         $v0, 0x2($t6)
/* 62D70 80062170 91C30003 */  lbu        $v1, 0x3($t6)
/* 62D74 80062174 00021200 */  sll        $v0, $v0, 8
/* 62D78 80062178 00431025 */  or         $v0, $v0, $v1
/* 62D7C 8006217C 00491022 */  sub        $v0, $v0, $t1 /* handwritten instruction */
/* 62D80 80062180 00580019 */  multu      $v0, $t8
/* 62D84 80062184 00001012 */  mflo       $v0
/* 62D88 80062188 00021102 */  srl        $v0, $v0, 4
/* 62D8C 8006218C 01224820 */  add        $t1, $t1, $v0 /* handwritten instruction */
/* 62D90 80062190 A4A90018 */  sh         $t1, 0x18($a1)
/* 62D94 80062194 81C20004 */  lb         $v0, 0x4($t6)
/* 62D98 80062198 91C30005 */  lbu        $v1, 0x5($t6)
/* 62D9C 8006219C 00021200 */  sll        $v0, $v0, 8
/* 62DA0 800621A0 00431025 */  or         $v0, $v0, $v1
/* 62DA4 800621A4 004A1022 */  sub        $v0, $v0, $t2 /* handwritten instruction */
/* 62DA8 800621A8 00580019 */  multu      $v0, $t8
/* 62DAC 800621AC 00001012 */  mflo       $v0
/* 62DB0 800621B0 00021102 */  srl        $v0, $v0, 4
/* 62DB4 800621B4 01425020 */  add        $t2, $t2, $v0 /* handwritten instruction */
/* 62DB8 800621B8 A4AA001A */  sh         $t2, 0x1A($a1)
/* 62DBC 800621BC 81C2000A */  lb         $v0, 0xA($t6)
/* 62DC0 800621C0 91C3000B */  lbu        $v1, 0xB($t6)
/* 62DC4 800621C4 00021200 */  sll        $v0, $v0, 8
/* 62DC8 800621C8 00431025 */  or         $v0, $v0, $v1
/* 62DCC 800621CC 004B1022 */  sub        $v0, $v0, $t3 /* handwritten instruction */
/* 62DD0 800621D0 00580019 */  multu      $v0, $t8
/* 62DD4 800621D4 24A30004 */  addiu      $v1, $a1, 0x4
/* 62DD8 800621D8 00001012 */  mflo       $v0
/* 62DDC 800621DC 00021102 */  srl        $v0, $v0, 4
/* 62DE0 800621E0 01625820 */  add        $t3, $t3, $v0 /* handwritten instruction */
/* 62DE4 800621E4 80A2001F */  lb         $v0, 0x1F($a1)
/* 62DE8 800621E8 A4AB001C */  sh         $t3, 0x1C($a1)
/* 62DEC 800621EC 38420001 */  xori       $v0, $v0, 0x1
/* 62DF0 800621F0 A0A2001F */  sb         $v0, 0x1F($a1)
/* 62DF4 800621F4 00021080 */  sll        $v0, $v0, 2
/* 62DF8 800621F8 00621820 */  add        $v1, $v1, $v0 /* handwritten instruction */
/* 62DFC 800621FC 84C20024 */  lh         $v0, 0x24($a2)
/* 62E00 80062200 8CCD004C */  lw         $t5, 0x4C($a2)
/* 62E04 80062204 8C6E0000 */  lw         $t6, 0x0($v1)
/* 62E08 80062208 00021040 */  sll        $v0, $v0, 1
/* 62E0C 8006220C 8F39D644 */  lw         $t9, %lo(D_8011D644)($t9)
/* 62E10 80062210 01A25820 */  add        $t3, $t5, $v0 /* handwritten instruction */
.L80062214:
/* 62E14 80062214 85A20000 */  lh         $v0, 0x0($t5)
/* 62E18 80062218 2401FFFF */  addiu      $at, $zero, -0x1
/* 62E1C 8006221C 21AD0002 */  addi       $t5, $t5, 0x2 /* handwritten instruction */
/* 62E20 80062220 50410013 */  beql       $v0, $at, .L80062270
/* 62E24 80062224 01AB082A */   slt       $at, $t5, $t3
/* 62E28 80062228 00021880 */  sll        $v1, $v0, 2
/* 62E2C 8006222C 00021040 */  sll        $v0, $v0, 1
/* 62E30 80062230 00431020 */  add        $v0, $v0, $v1 /* handwritten instruction */
/* 62E34 80062234 03224820 */  add        $t1, $t9, $v0 /* handwritten instruction */
/* 62E38 80062238 02224020 */  add        $t0, $s1, $v0 /* handwritten instruction */
/* 62E3C 8006223C 85020000 */  lh         $v0, 0x0($t0)
/* 62E40 80062240 85230000 */  lh         $v1, 0x0($t1)
/* 62E44 80062244 00435020 */  add        $t2, $v0, $v1 /* handwritten instruction */
/* 62E48 80062248 A5CA0000 */  sh         $t2, 0x0($t6)
/* 62E4C 8006224C 85020002 */  lh         $v0, 0x2($t0)
/* 62E50 80062250 85230002 */  lh         $v1, 0x2($t1)
/* 62E54 80062254 00435020 */  add        $t2, $v0, $v1 /* handwritten instruction */
/* 62E58 80062258 A5CA0002 */  sh         $t2, 0x2($t6)
/* 62E5C 8006225C 85020004 */  lh         $v0, 0x4($t0)
/* 62E60 80062260 85230004 */  lh         $v1, 0x4($t1)
/* 62E64 80062264 00435020 */  add        $t2, $v0, $v1 /* handwritten instruction */
/* 62E68 80062268 A5CA0004 */  sh         $t2, 0x4($t6)
/* 62E6C 8006226C 01AB082A */  slt        $at, $t5, $t3
.L80062270:
/* 62E70 80062270 1420FFE8 */  bnez       $at, .L80062214
/* 62E74 80062274 21CE000A */   addi      $t6, $t6, 0xA /* handwritten instruction */
/* 62E78 80062278 24020001 */  addiu      $v0, $zero, 0x1
.L8006227C:
/* 62E7C 8006227C 8FB00000 */  lw         $s0, 0x0($sp)
/* 62E80 80062280 8FB10004 */  lw         $s1, 0x4($sp)
/* 62E84 80062284 03E00008 */  jr         $ra
/* 62E88 80062288 27BD0008 */   addiu     $sp, $sp, 0x8
.end object_animate
