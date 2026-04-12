norom
arch spc700-raw
dpbase $0000
optimize dp always

;direct page

org $000000
incbin "input.spc":$000000..$010000 ;insert original SPC here
org $010000
incbin "input.spc":$010000..$010200 ;insert original SPC here
org $01016C
db $E0 ;disable audio/echo writes at all cost


org $000025
dw KonvertInit

org $000100
base $000000 ;zero page

ReadSeq:
skip 2
BackSeq: ;backup for subroutine calls
skip 2
DPSubFlag:
skip 1
ReadPat:
skip 2
ReadTrackX: ;0-7,1-8
skip 2
WriteOut:
skip 2
DParamSize:
skip 1
DPNoteLength:
skip 1
DPNoteOctave:
skip 1
DPOctLatest:
skip 1
DPNoteKey:
skip 1
DPNoteTens:
skip 1
DPNoteHund:
skip 1
DPNoteTrans:
skip 1
DPStack:
skip 1
DPStack2:
skip 1
DPatPhrase: ;which phrase to take place at currently
skip 1
DPatFlag: ;how many repeats are left, if specified
skip 1
DPSum1:
skip 1
DPSum2:
skip 1
DPQuant:
skip 1
DPBypass:
skip 1
DPureEchoVolL:
skip 1
DPureEchoVolR:
skip 1
DPureEchoChn:
skip 1
DPureVolA:
skip 1
DPureVolB:
skip 1
DPureQuantA:
skip 1
DPureQuantB:
skip 1
DPureSFlag:
skip 1
DPureVelFlag:
skip 1
DPureBendFlag:
skip 1

org !OutAddr+256
base !OutAddr
	db "#amk 4 #samples {#default }"
	db $20
	db $20
	db "#0 "


org !ProgAddr+256
base !ProgAddr ;bypass driver code with a converter

KonvertInit:
	mov $f2,#$6c
	mov $f3,#$e0
	mov a,#$00 ;clear zero page
	mov y,a
	mov x,a
	dec x
	mov sp,x
	inc x
	mov y,#$f0
-	dec y
	mov $00+y,a
	cmp y,#$00
	bne -
	mov a,KonvertSet+1+x ;store song position
	mov y,a
	mov a,KonvertSet+x
	movw ReadSeq,ya
	mov a,KonvertSet+2 ;store song ID (-1) to read
	dec a
	asl a
	mov y,a
	mov a,(ReadSeq)+y
	push a
	inc y
	mov a,(ReadSeq)+y
	mov y,a
	pop a
	movw ReadSeq,ya 
	mov a,KonvertSet+4
	mov y,a
	mov a,KonvertSet+3
	movw WriteOut,ya

PureEchoSetup:
	mov y,#$00
	mov a,#$f1
	call RoutineWriteHex
	mov a,(ReadSeq)+y ;echo delay
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y ;echo feedback
	call RoutineWriteHex
	inc y
	mov a,#$01 ;echo FIR
	call RoutineWriteHex
	mov a,#$a3
	mov y,a
	call RoutineUpdateWord ;skip ADSR, begin header afterwards
	movw ya,ReadSeq 
	movw ReadPat,ya
	jmp KonvertReadPattern


KonvertSet:
	dw !ReadAddr
	db !ReadIndex
	dw !OutAddr+32


KonvertReadPattern:
	;read 2x8 pattern index from channel 0-7
	mov a,ReadTrackX
	asl a
	mov y,a
	mov a,(ReadSeq)+y
	push a
	inc y
	mov a,(ReadSeq)+y
	bne ++
	pop a
	inc ReadTrackX
	cmp ReadTrackX,#$08
	bmi +
-	nop
	bra -
+	movw ya,ReadPat
	movw ReadSeq,ya
	jmp KonvertReadPattern
++	mov y,a
	pop a
	movw ReadSeq,ya
	jmp ReadSequence

ReadSequence:
	mov y,#$00
	mov a,(ReadSeq)+y
	bne +
	jmp VoiceInterrupt
+	bmi +
-	jmp VoiceNoteEvent
+	and a,#$7f
	cmp a,#$60
	bmi -
	or a,#$80
	jmp VoiceCommandRun

VoiceInterrupt: ;00
	cmp DPSubFlag,#$00 ;check for subroutines
	bne ++
ForceInterrupt:
	inc ReadTrackX
	cmp ReadTrackX,#$08
	bmi +
-	nop
	bra -
+	cmp DPSubFlag,#$00
	beq +
	call RoutineCloseLoop
