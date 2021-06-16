# ALL DUPLICATE SCRIPTS IN MACROS.S

.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# NPC scripts:

.global NPCScript_MainTown_StoppingFromGoingOutGirl
NPCScript_MainTown_StoppingFromGoingOutGirl:
	lock
	compare 0x4011 0x4
	if equal _goto OtherMessage
	msgbox gText_MainTown_GirlStopFromGoingOut1 MSG_FACE
	end
	
OtherMessage:
	msgbox gText_MainTown_GirlStopFromGoingOut2 MSG_FACE
	end

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Sign scripts:

.global SignScript_PlayerRoom_PC
SignScript_PlayerRoom_PC:
	special 0x187
	compare LASTRESULT 0x2
	if equal _goto EndScript
	lock
	setvar 0x8004 0x20
	special 0x17D
	setvar 0x8004 0x1
	special 0xD6
	sound 0x4
	msgbox gText_PlayerRoom_PlayerBootUpPC MSG_KEEPOPEN
	special 0xF9
	waitstate
	special 0x190
	release
	end

EndScript:
	releaseall
	end
	
@@@@@@@@@@@@@@@
	
.global SignScript_PlayerHouse_TV
SignScript_PlayerHouse_TV:
	compare 0x4011 0x2
	if equal _goto CodeVanish
	lock
	msgbox gText_PlayerHouse_TV1 MSG_SIGN
	end
	
CodeVanish:
	msgbox gText_PlayerHouse_TV2 MSG_SIGN
	end

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Tile scripts:

.equ GIRL, 4

.global TileScript_GoingOutsideTown
TileScript_GoingOutsideTown:
	lock
	checksound
	sound 0x15
	applymovement GIRL m_LookDownExclaim
	waitmovement 0x0
	msgbox gText_MainTown_GirlStopping MSG_KEEPOPEN
	waitmsg
	closeonkeypress
	applymovement PLAYER m_StepLeft
	waitmovement 0x0
	release
	end

m_LookDownExclaim: .byte look_down, exclaim, pause_long, pause_long, pause_long, end_m
m_StepLeft: .byte walk_left_slow, end_m

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Level scripts:

.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_WOKE_UP_IN_HOUSE, 0x0
.equ MAIN_STORY_TALKED_TO_MOM_HOUSE, 0x1

.equ MOM, 1

.global gMapScripts_PlayerHouse
gMapScripts_PlayerHouse:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_PlayerHouse
	.byte MAP_SCRIPT_TERMIN

LevelScripts_PlayerHouse:
	levelscript VAR_MAIN_STORY, MAIN_STORY_WOKE_UP_IN_HOUSE, LevelScript_PlayerHouse
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_PlayerHouse:
	lockall
	checksound
	sound 0x15
	applymovement MOM m_LookUpExclaim
	waitmovement 0x0
	pause 0x1E
	preparemsg gText_PlayerHouse_Mom1
	waitmsg
	pause 0x3A
	closeonkeypress
	applymovement MOM m_MomMoveToPlayer
	waitmovement 0x0
	spriteface PLAYER DOWN
	msgbox gText_PlayerHouse_Mom2a MSG_KEEPOPEN
	fanfare 0x10D
	msgbox gText_PlayerHouse_Mom2b MSG_KEEPOPEN
	waitfanfare
	msgbox gText_PlayerHouse_Mom2c MSG_KEEPOPEN
	closeonkeypress
	applymovement MOM m_MomMoveBackToSpot
	waitmovement 0x0
	setflag 0x82F
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_MOM_HOUSE
	releaseall
	end

m_LookUpExclaim: .byte look_up, exclaim, end_m
m_MomMoveToPlayer: .byte walk_right, walk_right, walk_up, end_m
m_MomMoveBackToSpot: .byte walk_down, walk_left, walk_left, end_m

@@@@@@@@@@@@@@@

.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_LEAVE_HOUSE_TOWN, 0x1
.equ MAIN_STORY_TALKED_TO_PROF_AIDE_TOWN, 0x2

.equ PROF_AIDE, 2

.global gMapScripts_MainTown
gMapScripts_MainTown:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_MainTown
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_MainTown
	.byte MAP_SCRIPT_TERMIN
	
LevelScripts_MainTown: 
	levelscript VAR_MAIN_STORY, MAIN_STORY_LEAVE_HOUSE_TOWN, LevelScript_MainTown
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_MainTown:
	lockall
	msgbox gText_MainTown_Aide1 MSG_KEEPOPEN
	waitmsg
	pause 0x10
	closeonkeypress
	checksound
	sound 0x15
	applymovement PLAYER m_LookRightQuestion
	waitmovement 0x0
	applymovement PROF_AIDE m_WalkLeftToPlayer
	waitmovement 0x0
	msgbox gText_MainTown_Aide2 MSG_KEEPOPEN
	closeonkeypress
	applymovement PROF_AIDE m_WalkRightFromPlayer
	waitmovement 0x0
	pause 0x1E
	hidesprite 0x2
	setflag 0x1FF
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_PROF_AIDE_TOWN
	releaseall
	end
	
m_LookRightQuestion: .byte look_right, say_question, pause_long, end_m
m_WalkLeftToPlayer: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, end_m
m_WalkRightFromPlayer: .byte walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, end_m

MapEntryScript_MainTown:
	setworldmapflag 0x890
	end
