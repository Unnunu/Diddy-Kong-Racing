glabel func_800017D4
/* 0023D4 800017D4 00803025 */  move  $a2, $a0
/* 0023D8 800017D8 44863000 */  mtc1  $a2, $f6
/* 0023DC 800017DC 3C013F80 */  li    $at, 0x3F800000 # 1.000000
/* 0023E0 800017E0 46803220 */  cvt.s.w $f8, $f6
/* 0023E4 800017E4 44812000 */  mtc1  $at, $f4
/* 0023E8 800017E8 3C01800E */  lui   $at, %hi(D_800E49EC) # $at, 0x800e
/* 0023EC 800017EC 46082283 */  div.s $f10, $f4, $f8
/* 0023F0 800017F0 C43049EC */  lwc1  $f16, %lo(D_800E49EC)($at)
/* 0023F4 800017F4 27BDFFE8 */  addiu $sp, $sp, -0x18
/* 0023F8 800017F8 3C04800E */  lui   $a0, %hi(D_800DC634) # $a0, 0x800e
/* 0023FC 800017FC AFBF0014 */  sw    $ra, 0x14($sp)
/* 002400 80001800 8C84C634 */  lw    $a0, %lo(D_800DC634)($a0)
/* 002404 80001804 46105482 */  mul.s $f18, $f10, $f16
/* 002408 80001808 444EF800 */  cfc1  $t6, $31
/* 00240C 8000180C 00000000 */  nop   
/* 002410 80001810 35C10003 */  ori   $at, $t6, 3
/* 002414 80001814 38210002 */  xori  $at, $at, 2
/* 002418 80001818 44C1F800 */  ctc1  $at, $31
/* 00241C 8000181C 00000000 */  nop   
/* 002420 80001820 460091A4 */  cvt.w.s $f6, $f18
/* 002424 80001824 44053000 */  mfc1  $a1, $f6
/* 002428 80001828 44CEF800 */  ctc1  $t6, $31
/* 00242C 8000182C 0C031E78 */  jal   func_800C79E0
/* 002430 80001830 00000000 */   nop   
/* 002434 80001834 8FBF0014 */  lw    $ra, 0x14($sp)
/* 002438 80001838 27BD0018 */  addiu $sp, $sp, 0x18
/* 00243C 8000183C 03E00008 */  jr    $ra
/* 002440 80001840 00000000 */   nop   

