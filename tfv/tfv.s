.include "zp.inc"

	;================================
	; Clear screen and setup graphics
	;================================

	jsr	HOME
	jsr	set_gr_page0

	;===================================
	; zero out the zero page that we use
	;===================================

	; memset()

	;===================================
	; Clear top/bottom of page 0
	;===================================

	lda	#$0
	sta	DRAW_PAGE
	jsr	clear_top
	jsr	clear_bottom

	;===================================
	; Clear top/bottom of page 1
	;===================================

	lda	#$4
	sta	DRAW_PAGE
	jsr	clear_top
	jsr	clear_bottom

	;==========================
	; Do Opening
	;==========================

	jsr	opening

	;======================
	; show the title screen
	;======================

	jsr	title_screen

enter_name:

	jsr	TEXT
	jsr	HOME

	lda     #>(enter_name_string)
        sta     OUTH
	lda     #<(enter_name_string)
        sta     OUTL

	jsr	print_string

	; zero out name

	lda	#<(name)
	sta	MEMPTRL
	sta	NAMEL
	lda	#>(name)
	sta	MEMPTRH
	sta	NAMEH
	lda	#0
	ldx	#8
	jsr	memset

name_loop:

	jsr	NORMAL

	lda	#11
	sta	CH		; HTAB 12

	lda	#2
	jsr	TABV		; VTAB 3

	ldy	#0
	sty	NAMEX

name_line:
	cpy	NAMEX
	bne	name_notx
	lda	#'+'
	jmp	name_next

name_notx:
	lda	NAMEL,Y
	beq	name_zero
	ora	#$80
	bne	name_next

name_zero:
	lda	#('_'+$80)
name_next:
	jsr	COUT
	lda	#(' '+$80)
	jsr	COUT
	iny
	cpy	#8
	bne	name_line

	lda	#7
	sta	CV

	lda	#('@'+$80)
	sta	CHAR

print_letters_loop:
	lda	#11
	sta	CH		; HTAB 12
	jsr	VTAB

	ldy	#0

print_letters_inner_loop:
	lda	CHAR
	jsr	COUT
	inc	CHAR
	lda	#(' '+$80)
	jsr	COUT
	iny

	cpy	#$8
	bne	print_letters_inner_loop






	jsr	wait_until_keypressed

	;=====================
	; Start the game
	;=====================


flying_start:

	jsr     set_gr_page0

flying_loop:
	jsr	gr_copy_to_current

	jsr	put_sprite

	jsr	wait_until_keypressed





	lda	LASTKEY

	cmp	#('Q')
        beq	exit

	cmp	#('I')
	bne	check_down
	dec	YPOS
	dec	YPOS

check_down:
	cmp	#('M')
	bne	check_left
	inc	YPOS
	inc	YPOS

check_left:
	cmp	#('J')
	bne	check_right
	dec	XPOS

check_right:
	cmp	#('K')
	bne	check_done
	inc	XPOS

check_done:
	jmp	flying_loop



exit:

	lda	#$4
	sta	BASH
	lda	#$0
	sta	BASL			; restore to 0x400 (page 0)
					; copy to 0x400 (page 0)

	; call home
	jsr	HOME


	; Return to BASIC?
	rts


;===============================================
; External modules
;===============================================

.include "opener.s"
.include "utils.s"
.include "title.s"

;===============================================
; Variables
;===============================================

vmwsw_string:
	.asciiz "A VMW SOFTWARE PRODUCTION"

enter_name_string:
	.asciiz	"PLEASE ENTER A NAME:"

name:
	.byte $0,$0,$0,$0,$0,$0,$0,$0


	; waste memory with a lookup table
	; maybe faster than using GBASCALC?

gr_offsets:
	.word	$400,$480,$500,$580,$600,$680,$700,$780
	.word 	$428,$4a8,$528,$5a8,$628,$6a8,$728,$7a8
	.word	$450,$4d0,$550,$5d0,$650,$6d0,$750,$7d0

tb1_sprite:
	.byte $8,$4
	.byte $55,$50,$00,$00,$00,$00,$00,$00
	.byte $55,$55,$55,$00,$00,$00,$00,$00
	.byte $ff,$1f,$4f,$2f,$ff,$22,$20,$00
	.byte $5f,$5f,$5f,$5f,$ff,$f2,$f2,$f2

.include "backgrounds.inc"
