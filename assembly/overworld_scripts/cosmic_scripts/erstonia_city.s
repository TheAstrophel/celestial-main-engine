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
