# How do I X in Commander x16 assembly?

## Do Math?

Integer Addition and subtraction are baked in instructions, adc and sbc respectively. Be sure to clear (clc) or set (sec) the carry flag for the first byte.

Integer division, multiplication can be implemented pen-and-paper style. See x16-util/intmath.asm for examples (no promises these are the most efficient implementations.)

Floating point math can be done with the Math library, see [Commander x16 documentation|https://github.com/X16Community/x16-docs/blob/master/X16%20Reference%20-%2005%20-%20Math%20Library.md]

## Print text to the screen?

Using CHROUT (see Kernal documentation). This will work for short (len(str)<255) strings:

```
ldx #$00
loop:
    lda strval,x
    beq done
    jsr CHROUT
done:
    brk

strval: .byte "hello, world!", #$00
```



    



