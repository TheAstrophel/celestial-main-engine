# ALL DUPLICATE SCRIPTS IN MACROS.S

.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# NPC scripts:

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Sign scripts:

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Tile scripts:

.equ PROF_AIDE, 1
.equ VAR_EXTRA, 0x51FD
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF

.global TileScript_GoingToObservatory
TileScript_GoingToObservatory:
	lock
	sound 0x15
	applymovement PROF_AIDE m_LookAtPlayerExclaim
	waitmovement 0x0
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_1, 0x1D @X-Pos equals 0x1D
	if equal _call MoveForScriptOnLeft1
	compare VAR_TEMP_1, 0x1E @X-Pos equals 0x1E
	if equal _call MoveForScriptOnMiddle1
	compare VAR_TEMP_1, 0x1F @Y-Pos equals 0x1F
	if equal _call MoveForScriptOnRight1
	spriteface PLAYER RIGHT
	compare VAR_EXTRA 0x1
	if equal _goto AlreadyDoneAndTalkingAgain
	msgbox gText_AerilonHills_ProfAideGreetingPlayer MSG_KEEPOPEN
	waitmsg
	msgbox gText_AerilonHills_ProfAideAskQuestion MSG_YESNO
	compare LASTRESULT 0x1
	if equal _goto PlayerSaysYes
	compare LASTRESULT 0x0
	if equal _goto PlayerSaysNo
	release
	end

MoveForScriptOnLeft1:
	applymovement PROF_AIDE, m_WalkTowardsPlayerWhenPlayerLeft
	waitmovement 0x0
	return

MoveForScriptOnMiddle1:
	applymovement PROF_AIDE, m_WalkTowardsPlayerWhenPlayerMiddle
	waitmovement 0x0
	return
	
MoveForScriptOnRight1:
	spriteface PROF_AIDE, LEFT
	return
	
PlayerSaysYes:
	lock
	playsong 0x12E 0x0
	msgbox gText_AerilonHills_ProfAideTalkedWhenSayYes MSG_KEEPOPEN
	closeonkeypress
	compare VAR_TEMP_1, 0x1D @X-Pos equals 0x1D
	if equal _call MoveForScriptOnLeft2
	compare VAR_TEMP_1, 0x1E @X-Pos equals 0x1E
	if equal _call MoveForScriptOnMiddle2
	compare VAR_TEMP_1, 0x1F @X-Pos equals 0x1F
	if equal _call MoveForScriptOnRight2
	opendoor 0x2B 0x2B
	waitdooranim
	applymovement PROF_AIDE m_ProfAideEnterLab
	applymovement PLAYER m_PlayerEnterLab
	waitmovement 0x0
	closedoor 0x2B 0x2B
	waitdooranim
	hidesprite PROF_AIDE
	setvar VAR_EXTRA, 0
	setvar VAR_TEMP_1, 0
	setvar VAR_TEMP_2, 0
	setflag 0x200 @PROF_AIDE "Person ID" in A-Map
	setflag 0x4001 @Set so song doesnt end
	warp 0xF 0x0 0x1 0xE 0xD
	waitstate
	release
	end

MoveForScriptOnLeft2:
	applymovement PROF_AIDE, m_AideWalkToLabWhenPlayerLeft
	applymovement PLAYER, m_FollowingAideWhenLeft
	waitmovement 0x0
	return
	
MoveForScriptOnMiddle2:
	applymovement PROF_AIDE, m_AideWalkToLabWhenPlayerMiddle
	applymovement PLAYER, m_FollowingAideWhenMiddle
	waitmovement 0x0
	return
	
MoveForScriptOnRight2:
	applymovement PLAYER, m_ExtraMove1
	waitmovement 0x0
	applymovement PROF_AIDE, m_ExtraMove2
	waitmovement 0x0
	applymovement PROF_AIDE, m_AideWalkToLabWhenPlayerRight
	applymovement PLAYER, m_FollowingAideWhenRight
	waitmovement 0x0
	return

PlayerSaysNo:
	lock
	msgbox gText_AerilonHills_ProfAideTalkedWhenSayNo MSG_KEEPOPEN
	closeonkeypress
	applymovement PLAYER, m_Leaving
	waitmovement 0x0
	compare VAR_TEMP_1, 0x1D @X-Pos equals 0x1D
	if equal _call MoveForScriptOnLeft3
	compare VAR_TEMP_1, 0x1E @X-Pos equals 0x1F
	if equal _call MoveForScriptOnMiddle3
	compare VAR_TEMP_1, 0x1F @X-Pos equals 0x1F
	if equal _call MoveForScriptOnRight3
	spriteface PROF_AIDE, DOWN
	spritebehave PROF_AIDE, 0x11
	setvar VAR_EXTRA, 1
	release
	end
	
MoveForScriptOnLeft3:
	applymovement PROF_AIDE, m_ProfAideGoingToOriginalPositionWhenPlayerLeft
	waitmovement 0x0
	return

