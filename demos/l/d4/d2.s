; Apple II graphics/music in 1k

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"

; for a 256 entry we need to fit in 252 bytes

; 310 bytes -- initial
; 268 bytes -- strip out interrupts
; 262 bytes -- simplify init
; 261 bytes -- optimize init more
; 253 bytes -- optimize var init
; 252 bytes -- bne vs jmp
; 250 bytes -- song only has 16 notes so can never be negative
; 249 bytes -- make terminating value $80 instead of $FF
; 247 bytes -- combine note loop.  makes song a bit faster

d2:

	;===================
	; music Player Setup

tracker_song = peasant_song

	; assume mockingboard in slot#4

	; inline mockingboard_init

.include "mockingboard_init.s"

.include "tracker_init.s"

game_loop:

	; start the music playing

.include "play_frame.s"
.include "ay3_write_regs.s"

	; delay 20Hz, or 1/20s = 50ms

	lda	#140
	jsr	WAIT

	beq	game_loop


; music
.include	"mA2E_2.s"

