.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.equ RIVAL, 1
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_ENTERED_PKMNCENTER_IN_GOLDTREE, 0x7

.global NPCScript_GoldtreeVillage_Rival
NPCScript_GoldtreeVillage_Rival:
	lock
	faceplayer
	msgboxname gText_GoldtreeVillage_Rival_01, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	spriteface RIVAL, UP
	opendoor 0xC 0x5
	waitdooranim
	applymovement RIVAL, m_RivalEntersPKMNCenter
	waitmovement 0x0
	compare PLAYERFACING, RIGHT
	if equal _call PlayerLookingRight
	compare PLAYERFACING, UP
	if equal _call PlayerLookingUp
	compare PLAYERFACING, LEFT
	if equal _call PlayerLookingLeft
	setvar VAR_MAIN_STORY, MAIN_STORY_ENTERED_PKMNCENTER_IN_GOLDTREE
	hidesprite RIVAL
	setflag 0x202 @Person ID of Rival in A-Map
	warp 0x5 0x3 0x0 0x9 0x9
	waitstate
	release
	end

PlayerLookingRight:
	applymovement PLAYER, m_PlayerStepsRightAndEnters
	waitmovement 0x0
	return

PlayerLookingUp:
	applymovement PLAYER, m_PlayerStepsUpAndEnters
	waitmovement 0x0
	return

PlayerLookingLeft:
	applymovement PLAYER, m_PlayerStepsLeftAndEnters
	waitmovement 0x0
	return

m_RivalEntersPKMNCenter: .byte walk_up, set_invisible, end_m
m_PlayerStepsRightAndEnters: .byte walk_right, walk_up, set_invisible, end_m
m_PlayerStepsUpAndEnters: .byte walk_up, walk_up, set_invisible, end_m
m_PlayerStepsLeftAndEnters: .byte walk_left, walk_up, set_invisible, end_m

#Level scripts:
.global gMapScripts_GoldtreeVillage
gMapScripts_GoldtreeVillage:
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_GoldtreeVillage
	.byte MAP_SCRIPT_TERMIN

MapEntryScript_GoldtreeVillage:
	setworldmapflag 0x891
	end

#@@@@@@@@;Sub-maps;@@@@@@@@
#NPC scripts:
.global GoldtreeVillage_PKMNCenter_FatherOfRival
GoldtreeVillage_PKMNCenter_FatherOfRival:
	lock
	faceplayer
	msgboxname gText_GoldtreeVillage_PKMNCenter_FatherOfRival, MSG_KEEPOPEN, gText_RivalFatherName
	closeonkeypress
	spriteface 0x3, UP
	release
	end

#Level scripts:
.equ RIVAL, 2
.equ FATHER_OF_RIVAL, 3
.equ PROF_ALMOND, 7
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_ENTERED_PKMNCENTER_IN_GOLDTREE, 0x7
.equ MAIN_STORY_MEETING_COMPLETED_IN_GOLDTREE_PKMNCENTER, 0x8

.global gMapScripts_GoldtreeVillage_PKMNCenter
gMapScripts_GoldtreeVillage_PKMNCenter:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_GoldtreeVillage_PKMNCenter
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_GoldtreeVillage_PKMNCenter
	.byte MAP_SCRIPT_TERMIN

