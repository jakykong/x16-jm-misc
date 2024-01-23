; Commander X16 boilerplate
.org $080D

.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
   jmp start         ; absolute

.include "library.inc"


start:
   lda #$31
   sta ZEROPAGE
   jsr DOSOMETHING


.include "library.asm"
