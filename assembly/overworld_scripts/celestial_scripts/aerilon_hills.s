.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#Tile scripts:
.equ PROF_AIDE, 1
.equ VAR_EXTRA, 0x51FD
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF

.global TileScript_AerilonHills_AideAtTheBaseOfObservatory
TileScript_AerilonHills_AideAtTheBaseOfObservatory:
	lock
	sound 0x15
	applymovement PROF_AIDE, m_LookAtPlayerExclaim
	waitmovement 0x0
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_1, 0x1D @X-Pos equals 0x1D
	if equal _call StepLeftIfScriptNumberZero
	compare VAR_TEMP_1, 0x1E @X-Pos equals 0x1E
	if equal _call StepLeftIfScriptNumberOne
	spriteface PROF_AIDE, LEFT
	spriteface PLAYER, RIGHT
	compare VAR_EXTRA 0x1 @Set to 0x1 if [player] says no to avoid a loop
	if equal _goto MetAideBefore
	msgbox gText_AerilonHills_ProfAide_01, MSG_YESNO
	compare LASTRESULT, 0x1
	if equal _goto PlayerSaysYes
	compare LASTRESULT, 0x0
	if equal _goto PlayerSaysNo
	release
	end

StepLeftIfScriptNumberZero:
	applymovement PROF_AIDE, m_WalkTowardsPlayerIfScriptNumberZero
	waitmovement 0x0
	return

StepLeftIfScriptNumberOne:
	applymovement PROF_AIDE, m_WalkTowardsPlayerIfScriptNumberOne
	waitmovement 0x0
	return
	
PlayerSaysYes:
	lock
	playsong 0x12E 0x0
	msgbox gText_AerilonHills_ProfAide_02, MSG_KEEPOPEN
	closeonkeypress
	compare VAR_TEMP_1, 0x1D @X-Pos equals 0x1D
	if equal _call MoveTowardsObservatoryIfScriptNumberZero
	compare VAR_TEMP_1, 0x1E @X-Pos equals 0x1E
	if equal _call MoveTowardsObservatoryIfScriptNumberOne
	compare VAR_TEMP_1, 0x1F @X-Pos equals 0x1F
	if equal _call MoveTowardsObservatoryIfScriptNumberTwo
	opendoor 0x2B 0x2B
	waitdooranim
	applymovement PROF_AIDE, m_ProfAideEntersObservatory
	applymovement PLAYER, m_PlayerEntersObservatory
	waitmovement 0x0
	closedoor 0x2B 0x2B
	waitdooranim
	hidesprite PROF_AIDE
	setvar VAR_EXTRA, 0 @Will be used later in other scripts
	setvar VAR_TEMP_1, 0
	setvar VAR_TEMP_2, 0
	setflag 0x200 @Person ID of Aide in A-Map
	setflag 0x4001 @Set so song does not stop
	warp 0xF 0x0 0x1 0xE 0xD
	waitstate
	release
	end

MoveTowardsObservatoryIfScriptNumberZero:
	applymovement PROF_AIDE, m_AideWalksToObservatoryIfScriptNumberZero
	applymovement PLAYER, m_FollowingAideIfScriptNumberZero
	waitmovement 0x0
	return

MoveTowardsObservatoryIfScriptNumberOne:
	applymovement PROF_AIDE, m_AideWalksToObservatoryIfScriptNumberOne
	applymovement PLAYER, m_FollowingAideIfScriptNumberOne
	waitmovement 0x0
	return

MoveTowardsObservatoryIfScriptNumberTwo:
	applymovement PLAYER, m_SlowlyStepLeft
	waitmovement 0x0
	applymovement PROF_AIDE, m_StepLeftAtPlayersPosition
	waitmovement 0x0
	applymovement PROF_AIDE, m_AideWalksToObservatoryIfScriptNumberTwo
	applymovement PLAYER, m_FollowingAideIfScriptNumberTwo
	waitmovement 0x0
	return

PlayerSaysNo:
	lock
	msgbox gText_AerilonHills_ProfAide_03, MSG_KEEPOPEN
	closeonkeypress
	applymovement PLAYER, m_Leaving
	waitmovement 0x0
	compare VAR_TEMP_1, 0x1D @X-Pos equals 0x1D
	if equal _call StepRightIfScriptNumberZero
	compare VAR_TEMP_1, 0x1E @X-Pos equals 0x1F
	if equal _call StepRightIfScriptNumberOne
	spriteface PROF_AIDE, DOWN
	spritebehave PROF_AIDE, 0x11
	setvar VAR_EXTRA, 1 @Set to avoid loop
	release
	end
	
StepRightIfScriptNumberZero:
	applymovement PROF_AIDE, m_ProfAideGoingToOriginalPositionIfScriptNumberZero
	waitmovement 0x0
	return

StepRightIfScriptNumberOne:
	applymovement PROF_AIDE, m_ProfAideGoingToOriginalPositionIfScriptNumberOne
	waitmovement 0x0
	return

MetAideBefore:
	msgbox gText_AerilonHills_ProfAide_04, MSG_YESNO
	compare LASTRESULT, 0x1
	if equal _goto PlayerSaysYes
	compare LASTRESULT, 0x0
	if equal _goto PlayerSaysNo
	release
	end