+	mov DPatPhrase,#$00
	mov DPNoteOctave,#$00
	mov DPNoteLength,#$00
	mov DPNoteKey,#$00
	mov DPNoteTrans,#$00
	mov DPureSFlag,#$00
	mov DPureVelFlag,#$00
	mov a,#$23 ;# start a new channel
	call RoutineWriter
	mov a,ReadTrackX
	mov x,a
	mov a,PresetHex+x
	call RoutineWriter
	movw ya,ReadPat
	movw ReadSeq,ya
	jmp KonvertReadPattern

++	call RoutineCloseLoop
	movw ya,BackSeq
	movw ReadSeq,ya
	jmp ReadSequence


VoiceNoteEvent: ;01-7F
	mov a,(ReadSeq)+y ;read note
	bpl +++
	jmp VoiceCommandRun
+++ cmp a,#$56 ;compare for other types of notes
	bne +
VoiceNoteTie:
	mov a,#$5e ;tie (^)
	call RoutineWriter
	bra +++
+	cmp a,#$55
	bne +
VoiceNoteRest:
	mov a,#$72 ;rest (r)
	call RoutineWriter
	bra +++
+	push a
	inc y
	mov a,(ReadSeq)+y ;check for velocity flag
	bpl ++
	cmp DPureVelFlag,#$00 ;skip if already in effect
	bne +
	mov DPureVelFlag,#$01
	mov a,#$e7
	call RoutineWriteHex
	mov a,DPureVolB ;alt volume
	call RoutineWriteHex
	bra +
++	cmp DPureVelFlag,#$01 ;check for previous flag
	bne +
	mov DPureVelFlag,#$00
	mov a,#$e7
	call RoutineWriteHex
	mov a,DPureVolA ;main volume
	call RoutineWriteHex
+	dec y
	pop a
	call RoutineGetNote 
+++	mov a,#$3d ;=
	call RoutineWriter
	inc y
	mov a,(ReadSeq)+y ;read note length
	and a,#$7f
	mov DPNoteLength,a
	call RoutineHexDecimal ;convert hex to decimal length (up to =127 supported)
	inc y
	call RoutineUpdateWord
	cmp DPureBendFlag,#$00
	beq +
	mov DPureBendFlag,#$00
	mov a,#$fe
	call RoutineWriteHex
+	jmp ReadSequence


VoiceCommandRun: ;E0-FF
	and a,#$1f
	asl a
	mov x,a
	mov a,PresetVCMDIndex+1+x ;jump to special VCMD
	push a
	mov a,PresetVCMDIndex+x
	push a
	ret

PresetVCMDIndex:
	dw VcmdE0inst	;e0
	dw VcmdE1pan	;e1
	dw VcmdE2	;e2
	dw VcmdE3vibrato	;e3
	dw VcmdE4	;e4
	dw VcmdE5songvol	;e5
	dw VcmdE6	;e6
	dw VcmdE7tempo	;e7
	dw VcmdE8	;e8
	dw VcmdE9	;e9
	dw VcmdEAkeydiff	;ea
	dw VcmdEBadsr	;eb
	dw VcmdEC	;ec
	dw VcmdEDchvol	;ed
	dw VcmdEE	;ee
	dw VcmdEF	;ef
	dw VcmdF0bend	;f0
	dw VcmdF1echovol	;f1
	dw VcmdF2echoflg	;f2
	dw VcmdF3	;f3
	dw VcmdF4quant	;f4
	dw VcmdF5	;f5
	dw VcmdF6	;f6
	dw VcmdF7	;f7
	dw VcmdF8	;f8
	dw VcmdF9bend	;f9
	dw VcmdFAqalt	;fa
	dw VcmdFBsetloop	;fb
	dw VcmdFCgoto	;fc
	dw VcmdFD	;fd
	dw VcmdFEendloop	;fe
	dw VcmdFF	;ff


FinishCom:
	inc y
	call RoutineUpdateWord
	jmp ReadSequence


VcmdE0inst:
	mov a,#$da
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y
	call RoutineWriteHex
	jmp FinishCom


VcmdE1pan:
	mov a,#$db
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y
	call RoutineWriteHex
	jmp FinishCom


VcmdE2:
-	nop
	bra -


VcmdE3vibrato:
	mov a,#$de
	call RoutineWriteHex
	inc y
	inc y
	mov a,(ReadSeq)+y
	call RoutineWriteHex
	mov a,(ReadSeq)+y
	asl a
	asl a
	asl a
	call RoutineWriteHex
	dec y
	mov a,(ReadSeq)+y
	call RoutineWriteHex
	inc y
	jmp FinishCom

