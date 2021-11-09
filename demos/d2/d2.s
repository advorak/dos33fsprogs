; Demo2

; by deater (Vince Weaver) <vince@deater.net>

; Zero Page
	.include "zp.inc"
	.include "hardware.inc"


d2:

	;===================
	; music Player Setup


	lda	#<peasant_song
	sta	SONG_L
	lda	#>peasant_song
	sta	SONG_H

	; assume mockingboard in slot#4
	jsr	mockingboard_init

start_interrupts:
	cli

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HGR2		; set hi-res 140x192, page2, fullscreen
				; A and Y both 0 at end

	sty	FRAME		; start at 1 for wires purposes

	;==================
	; create sinetable

	;ldy	#0		; Y is 0
sinetable_loop:
	tya							; 2
	and	#$3f	; wrap sine at 63 entries		; 2

	cmp	#$20
	php		; save pos/negative for later

	and	#$1f

	cmp	#$10
	bcc	sin_left		; blt

sin_right:
	; sec	carry should be set here
	eor	#$FF
	adc	#$20			; 32-X
sin_left:
	tax
	lda	sinetable_base,X				; 4+

	plp
	bcc	sin_done

sin_negate:
	; carry set here
	eor	#$ff
;	adc	#0		; FIXME: this makes things off by 1

sin_done:
	sta	sinetable,Y

	iny
	bne	sinetable_loop


	; NOTE: making gbash/gbasl table wasn't worth it


	jsr	dsr_spin

forever:

	jsr	moving

	jsr	fast_hclr
	jsr	flip_page

	jsr	wires

	jsr	oval

	jmp	forever



flip_page:
	ldy	#$0
        lda     HGR_PAGE        ; will be $20/$40
        cmp     #$20
        beq     done_flip_page
        iny
done_flip_page:
        ldx     PAGE1,Y     ; set display page to PAGE1 or PAGE2

        eor     #$60            ; flip draw page between $2000/$4000
        sta     HGR_PAGE

        rts



.include	"dsr_shape.s"
.include	"moving.s"
.include	"wires.s"
.include	"oval.s"

; music
.include	"peasant_music.s"
.include        "interrupt_handler.s"
; must be last
.include        "mockingboard_setup.s"

; Moving
;   moving, orange and green





