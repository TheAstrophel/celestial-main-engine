.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_GoldtreeMeadows_TreeCutter
NPCScript_GoldtreeMeadows_TreeCutter:
	msgbox gText_GoldtreeMeadows_TreeCutter_CurrentlyCuttingWoods, MSG_FACE
	applymovement LASTTALKED, m_FaceDefault
	end

m_FaceDefault: .byte face_default, end_m

#Tile scripts:
.global TileScript_GoldtreeMeadows_BattleToStopPlayer
TileScript_GoldtreeMeadows_BattleToStopPlayer:
	lock
	playsong 0x129 0x0
	getplayerpos 0x51FE, 0x51FF
	compare 0x51FF, 0x1C
	if equal _goto OtherGirlAttacks
	compare 0x51FF, 0x1D
	if equal _goto OtherGirlAttacks
	msgbox gText_GoldtreeMeadows_BattleToStopPlayer_GirlTowardsLeft_01, MSG_KEEPOPEN
	closeonkeypress
	checksound
	sound 0xA
	applymovement 0x4, m_JumpTowardsMeowth
	waitmovement 0x0
	checksound
	sound 0x5C
	checksound
	sound 0xA
	applymovement 0x4, m_JumpAwayFromMeowth
	waitmovement 0x0
	pause 0xE
	spriteface 0x3, LEFT
	msgbox gText_GoldtreeMeadows_BattleToStopPlayer_BothGirls, MSG_KEEPOPEN
	closeonkeypress
	spriteface 0x3, DOWN
	fadedefault
	applymovement PLAYER, m_StepLeft
	waitmovement 0x0
	setvar 0x51FE, 0x0
	setvar 0x51FF, 0x0
	release
	end

OtherGirlAttacks:
	msgbox gText_GoldtreeMeadows_BattleToStopPlayer_GirlTowardsRight_01, MSG_KEEPOPEN
	closeonkeypress
	checksound
	sound 0xA
	applymovement 0x5, m_JumpTowardsPikachu
	waitmovement 0x0
	checksound
	sound 0x5C
	applymovement 0x5, m_WalkAwayFromPikachu
	waitmovement 0x0
	pause 0xE
	spriteface 0x6, LEFT
	msgbox gText_GoldtreeMeadows_BattleToStopPlayer_BothGirls, MSG_KEEPOPEN
	closeonkeypress
	spriteface 0x6, UP
	fadedefault
	applymovement PLAYER, m_StepLeft
	waitmovement 0x0
	setvar 0x51FE, 0x0
	setvar 0x51FF, 0x0
	release
	end

m_JumpTowardsMeowth: .byte jump_down, end_m
m_JumpAwayFromMeowth: .byte jump_up, look_down, end_m
m_JumpTowardsPikachu: .byte jump_up, end_m
m_WalkAwayFromPikachu: .byte walk_down, look_up, end_m
m_StepLeft: .byte walk_left_very_slow, end_m
