.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#Tile scripts:

.global TileScript_GoldtreeMeadows_BattleToStopPlayer
TileScript_GoldtreeMeadows_BattleToStopPlayer:
	lock
	playsong 0x129 0x0
	getplayerpos 0x51FE, 0x51FF
	compare 0x51FE, 0x11
	if equal _goto OtherGirlAttacks
	compare 0x51FE, 0x12
	if equal _goto OtherGirlAttacks
	msgbox gText_GoldtreeMeadows_BattleToStopPlayer_GirlTowardsLeft_01, MSG_KEEPOPEN
	closeonkeypress
	checksound
	sound 0xA
	applymovement 0x2, m_JumpTowardsMeowth
	waitmovement 0x0
	checksound
	sound 0x5C
	checksound
	sound 0xA
	applymovement 0x2, m_JumpAwayFromMeowth
	waitmovement 0x0
	pause 0xE
	spriteface 0x1, DOWN
	msgbox gText_GoldtreeMeadows_BattleToStopPlayer_BothGirls, MSG_KEEPOPEN
	closeonkeypress
	spriteface 0x1, RIGHT
	fadedefault
	applymovement PLAYER, m_StepDown
	waitmovement 0x0
	release
	end

OtherGirlAttacks:
	msgbox gText_GoldtreeMeadows_BattleToStopPlayer_GirlTowardsRight_01, MSG_KEEPOPEN
	closeonkeypress
	checksound
	sound 0xA
	applymovement 0x3, m_JumpTowardsPikachu
	waitmovement 0x0
	checksound
	sound 0x5C
	applymovement 0x3, m_WalkAwayFromPikachu
	waitmovement 0x0
	pause 0xE
	spriteface 0x4, DOWN
	msgbox gText_GoldtreeMeadows_BattleToStopPlayer_BothGirls, MSG_KEEPOPEN
	closeonkeypress
	spriteface 0x4, LEFT
	fadedefault
	applymovement PLAYER, m_StepDown
	waitmovement 0x0
	release
	end

m_JumpTowardsMeowth: .byte jump_right, end_m
m_JumpAwayFromMeowth: .byte jump_left, look_right, end_m
m_JumpTowardsPikachu: .byte jump_left, end_m
m_WalkAwayFromPikachu: .byte walk_right, look_left, end_m
m_StepDown: .byte walk_down_very_slow, end_m
