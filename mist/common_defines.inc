;=============================
; other common stuff

; external routines

opendir_filename = $1039

; audio files

linking_noise	= $9000
LINKING_NOISE_LENGTH = 43


;===============================================
; level data structure definitions
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
	BG_WEST = 4
	BG_EAST = 8
LOCATION_SPECIAL_EXIT=17		; if we have something clickable
					; $FF if not, direction if so
LOCATION_SPECIAL_X1=18			; collision box for the thing to click
LOCATION_SPECIAL_X2=19
LOCATION_SPECIAL_Y1=20
LOCATION_SPECIAL_Y2=21
LOCATION_SPECIAL_FUNC=22		; pointer-1 of function to call on click


;================================
; Loader definitions

LOAD_TITLE	= $0
LOAD_MIST	= $1
LOAD_MECHE	= $2
LOAD_SELENA	= $3
LOAD_OCTAGON	= $4
LOAD_VIEWER	= $5
LOAD_STONEY	= $6
LOAD_CHANNEL	= $7
LOAD_ENDING	= $8



;================================
; Level definitions

; Title

TITLE_MIST_LINKING_DOCK	=	0

; Mist

MIST_ARRIVAL_DOCK	=	0
MIST_DOCK_SWITCH	=	1
MIST_DOCK_STEPS		=	2
MIST_ABOVE_DOCK		=	3
MIST_BASE_STEPS		=	4
MIST_STEPS_1ST_LANDING	=	5
MIST_STEPS_2ND_LANDING	=	6
MIST_STEPS_DENTIST	=	7
MIST_STEPS_4TH_LANDING	=	8
MIST_OUTSIDE_TEMPLE	=	9
MIST_POOL		=	10
MIST_CLOCK		=	11
MIST_SPACESHIP_FAR	=	12
MIST_TREE_CORRIDOR_2	=	13
MIST_TREE_CORRIDOR_5	=	14
MIST_GEAR		=	15
MIST_GEAR_BASE		=	16
MIST_DENTIST_DOOR	=	17
MIST_SPACESHIP_SWITCH	=	18
MIST_TREE_CORRIDOR_4	=	19
MIST_UNUSED		=	20
MIST_CLOCK_PUZZLE	=	21
MIST_CLOCK_ISLAND	=	22
MIST_CLOCK_INSIDE	=	23
MIST_OPEN_GEAR		=	24
MIST_CHAIR_VIEW		=	25
MIST_GREEN_SHACK	=	26
MIST_GREEN_STEPS1	=	27
MIST_GREEN_STEPS6	=	28
MIST_GENERATOR_DOOR	=	29
MIST_GENERATOR_ROOM	=	30
MIST_ROCKET_PATH_PAD	=	31
MIST_ROCKET_CLOSE	=	32
MIST_TOWER2_PATH	=	33
MIST_TOWER2_BASE	=	34
MIST_TOWER2_TOP		=	35
MIST_TOWER1_TRAIL	=	36
MIST_TOWER1_TRAIL2	=	37
MIST_TOWER1_BOTTOM	=	38
MIST_TOWER1_TOP		=	39
MIST_VIEWER_DOOR	=	40
; re-use 20

; Mist Octagon Building

OCTAGON_TEMPLE_DOORWAY	=	0
OCTAGON_TEMPLE_CENTER	=	1
OCTAGON_RED_BOOKSHELF	=	2
OCTAGON_FIREPLACE	=	3
OCTAGON_IN_FIREPLACE	=	4
OCTAGON_CEILING		=	5
OCTAGON_MAP		=	6
OCTAGON_FRAME_SHELF	=	7
OCTAGON_BOOKSHELF	=	8
OCTAGON_FRAME_DOOR	=	9
OCTAGON_BLUE_BOOKSHELF	=	10
OCTAGON_TOWER_ROTATION	=	11
OCTAGON_BOOKSHELF_CLOSE	=	12
OCTAGON_TOWER_HALL1	=	13
OCTAGON_TOWER_HALL2	=	14
OCTAGON_ELEVATOR_VIEW	=	15
OCTAGON_ELEVATOR_OUT	=	16
OCTAGON_ELEVATOR_OPEN	=	17
OCTAGON_ELEVATOR_IN	=	18
OCTAGON_TOWER_BOOK	=	19
OCTAGON_BOOK_LADDER	=	20
OCTAGON_BOOK_VIEW	=	21
OCTAGON_TOWER_KEY	=	22
OCTAGON_TOWER_LEFT	=	23
OCTAGON_TOWER_RIGHT	=	24
OCTAGON_KEY_LADDER	=	25
OCTAGON_KEY_VIEW	=	26
OCTAGON_RED_BOOK_CLOSED	=	27
OCTAGON_RED_BOOK_OPEN	=	28
OCTAGON_BLUE_BOOK_CLOSED=	29
OCTAGON_BLUE_BOOK_OPEN	=	30

; Mechanical Engineering

