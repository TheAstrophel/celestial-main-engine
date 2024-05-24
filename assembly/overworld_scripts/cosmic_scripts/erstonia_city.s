.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_ErstoniaCity_GymCaretaker
NPCScript_ErstoniaCity_GymCaretaker:
	lock
	faceplayer
	msgboxname gText_ErstoniaCity_GymCaretaker_01 MSG_KEEPOPEN gText_Caretaker
	closeonkeypress
	spriteface 0x8, DOWN @0x8 is Gym Caretaker
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCity_Machop
NPCScript_ErstoniaCity_Machop:
	lock
	faceplayer
	checksound
	cry 0x42 0x0
	msgbox gText_ErstoniaCity_Machop_Cry, MSG_KEEPOPEN
	waitcry
	closeonkeypress
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCity_Meowth
NPCScript_ErstoniaCity_Meowth:
	lock
	faceplayer
	checkflag 0xB0 @Set when Oran Berry has been received
	if notequal _goto ReceiveGiftFromMeowth
	checksound
	cry 0x34 0x0
	msgbox gText_ErstoniaCity_Meowth_Cry, MSG_KEEPOPEN
	waitcry
	closeonkeypress
	release
	end

ReceiveGiftFromMeowth:
	checksound
	cry 0x34 0x0
	msgbox gText_ErstoniaCity_Meowth_GivingGift, MSG_KEEPOPEN
	waitcry
	giveitem 0x8B 0x1, MSG_OBTAIN
	setflag 0xB0 @Flag to not obtain Oran Berry again
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCity_ItemObtainRareCandy
NPCScript_ErstoniaCity_ItemObtainRareCandy:
	giveitem 0x44 0x1, MSG_FIND
	call SetItemFlag_ItemObtainRareCandy
	end

SetItemFlag_ItemObtainRareCandy:
	setflag 0x158 @Person ID of Rare Candy in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCity_ItemObtainTM27
NPCScript_ErstoniaCity_ItemObtainTM27:
	giveitem 0x13B 0x1, MSG_FIND
	call SetItemFlag_ItemObtainTM27
	end

SetItemFlag_ItemObtainTM27:
	setflag 0x159 @Person ID of TM27 (Return) in A-Map
	return

#Level scripts:
.global gMapScripts_ErstoniaCity
gMapScripts_ErstoniaCity:
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_ErstoniaCity
	.byte MAP_SCRIPT_TERMIN

MapEntryScript_ErstoniaCity:
	setworldmapflag 0x892
	end

#@@@@@@@@;Sub-maps;@@@@@@@@
#Tile scripts:

.equ MAYOR, 1

.global TileScript_ErstoniaCity_HouseOfMayor_PlayerTriesToEnterRoomOfLandre
TileScript_ErstoniaCity_HouseOfMayor_PlayerTriesToEnterRoomOfLandre:
	lock
	checksound
	sound 0x15
	applymovement MAYOR, m_MayorExclaim
	waitmovement 0x0
	pause 0x1E
	msgbox gText_ErstoniaCity_HouseOfMayor_Mayor_01, MSG_KEEPOPEN
	closeonkeypress
	applymovement PLAYER, m_StepAwayFromRoom
	waitmovement 0x0
	spriteface MAYOR, LEFT
	release
	end

m_MayorExclaim: .byte look_right, exclaim, end_m
m_StepAwayFromRoom: .byte walk_left_slow, end_m

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCity_Gym_Landre
NPCScript_ErstoniaCity_Gym_Landre:
setvar 0x8004 0x2
setvar 0x8005 0x2
special 0x174
trainerbattle1 0x1 0x19E 0x0 LandreChallenges LandreLoses LandreTechnicalScript
checkflag 0x254
if 0x0 _goto LandreGivesTM
msgboxname gText_ErstoniaCity_Gym_Landre_EndingWalaEnd, MSG_KEEPOPEN, gText_LandreName
release
end

LandreTechnicalScript:
setvar 0x8004 0x2
setvar 0x8005 0x1
special 0x173
setflag 0x4B0
setflag 0x820
setvar 0x406C 0x1
setflag 0x2E
clearflag 0x92
setvar 0x8008 0x1
call TechnicalShit
goto LandreGivesTM

LandreGivesTM:
msgboxname gText_ErstoniaCity_Gym_Landre_CallsForTM, MSG_KEEPOPEN, gText_LandreName
checkitemspace 0x147 0x1
compare LASTRESULT 0x0
if 0x1 _goto NoRoom
giveitem 0x147 0x1, MSG_OBTAIN
setflag 0x254
msgboxname gText_ErstoniaCity_Gym_Landre_ExplainsTM, MSG_KEEPOPEN, gText_LandreName
release
end

TechnicalShit:
copyvar 0x8000 0x8008
compare 0x8000 0x1
if 0x1 _goto TrainerFlagsOne
compare 0x8000 0x2
if 0x1 _goto TrainerFlagsTwo
compare 0x8000 0x3
if 0x1 _goto TrainerFlagsThree
compare 0x8000 0x4
if 0x1 _goto TrainerFlagsFour
compare 0x8000 0x5
if 0x1 _goto TrainerFlagsFive
compare 0x8000 0x6
if 0x1 _goto TrainerFlagsSix
compare 0x8000 0x7
if 0x1 _goto TrainerFlagsSeven
compare 0x8000 0x8
if 0x1 _goto TrainerFlagsEight
end

NoRoom:
msgbox gText_NoRoomFool, MSG_KEEPOPEN
release
end

TrainerFlagsOne:
cleartrainerflag 0x8E
return

TrainerFlagsTwo:
cleartrainerflag 0x96
cleartrainerflag 0xEA
return

TrainerFlagsThree:
cleartrainerflag 0x8D
cleartrainerflag 0xDC
cleartrainerflag 0x1A7
return

TrainerFlagsFour:
cleartrainerflag 0x84
cleartrainerflag 0x85
cleartrainerflag 0xA0
cleartrainerflag 0x109
cleartrainerflag 0x10A
cleartrainerflag 0x10B
cleartrainerflag 0x192
return

TrainerFlagsFive:
cleartrainerflag 0x126
cleartrainerflag 0x127
cleartrainerflag 0x120
cleartrainerflag 0x121
cleartrainerflag 0x124
cleartrainerflag 0x125
return

TrainerFlagsSix:
cleartrainerflag 0x118
cleartrainerflag 0x119
cleartrainerflag 0x11A
cleartrainerflag 0x11B
cleartrainerflag 0x1CE
cleartrainerflag 0x1CF
cleartrainerflag 0x1D0
return

TrainerFlagsSeven:
cleartrainerflag 0xB1
cleartrainerflag 0xB2
cleartrainerflag 0xB3
cleartrainerflag 0xB4
cleartrainerflag 0xD5
cleartrainerflag 0xD6
cleartrainerflag 0xD7
return

TrainerFlagsEight:
cleartrainerflag 0x128
cleartrainerflag 0x129
cleartrainerflag 0x142
cleartrainerflag 0x143
cleartrainerflag 0x144
cleartrainerflag 0x188
cleartrainerflag 0x190
cleartrainerflag 0x191
return