VcmdE4:
-	nop
	bra -


VcmdE5songvol:
	mov a,#$e0
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y
	call RoutineWriteHex
	jmp FinishCom


VcmdE6:
-	nop
	bra -


VcmdE7tempo:
	mov a,#$74 ;t
	call RoutineWriter
	inc y
	mov a,(ReadSeq)+y
	dec a ;adapt tempo for carry
	call RoutineHexDecimal
	jmp FinishCom


VcmdE8:
-	nop
	bra -


VcmdE9:
-	nop
	bra -


VcmdEAkeydiff:
	inc y
	mov a,(ReadSeq)+y
	mov DPNoteTrans,a
	jmp FinishCom


VcmdEBadsr:
	mov a,#$ed
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y ;attack
	and a,#$7f
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y ;decay
	call RoutineWriteHex
	jmp FinishCom


VcmdEC:
-	nop
	bra -


VcmdEDchvol:
	mov a,#$e7
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y
	mov DPureVolB,a
	inc y
	mov a,(ReadSeq)+y
	mov DPureVolA,a
	cmp DPureSFlag,#$00
	beq ++
	mov a,DPureVolB
++	call RoutineWriteHex
	jmp FinishCom


VcmdEE:
-	nop
	bra -


VcmdEF:
-	nop
	bra -


VcmdF0bend:
	mov DPureBendFlag,#$01
	mov a,#$eb
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y ;delay
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y
	bmi ++
	mov DPStack,a
	mov a,#$80
	setc
	sbc a,DPStack
	asl a
	call RoutineWriteHex
	mov a,#$18 ;slide up
	bra +++
++	and a,#$7f
	asl a
	call RoutineWriteHex
	mov a,#$e8 ;slide down
+++	call RoutineWriteHex
	jmp FinishCom


VcmdF1echovol:
	mov a,#$ef
	call RoutineWriteHex
	mov a,DPureEchoChn
	call RoutineWriteHex
	inc y
	mov a,(ReadSeq)+y
	mov DPureEchoVolL,a 
	mov y,#$96 ;adjust echo to master volume ($50->$7F)
	mul ya
	mov a,y
	clrc
	adc a,DPureEchoVolL
	mov DPureEchoVolL,a 
	call RoutineWriteHex
	mov y,#$02
	mov a,(ReadSeq)+y
	mov DPureEchoVolR,a 
	mov y,#$96 ;adjust echo to master volume ($50->$7F)
	mul ya
	mov a,y
	clrc
	adc a,DPureEchoVolR
	mov DPureEchoVolR,a 
	call RoutineWriteHex
	mov y,#$02
	jmp FinishCom


VcmdF2echoflg:
	inc y
	mov a,(ReadSeq)+y
	mov DPureEchoChn,a
	jmp FinishCom


VcmdF3:
-	nop
	bra -


VcmdF4quant:
	inc y
	mov a,(ReadSeq)+y
	mov DPureQuantB,a
	inc y
	mov a,(ReadSeq)+y
	mov DPureQuantA,a
SetQuantisizer:
	mov a,#$71 ;q
	call RoutineWriter
	mov a,DPureQuantA
	cmp DPureSFlag,#$00
	beq ++
	mov a,DPureQuantB
++	inc a
	xcn a
	dec a
	call RoutineWriteItself
	jmp FinishCom


VcmdF5:
-	nop
	bra -


VcmdF6:
-	nop
	bra -


VcmdF7:
-	nop
	bra -


VcmdF8:
-	nop
	bra -


VcmdF9bend:
	mov a,#$5e ;tie (^)
	call RoutineWriter
	mov a,#$3d
	call RoutineWriter
	mov y,#$02
	mov a,(ReadSeq)+y ;note length
	call RoutineHexDecimal
	mov a,#$dd
	call RoutineWriteHex
	mov a,#$00
	call RoutineWriteHex
	mov a,#$01
	call RoutineWriteHex
	mov y,#$01
	mov a,(ReadSeq)+y ;note destination
	call RoutineGetNote
	mov a,#$20
	call RoutineWriter
	inc y
	jmp FinishCom


VcmdFAqalt:
	cmp DPureSFlag,#$00
	bne +
	mov DPureSFlag,#$01
	bra ++
+	mov DPureSFlag,#$00
++  jmp SetQuantisizer