MoveForScriptOnMiddle3:
	applymovement PROF_AIDE, m_ProfAideGoingToOriginalPositionWhenPlayerMiddle
	waitmovement 0x0
	return

MoveForScriptOnRight3:
	spriteface PROF_AIDE, DOWN
	return

AlreadyDoneAndTalkingAgain:
	msgbox gText_AerilonHills_TalkingToProfAideAgain MSG_KEEPOPEN
	waitmsg
	msgbox gText_AerilonHills_ProfAideAskQuestion MSG_YESNO
	compare LASTRESULT 0x1
	if equal _goto PlayerSaysYes
	compare LASTRESULT 0x0
	if equal _goto PlayerSaysNo
	release
	end

m_LookAtPlayerExclaim: .byte look_left, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, end_m
m_WalkTowardsPlayerWhenPlayerLeft: .byte walk_left, walk_left, end_m
m_WalkTowardsPlayerWhenPlayerMiddle: .byte walk_left, end_m
m_ProfAideEnterLab: .byte walk_up, set_invisible, end_m
m_PlayerEnterLab: .byte walk_up, walk_up, set_invisible, end_m
m_AideWalkToLabWhenPlayerLeft: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAideWhenLeft: .byte walk_right, walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_AideWalkToLabWhenPlayerMiddle: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAideWhenMiddle: .byte walk_right, walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_ExtraMove1: .byte walk_left_slow, look_right, end_m
m_ExtraMove2: .byte walk_left, end_m
m_AideWalkToLabWhenPlayerRight: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAideWhenRight: .byte walk_right, walk_up, walk_up, walk_up, walk_up, walk_up, walk_right,  walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_Leaving: .byte walk_down_very_slow, end_m
m_ProfAideGoingToOriginalPositionWhenPlayerLeft: .byte walk_right, walk_right, end_m
m_ProfAideGoingToOriginalPositionWhenPlayerMiddle: .byte walk_right, end_m

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Level scripts:

.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_GOING_TO_PROFESSOR_LAB, 0x2
.equ MAIN_STORY_TALKED_TO_PROFESSOR_LAB, 0x3

.equ PROF_AIDE, 4
.equ PROF, 1

.global gMapScripts_AlmondLab
gMapScripts_AlmondLab:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AlmondLab
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_AlmondLab
	.byte MAP_SCRIPT_TERMIN

LevelScripts_AlmondLab:
	levelscript VAR_MAIN_STORY, MAIN_STORY_GOING_TO_PROFESSOR_LAB, LevelScript_AlmondLab
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AlmondLab:
	lockall
	applymovement PROF_AIDE m_GoToProfessor
	applymovement PLAYER m_GoToProfessor
	waitmovement 0x0
	clearflag 0x4001
	playsong2 0x0
	fadedefault
	msgbox gText_AlmondLab_Aide1 0x4
	closeonkeypress
	applymovement PROF m_ProfStepOnSpot
	waitmovement 0x0
	msgbox gText_AlmondLab_Prof1 0x4
	closeonkeypress
	msgbox gText_AlmondLab_Aide2 0x4
	closeonkeypress
	spriteface PROF_AIDE DOWN
	pause 0x14
	msgbox gText_AlmondLab_Aide3 0x4
	closeonkeypress
	applymovement PROF_AIDE m_ProfAideLeave
	waitmovement 0x0
	applymovement PLAYER m_PlayerStepUp
	waitmovement 0x0
	msgbox gText_AlmondLab_Prof2 0x4
	closeonkeypress
	applymovement PROF m_ProfStepUpAndLeave
	waitmovement 0x0
	sound 0x9
	applymovement PROF m_Vanish
	waitmovement 0x0
	applymovement PLAYER m_PlayerStepUpAndLeave
	waitmovement 0x0
	sound 0x9
	applymovement PLAYER m_Vanish
	waitmovement 0x0
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_PROFESSOR_LAB
	clearflag 0x1FF
	clearflag 0x200
	warp 0xF 0x1 0x1 0x0 0x0
	release
	end

m_GoToProfessor: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_ProfStepOnSpot: .byte pause_short, pause_short, walk_down_onspot, pause_short, pause_short, pause_short, end_m
m_ProfAideLeave: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, pause_short, pause_short, end_m
m_PlayerStepUp: .byte walk_up, pause_short, pause_short, pause_short, end_m
m_ProfStepUpAndLeave: .byte walk_up, walk_up, walk_up, walk_up, end_m
m_PlayerStepUpAndLeave: .byte walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_Vanish: .byte pause_short, set_invisible, end_m

MapEntryScript_AlmondLab:
	compare 0x4011 0x2
	if equal _call MapEntryScript_AlmondLab_FirstTimeEntering
	end
	
MapEntryScript_AlmondLab_FirstTimeEntering:
	spriteface PROF_AIDE, UP
	movesprite2 PROF_AIDE, 0xA 0xD
	playsong2 0x12E
	return
