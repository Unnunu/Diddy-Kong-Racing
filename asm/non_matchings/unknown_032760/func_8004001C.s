glabel func_8004001C
/* 040C1C 8004001C 27BDFFE0 */  addiu $sp, $sp, -0x20
/* 040C20 80040020 AFBF001C */  sw    $ra, 0x1c($sp)
/* 040C24 80040024 AFA40020 */  sw    $a0, 0x20($sp)
/* 040C28 80040028 8C820064 */  lw    $v0, 0x64($a0)
/* 040C2C 8004002C 90AF0008 */  lbu   $t7, 8($a1)
/* 040C30 80040030 00000000 */  nop   
/* 040C34 80040034 A44F0002 */  sh    $t7, 2($v0)
/* 040C38 80040038 90B80009 */  lbu   $t8, 9($a1)
/* 040C3C 8004003C 90470003 */  lbu   $a3, 3($v0)
/* 040C40 80040040 A0580004 */  sb    $t8, 4($v0)
/* 040C44 80040044 90B9000A */  lbu   $t9, 0xa($a1)
/* 040C48 80040048 330B00FF */  andi  $t3, $t8, 0xff
/* 040C4C 8004004C A0590005 */  sb    $t9, 5($v0)
/* 040C50 80040050 84AA0006 */  lh    $t2, 6($a1)
/* 040C54 80040054 84A90004 */  lh    $t1, 4($a1)
/* 040C58 80040058 448A4000 */  mtc1  $t2, $f8
/* 040C5C 8004005C 84A80002 */  lh    $t0, 2($a1)
/* 040C60 80040060 46804220 */  cvt.s.w $f8, $f8
/* 040C64 80040064 AFAB0010 */  sw    $t3, 0x10($sp)
/* 040C68 80040068 904C0005 */  lbu   $t4, 5($v0)
/* 040C6C 8004006C 44893000 */  mtc1  $t1, $f6
/* 040C70 80040070 44882000 */  mtc1  $t0, $f4
/* 040C74 80040074 44064000 */  mfc1  $a2, $f8
/* 040C78 80040078 AFAC0014 */  sw    $t4, 0x14($sp)
/* 040C7C 8004007C 468033A0 */  cvt.s.w $f14, $f6
/* 040C80 80040080 0C00265A */  jal   func_80009968
/* 040C84 80040084 46802320 */   cvt.s.w $f12, $f4
/* 040C88 80040088 8FA40020 */  lw    $a0, 0x20($sp)
/* 040C8C 8004008C 0C003FEE */  jal   particlePtrList_addObject
/* 040C90 80040090 00000000 */   nop   
/* 040C94 80040094 8FBF001C */  lw    $ra, 0x1c($sp)
/* 040C98 80040098 27BD0020 */  addiu $sp, $sp, 0x20
/* 040C9C 8004009C 03E00008 */  jr    $ra
/* 040CA0 800400A0 00000000 */   nop   

