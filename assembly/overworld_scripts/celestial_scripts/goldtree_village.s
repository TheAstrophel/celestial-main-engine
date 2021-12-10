.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.equ RIVAL, 1
.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_ENTERED_PKMNCENTER_IN_GOLDTREE, 0x7

.global NPCScript_GoldtreeVillage_Rival
NPCScript_GoldtreeVillage_Rival:
	lock
	faceplayer
	msgbox gText_GoldtreeVillage_Rival_01, MSG_KEEPOPEN
	closeonkeypress
	spriteface RIVAL, UP
	opendoor 0x9 0x9
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

#@@@@@@@@;Sub-maps;@@@@@@@@
#Level scripts:
.equ RIVAL, 2
.equ FATHER_OF_RIVAL, 3
.equ PROF_ALMOND, 7
.equ VAR_MAIN_STORY, 0x4011
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
	

MapEntryScript_GoldtreeVillage_PKMNCenter:
	sethealingplace 0x2
	compare VAR_MAIN_STORY, MAIN_STORY_ENTERED_PKMNCENTER_IN_GOLDTREE
	if equal _call MapEntryScript_GoldtreeVillage_PKMNCenter_FirstTimeEntering
	end
	
MapEntryScript_GoldtreeVillage_PKMNCenter_FirstTimeEntering:
	showsprite RIVAL
	clearflag 0x1FF @Person ID Rival in A-Map
	return
