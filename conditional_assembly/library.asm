.ifndef __library_asm__
__library_asm__ = 1

ZEROPAGE=$30

; Code to be assembled only if referenced
.ifref DOSOMETHING
.proc DOSOMETHING
   lda ZEROPAGE
   rts
.endproc
.endif

.endif ; .ifndef __library_asm__