m_LookAtPlayerExclaim: .byte look_left, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, end_m
m_WalkTowardsPlayerIfScriptNumberZero: .byte walk_left, walk_left, end_m
m_WalkTowardsPlayerIfScriptNumberOne: .byte walk_left, end_m
m_ProfAideEntersObservatory: .byte walk_up, set_invisible, end_m
m_PlayerEntersObservatory: .byte walk_up, walk_up, set_invisible, end_m
m_AideWalksToObservatoryIfScriptNumberZero: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAideIfScriptNumberZero: .byte walk_right, walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_AideWalksToObservatoryIfScriptNumberOne: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAideIfScriptNumberOne: .byte walk_right, walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_SlowlyStepLeft: .byte walk_left_slow, look_right, end_m
m_StepLeftAtPlayersPosition: .byte walk_left, end_m
m_AideWalksToObservatoryIfScriptNumberTwo: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAideIfScriptNumberTwo: .byte walk_right, walk_up, walk_up, walk_up, walk_up, walk_up, walk_right,  walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_Leaving: .byte walk_down_very_slow, end_m
m_ProfAideGoingToOriginalPositionIfScriptNumberZero: .byte walk_right, walk_right, end_m
m_ProfAideGoingToOriginalPositionIfScriptNumberOne: .byte walk_right, end_m

#@@@@@@@@;Sub-maps;@@@@@@@@
#Level scripts:
.equ PROF, 1
.equ PROF_AIDE, 4
.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_GOING_TO_PROFESSOR, 0x2
.equ MAIN_STORY_TALKED_TO_PROFESSOR, 0x3

.global gMapScripts_AerilonHills_AlmondObservatory
gMapScripts_AerilonHills_AlmondObservatory:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AerilonHills_AlmondObservatory
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_AerilonHills_AlmondObservatory
	.byte MAP_SCRIPT_TERMIN

LevelScripts_AerilonHills_AlmondObservatory:
	levelscript VAR_MAIN_STORY, MAIN_STORY_GOING_TO_PROFESSOR, LevelScript_AerilonHills_AlmondObservatory
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AerilonHills_AlmondObservatory:
	lockall
	applymovement PROF_AIDE, m_MoveTowardsProfessor
	applymovement PLAYER, m_MoveTowardsProfessor
	waitmovement 0x0
	clearflag 0x4001 @Had been set so song does not stop
	playsong2 0x0
	fadedefault
	msgbox gText_AerilonHills_AlmondObservatory_Aide_01, MSG_KEEPOPEN
	closeonkeypress
	applymovement PROF, m_ProfStepOnSpot
	waitmovement 0x0
	msgbox gText_AerilonHills_AlmondObservatory_Prof_01, MSG_KEEPOPEN
	closeonkeypress
	msgbox gText_AerilonHills_AlmondObservatory_Aide_02, MSG_KEEPOPEN
	closeonkeypress
	spriteface PROF_AIDE, DOWN
	pause 0x20
	msgbox gText_AerilonHills_AlmondObservatory_Aide_03, MSG_KEEPOPEN
	closeonkeypress
	applymovement PROF_AIDE, m_ProfAideLeave
	waitmovement 0x0
	applymovement PLAYER, m_PlayerStepUp
	waitmovement 0x0
	msgbox gText_AerilonHills_AlmondObservatory_Prof_02, MSG_KEEPOPEN
	closeonkeypress
	applymovement PROF, m_ProfStepUpAndLeave
	waitmovement 0x0
	sound 0x9
	applymovement PROF, m_SetInvisible
	waitmovement 0x0
	applymovement PLAYER, m_PlayerStepUpAndLeave
	waitmovement 0x0
	applymovement PLAYER, m_SetInvisible
	waitmovement 0x0
	clearflag 0x1FF @Person ID of Prof Aide in Aerilon Town
	clearflag 0x200 @Person ID of Prof Aide in Aerilon Hills
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_PROFESSOR
	warp 0xF 0x1 0x1 0x0 0x0
	release
	end

m_MoveTowardsProfessor: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_ProfStepOnSpot: .byte pause_short, pause_short, walk_down_onspot, pause_short, pause_short, pause_short, end_m
m_ProfAideLeave: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, pause_short, pause_short, end_m
m_PlayerStepUp: .byte walk_up, pause_short, pause_short, pause_short, end_m
m_ProfStepUpAndLeave: .byte walk_up, walk_up, walk_up, walk_up, end_m
m_PlayerStepUpAndLeave: .byte walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_SetInvisible: .byte pause_short, set_invisible, end_m

MapEntryScript_AerilonHills_AlmondObservatory:
	compare VAR_MAIN_STORY, MAIN_STORY_GOING_TO_PROFESSOR
	if equal _call MapEntryScript_AerilonHills_AlmondObservatory_FirstTimeEntering
	end
	
MapEntryScript_AerilonHills_AlmondObservatory_FirstTimeEntering:
	spriteface PROF_AIDE, UP
	movesprite2 PROF_AIDE, 0xA 0xD
	playsong2 0x12E
	return