VcmdFBsetloop:
	mov a,#$5b ;start bracket
	call RoutineWriter
	jmp FinishCom


VcmdFCgoto:
	jmp ForceInterrupt


VcmdFD:
-	nop
	bra -


VcmdFEendloop:
	mov a,#$5d ;end bracket
	call RoutineWriter
	inc y
	mov a,(ReadSeq)+y ;amount of repeats
	call RoutineHexDecimal
	jmp FinishCom


VcmdFF:
-	nop
	bra -


RoutineFIREntry:
	call RoutineWriteHex
	mov a,PresetFIRs+x
	inc x
	ret


RoutineCloseLoop:
	mov a,#$5d ;close bracket
	call RoutineWriter
	mov a,DPSubFlag
	call RoutineHexDecimal
	mov DPSubFlag,#$00
	ret


RoutineUpdateWord:
	mov a,y
	clrc
	adc a,ReadSeq
	bcc +
	inc ReadSeq+1
+	mov ReadSeq,a
	mov y,#$00
	ret


RoutineWriter: ;write accumulator to output
	push y
	mov y,#$00
	mov (WriteOut)+y,a
	mov a,WriteOut
	clrc
	adc a,#$01
	bcc +
	inc WriteOut+1
+	mov WriteOut,a
	pop y
	ret


RoutineWriteHex: ;write accumulator as a hex value
	push y
	push a
	mov a,#$24 ;hex sign
	call RoutineWriter
	pop a
	pop y
RoutineWriteItself:
	push y
	push a ;process left value
	and a,#$f0
	xcn a
	mov y,a
	mov a,PresetHex+y
	call RoutineWriter
	pop a ;process right value
	and a,#$0f
	mov y,a
	mov a,PresetHex+y
	call RoutineWriter
	pop y
	ret


RoutineGetNote:
	mov DPNoteOctave,#$01
	clrc
	adc a,DPNoteTrans ;adjust for transposition
	dec a
-	cmp a,#$0c ;decrement until the last octave
	bmi +
	inc DPNoteOctave
	setc
	sbc a,#$0c
	bra -
+	mov DPNoteKey,a
	cmp DPNoteOctave,DPOctLatest ;compare latest octave for truncation
	beq +
	mov a,#$6f ;o
	call RoutineWriter
	mov a,DPNoteOctave
	mov x,a
	mov a,PresetHex+x 
	call RoutineWriter ;write octave of the key in ASCII
+	mov a,DPNoteKey
	asl a
	mov x,a
	mov a,PresetNotes+x
	call RoutineWriter ;write note letter
	mov a,PresetNotes+1+x
	beq ++
	call RoutineWriter ;account for sharps and flats
++	mov DPOctLatest,DPNoteOctave
	ret


RoutineHexDecimal:
	;convert hex to decimal length (up to =127 supported)
	mov DPSum1,#$00
	mov DPSum2,#$00
-	inc DPSum1
	setc
	sbc a,#$0a
	bcs -
	adc a,#$0a
	dec DPSum1
+	mov DPStack,a
-	mov a,DPSum1
	cmp a,#$10
	bmi ++
	inc DPSum2
	clrc
	and DPSum1,#$0f
	adc DPSum1,#$06
	bra -
++	xcn a
	and a,#$f0
	clrc
	adc a,DPStack
	daa a
	bcc +
	inc DPSum2
+	mov DPSum1,a
	mov a,DPSum2
	beq +
	mov x,a
	mov a,PresetHex+x
	call RoutineWriter ;write hundreds (if given)
+	mov a,DPSum1
	and a,#$f0
	xcn a
;	beq +
	mov x,a
	mov a,PresetHex+x
	call RoutineWriter ;write tens (if given)
+	mov a,DPSum1
	and a,#$0f
	mov x,a
	mov a,PresetHex+x
	call RoutineWriter ;write ones (mandatory)
	ret


PresetHex: ;direct hex to ascii conversion table
	db "0123456789ABCDEF"


PresetNotes: ;note definition per octave
	db "c",$00
	db "c+"
	db "d",$00
	db "d+"
	db "e",$00
	db "f",$00
	db "f+"
	db "g",$00
	db "g+"
	db "a",$00
	db "a+"
	db "b",$00


PresetFIRs:
	db $7f,$00,$00,$00,$00,$00,$00,$00
	db $58,$bf,$db,$f0,$fe,$07,$0c,$0c
	db $0c,$21,$2b,$2b,$13,$fe,$f3,$f9
	db $34,$33,$00,$d9,$e5,$01,$fc,$eb

