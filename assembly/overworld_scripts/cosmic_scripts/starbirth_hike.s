.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.equ RIVAL, 2
.equ VAR_MAIN_STORY, 0x4029
.equ VAR_PRE_BATTLE_MUGSHOT_STYLE, 0x503A
.equ VAR_PRE_BATTLE_MUGSHOT_SPRITE, 0x503B
.equ VAR_STARTER_MON, 0x51F0
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ MAIN_STORY_MET_RIVAL_IN_Starbirth_HIKE, 0x7

.global NPCScript_StarbirthHike_Rival
NPCScript_StarbirthHike_Rival:
	lock
	faceplayer
	msgboxname gText_StarbirthHike_Rival_01, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	compare VAR_STARTER_MON, 0x1
	if equal _call RivalBattleWhenPlayerHasTreecko
	compare VAR_STARTER_MON, 0x2
	if equal _call RivalBattleWhenPlayerHasTorchic
	compare VAR_STARTER_MON, 0x3
	if equal _call RivalBattleWhenPlayerHasMudkip
	msgboxname gText_StarbirthHike_Rival_02, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_RivalLeaves
	waitmovement 0x0
	hidesprite RIVAL
	setvar VAR_MAIN_STORY, MAIN_STORY_MET_RIVAL_IN_Starbirth_HIKE
	setflag 0x2E @Person ID of Rival in A-Map
	pause 0x1E
	release
	end

RivalBattleWhenPlayerHasTreecko:
	setvar VAR_PRE_BATTLE_MUGSHOT_STYLE, 0x2
	setvar VAR_PRE_BATTLE_MUGSHOT_SPRITE, 0x0
	trainerbattle3 0x3 0x149 0x100 RivalLoses
	return

RivalBattleWhenPlayerHasTorchic:
	setvar VAR_PRE_BATTLE_MUGSHOT_STYLE, 0x2
	setvar VAR_PRE_BATTLE_MUGSHOT_SPRITE, 0x0
	trainerbattle3 0x3 0x14A 0x100 RivalLoses
	return

RivalBattleWhenPlayerHasMudkip:
	setvar VAR_PRE_BATTLE_MUGSHOT_STYLE, 0x2
	setvar VAR_PRE_BATTLE_MUGSHOT_SPRITE, 0x0
	trainerbattle3 0x3 0x14B 0x100 RivalLoses
	return

@;////////////////////////////////////////////////

.global NPCScript_StarbirthHike_ItemObtainPotion
NPCScript_StarbirthHike_ItemObtainPotion:
	giveitem 0xD 0x1, MSG_FIND
	call SetItemFlag_ItemObtainPotion
	end

SetItemFlag_ItemObtainPotion:
	setflag 0x154 @Person ID of Potion in A-Map
	return

#Tile scripts:
.equ RIVAL, 2
.equ VAR_MAIN_STORY, 0x4029
.equ VAR_PRE_BATTLE_MUGSHOT_STYLE, 0x503A
.equ VAR_PRE_BATTLE_MUGSHOT_SPRITE, 0x503B
.equ VAR_STARTER_MON, 0x51F0
.equ MAIN_STORY_MET_RIVAL_IN_Starbirth_HIKE, 0x7

.global TileScript_StarbirthHike_Rival
TileScript_StarbirthHike_Rival:
	lock
	checksound
	sound 0x15
	applymovement RIVAL, m_LookDownExclaim
	waitmovement 0x0
	pause 0x2E
	msgboxname gText_StarbirthHike_Rival_01a, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	spriteface PLAYER, UP
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_2, 0xF @Y-Pos equals 0xD
	if equal _call RivalMovesTowardsPlayerWhenScriptNumberOne
	compare VAR_TEMP_2, 0x10 @Y-Pos equals 0x10
	if equal _call RivalMovesTowardsPlayerWhenScriptNumberTwo
	msgboxname gText_StarbirthHike_Rival_01b, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	compare VAR_STARTER_MON, 0x1
	if equal _call TileScriptRivalBattleWhenPlayerHasTreecko
	compare VAR_STARTER_MON, 0x2
	if equal _call TileScriptRivalBattleWhenPlayerHasTorchic
	compare VAR_STARTER_MON, 0x3
	if equal _call TileScriptRivalBattleWhenPlayerHasMudkip
	msgboxname gText_StarbirthHike_Rival_02, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_RivalLeaves
	waitmovement 0x0
	hidesprite RIVAL
	setvar VAR_MAIN_STORY, MAIN_STORY_MET_RIVAL_IN_Starbirth_HIKE
	setflag 0x2E @Person ID of Rival in A-Map
	pause 0x1E
	release
	end
	
RivalMovesTowardsPlayerWhenScriptNumberOne:
	applymovement RIVAL, m_RivalComesWhenScriptOne
	waitmovement 0x0
	return

RivalMovesTowardsPlayerWhenScriptNumberTwo:
	applymovement RIVAL, m_RivalComesWhenScriptTwo
	waitmovement 0x0
	return

TileScriptRivalBattleWhenPlayerHasTreecko:
	setvar VAR_PRE_BATTLE_MUGSHOT_STYLE, 0x2
	setvar VAR_PRE_BATTLE_MUGSHOT_SPRITE, 0x0
	trainerbattle3 0x3 0x149 0x100 RivalLoses
	return

TileScriptRivalBattleWhenPlayerHasTorchic:
	setvar VAR_PRE_BATTLE_MUGSHOT_STYLE, 0x2
	setvar VAR_PRE_BATTLE_MUGSHOT_SPRITE, 0x0
	trainerbattle3 0x3 0x14A 0x100 RivalLoses
	return

TileScriptRivalBattleWhenPlayerHasMudkip:
	setvar VAR_PRE_BATTLE_MUGSHOT_STYLE, 0x2
	setvar VAR_PRE_BATTLE_MUGSHOT_SPRITE, 0x0
	trainerbattle3 0x3 0x14B 0x100 RivalLoses
	return

m_LookDownExclaim: .byte look_down, exclaim, end_m
m_RivalComesWhenScriptOne: .byte walk_down, end_m
m_RivalComesWhenScriptTwo: .byte walk_down, walk_down, end_m
m_RivalLeaves: .byte walk_right, walk_right, walk_right, walk_right, walk_down, walk_down, walk_down, walk_down, walk_down, walk_down, walk_down, end_m
