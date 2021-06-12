; starfield tiny -- Apple II Lores

; by Vince `deater` Weaver

; actually too fast

; 189 bytes - original
; 184 bytes - move DIVIDEND to A
; 173 bytes - move variables to 0 page. limits to 16 stars but that's fine?
; 171 bytes - adjust random # generator
; 170 bytes - can do sty zp,x
; 163 bytes - lose the cool HGR intro
; 161 bytes - re-arrange RNG location
; 158 bytes - ra-arrange a lot to remove need for XX
; 133 bytes -- undo opt, no lookup table, just raw divide
; 145 bytes -- init stars at beginning, so don't initially run bacward if Z=FF
; 135 bytes -- optimize divide some more

COLOR		= $30

NEGATIVE	= $F9
QUOTIENT	= $FA
DIVISOR		= $FB
DIVIDEND	= $FC
XX		= $FD
YY		= $FE
FRAME		= $FF

star_z		= $60
oldx		= $70
oldy		= $80
star_x		= $90
star_y		= $A0


;oldx		= $1000
;oldy		= $1040
;star_x		= $2000	; should be 0, not used as we never /0
;star_y		= $2040
;star_z		= $2080


LORES		= $C056		; Enable LORES graphics

HGR2		= $F3D8
HGR		= $F3E2
PLOT		= $F800		; PLOT AT Y,A (A colors output, Y preserved)
NEXTCOL		= $F85F
SETCOL		= $F864		; COLOR=A
SETGR		= $FB40
WAIT		= $FCA8		; delay 1/2(26+27A+5A^2) us

small_starfield:

	;0GR:DIMV(64,48):FORZ=1TO48:FORX=0TO64:V(X,Z)=(X*4-128)/Z+20:NEXTX,Z

	jsr	SETGR		; A is D0 after?

	;===================================
	; draw the stars
	;===================================

;	bit	LORES
;	jsr	SETGR

;	tax

	ldx	#15
make_orig_stars:
	jsr	make_new_star
	dex
	bpl	make_orig_stars

	;===================================
	; starloop

	;2FORP=0TO5
big_loop:
	ldx	#15
star_loop:

	;===================
	; erase old

	;4 COLOR=0
	lda	#$00
	sta	COLOR

	;PLOT O(P),Q(P)

	ldy	oldx,X
	lda	oldy,X
	jsr	PLOT		; PLOT AT Y,A

	;===========================
	; position Z

;	lda	star_z,X
;	beq	new_star	; should never happen
;	sta	DIVISOR

	; DIVISOR always star_z,X

	;==============================
	; get Y/Z
	;	Y=V(B(P),Z(P))

	; get YY

	lda	star_y,X	; get Y of star

	jsr	do_divide

	sta	YY		; YY

	bmi	new_star	; if <0
	cmp	#40
	bcs	new_star	; bge >39


	;==============================
	; get X/Z
	;	X=V(A(P),Z(P))

	; get XX

	lda	star_x,X	; get X of start

	jsr	do_divide

;	sta	XX
	tay

	bmi	new_star	; if <0
	cpy	#40
	bcs	new_star	; bge >40

	;========================
	; adjust Z

	;Z(P)=Z(P)-1
	dec	star_z,X
	beq	new_star	; if Z=0 new star

	; draw the star

draw_star:

	; COLOR=15
	dec	COLOR		; color from $00 (black) to $ff (white)
	txa
	ror
	bcs	not_far
	jsr	NEXTCOL

;	ror
;	jsr	NEXTCOL
;	lda	#$55
;	sta	COLOR		; FF -> 7F
not_far:

	;PLOT X,Y
	; O(P)=X:Q(P)=Y

;	ldy	XX		; XX already in Y
	sty	oldx,X		; save for next time to erase

	lda	YY		; YY
	sta	oldy,X		; ;save for next time to erase
	jsr	PLOT		; PLOT AT Y,A

				; a should be F0/20 or 0F/02 here?
	bne	done_star	; bra

new_star:
	jsr	make_new_star	;

done_star:
	;7NEXT

	dex
	bpl	star_loop

	lda	#120
	jsr	WAIT		; A is 0 after

	; GOTO2
	beq	big_loop	; bra


	;===========================
	; NEW STAR
	;===========================

make_new_star:
	;IFX<0ORX>39ORY<0ORY>39ORZ(P)<1THEN
	;	A(P)=RND(1)*64
	;	B(P)=RND(1)*64
	;	Z(P)=RND(1)*48+1:GOTO7

	ldy	FRAME
	lda	$F000,Y
	sta	star_x,X	; random XX

color_lookup:
	lda	$F100,Y
	sta	star_y,X	; random YY

	lda	$F002,Y
	and	#$3f		; random ZZ 0..63
	ora	#$1		; avoid 0
	sta	star_z,X

	inc	FRAME

	rts

	;=============================
	; do divide
	;=============================
	; Z is in divisor
	; x/y is in A

do_divide:
	; A was just loaded so flags still valid
	php
	bpl	not_negative

	eor	#$ff
	clc
	adc	#1	; invert

not_negative:

	ldy	#$ff		; QUOTIENT
div_loop:
	iny			;	inc	QUOTIENT
	sec
	sbc	star_z,X	; DIVIDEND=DIVIDEND-DIVISOR
	bpl	div_loop

	; write out quotient
	tya			; lda	QUOTIENT

	plp
	bpl	pos_add

	eor	#$ff
	sec
	bcs	do_add

pos_add:
	clc
do_add:
	adc	#20

early_out:
	rts


	; for BASIC bot load

	; need this to be at $3F5
	; it's at 8A, so 6B
	jmp	small_starfield