MECHE_INSIDE_GEAR	=	0
MECHE_CLOSED_BOOK	=	1
MECHE_OPEN_BOOK		=	2
MECHE_ARRIVAL		=	3
MECHE_ENTRANCE		=	4
MECHE_FORT_VIEW		=	5
MECHE_BRIDGE2		=	6
MECHE_FORT_DOOR		=	7
MECHE_FORT_ENTRY	=	8
MECHE_WEST_PLATFORM	=	9
MECHE_NORTH_PLATFORM	=	10
MECHE_NORTH_HINT	=	11
MECHE_NORTH_TOP		=	12
MECHE_NORTH_DIP		=	13
MECHE_LEFT_HALL2	=	14
MECHE_LEFT_HALL_CORNER	=	15
MECHE_RED_ROOM_CENTER	=	16
MECHE_CENTER_HALL	=	17
MECHE_RED_BUTTON	=	18
MECHE_BASEMENT		=	19
MECHE_ELEVATOR_ROTATE	=	20
MECHE_RIGHT_HALL2	=	21
MECHE_RIGHT_HALL_CORNER	=	22
MECHE_BLUE_ROOM_CENTER	=	23
MECHE_CENTER_HALL2	=	24
MECHE_ELEVATOR_PATH	=	25
MECHE_IN_ELEVATOR	=	26
MECHE_TOP_FLOOR		=	27
MECHE_ROTATE_CONTROLS	=	28
MECHE_EAST_PLATFORM	=	29
MECHE_EAST_ARCH		=	30
MECHE_EAST_TOP		=	31
MECHE_EAST_HINT		=	32
MECHE_EXIT_PUZZLE	=	33
MECHE_BOOK_STAIRS	=	34
MECHE_MIST_BOOK		=	35
MECHE_MIST_CLOSED	=	36
MECHE_MIST_OPEN		=	37
MECHE_BLUE_SECRET_DOOR	=	38
MECHE_BLUE_SECRET_ROOM	=	39
MECHE_RED_SECRET_DOOR	=	40
MECHE_RED_SECRET_ROOM	=	41




; Selena Age

SELENA_INSIDE_SHIP	=	0
SELENA_CONTROLS		=	1
SELENA_ELECTRIC_ORGAN	=	2
SELENA_WALKWAY1		=	3
SELENA_SPACESHIP_DOOR	=	4
SELENA_WALKWAY4		=	5
SELENA_BUNKER		=	6
SELENA_SUB_ROOM		=	7
SELENA_BOOK_ROOM	=	8
SELENA_BOOK_CLOSED	=	9
SELENA_BOOK_OPEN	=	10


; Viewer Room

VIEWER_STEPS		=	0
VIEWER_POOL		=	1
VIEWER_POOL_CLOSE	=	2
VIEWER_CONTROL_PANEL	=	3

; Stoney Ship
STONEY_SHIP_STERN	=	0
STONEY_SHIP_BOW		=	1
STONEY_SHIP_DOOR_CLOSED	=	2
STONEY_SHIP_DOOR_OPEN	=	3
STONEY_SHIP_CHAIR	=	4
STONEY_SHIP_BOOK_CLOSED	=	5
STONEY_SHIP_BOOK_OPEN	=	6
STONEY_ARRIVAL		=	7
STONEY_UMBRELLA_PATH	=	8
STONEY_UMBRELLA		=	9
STONEY_LIGHTHOUSE_PATH	=	10
STONEY_LIGHTHOUSE_DOOR	=	11
STONEY_LIGHTHOUSE_INSIDE=	12
STONEY_LIGHTHOUSE_UPSTAIRS=	13
STONEY_LIGHTHOUSE_BATTERY=	14
STONEY_LIGHTHOUSE_DOWNLADDER=	15
STONEY_DOORWAY1		=	16
STONEY_BRIDGE		=	17
STONEY_EXIT		=	18
STONEY_EXIT_AIRLOCK	=	19
STONEY_EXIT_AIRLOCK_OPEN=	20
STONEY_BOOK_STAIRS1	=	21
STONEY_BOOK_STAIRS2	=	22
STONEY_BOOK_ROOM	=	23
STONEY_BOOK_TABLE	=	24
STONEY_BOOK_TABLE_CLOSED=	25
STONEY_BOOK_TABLE_OPEN	=	26
STONEY_DOORWAY2		=	27
STONEY_TELESCOPE_PATH1	=	28
STONEY_TELESCOPE_PATH2	=	29
STONEY_TELESCOPE_PATH3	=	30
STONEY_TELESCOPE	=	31
STONEY_TELESCOPE_VIEW	=	32
STONEY_LEFT_TUNNEL1	=	33
STONEY_LEFT_TUNNEL2	=	34
STONEY_LEFT_AIRLOCK	=	35
STONEY_LEFT_AIRLOCK_OPEN=	36
STONEY_RED_ROOM		=	37
STONEY_RED_ROOM_DRESSER	=	38
STONEY_RED_DRESSER_OPEN	=	39
STONEY_CRAWLWAY_LEFT	=	40
STONEY_COMPASS_ROOM	=	41
STONEY_COMPASS_ROSE	=	42
STONEY_RIGHT_TUNNEL1	=	43
STONEY_RIGHT_TUNNEL2	=	44
STONEY_RIGHT_AIRLOCK	=	45
STONEY_RIGHT_AIRLOCK_OPEN=	46
STONEY_BLUE_ROOM	=	47
STONEY_BLUE_MAPCASE	=	48
STONEY_BLUE_MAPCASE_OPEN=	49
STONEY_BLUE_HALFMESSAGE	=	50
STONEY_CRAWLWAY_RIGHT	=	51

; Channely Wood
CHANNEL_OUTSIDE_CABIN	=	0
CHANNEL_CABIN_OPEN	=	1
CHANNEL_CABIN_ENTRANCE	=	2
CHANNEL_INSIDE_CABIN	=	3
CHANNEL_SAFE		=	4
CHANNEL_CLOCK_PATH	=	5
CHANNEL_TREE_PATH	=	6
CHANNEL_BIG_TREE	=	7
CHANNEL_TREE_ELEVATOR	=	8
CHANNEL_TREE_BASEMENT	=	9
CHANNEL_TREE_BOOK	=	10
CHANNEL_TREE_BOOK_CLOSED=	11
CHANNEL_TREE_BOOK_OPEN	=	12
CHANNEL_ARRIVAL		=	13