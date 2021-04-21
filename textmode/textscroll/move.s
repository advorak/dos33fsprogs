
CH	= $24
CV	= $25
BASL	= $28
BASH	= $29
SEEDL	= $4E
FACL	= $9D
FACH	= $9E

COUNT		= $FE
DRAW_PAGE	= $FF

PAGE0		= $C054
GETCHAR		= $D72C		; loads (FAC),Y and increments FAC
HGR		= $F3E2
SETTXT		= $FB39
TABV		= $FB5B		; store A in CV and call MON_VTAB
STORADV		= $FBF0		; store A at (BASL),CH, advancing CH, trash Y
MON_VTAB	= $FC22		; VTAB to CV
VTABZ		= $FC24		; VTAB to value in A
HOME		= $FC58
WAIT    = $FCA8                 ;; delay 1/2(26+27A+5A^2) us

COUT	= $FDED
COUT1	= $FDF0
COUTZ	= $FDF6		; cout but ignore inverse flag

ypos	= $2000
xpos	= $2100
textl	= $2200
texth	= $2300

move:
	jsr	HGR

	sta	DRAW_PAGE

	jsr	SETTXT


next_frame:
	ldx	#0
next_text:
	lda	xpos,X
	bne	not_new

new_text:
	jsr	random8
	and	#$1f
	adc	#$4
	sta	xpos,X

	jsr	random8
	and	#$f
	sta	ypos,X

	jsr	random8
	and	#$7f
	sta	COUNT

	lda	#$d0		; token table at $D0D0
	sta	FACL
	sta	FACH

	ldy	#0
find_token_loop:
	dec	COUNT
	bmi	found_token
find_token_inner:
	inc	FACL
	bne	blargh
	inc	FACH
blargh:
	lda	(FACL),Y
	bpl	find_token_inner
	bmi	find_token_loop

found_token:
	inc	FACL
	lda	FACL
	sta	textl,X
	lda	FACH
	sta	texth,X

not_new:
	lda	xpos,X
	sta	CH
	lda	ypos,X
	sta	CV

	jsr	MON_VTAB

	lda	BASH
	clc
	adc	DRAW_PAGE
	sta	BASH

	lda	textl,X
	sta	text_smc+1
	lda	texth,X
	sta	text_smc+2

	txa
	pha

	ldx	#0
print_loop:

text_smc:
	lda	$dddd,X

	php

	ora	#$80
	jsr	STORADV		; trashes Y :(

	inx

	plp

	bpl	print_loop

big_done:

	pla
	tax

	dec	xpos,X

	inx
	cpx	#32
	bne	next_text

flip_pages:
	ldx	#0

	lda     DRAW_PAGE
	beq	done_page
	inx
done_page:
	ldy	PAGE0,X         ; set display page to PAGE1 or PAGE2

	eor	#$4             ; flip draw page between $400/$800
        sta	DRAW_PAGE

	clc
	adc	#$4
	sta	BASH
	lda	#$0
	sta	BASL

clear_screen_outer:
	ldy	#$f8
clear_screen_inner:
	lda	#$A0		; space char
	sta	(BASL),Y	; 100 101 110 111
	dey
	cpy	#$FF
	bne	clear_screen_inner
	inc	BASH
	lda	BASH
	and	#$3
	bne	clear_screen_outer

	lda	#200
	jsr	WAIT

	jmp	next_frame


	;=============================
        ; random8
        ;=============================
        ; 8-bit 6502 Random Number Generator
        ; Linear feedback shift register PRNG by White Flame
        ; http://codebase64.org/doku.php?id=base:small_fast_8-bit_prng

random8:
        lda     SEEDL                                                   ; 2
        beq     doEor                                                   ; 2
        asl                                                             ; 1
        beq     noEor   ; if the input was $80, skip the EOR            ; 2
        bcc     noEor                                                   ; 2
doEor:  eor     #$1d                                                    ; 2
noEor:  sta     SEEDL                                                   ; 2
	rts




