.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_WestrayPass_GuardThatBlocksAccess
NPCScript_WestrayPass_GuardThatBlocksAccess:
	lock
	faceplayer
	msgboxname gText_WestrayPass_Guard_01, MSG_KEEPOPEN, gText_OfficerName
	closeonkeypress
	spriteface LASTTALKED, DOWN
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_WestrayPass_ItemObtainHealBall
NPCScript_WestrayPass_ItemObtainHealBall:
	giveitem 0xF1 0x1, MSG_FIND
	call SetItemFlag_ItemObtainHealBall
	end

SetItemFlag_ItemObtainHealBall:
	setflag 0x164 @Person ID of Heal Ball in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_WestrayPass_ItemObtainTM28
NPCScript_WestrayPass_ItemObtainTM28:
	giveitem 0x13C 0x1, MSG_FIND
	call SetItemFlag_ItemObtainTM28
	end

SetItemFlag_ItemObtainTM28:
	setflag 0x165 @Person ID of TM28 (Dig) in A-Map
	return

#Tile scripts:
.equ GUARD, 0x1
.equ VAR_GUARD_BLOCKS_WESTRAY_Pass, 0x402D
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF

.global TileScript_WestrayPass_GuardThatBlocksAccess
TileScript_WestrayPass_GuardThatBlocksAccess:
	lock
	checksound
	sound 0x15
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_2, 0x49 @Y-Pos equals 0x49
	if equal _call ApproachPlayerWhenScriptNumberZero
	compare VAR_TEMP_2, 0x4A @Y-Pos equals 0x4A
	if equal _call ApproachPlayerWhenScriptNumberOne
	compare VAR_TEMP_2, 0x4B @Y-Pos equals 0x4B
	if equal _call ApproachPlayerWhenScriptNumberTwo
	spriteface PLAYER, UP
	msgboxname gText_WestrayPass_GuardWarnsPlayer, MSG_KEEPOPEN, gText_OfficerName
	closeonkeypress
	applymovement PLAYER, m_WalkLeftSlowly
	waitmovement 0x0
	compare VAR_TEMP_2, 0x4A @Y-Pos equals 0x4A
	if equal _call LeavePlayerWhenScriptNumberOne
	compare VAR_TEMP_2, 0x4B @Y-Pos equals 0x4B
	if equal _call LeavePlayerWhenScriptNumberTwo
	spriteface GUARD, DOWN
	release
	end

ApproachPlayerWhenScriptNumberZero:
	applymovement GUARD, m_ExclaimAndMoveTowardsPlayerWhenScriptNumberZero
	waitmovement 0x0
	return

ApproachPlayerWhenScriptNumberOne:
	applymovement GUARD, m_ExclaimAndMoveTowardsPlayerWhenScriptNumberOne
	waitmovement 0x0
	return

ApproachPlayerWhenScriptNumberTwo:
	applymovement GUARD, m_ExclaimAndMoveTowardsPlayerWhenScriptNumberTwo
	waitmovement 0x0
	return

LeavePlayerWhenScriptNumberOne:
	applymovement GUARD, m_StepAwayFromPlayerWhenScriptNumberOne
	waitmovement 0x0
	return

LeavePlayerWhenScriptNumberTwo:
	applymovement GUARD, m_StepAwayFromPlayerWhenScriptNumberTwo
	waitmovement 0x0
	return

m_WalkLeftSlowly: .byte walk_left_very_slow, end_m
m_ExclaimAndMoveTowardsPlayerWhenScriptNumberZero: .byte look_down, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, end_m
m_ExclaimAndMoveTowardsPlayerWhenScriptNumberOne: .byte look_down, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, walk_down, end_m
m_ExclaimAndMoveTowardsPlayerWhenScriptNumberTwo: .byte look_down, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, walk_down, walk_down, end_m
m_StepAwayFromPlayerWhenScriptNumberOne: .byte walk_up, end_m
m_StepAwayFromPlayerWhenScriptNumberTwo: .byte walk_up, walk_up, end_m
