.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_WestrayVillage_BoyThatGivesHint
NPCScript_WestrayVillage_BoyThatGivesHint:
	checkflag 0x230 @Checks whether [player] talked with Joe or not
	if notequal _goto PlayerHasNotMetJoe
	lock
	faceplayer
	msgbox gText_WestrayVillage_BoyGivesHint, MSG_KEEPOPEN
	closeonkeypress
	release
	end

PlayerHasNotMetJoe:
	lock
	faceplayer
	msgbox gText_WestrayVillage_BoyTalksAboutSomethingStupid, MSG_KEEPOPEN
	closeonkeypress
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_WestrayVillage_ItemObtainEther
NPCScript_WestrayVillage_ItemObtainEther:
	giveitem 0x22 0x1, MSG_FIND
	call SetItemFlag_ItemObtainEther
	end

SetItemFlag_ItemObtainEther:
	setflag 0x166 @Person ID of Ether in A-Map
	return

#Sign scripts:
.global SignScript_WestrayVillage_AppleStand
SignScript_WestrayVillage_AppleStand:
	lock
	applymovement 0xA m_AppleDudeLookingDownOnTheInsignificantPlayerAsIfThePlayerDoesNotMatter @Apple stand man ID in A-Map
	waitmovement 0x0
	msgbox gText_WestrayVillage_AppleStandMan_01, MSG_YESNO
	compare LASTRESULT, 0x1
	if equal _goto PlayerWantsApple
	msgbox gText_WestrayVillage_AppleStandMan_02, MSG_KEEPOPEN
	closeonkeypress
	release
	end

PlayerWantsApple:
	checkmoney 0x14 0x0
	compare LASTRESULT, 0x1
	if greaterorequal _goto PlayerGetsAppleYay
	msgbox gText_WestrayVillage_AppleStandMan_03, MSG_KEEPOPEN
	closeonkeypress
	release
	end

PlayerGetsAppleYay:
	fanfare 0x10D
	msgbox gText_WestrayVillage_PlayerGetsAppleYay, MSG_KEEPOPEN
	waitfanfare
	closeonkeypress
	msgbox gText_WestrayVillage_AppleStandMan_04, MSG_KEEPOPEN
	closeonkeypress
	removemoney 0x14 0x0
	release
	end

m_AppleDudeLookingDownOnTheInsignificantPlayerAsIfThePlayerDoesNotMatter: .byte look_down, end_m

@;////////////////////////////////////////////////

.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_PLAYER_FOUND_WESTRAY_CATACOMBS, 0xB

.global SignScript_WestrayVillage_HiddenEntrance
SignScript_WestrayVillage_HiddenEntrance:
	lock
	compare VAR_MAIN_STORY, MAIN_STORY_PLAYER_FOUND_WESTRAY_CATACOMBS
	if equal _goto PlayerHasAlreadyFoundWestrayCatacombs
	checkflag 0x230
	if equal _goto PlayerFindsWestrayCatacombs
	msgbox gText_WestrayVillage_SuspiciousGrassPatch, MSG_KEEPOPEN
	closeonkeypress
	release
	end

PlayerHasAlreadyFoundWestrayCatacombs:
	lock
	msgbox gText_WestrayVillage_LaddersLeadToCatacombs, MSG_KEEPOPEN
	closeonkeypress
	release
	end

PlayerFindsWestrayCatacombs:
	lock
	msgbox gText_WestrayVillage_PlayerFindingCatacombs, MSG_KEEPOPEN
	closeonkeypress
	checksound
	sound 0x7C
	setmaptile 0x34 0x20 0x340 0x0
	special 0x8E
	pause 0x1E
	checksound
	sound 0x15
	applymovement PLAYER, m_Surprised
	waitmovement 0x0
	fanfare 0x10C
	msgbox gText_WestrayVillage_PlayerFoundCatacombs, MSG_KEEPOPEN
	waitfanfare
	closeonkeypress
	setvar VAR_MAIN_STORY, MAIN_STORY_PLAYER_FOUND_WESTRAY_CATACOMBS
	release
	end

m_Surprised: .byte exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, end_m
	
#Level scripts:
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_PLAYER_FOUND_WESTRAY_CATACOMBS, 0xB

.global gMapScripts_WestrayVillage
gMapScripts_WestrayVillage:
	mapscript MAP_SCRIPT_ON_LOAD SetMapTileScript_WestrayVillage
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_WestrayVillage
	.byte MAP_SCRIPT_TERMIN

SetMapTileScript_WestrayVillage:
	compare VAR_MAIN_STORY, MAIN_STORY_PLAYER_FOUND_WESTRAY_CATACOMBS
	if lessthan _call SetMapTileScript_WestrayVillage_WestrayCatacombsNotOpened
	end

SetMapTileScript_WestrayVillage_WestrayCatacombsNotOpened:
	setmaptile 0x34 0x20 0x280 0x0
	return

MapEntryScript_WestrayVillage:
	setworldmapflag 0x893
	end
