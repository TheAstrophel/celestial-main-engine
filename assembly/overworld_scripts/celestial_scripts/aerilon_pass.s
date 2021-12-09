.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.equ RIVAL, 2
.equ VAR_MAIN_STORY, 0x4011
.equ VAR_STARTER_MON, 0x51F0
.equ MAIN_STORY_MET_RIVAL_IN_AERILON_PASS, 0x7

.global NPCScript_AerilonPass_Rival
NPCScript_AerilonPass_Rival:
	lock
	faceplayer
	msgbox gText_AerilonPass_Rival_01, MSG_KEEPOPEN
	closeonkeypress
	compare VAR_STARTER_MON, 0x1
	if equal _call RivalBattleWhenPlayerHasTreecko
	compare VAR_STARTER_MON, 0x2
	if equal _call RivalBattleWhenPlayerHasTorchic
	compare VAR_STARTER_MON, 0x3
	if equal _call RivalBattleWhenPlayerHasMudkip
	msgbox gText_AerilonPass_Rival_02, MSG_KEEPOPEN
	closeonkeypress
	applymovement RIVAL, m_RivalLeaves
	waitmovement 0x0
	hidesprite RIVAL
	setvar VAR_MAIN_STORY, MAIN_STORY_MET_RIVAL_IN_AERILON_PASS
	setflag 0x201 @Person ID of Rival in A-Map
	pause 0x1E
	release
	end

RivalBattleWhenPlayerHasTreecko:
	trainerbattle3 0x3 0x149 0x0 RivalLoses
	return

RivalBattleWhenPlayerHasTorchic:
	trainerbattle3 0x3 0x14A 0x0 RivalLoses
	return

RivalBattleWhenPlayerHasMudkip:
	trainerbattle3 0x3 0x14B 0x0 RivalLoses
	return

m_RivalLeaves: .byte walk_right, walk_right, walk_right, walk_down, walk_down, walk_down, walk_down, walk_down, walk_down, walk_down, end_m

@;////////////////////////////////////////////////

.global NPCScript_AerilonPass_ItemObtainPotion
NPCScript_AerilonPass_ItemObtainPotion:
	giveitem 0xD 0x1, MSG_FIND
	call SetItemFlag
	end

SetItemFlag:
	setflag 0x154 @Person ID of Potion in A-Map
	return

#Tile scripts:
.equ RIVAL, 2
.equ VAR_MAIN_STORY, 0x4011
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ VAR_STARTER_MON, 0x51F0
.equ MAIN_STORY_MET_RIVAL_IN_AERILON_PASS, 0x7

.global TileScript_AerilonPass_Rival
TileScript_AerilonPass_Rival:
	lock
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_2, 0xB @Y-Pos equals 0xB
	if equal _call PlayerStepsOnScriptNumberZero
	compare VAR_TEMP_2, 0xD @Y-Pos equals 0xD
	if equal _call PlayerStepsOnScriptNumberOne
	msgbox gText_AerilonPass_Rival_01, MSG_KEEPOPEN
	closeonkeypress
	compare VAR_STARTER_MON, 0x1
	if equal _call TileScriptRivalBattleWhenPlayerHasTreecko
	compare VAR_STARTER_MON, 0x2
	if equal _call TileScriptRivalBattleWhenPlayerHasTorchic
	compare VAR_STARTER_MON, 0x3
	if equal _call TileScriptRivalBattleWhenPlayerHasMudkip
	msgbox gText_AerilonPass_Rival_02, MSG_KEEPOPEN
	closeonkeypress
	applymovement RIVAL, m_RivalLeaves
	waitmovement 0x0
	hidesprite RIVAL
	setvar VAR_MAIN_STORY, MAIN_STORY_MET_RIVAL_IN_AERILON_PASS
	setflag 0x201 @Person ID of Rival in A-Map
	pause 0x1E
	release
	end

PlayerStepsOnScriptNumberZero:
	checksound
	sound 0x15
	applymovement RIVAL, m_LookUpExclaim
	waitmovement 0x0
	pause 0x2E
	spriteface PLAYER, DOWN
	return

m_LookUpExclaim: .byte look_up, exclaim, end_m

PlayerStepsOnScriptNumberOne:
	checksound
	sound 0x15
	applymovement RIVAL, m_LookDownExclaim
	waitmovement 0x0
	pause 0x2E
	spriteface PLAYER, UP
	return

m_LookDownExclaim: .byte look_down, exclaim, end_m

TileScriptRivalBattleWhenPlayerHasTreecko:
	trainerbattle3 0x3 0x149 0x0 RivalLoses
	return

TileScriptRivalBattleWhenPlayerHasTorchic:
	trainerbattle3 0x3 0x14A 0x0 RivalLoses
	return

TileScriptRivalBattleWhenPlayerHasMudkip:
	trainerbattle3 0x3 0x14B 0x0 RivalLoses
	return
