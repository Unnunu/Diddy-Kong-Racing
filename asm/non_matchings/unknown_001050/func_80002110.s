glabel func_80002110
/* 002D10 80002110 3C0E8011 */  lui   $t6, %hi(D_80115CF8) # $t6, 0x8011
/* 002D14 80002114 8DCE5CF8 */  lw    $t6, %lo(D_80115CF8)($t6)
/* 002D18 80002118 00000000 */  nop   
/* 002D1C 8000211C 91C20003 */  lbu   $v0, 3($t6)
/* 002D20 80002120 03E00008 */  jr    $ra
/* 002D24 80002124 00000000 */   nop   

