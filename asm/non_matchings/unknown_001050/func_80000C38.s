glabel func_80000C38
/* 001838 80000C38 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 00183C 80000C3C AFA40018 */  sw    $a0, 0x18($sp)
/* 001840 80000C40 308500FF */  andi  $a1, $a0, 0xff
/* 001844 80000C44 3C04800E */  lui   $a0, %hi(D_800DC634) # $a0, 0x800e
/* 001848 80000C48 AFBF0014 */  sw    $ra, 0x14($sp)
/* 00184C 80000C4C 8C84C634 */  lw    $a0, %lo(D_800DC634)($a0)
/* 001850 80000C50 0C002C04 */  jal   func_8000B010
/* 001854 80000C54 00000000 */   nop   
/* 001858 80000C58 8FBF0014 */  lw    $ra, 0x14($sp)
/* 00185C 80000C5C 27BD0018 */  addiu $sp, $sp, 0x18
/* 001860 80000C60 03E00008 */  jr    $ra
/* 001864 80000C64 00000000 */   nop   

/* 001868 80000C68 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 00186C 80000C6C AFA40018 */  sw    $a0, 0x18($sp)
/* 001870 80000C70 308500FF */  andi  $a1, $a0, 0xff
/* 001874 80000C74 3C04800E */  lui   $a0, %hi(D_800DC630) # $a0, 0x800e
/* 001878 80000C78 AFBF0014 */  sw    $ra, 0x14($sp)
/* 00187C 80000C7C 8C84C630 */  lw    $a0, %lo(D_800DC630)($a0)
/* 001880 80000C80 0C018EA4 */  jal   func_80063A90
/* 001884 80000C84 00000000 */   nop   
/* 001888 80000C88 8FBF0014 */  lw    $ra, 0x14($sp)
/* 00188C 80000C8C 27BD0018 */  addiu $sp, $sp, 0x18
/* 001890 80000C90 03E00008 */  jr    $ra
/* 001894 80000C94 00000000 */   nop   

