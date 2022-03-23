

	;============================
	; update the time
	;============================
	; this gets called approximately once a second

	; updates the time left
update_time:

	;==============================
	; update explosion timer
	;==============================
	; not ideal (first second might be short)

	ldy	#0
update_exploding_loop:
	lda	lemming_exploding,Y
	beq	not_done_exploding


	tya
	tax
	inc	lemming_exploding,X
	lda	lemming_exploding,Y
	cmp	#6
	bne	not_done_exploding

	lda	#LEMMING_EXPLODING
	sta	lemming_status,Y
	lda	#0
	sta	lemming_frame,Y
	sta	lemming_exploding,Y

not_done_exploding:

	iny
	cpy	#MAX_LEMMINGS
	bne	update_exploding_loop



	sed

	sec
	lda	TIME_SECONDS
	sbc	#1
	cmp	#$99
	bne	no_time_uflo
	lda	#$59
	dec	TIME_MINUTES

no_time_uflo:
	sta	TIME_SECONDS

	cld

	lda	TIME_MINUTES
	bne	not_over
	lda	TIME_SECONDS
	bne	not_over

	; out of time


	lda	#LEVEL_FAIL
	sta	LEVEL_OVER


not_over:


draw_time:

	; draw minute
	ldy	TIME_MINUTES

	lda	bignums_l,Y
	sta	INL
	lda	bignums_h,Y
	sta	INH

	; 246, 152

	ldx	#35		; 245
        stx     XPOS
	lda	#152
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	;================
	; draw seconds

	lda	TIME_SECONDS
	ldx	#37
	sec				; no leading zero removal
	jmp	print_two_digits


	;===========================
	;===========================
	; update percent in
	;===========================
	;===========================

update_percent_in:

	; draw hundreds
	ldy	PERCENT_RESCUED_H
	beq	not_hundred_yet

	lda	bignums_l,Y
	sta	INL
	lda	bignums_h,Y
	sta	INH

	ldx	#23
        stx     XPOS
	lda	#152
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	sec	; no leading zero for rest
	bcs	hundreds_entry

not_hundred_yet:
	; print tens/ones
	clc				; leading zero removal
hundreds_entry:

	lda	PERCENT_RESCUED_L
	ldx	#24
	jmp	print_two_digits


	;===========================
	;===========================
	; update lemmings out number
	;===========================
	;===========================

update_lemmings_out:


	lda	LEMMINGS_OUT
	ldx	#15
	clc				; leading zero removal
	jmp	print_two_digits



	;===========================
	;===========================
	; print two-digit number
	;===========================
	;===========================
	; A is the BCD value
	; X is the X location
	; C set means print 0
	; we assume 152 for Y location

print_two_digits:
	ldy	#0

	bcs	ptd_leading_zero

	ldy	#10
ptd_leading_zero:

	sty	ptt_lz_smc+1


	stx	ptt_smc+1
	inx
	stx	pto_smc+1

print_two_tens:

	; draw tens
	pha
	lsr
	lsr
	lsr
	lsr

	bne	no_handle_zero

	clc
ptt_lz_smc:
	adc	#10			; blank  or zero, depending

no_handle_zero:

	tay
	lda	bignums_l,Y
	sta	INL
	lda	bignums_h,Y
	sta	INH

ptt_smc:
	lda	#15
        sta	XPOS
	lda	#152
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift


print_two_ones:
	pla
	and	#$f
	tay

	lda	bignums_l,Y
	sta	INL
	lda	bignums_h,Y
	sta	INH

pto_smc:
	lda	#16
	sta	XPOS
	lda	#152
	sta	YPOS

	jsr	hgr_draw_sprite_autoshift

	rts



bignums_l:
.byte	<big0_sprite,<big1_sprite,<big2_sprite,<big3_sprite,<big4_sprite
.byte	<big5_sprite,<big6_sprite,<big7_sprite,<big8_sprite,<big9_sprite
.byte	<blank_sprite

bignums_h:
.byte	>big0_sprite,>big1_sprite,>big2_sprite,>big3_sprite,>big4_sprite
.byte	>big5_sprite,>big6_sprite,>big7_sprite,>big8_sprite,>big9_sprite
.byte	>blank_sprite
