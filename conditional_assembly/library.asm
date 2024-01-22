.ifndef __library__
__library__ = 1


ZEROPAGE=$30

.ifref DOSOMETHING
.proc DOSOMETHING
   lda ZEROPAGE
   rts
.endproc
.endif

.endif ; .ifndef __library__
