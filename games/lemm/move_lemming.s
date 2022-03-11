
move_lemmings:

	ldy	#0
	lda	lemming_out,Y

	bne	really_move_lemming
	jmp	done_move_lemming

really_move_lemming:
	lda	lemming_status
	cmp	#LEMMING_FALLING
	beq	do_lemming_falling
	cmp	#LEMMING_WALKING
	beq	do_lemming_walking
	cmp	#LEMMING_DIGGING
	beq	do_lemming_digging
	jmp	done_move_lemming

do_lemming_falling:
	inc	lemming_y

	jsr	collision_check_ground

	jmp	done_move_lemming

do_lemming_walking:


	lda	lemming_y
	clc
	adc	#3		; waist-high?
	tay

	lda     hposn_high,Y
        sta     GBASH
        lda     hposn_low,Y
        sta     GBASL

	clc
	lda	lemming_x
	adc	lemming_direction
	tay

	lda	(GBASL),Y
	and	#$7f
	beq	walking_no_wall

walking_yes_wall:

	lda	lemming_direction
	eor	#$ff
	clc
	adc	#1
	sta	lemming_direction

	lda	lemming_x

walking_no_wall:
	tya

walking_done:
	sta	lemming_x

	jsr	collision_check_ground

	jmp	done_move_lemming

do_lemming_digging:
	lda	lemming_y
	clc
	adc	#9
	tay

	lda     hposn_high,Y
        sta     GBASH
        lda     hposn_low,Y
        sta     GBASL

	ldy	lemming_x
	lda	(GBASL),Y
	and	#$7f
	beq	digging_falling
digging_digging:
	lda	#$0
	sta	(GBASL),Y
	lda	GBASH
	adc	#$20
	sta	GBASH
	lda	#$0
	sta	(GBASL),Y

	inc	lemming_y

	jmp	done_digging
digging_falling:
	lda	#LEMMING_FALLING
	sta	lemming_status
done_digging:


done_move_lemming:
	rts

lemming_direction:
	.byte 1

lemming_x:
	.byte 12
lemming_y:
	.byte 45

lemming_out:
	.byte $0


LEMMING_FALLING = 1
LEMMING_WALKING = 2
LEMMING_DIGGING = 3

lemming_status:
	.byte LEMMING_FALLING

lemming_job:
	.byte $00


collision_check_ground:
	lda	lemming_y
	clc
	adc	#9
	tay

	lda     hposn_high,Y
        sta     GBASH
        lda     hposn_low,Y
        sta     GBASL

	ldy	lemming_x
	lda	(GBASL),Y
	and	#$7f
	beq	ground_falling
ground_walking:
	lda	#LEMMING_WALKING
	jmp	done_check_ground
ground_falling:
	lda	#LEMMING_FALLING
done_check_ground:
	sta	lemming_status

	rts
