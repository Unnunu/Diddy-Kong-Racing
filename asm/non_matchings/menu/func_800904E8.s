.late_rodata
glabel D_800E84E0
.double 0.1
glabel D_800E84E8
.double 0.1

.text
glabel func_800904E8
/* 0910E8 800904E8 27BDFFB8 */  addiu $sp, $sp, -0x48
/* 0910EC 800904EC AFBF001C */  sw    $ra, 0x1c($sp)
/* 0910F0 800904F0 0C031CFC */  jal   tick_thread30
/* 0910F4 800904F4 AFA40048 */   sw    $a0, 0x48($sp)
/* 0910F8 800904F8 8FA50048 */  lw    $a1, 0x48($sp)
/* 0910FC 800904FC 00001025 */  move  $v0, $zero
/* 091100 80090500 18A00080 */  blez  $a1, .L80090704
/* 091104 80090504 30A30003 */   andi  $v1, $a1, 3
/* 091108 80090508 10600031 */  beqz  $v1, .L800905D0
/* 09110C 8009050C 00602025 */   move  $a0, $v1
/* 091110 80090510 3C018012 */  lui   $at, %hi(D_801269E8) # $at, 0x8012
/* 091114 80090514 C42E69E8 */  lwc1  $f14, %lo(D_801269E8)($at)
/* 091118 80090518 3C018012 */  lui   $at, %hi(D_801269EC) # $at, 0x8012
/* 09111C 8009051C C43069EC */  lwc1  $f16, %lo(D_801269EC)($at)
/* 091120 80090520 3C01800F */  lui   $at, %hi(D_800E84E0 + 4) # $at, 0x800f
/* 091124 80090524 3C088012 */  lui   $t0, %hi(gTrackSelectY) # $t0, 0x8012
/* 091128 80090528 3C038012 */  lui   $v1, %hi(gTrackSelectX) # $v1, 0x8012
/* 09112C 8009052C C42184E0 */  lwc1  $f1, %lo(D_800E84E0)($at)
/* 091130 80090530 C42084E4 */  lwc1  $f0, %lo(D_800E84E0 + 4)($at)
/* 091134 80090534 246369DC */  addiu $v1, %lo(gTrackSelectX) # addiu $v1, $v1, 0x69dc
/* 091138 80090538 250869E4 */  addiu $t0, %lo(gTrackSelectY) # addiu $t0, $t0, 0x69e4
/* 09113C 8009053C C4660000 */  lwc1  $f6, ($v1)
/* 091140 80090540 C50C0000 */  lwc1  $f12, ($t0)
/* 091144 80090544 46067101 */  sub.s $f4, $f14, $f6
/* 091148 80090548 24420001 */  addiu $v0, $v0, 1
/* 09114C 8009054C 46002121 */  cvt.d.s $f4, $f4
/* 091150 80090550 46202102 */  mul.d $f4, $f4, $f0
/* 091154 80090554 460C8201 */  sub.s $f8, $f16, $f12
/* 091158 80090558 460031A1 */  cvt.d.s $f6, $f6
/* 09115C 8009055C 46243280 */  add.d $f10, $f6, $f4
/* 091160 80090560 10820013 */  beq   $a0, $v0, .L800905B0
/* 091164 80090564 460044A1 */   cvt.d.s $f18, $f8
.L80090568:
/* 091168 80090568 46209202 */  mul.d $f8, $f18, $f0
/* 09116C 8009056C 462051A0 */  cvt.s.d $f6, $f10
/* 091170 80090570 24420001 */  addiu $v0, $v0, 1
/* 091174 80090574 E4660000 */  swc1  $f6, ($v1)
/* 091178 80090578 C4660000 */  lwc1  $f6, ($v1)
/* 09117C 8009057C 46006121 */  cvt.d.s $f4, $f12
/* 091180 80090580 46282200 */  add.d $f8, $f4, $f8
/* 091184 80090584 46204220 */  cvt.s.d $f8, $f8
/* 091188 80090588 46067101 */  sub.s $f4, $f14, $f6
/* 09118C 8009058C E5080000 */  swc1  $f8, ($t0)
/* 091190 80090590 C50C0000 */  lwc1  $f12, ($t0)
/* 091194 80090594 46002121 */  cvt.d.s $f4, $f4
/* 091198 80090598 46202102 */  mul.d $f4, $f4, $f0
/* 09119C 8009059C 460C8201 */  sub.s $f8, $f16, $f12
/* 0911A0 800905A0 460031A1 */  cvt.d.s $f6, $f6
/* 0911A4 800905A4 46243280 */  add.d $f10, $f6, $f4
/* 0911A8 800905A8 1482FFEF */  bne   $a0, $v0, .L80090568
/* 0911AC 800905AC 460044A1 */   cvt.d.s $f18, $f8
.L800905B0:
/* 0911B0 800905B0 46209202 */  mul.d $f8, $f18, $f0
/* 0911B4 800905B4 46006121 */  cvt.d.s $f4, $f12
/* 0911B8 800905B8 462051A0 */  cvt.s.d $f6, $f10
/* 0911BC 800905BC E4660000 */  swc1  $f6, ($v1)
/* 0911C0 800905C0 46282200 */  add.d $f8, $f4, $f8
/* 0911C4 800905C4 46204220 */  cvt.s.d $f8, $f8
/* 0911C8 800905C8 E5080000 */  swc1  $f8, ($t0)
/* 0911CC 800905CC 1045004D */  beq   $v0, $a1, .L80090704
.L800905D0:
/* 0911D0 800905D0 3C01800F */   lui   $at, %hi(D_800E84E8 + 4) # $at, 0x800f
/* 0911D4 800905D4 C42184E8 */  lwc1  $f1, %lo(D_800E84E8)($at)
/* 0911D8 800905D8 C42084EC */  lwc1  $f0, %lo(D_800E84E8 + 4)($at)
/* 0911DC 800905DC 3C018012 */  lui   $at, %hi(D_801269E8) # $at, 0x8012
/* 0911E0 800905E0 C42E69E8 */  lwc1  $f14, %lo(D_801269E8)($at)
/* 0911E4 800905E4 3C018012 */  lui   $at, %hi(D_801269EC) # $at, 0x8012
/* 0911E8 800905E8 3C038012 */  lui   $v1, %hi(gTrackSelectX) # $v1, 0x8012
/* 0911EC 800905EC 3C088012 */  lui   $t0, %hi(gTrackSelectY) # $t0, 0x8012
/* 0911F0 800905F0 C43069EC */  lwc1  $f16, %lo(D_801269EC)($at)
/* 0911F4 800905F4 250869E4 */  addiu $t0, %lo(gTrackSelectY) # addiu $t0, $t0, 0x69e4
/* 0911F8 800905F8 246369DC */  addiu $v1, %lo(gTrackSelectX) # addiu $v1, $v1, 0x69dc
.L800905FC:
/* 0911FC 800905FC C4720000 */  lwc1  $f18, ($v1)
/* 091200 80090600 C50C0000 */  lwc1  $f12, ($t0)
/* 091204 80090604 46127281 */  sub.s $f10, $f14, $f18
/* 091208 80090608 24420004 */  addiu $v0, $v0, 4
/* 09120C 8009060C 460C8201 */  sub.s $f8, $f16, $f12
/* 091210 80090610 460052A1 */  cvt.d.s $f10, $f10
/* 091214 80090614 46205282 */  mul.d $f10, $f10, $f0
/* 091218 80090618 460094A1 */  cvt.d.s $f18, $f18
/* 09121C 8009061C 46004221 */  cvt.d.s $f8, $f8
/* 091220 80090620 46006321 */  cvt.d.s $f12, $f12
/* 091224 80090624 46204202 */  mul.d $f8, $f8, $f0
/* 091228 80090628 462A9280 */  add.d $f10, $f18, $f10
/* 09122C 8009062C 462052A0 */  cvt.s.d $f10, $f10
/* 091230 80090630 46286200 */  add.d $f8, $f12, $f8
/* 091234 80090634 E46A0000 */  swc1  $f10, ($v1)
/* 091238 80090638 46204220 */  cvt.s.d $f8, $f8
/* 09123C 8009063C C46A0000 */  lwc1  $f10, ($v1)
/* 091240 80090640 E5080000 */  swc1  $f8, ($t0)
/* 091244 80090644 460A7201 */  sub.s $f8, $f14, $f10
/* 091248 80090648 C50C0000 */  lwc1  $f12, ($t0)
/* 09124C 8009064C 46004221 */  cvt.d.s $f8, $f8
/* 091250 80090650 46204202 */  mul.d $f8, $f8, $f0
/* 091254 80090654 460C8481 */  sub.s $f18, $f16, $f12
/* 091258 80090658 460052A1 */  cvt.d.s $f10, $f10
/* 09125C 8009065C 46285200 */  add.d $f8, $f10, $f8
/* 091260 80090660 46204220 */  cvt.s.d $f8, $f8
/* 091264 80090664 E4680000 */  swc1  $f8, ($v1)
/* 091268 80090668 C4680000 */  lwc1  $f8, ($v1)
/* 09126C 8009066C 460094A1 */  cvt.d.s $f18, $f18
/* 091270 80090670 46209482 */  mul.d $f18, $f18, $f0
/* 091274 80090674 46087281 */  sub.s $f10, $f14, $f8
/* 091278 80090678 46006321 */  cvt.d.s $f12, $f12
/* 09127C 8009067C 46326480 */  add.d $f18, $f12, $f18
/* 091280 80090680 462094A0 */  cvt.s.d $f18, $f18
/* 091284 80090684 E5120000 */  swc1  $f18, ($t0)
/* 091288 80090688 C5120000 */  lwc1  $f18, ($t0)
/* 09128C 8009068C 460052A1 */  cvt.d.s $f10, $f10
/* 091290 80090690 46205282 */  mul.d $f10, $f10, $f0
/* 091294 80090694 46128301 */  sub.s $f12, $f16, $f18
/* 091298 80090698 46004221 */  cvt.d.s $f8, $f8
/* 09129C 8009069C 462A4280 */  add.d $f10, $f8, $f10
/* 0912A0 800906A0 462052A0 */  cvt.s.d $f10, $f10
/* 0912A4 800906A4 46006321 */  cvt.d.s $f12, $f12
/* 0912A8 800906A8 46206302 */  mul.d $f12, $f12, $f0
/* 0912AC 800906AC E46A0000 */  swc1  $f10, ($v1)
/* 0912B0 800906B0 C46A0000 */  lwc1  $f10, ($v1)
/* 0912B4 800906B4 460094A1 */  cvt.d.s $f18, $f18
/* 0912B8 800906B8 462C9300 */  add.d $f12, $f18, $f12
/* 0912BC 800906BC 46206320 */  cvt.s.d $f12, $f12
/* 0912C0 800906C0 460A7481 */  sub.s $f18, $f14, $f10
/* 0912C4 800906C4 E50C0000 */  swc1  $f12, ($t0)
/* 0912C8 800906C8 C50C0000 */  lwc1  $f12, ($t0)
/* 0912CC 800906CC 460094A1 */  cvt.d.s $f18, $f18
/* 0912D0 800906D0 46209482 */  mul.d $f18, $f18, $f0
/* 0912D4 800906D4 460C8201 */  sub.s $f8, $f16, $f12
/* 0912D8 800906D8 460052A1 */  cvt.d.s $f10, $f10
/* 0912DC 800906DC 46325480 */  add.d $f18, $f10, $f18
/* 0912E0 800906E0 462094A0 */  cvt.s.d $f18, $f18
/* 0912E4 800906E4 46004221 */  cvt.d.s $f8, $f8
/* 0912E8 800906E8 46204202 */  mul.d $f8, $f8, $f0
/* 0912EC 800906EC 46006321 */  cvt.d.s $f12, $f12
/* 0912F0 800906F0 E4720000 */  swc1  $f18, ($v1)
/* 0912F4 800906F4 46286200 */  add.d $f8, $f12, $f8
/* 0912F8 800906F8 46204220 */  cvt.s.d $f8, $f8
/* 0912FC 800906FC 1445FFBF */  bne   $v0, $a1, .L800905FC
/* 091300 80090700 E5080000 */   swc1  $f8, ($t0)
.L80090704:
/* 091304 80090704 3C0E8012 */  lui   $t6, %hi(gOpacityDecayTimer) # $t6, 0x8012
/* 091308 80090708 8DCE63D8 */  lw    $t6, %lo(gOpacityDecayTimer)($t6)
/* 09130C 8009070C 3C038012 */  lui   $v1, %hi(gTrackSelectX) # $v1, 0x8012
/* 091310 80090710 3C088012 */  lui   $t0, %hi(gTrackSelectY) # $t0, 0x8012
/* 091314 80090714 24010020 */  li    $at, 32
/* 091318 80090718 250869E4 */  addiu $t0, %lo(gTrackSelectY) # addiu $t0, $t0, 0x69e4
/* 09131C 8009071C 15C10034 */  bne   $t6, $at, .L800907F0
/* 091320 80090720 246369DC */   addiu $v1, %lo(gTrackSelectX) # addiu $v1, $v1, 0x69dc
/* 091324 80090724 0C031CF8 */  jal   get_thread30_level_id_to_load
/* 091328 80090728 00000000 */   nop   
/* 09132C 8009072C 3C038012 */  lui   $v1, %hi(gTrackSelectX) # $v1, 0x8012
/* 091330 80090730 3C088012 */  lui   $t0, %hi(gTrackSelectY) # $t0, 0x8012
/* 091334 80090734 250869E4 */  addiu $t0, %lo(gTrackSelectY) # addiu $t0, $t0, 0x69e4
/* 091338 80090738 1440002D */  bnez  $v0, .L800907F0
/* 09133C 8009073C 246369DC */   addiu $v1, %lo(gTrackSelectX) # addiu $v1, $v1, 0x69dc
/* 091340 80090740 3C028012 */  lui   $v0, %hi(D_801263D0) # $v0, 0x8012
/* 091344 80090744 3C04800E */  lui   $a0, %hi(gTrackIdForPreview) # $a0, 0x800e
/* 091348 80090748 8C84F4C4 */  lw    $a0, %lo(gTrackIdForPreview)($a0)
/* 09134C 8009074C 8C4263D0 */  lw    $v0, %lo(D_801263D0)($v0)
/* 091350 80090750 3C0F8012 */  lui   $t7, %hi(D_801269C8) # $t7, 0x8012
/* 091354 80090754 14440008 */  bne   $v0, $a0, .L80090778
/* 091358 80090758 3C018012 */   lui   $at, %hi(gSelectedTrackX) # $at, 0x8012
/* 09135C 8009075C 8DEF69C8 */  lw    $t7, %lo(D_801269C8)($t7)
/* 091360 80090760 3C188012 */  lui   $t8, %hi(D_801269CC) # $t8, 0x8012
/* 091364 80090764 8F1869CC */  lw    $t8, %lo(D_801269CC)($t8)
/* 091368 80090768 AC2F69F4 */  sw    $t7, %lo(gSelectedTrackX)($at)
/* 09136C 8009076C 3C018012 */  lui   $at, %hi(gSelectedTrackY) # $at, 0x8012
/* 091370 80090770 1000001F */  b     .L800907F0
/* 091374 80090774 AC3869F8 */   sw    $t8, %lo(gSelectedTrackY)($at)
.L80090778:
/* 091378 80090778 1044001D */  beq   $v0, $a0, .L800907F0
/* 09137C 8009077C 2401FFFF */   li    $at, -1
/* 091380 80090780 1081001B */  beq   $a0, $at, .L800907F0
/* 091384 80090784 00000000 */   nop   
/* 091388 80090788 0C031D16 */  jal   set_level_to_load_in_background
/* 09138C 8009078C 24050001 */   li    $a1, 1
/* 091390 80090790 3C038012 */  lui   $v1, %hi(gTrackSelectX) # $v1, 0x8012
/* 091394 80090794 3C088012 */  lui   $t0, %hi(gTrackSelectY) # $t0, 0x8012
/* 091398 80090798 250869E4 */  addiu $t0, %lo(gTrackSelectY) # addiu $t0, $t0, 0x69e4
/* 09139C 8009079C 10400014 */  beqz  $v0, .L800907F0
/* 0913A0 800907A0 246369DC */   addiu $v1, %lo(gTrackSelectX) # addiu $v1, $v1, 0x69dc
/* 0913A4 800907A4 3C04800E */  lui   $a0, %hi(gTrackIdForPreview) # $a0, 0x800e
/* 0913A8 800907A8 8C84F4C4 */  lw    $a0, %lo(gTrackIdForPreview)($a0)
/* 0913AC 800907AC 3C018012 */  lui   $at, %hi(D_801263D0) # $at, 0x8012
/* 0913B0 800907B0 3C198012 */  lui   $t9, %hi(D_801269C8) # $t9, 0x8012
/* 0913B4 800907B4 8F3969C8 */  lw    $t9, %lo(D_801269C8)($t9)
/* 0913B8 800907B8 AC2463D0 */  sw    $a0, %lo(D_801263D0)($at)
/* 0913BC 800907BC 3C018012 */  lui   $at, %hi(gSelectedTrackX) # $at, 0x8012
/* 0913C0 800907C0 3C0B8012 */  lui   $t3, %hi(D_801269CC) # $t3, 0x8012
/* 0913C4 800907C4 8D6B69CC */  lw    $t3, %lo(D_801269CC)($t3)
/* 0913C8 800907C8 AC3969F4 */  sw    $t9, %lo(gSelectedTrackX)($at)
/* 0913CC 800907CC 3C018012 */  lui   $at, %hi(gSelectedTrackY) # $at, 0x8012
/* 0913D0 800907D0 0C01AC2B */  jal   get_map_default_vehicle
/* 0913D4 800907D4 AC2B69F8 */   sw    $t3, %lo(gSelectedTrackY)($at)
/* 0913D8 800907D8 0C01B6C5 */  jal   set_level_default_vehicle
/* 0913DC 800907DC 00402025 */   move  $a0, $v0
/* 0913E0 800907E0 3C038012 */  lui   $v1, %hi(gTrackSelectX) # $v1, 0x8012
/* 0913E4 800907E4 3C088012 */  lui   $t0, %hi(gTrackSelectY) # $t0, 0x8012
/* 0913E8 800907E8 250869E4 */  addiu $t0, %lo(gTrackSelectY) # addiu $t0, $t0, 0x69e4
/* 0913EC 800907EC 246369DC */  addiu $v1, %lo(gTrackSelectX) # addiu $v1, $v1, 0x69dc
.L800907F0:
/* 0913F0 800907F0 3C0C8012 */  lui   $t4, %hi(gSelectedTrackX) # $t4, 0x8012
/* 0913F4 800907F4 8D8C69F4 */  lw    $t4, %lo(gSelectedTrackX)($t4)
/* 0913F8 800907F8 3C098012 */  lui   $t1, %hi(gTrackSelectViewportY) # $t1, 0x8012
/* 0913FC 800907FC 000C6880 */  sll   $t5, $t4, 2
/* 091400 80090800 01AC6821 */  addu  $t5, $t5, $t4
/* 091404 80090804 000D6980 */  sll   $t5, $t5, 6
/* 091408 80090808 448D2000 */  mtc1  $t5, $f4
/* 09140C 8009080C C4680000 */  lwc1  $f8, ($v1)
/* 091410 80090810 468021A0 */  cvt.s.w $f6, $f4
/* 091414 80090814 8D296480 */  lw    $t1, %lo(gTrackSelectViewportY)($t1)
/* 091418 80090818 3C014320 */  li    $at, 0x43200000 # 160.000000
/* 09141C 8009081C 3C0F8012 */  lui   $t7, %hi(gSelectedTrackY) # $t7, 0x8012
/* 091420 80090820 44819000 */  mtc1  $at, $f18
/* 091424 80090824 8DEF69F8 */  lw    $t7, %lo(gSelectedTrackY)($t7)
/* 091428 80090828 46083281 */  sub.s $f10, $f6, $f8
/* 09142C 8009082C 0009C023 */  negu  $t8, $t1
/* 091430 80090830 01F80019 */  multu $t7, $t8
/* 091434 80090834 3C0142A0 */  li    $at, 0x42A00000 # 80.000000
/* 091438 80090838 44813000 */  mtc1  $at, $f6
/* 09143C 8009083C 46125100 */  add.s $f4, $f10, $f18
/* 091440 80090840 3C028012 */  lui   $v0, %hi(gTrackSelectViewPortHalfY) # $v0, 0x8012
/* 091444 80090844 46062201 */  sub.s $f8, $f4, $f6
/* 091448 80090848 8C426478 */  lw    $v0, %lo(gTrackSelectViewPortHalfY)($v0)
/* 09144C 8009084C 444EF800 */  cfc1  $t6, $31
/* 091450 80090850 C5060000 */  lwc1  $f6, ($t0)
/* 091454 80090854 35C10003 */  ori   $at, $t6, 3
/* 091458 80090858 38210002 */  xori  $at, $at, 2
/* 09145C 8009085C 44C1F800 */  ctc1  $at, $31
/* 091460 80090860 0000C812 */  mflo  $t9
/* 091464 80090864 460042A4 */  cvt.w.s $f10, $f8
/* 091468 80090868 44999000 */  mtc1  $t9, $f18
/* 09146C 8009086C 44CEF800 */  ctc1  $t6, $31
/* 091470 80090870 44055000 */  mfc1  $a1, $f10
/* 091474 80090874 46809120 */  cvt.s.w $f4, $f18
/* 091478 80090878 44825000 */  mtc1  $v0, $f10
/* 09147C 8009087C 00095883 */  sra   $t3, $t1, 2
/* 091480 80090880 46062201 */  sub.s $f8, $f4, $f6
/* 091484 80090884 448B3000 */  mtc1  $t3, $f6
/* 091488 80090888 468054A0 */  cvt.s.w $f18, $f10
/* 09148C 8009088C 24A700A0 */  addiu $a3, $a1, 0xa0
/* 091490 80090890 AFA7003C */  sw    $a3, 0x3c($sp)
/* 091494 80090894 468032A0 */  cvt.s.w $f10, $f6
/* 091498 80090898 00002025 */  move  $a0, $zero
/* 09149C 8009089C AFA50044 */  sw    $a1, 0x44($sp)
/* 0914A0 800908A0 46089101 */  sub.s $f4, $f18, $f8
/* 0914A4 800908A4 460A2481 */  sub.s $f18, $f4, $f10
/* 0914A8 800908A8 444CF800 */  cfc1  $t4, $31
/* 0914AC 800908AC 00000000 */  nop   
/* 0914B0 800908B0 35810003 */  ori   $at, $t4, 3
/* 0914B4 800908B4 38210002 */  xori  $at, $at, 2
/* 0914B8 800908B8 44C1F800 */  ctc1  $at, $31
/* 0914BC 800908BC 00000000 */  nop   
/* 0914C0 800908C0 46009224 */  cvt.w.s $f8, $f18
/* 0914C4 800908C4 44064000 */  mfc1  $a2, $f8
/* 0914C8 800908C8 44CCF800 */  ctc1  $t4, $31
/* 0914CC 800908CC 00C25021 */  addu  $t2, $a2, $v0
/* 0914D0 800908D0 AFAA0010 */  sw    $t2, 0x10($sp)
/* 0914D4 800908D4 AFAA0038 */  sw    $t2, 0x38($sp)
/* 0914D8 800908D8 0C019A50 */  jal   resize_viewport
/* 0914DC 800908DC AFA60040 */   sw    $a2, 0x40($sp)
/* 0914E0 800908E0 27AD0038 */  addiu $t5, $sp, 0x38
/* 0914E4 800908E4 AFAD0010 */  sw    $t5, 0x10($sp)
/* 0914E8 800908E8 00002025 */  move  $a0, $zero
/* 0914EC 800908EC 27A50044 */  addiu $a1, $sp, 0x44
/* 0914F0 800908F0 27A60040 */  addiu $a2, $sp, 0x40
/* 0914F4 800908F4 0C019AEA */  jal   copy_viewport_background_size_to_coords
/* 0914F8 800908F8 27A7003C */   addiu $a3, $sp, 0x3c
/* 0914FC 800908FC 00002025 */  move  $a0, $zero
/* 091500 80090900 0C019A06 */  jal   func_80066818
/* 091504 80090904 00002825 */   move  $a1, $zero
/* 091508 80090908 8FBF001C */  lw    $ra, 0x1c($sp)
/* 09150C 8009090C 27BD0048 */  addiu $sp, $sp, 0x48
/* 091510 80090910 03E00008 */  jr    $ra
/* 091514 80090914 00000000 */   nop   

