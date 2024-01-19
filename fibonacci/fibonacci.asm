; Print all 16-bit fibonacci numbers to the screen, space-separated.

; Commander X16 boilerplate
.org $080D

.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
   jmp start         ; absolute

; selected PETSCII constants
NEWLINE = $0D
SPACE = $20
COLON = $3A
LTR_A = $41
LTR_B = $42
LTR_C = $43
LTR_E = $45
LTR_F = $46
LTR_I = $49
LTR_M = $4D
LTR_N = $4E
LTR_O = $4F
LTR_R = $52
LTR_S = $53
LTR_U = $55


introtext: ; "FIBONACCI NUMBERS: \n"
    .byte LTR_F, LTR_I, LTR_B, LTR_O, LTR_N, LTR_A, LTR_C, LTR_C, LTR_I, SPACE, LTR_N, LTR_U, LTR_M, LTR_B, LTR_E, LTR_R, LTR_S, COLON, NEWLINE, $00

; Fibonacci registers
PREV1 = $22
PREV2 = $24
NEXT = $26


.include "util.asm"

start:
    ldx #0

introtext_loop:
    lda introtext,x
    beq fib_start
    jsr CHROUT
    inx
    bra introtext_loop

fib_start:
    ; for sequence to start 1, 1...
    lda #$01
    sta NEXT
    lda #$00
    sta NEXT+1
    sta PREV1
    sta PREV1+1
    sta PREV2
    sta PREV2+1

fib_loop:
    ; print number
    lda NEXT
    ldy NEXT+1
    jsr pru1610

    lda #SPACE
    jsr CHROUT

    ; rotate "registers" dropping prev2
    lda PREV1
    sta PREV2
    lda PREV1+1
    sta PREV2+1
    lda NEXT
    sta PREV1
    lda NEXT+1
    sta PREV1+1

    ; add together PREV*
    clc
    lda PREV1
    adc PREV2
    sta NEXT
    lda PREV1+1
    adc PREV2+1
    sta NEXT+1

    ; loop until all 16-bit numbers are exhausted
    bcc fib_loop




    


    
    
    
    
    
