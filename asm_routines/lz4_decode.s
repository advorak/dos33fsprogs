; LZ4 data decompressor for Apple II

; Code by Peter Ferrie (qkumba) (peter.ferrie@gmail.com)
; "LZ4 unpacker in 143 bytes (6502 version) (2013)"
;    http://pferrie.host22.com/misc/appleii.htm
; This is that code, but with comments and labels added for clarity.
; I also found a bug when decoding with runs of multiples of 256
;   which has since been fixed upstream.

; For LZ4 reference see
; https://github.com/lz4/lz4/wiki/lz4_Frame_format.md

; LZ4 summary:
;
; HEADER:
;       Should: check for magic number 04 22 4d 18
;	FLG: 64 in our case (01=version, block.index=1, block.checksum=0
;		size=0, checksum=1, reserved
;	MAX Blocksize: 40 (64kB)
;	HEADER CHECKSUM: a7
;	BLOCK HEADER: 4 bytes (le)  If highest bit set, uncompressed!
; BLOCKS:
;	Token byte.  High 4-bits literal length, low 4-bits copy length
;	+ If literal length==15, then following byte gets added to length
;	  If that byte was 255, then keep adding bytes until not 255
;       + The literal bytes follow.  There may be zero of them
;	+ Next is block copy info.  little-endian 2-byte offset to
;	  be subtracted from current read position indicating source
;	+ The low 4-bits of the token are the copy length, which needs
;         4 added to it.  As with the literal length, if it is 15 then
;	  you read a byte and add (and if that byte is 255, keep adding)

src	EQU $FC
dst	EQU $02
end	EQU $04
count	EQU $06
delta	EQU $08

orgoff	EQU $6000	; offset of first unpacked byte

	;======================
	; LZ4 decode
	;======================
	; input buffer in INH:INL
        ; output buffer hardcoded still
	; size in ENDH:ENDL

lz4_decode:
	lda	INL	 		; packed data offset
;	sta	src
	clc
	adc	end
	sta	end
	lda	INH
;	sta	src+1
	adc	end+1
	sta	end+1

	lda	#>orgoff		; original unpacked data offset
	sta	dst+1
	lda	#<orgoff
	sta	dst

unpmain:
	ldy	#0			; used to index, always zero

parsetoken:
	jsr	getsrc			; get next token
	pha				; save for later (need bottom 4 bits)

	lsr				; number of literals in top 4 bits
	lsr				; so shift into place
	lsr
	lsr
	beq	copymatches		; if zero, then no literals
					; jump ahead and copy

	jsr	buildcount		; add up all the literal sizes
					; result is in ram[count+1]-1:A
	tax				; now in ram[count+1]-1:X
	jsr	docopy			; copy the literals

	lda	src			; 16-bit compare
	cmp	end			; to see if we have reached the end
	lda	src+1
	sbc	end+1
	bcs	done

copymatches:
	jsr	getsrc			; get 16-bit delta value
	sta	delta
	jsr	getsrc
	sta	delta+1

	pla				; restore token
	and	#$0f			; get bottom 4 bits
					; match count.  0 means 4
					; 15 means 19+, must be calculated

	jsr	buildcount		; add up count bits, in ram[count+1]-:A

	clc
	adc	#4			; adjust count by 4 (minmatch)

	tax				; now in ramp[count+1]-1:X

	beq	copy_no_adjust		; BUGFIX, don't increment if
					;	exactly a multiple of 0x100
	bcc	copy_no_adjust

	inc	count+1			; increment if we overflowed
copy_no_adjust:

	lda	src+1			; save src on stack
	pha
	lda	src
	pha

	sec				; subtract delta
	lda	dst			; from destination, make new src
	sbc	delta
	sta	src
	lda	dst+1
	sbc	delta+1
	sta	src+1

	jsr	docopy			; do the copy

	pla				; restore the src
	sta	src
	pla
	sta	src+1

	jmp	parsetoken		; back to parsing tokens

done:
	pla
	rts

	;=========
	; getsrc
	;=========
	; gets byte from src into A, increments pointer
getsrc:
	lda	(src), Y		; get a byte from src
	inc	src			; increment pointer
	bne	done_getsrc		; update 16-bit pointer
	inc	src+1			; on 8-bit overflow
done_getsrc:
	rts

	;============
	; buildcount
	;============
buildcount:
	ldx	#1			; high count starts at 1
	stx	count+1			; (loops at zero?)
	cmp	#$0f			; if LITERAL_COUNT < 15, we are done
	bne	done_buildcount
buildcount_loop:
	sta	count			; save LITERAL_COUNT (15)
	jsr	getsrc			; get the next byte
	tax				; put in X
	clc
	adc	count			; add new byte to old value
	bcc	bc_8bit_oflow		; if overflow, increment high byte
	inc	count+1
bc_8bit_oflow:
	inx				; check if read value was 255
	beq	buildcount_loop		; if it was, keep looping and adding
done_buildcount:
	rts

	;============
	; getput
	;============
	; gets a byte, then puts the byte
getput:
	jsr	getsrc
	; fallthrough to putdst

	;=============
	; putdst
	;=============
	; store A into destination
putdst:
	sta 	(dst), Y		; store A into destination
	inc	dst			; increment 16-bit pointer
	bne	putdst_end		; if overflow, increment top byte
	inc	dst+1
putdst_end:
	rts

	;=============================
	; docopy
	;=============================
	; copies ram[count+1]-1:X bytes
	; from src to dst
docopy:

docopy_loop:
	jsr	getput			; get/put byte
	dex				; decrement count
	bne	docopy_loop		; if not zero, loop
	dec	count+1			; if zero, decrement high byte
	bne	docopy_loop		; if not zero, loop

	rts