LevelScripts_GoldtreeVillage_PKMNCenter:
	levelscript VAR_MAIN_STORY, MAIN_STORY_ENTERED_PKMNCENTER_IN_GOLDTREE, LevelScript_GoldtreeVillage_PKMNCenter
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_GoldtreeVillage_PKMNCenter:
	lock
	applymovement RIVAL, m_RivalWalkTowardsFatherOfRival
	applymovement PLAYER, m_PlayerWalkTowardsFatherOfRival
	waitmovement 0x0
	msgboxname gText_GoldtreeVillage_PKMNCenter_Rival_01, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	checksound
	sound 0x15
	applymovement FATHER_OF_RIVAL, m_Exclaim
	waitmovement 0x0
	msgboxname gText_GoldtreeVillage_PKMNCenter_FatherOfRival_01, MSG_KEEPOPEN, gText_RivalFatherName
	closeonkeypress
	applymovement PLAYER, m_ApproachFatherOfRival
	waitmovement 0x0
	spriteface FATHER_OF_RIVAL, DOWN
	msgboxname gText_GoldtreeVillage_PKMNCenter_FatherOfRival_02, MSG_KEEPOPEN, gText_RivalFatherName
	closeonkeypress
	fanfare 0x105
	preparemsg gText_GoldtreeVillage_PKMNCenter_PlayerDeliversParcel
	waitmsg
	waitfanfare
	removeitem 0x15D 0x1
	msgboxname gText_GoldtreeVillage_PKMNCenter_FatherOfRival_03, MSG_KEEPOPEN, gText_RivalFatherName
	closeonkeypress
	pause 0x40
	checksound
	sound 0x15
	applymovement FATHER_OF_RIVAL, m_QuestionMark
	waitmovement 0x0
	msgboxname gText_GoldtreeVillage_PKMNCenter_FatherOfRival_04, MSG_KEEPOPEN, gText_RivalFatherName
	closeonkeypress
	showsprite PROF_ALMOND
	spriteface PROF_ALMOND, UP
	clearflag 0x200 @Person ID of Professor Almond in A-Map
	checksound
	sound 0x9
	pause 0x3E
	spriteface PROF_ALMOND, RIGHT
	checksound
	sound 0x15
	applymovement PROF_ALMOND, m_NoticesPlayerAndExclaims
	waitmovement 0x0
	spriteface RIVAL, DOWN
	spriteface FATHER_OF_RIVAL, LEFT
	spriteface PLAYER, LEFT
	msgboxname gText_GoldtreeVillage_PKMNCenter_ProfAlmond_01, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	pause 0x2C
	msgboxname gText_GoldtreeVillage_PKMNCenter_FatherOfRival_05, MSG_KEEPOPEN, gText_RivalFatherName
	closeonkeypress
	msgboxname gText_GoldtreeVillage_PKMNCenter_ProfAlmond_02, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	spriteface RIVAL, DOWN
	msgboxname gText_GoldtreeVillage_PKMNCenter_Rival_02, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	spriteface PROF_ALMOND, LEFT
	applymovement RIVAL, m_LeavesPKMNCenter
	waitmovement 0x0
	checksound
	sound 0x9
	hidesprite RIVAL
	pause 0x20
	msgboxname gText_GoldtreeVillage_PKMNCenter_ProfAlmond_03, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	spriteface PROF_ALMOND, RIGHT
	msgboxname gText_GoldtreeVillage_PKMNCenter_FatherOfRival_06, MSG_KEEPOPEN, gText_RivalFatherName
	closeonkeypress
	msgboxname gText_GoldtreeVillage_PKMNCenter_ProfAlmond_04, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	fanfare 0x13E
	preparemsg gText_GoldtreeVillage_PKMNCenter_PlayerReceivesDex
	waitmsg
	waitfanfare
	setflag 0x829
	special 0x181
	msgboxname gText_GoldtreeVillage_PKMNCenter_ProfAlmond_05, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	fanfare 0x101
	obtainitem 0x4 0x5
	waitfanfare
	msgboxname gText_GoldtreeVillage_PKMNCenter_ProfAlmond_06, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	setvar 0x8004 0x0
	setvar 0x8005 0x1
	special 0x173
	applymovement PROF_ALMOND, m_ExitsPKMNCenter
	waitmovement 0x0
	checksound
	sound 0x9
	hidesprite PROF_ALMOND
	pause 0x20
	spriteface FATHER_OF_RIVAL, DOWN
	spriteface PLAYER, UP
	msgboxname gText_GoldtreeVillage_PKMNCenter_FatherOfRival_07, MSG_KEEPOPEN, gText_RivalFatherName
	closeonkeypress
	spriteface FATHER_OF_RIVAL, UP
	setflag 0x1FF @Person ID of Rival in A-Map
	setflag 0x200 @Person ID of Professor Almond in A-Map
	setvar VAR_MAIN_STORY, MAIN_STORY_MEETING_COMPLETED_IN_GOLDTREE_PKMNCENTER
	release
	end

m_RivalWalkTowardsFatherOfRival: .byte walk_up, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, end_m
m_PlayerWalkTowardsFatherOfRival: .byte walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_right, end_m
m_Exclaim: .byte exclaim, look_left, pause_long, pause_long, end_m
m_ApproachFatherOfRival: .byte walk_down, walk_right, walk_right, look_up, end_m
m_QuestionMark: .byte say_question, pause_short, pause_short, end_m
m_NoticesPlayerAndExclaims: .byte exclaim, pause_long, pause_long, pause_long, pause_long, walk_right, walk_up, walk_up, walk_right, walk_right, walk_right, walk_right, end_m
m_LeavesPKMNCenter: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_down, walk_down, walk_down, pause_long, walk_down_onspot, end_m
m_ExitsPKMNCenter: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_down, walk_down, pause_long, walk_down_onspot, end_m

MapEntryScript_GoldtreeVillage_PKMNCenter:
	sethealingplace 0x2
	compare VAR_MAIN_STORY, MAIN_STORY_ENTERED_PKMNCENTER_IN_GOLDTREE
	if equal _call MapEntryScript_GoldtreeVillage_PKMNCenter_FirstTimeEntering
	end
	
MapEntryScript_GoldtreeVillage_PKMNCenter_FirstTimeEntering:
	showsprite RIVAL
	clearflag 0x1FF @Person ID Rival in A-Map
	return
