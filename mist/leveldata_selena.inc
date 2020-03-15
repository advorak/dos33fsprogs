
;===============================================
; level data for Selena level
;===============================================
; 24 bytes each location
; we put special at end as it's ignored if not set

LOCATION_NORTH_EXIT=0			; new room when heading north
LOCATION_SOUTH_EXIT=1			; new room when heading south
LOCATION_EAST_EXIT=2			; new room when heading east
LOCATION_WEST_EXIT=3			; new room when heading west
LOCATION_NORTH_EXIT_DIR=4		; direction faced in new room when N
LOCATION_SOUTH_EXIT_DIR=5		; direction faced in new room when S
LOCATION_EAST_EXIT_DIR=6		; direction faced in new room when E
LOCATION_WEST_EXIT_DIR=7		; direction faced in new room when W
LOCATION_NORTH_BG=8			; pointer to north background image
LOCATION_SOUTH_BG=10			; pointer to south background image
LOCATION_EAST_BG=12			; pointer to east background image
LOCATION_WEST_BG=14			; pointer to west background image
LOCATION_BGS	= 16			; bitmap saying which backgrounds valid
	BG_NORTH = 1
	BG_SOUTH = 2
	BG_EAST = 4
	BG_WEST = 8
LOCATION_SPECIAL_EXIT=17		; if we have something clickable
					; $FF if not, direction if so
LOCATION_SPECIAL_X1=18			; collision box for the thing to click
LOCATION_SPECIAL_X2=19
LOCATION_SPECIAL_Y1=20
LOCATION_SPECIAL_Y2=21
LOCATION_SPECIAL_FUNC=22		; pointer-1 of function to call on click



locations:
	.word location0, location1, location2, location3
	.word location4, location5, location6

; Inside Ship
location0:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	1		; east exit
	.byte	2		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	(DIRECTION_E|DIRECTION_ONLY_POINT)	; east exit_dir
	.byte	(DIRECTION_W|DIRECTION_ONLY_POINT)	; west exit_dir
	.word	spaceship_inside_mist_n_lzsa	; north bg
	.word	$0000				; south bg
	.word	spaceship_inside_e_lzsa		; east bg
	.word	spaceship_inside_w_lzsa		; west bg
	.byte	BG_WEST | BG_EAST | BG_NORTH
	.byte	$ff		; special exit


; controls
location1:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	0		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	DIRECTION_E	; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	controls_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_EAST
	.byte	DIRECTION_E	; special exit
	.byte	12,25		; special x
	.byte	26,46		; special y
	.word	controls_pressed-1		; special function


; electric organ
location2:
	.byte	$ff		; north exit
	.byte	$ff		; south exit
	.byte	$ff		; east exit
	.byte	0		; west exit
	.byte	$ff		; north exit_dir
	.byte	$ff		; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	DIRECTION_W	; west exit_dir
	.word	$0000			; north bg
	.word	$0000			; south bg
	.word	$0000			; east bg
	.word	organ_w_lzsa		; west bg
	.byte	BG_WEST
	.byte	DIRECTION_W	; special exit
	.byte	7,31		; special x
	.byte	24,34		; special y
	.word	organ_pressed-1		; special function


; walkway1
location3:
	.byte	5		; north exit
	.byte	4		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	walkway1_n_lzsa		; north bg
	.word	walkway1_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH
	.byte	$ff

; spaceship door
location4:
	.byte	$ff		; north exit
	.byte	3		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_N	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	$0000			; north bg
	.word	spaceship_door_s_lzsa	; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_SOUTH
	.byte	$ff

; walkway4
location5:
	.byte	6		; north exit
	.byte	3		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	DIRECTION_N	; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	walkway4_n_lzsa		; north bg
	.word	walkway4_s_lzsa		; south bg
	.word	$0000			; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH
	.byte	$ff

; bunker
location6:
	.byte	$ff		; north exit
	.byte	5		; south exit
	.byte	$ff		; east exit
	.byte	$ff		; west exit
	.byte	$ff		; north exit_dir
	.byte	DIRECTION_S	; south exit_dir
	.byte	$ff		; east exit_dir
	.byte	$ff		; west exit_dir
	.word	bunker_n_lzsa		; north bg
	.word	bunker_s_lzsa		; south bg
	.word	bunker_e_lzsa		; east bg
	.word	$0000			; west bg
	.byte	BG_NORTH|BG_SOUTH|BG_EAST
	.byte	$ff

