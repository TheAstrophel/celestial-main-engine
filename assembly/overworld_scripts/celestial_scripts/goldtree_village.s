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
