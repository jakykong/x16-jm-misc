# Jack Mudge's quick guide to Commander X16 assembly

## Introduction

First, I make no promises. :) I'm writing this guide as I get started myself primarily so I can reference back to it when I've forgotten exactly what I was thinking, where I was looking, or what those random bytes came from.

## Credits and Resources

### The Retro Desk - Commander X16 Assembly Language Tutorial:
Link: https://www.youtube.com/playlist?list=PLPSrOWYluVLIJ1n-TsVb-BESL1tkSTRI_

A great deal of initial setup and introductory material came from this playlist. I deviated pretty early, but it had the right set of information to get the ball rolling.

### skilldrick - Easy 6502 tutorial
Link: https://skilldrick.github.io/easy6502/ 

The assembly syntax in this tutorial is slightly different from cc65, but the emulator is trivial enough to get started quickly, and having a tiny amount of background knowledge about 6502 assembly broadly made following along with The Retro Desk and other documentation much easier.

### Commander X16 source code & documentation
Referenced constantly.

Documentation (link for memory map): https://github.com/X16Community/x16-docs/blob/master/X16%20Reference%20-%2007%20-%20Memory%20Map.md

ROM source code: https://github.com/X16Community/x16-rom/tree/master

### 6502/65c02 reference material
Also referenced constantly. Many of these are "duplicate" but the different presentations of the information helped it sink in and helped reference faster.

Book: Programming the 65816 / Including the 6502, 65C02, and 65802. David Eyes / Ron Lichty - https://a.co/d/7w2NwjO 
This book has the most thorough and clear descriptions of each instruction I know of, as well as a wealth of conceptual and practical information. I've referenced it more than anything else in this reference material.

Instruction Set Documents: These all provide a reference to the 65(c)02 instruction set, with slightly different presentations. Equivalent info otherwise. No particular order.
https://www.zophar.net/fileuploads/2/10533qqcap/6502ref.html#InstructionSet
https://en.wikibooks.org/wiki/65c02_Assembly
http://6502.org/tutorials/65c02opcodes.html

### Other Tutorials
Referenced briefly, although for my own use I mostly found The Retro Desk was comprehensive. 

Brent Farris/Retroscience.net: https://retroscience.net/commander-x16-hello-world-6502-assembly.html

### Commodore Reference Material
A significant compatibility between the Commander X16 and Commodore 64 etc. made finding reference material for the Commodore 64 a fruitful exercise in answering quite a few questions along the way. Caveat, especially in assembly, "significant compatibility" doesn't mean everything will simply copy-paste. Graphics are very different between the two systems, and memory addresses are different between the two systems for the most part. The Commander X16 manual lists out most of the memory address differences.

C64 Wiki: https://www.c64-wiki.com/wiki/Main_Page
Zimmers file archive: https://www.zimmers.net/anonftp/pub/cbm/schematics/computers/

PETSCII chart: https://sta.c64.org/cbm64pet.html


## Setting Up Shop
I'm developing under Windows, so my base of operations is in c:\cx16 for easy reference. Build tools and the emulator at the top level, documentation under .\doc, and code I wrote or downloaded under .\src.

### 1. Assembler

While there are many assemblers out there, the one I found had the best documentation and seemed to be a popular choice is cc65 (ca65/cl65 programs included there). 
1. Visit the main page at https://cc65.github.io/ 
2. Download the Windows Snapshot from the link. 
3. Unpack it into C:\cx16 (or wherever you're housing development.)
4. Add the respective c:\cx16\cc65-snapshot-win64\bin subdirectory to your PATH.

### 2. Emulator

The Commander X16 emulator is incredibly convenient for development. I acquired one of the keyboards for it and have it attached to my PC for use with the emulator, but certainly any regular keyboard will work for this. Similar to the assembler, make sure it's on your PATH.

1. Visit the github releases page: https://github.com/X16Community/x16-emulator/releases
2. Download x16emu_win64-r##.zip corresponding to the most recent release. 
3. Unpack it into c:\cx16
4. Add c:\cx16\x16emu_win64-r##\ to your PATH

### 3. Build script

Each project will need a build script. If you have additional include directories, make sure to include them. Target the Commander X16 and be sure to output a program listing which will have the entire source code (including includes) linked together with memory addresses. An example build script that provides access to my own utilities library and the cc65 include files is:
 
cl65.exe -t cx16 --asm-include-dir C:\cx16\src\x16-util\ --asm-include-dir C:\cx16\cc65-snapshot-win64\asminc -o PROGRAM.PRG -l program.list program.asm

Substitute paths and "program" filenames as needed.

### 4. Commander X16 assembly boilerplate.

Assuming you are using cc65 with the above build script, you won't need to worry about the BASIC syscall bytes some tutorials reference, since the assembler will include them for you. That reduces the boilerplate to a bare minimum, such as this:

```
; Commander X16 boilerplate
.org $080D

.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
   jmp start         ; absolute

CHROUT = $FFD2
NEWLINE = $0D


.include "util.asm"

start:
   ; Some arbitrary output just so the template does something
   lda #64
   jsr CHROUT
   lda #NEWLINE
   jsr CHROUT
   rts ; Be sure to return to BASIC
```

I have a template file with these contents to make getting new code started easy. If you `.include "cbm_kernal.inc"` (from cc65) then CHROUT will already be defined, along with other kernal routines. 







