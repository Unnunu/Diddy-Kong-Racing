glabel __osGetActiveQueue
/* 0D3070 800D2470 3C02800E */  lui   $v0, %hi(__osActiveQueue) # $v0, 0x800e
/* 0D3074 800D2474 03E00008 */  jr    $ra
/* 0D3078 800D2478 8C42488C */   lw    $v0, %lo(__osActiveQueue)($v0)

/* 0D307C 800D247C 00000000 */  nop   
