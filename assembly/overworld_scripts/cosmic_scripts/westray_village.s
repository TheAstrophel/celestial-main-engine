.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_WestrayVillage_BoyThatGivesHint
NPCScript_WestrayVillage_BoyThatGivesHint:
	compare 0x4029, 0xB @Checks whether [player] talked with Joe or not
	if lessthan _goto PlayerHasNotMetJoe
	lock
	faceplayer
	msgbox gText_WestrayVillage_BoyGivesHint, MSG_KEEPOPEN
	closeonkeypress
	setflag 0x232 @Sets Catacombs entrance and shi
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

@;////////////////////////////////////////////////

.global NPCScript_WestrayVillage_ItemObtainHyperPotion
NPCScript_WestrayVillage_ItemObtainHyperPotion:
	giveitem 0x15 0x1, MSG_FIND
	call SetItemFlag_ItemObtainHyperPotion
	end

SetItemFlag_ItemObtainHyperPotion:
	setflag 0x16A @Person ID of Hyper Potion in A-Map
	return

#Sign scripts:
.global SignScript_WestrayVillage_HiddenGrotto
SignScript_WestrayVillage_HiddenGrotto:
	msgbox gText_WestrayVillage_HiddenGrotto, MSG_YESNO
	compare LASTRESULT, 0x1
	if equal _goto EnterHiddenGrotto
	release
	end

EnterHiddenGrotto:
	getplayerpos 0x51FE, 0x51FF
	compare 0x51FE, 0xD @X-Pos equals 0xD
	if equal _goto LeftWarp
	compare 0x51FE, 0xE @X-Pos equals 0xE
	if equal _goto RightWarp
	end

LeftWarp:
	warp 0x7 0x9 0x0 0x0 0x0
	waitstate
	end

RightWarp:
	warp 0x7 0x9 0x1 0x0 0x0
	waitstate
	end

@;////////////////////////////////////////////////

.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_PLAYER_FOUND_WESTRAY_CATACOMBS, 0xC

.global SignScript_WestrayVillage_HiddenEntrance
SignScript_WestrayVillage_HiddenEntrance:
	lock
	compare VAR_MAIN_STORY, MAIN_STORY_PLAYER_FOUND_WESTRAY_CATACOMBS
	if greaterorequal _goto PlayerHasAlreadyFoundWestrayCatacombs
	checkflag 0x232
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

@;////////////////////////////////////////////////

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
	
#Level scripts:
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_PLAYER_FOUND_WESTRAY_CATACOMBS, 0xC

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

#@@@@@@@@;Sub-maps;@@@@@@@@
#NPC scripts:
.equ MAN, 4
.equ JOE, 5
.equ LADY, 6
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_PLAYER_DEFEATED_AVERILL_IN_WESTRAY_CATACOMBS, 0xD
.equ MAIN_STORY_PLAYER_RECEIVED_WINTER_GEAR_FROM_JOE_IN_WESTRAY_VILLAGE, 0xE

.global NPCScript_WestrayVillage_HouseOfJoe_Joe
NPCScript_WestrayVillage_HouseOfJoe_Joe:
	lock
	faceplayer
	compare VAR_MAIN_STORY, MAIN_STORY_PLAYER_DEFEATED_AVERILL_IN_WESTRAY_CATACOMBS
	if equal _goto PlayerGetsWinterGear
	compare VAR_MAIN_STORY, MAIN_STORY_PLAYER_RECEIVED_WINTER_GEAR_FROM_JOE_IN_WESTRAY_VILLAGE
	if equal _goto JoeUniversalKinda
	msgboxname gText_WestrayVillage_HouseOfJoe_Joe_01, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	release
	end

PlayerGetsWinterGear:
	spriteface MAN, UP
	spriteface LADY, LEFT
	msgboxname gText_WestrayVillage_HouseOfJoe_PlayerGetsWinterGear_JoeHappy, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
#	fanfare 0x13E
#	obtainitem 0x0 0x1
#	waitfanfare
	msgboxname gText_WestrayVillage_HouseOfJoe_PlayerGetsWinterGear_JoeFinal, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	spriteface MAN, UP
	pause 0x10
	msgbox gText_WestrayVillage_HouseOfJoe_PlayerGetsWinterGear_ManYaps, MSG_KEEPOPEN
	closeonkeypress
	msgbox gText_WestrayVillage_HouseOfJoe_PlayerGetsWinterGear_LadyYaps, MSG_KEEPOPEN
	closeonkeypress
	msgboxname gText_WestrayVillage_HouseOfJoe_PlayerGetsWinterGear_JoeDefFinal, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	setvar VAR_MAIN_STORY, MAIN_STORY_PLAYER_RECEIVED_WINTER_GEAR_FROM_JOE_IN_WESTRAY_VILLAGE
	setvar 0x4051 0x0 @Guard var blocking access to Articuno Climb
	release
	end

JoeUniversalKinda:
	msgboxname gText_WestrayVillage_HouseOfJoe_Joe_02, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_WestrayVillage_WestrayCatacombs_ItemObtainSuperRepel
NPCScript_WestrayVillage_WestrayCatacombs_ItemObtainSuperRepel:
	giveitem 0x53 0x1, MSG_FIND
	call SetItemFlag_ItemObtainSuperRepel
	end

SetItemFlag_ItemObtainSuperRepel:
	setflag 0x16C @Person ID of Super Repel in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_WestrayVillage_WestrayCatacombs_ItemObtainMoonStone
NPCScript_WestrayVillage_WestrayCatacombs_ItemObtainMoonStone:
	giveitem 0x5E 0x1, MSG_FIND
	call SetItemFlag_ItemObtainMoonStone
	end

SetItemFlag_ItemObtainMoonStone:
	setflag 0x16D @Person ID of Moon Stone in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_WestrayVillage_WestrayCatacombs_ItemObtainSmokeBall
NPCScript_WestrayVillage_WestrayCatacombs_ItemObtainSmokeBall:
	giveitem 0xC2 0x1, MSG_FIND
	call SetItemFlag_ItemObtainSmokeBall
	end

SetItemFlag_ItemObtainSmokeBall:
	setflag 0x16E @Person ID of Smoke Ball in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_WestrayVillage_HiddenGrotto_ItemObtainTM39
NPCScript_WestrayVillage_HiddenGrotto_ItemObtainTM39:
	giveitem 0x147 0x1, MSG_FIND
	call SetItemFlag_ItemObtainTM39
	end

SetItemFlag_ItemObtainTM39:
	setflag 0x16B @Person ID of TM 39 (Rock Tomb) in A-Map
	return

#Tile scripts:
.equ AVERWILL, 14
.equ GRUNT, 15
.equ VAR_MAIN_STORY, 0x4029
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ MAIN_STORY_PLAYER_DEFEATED_AVERILL_IN_WESTRAY_CATACOMBS, 0xD

.global TileScript_WestrayVillage_WestrayCatacombs_FoundRoseOrder
TileScript_WestrayVillage_WestrayCatacombs_FoundRoseOrder:
	lock
	msgboxname gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Averwill_01, MSG_KEEPOPEN, gText_UnknownName
	closeonkeypress
	applymovement GRUNT, m_GruntStepsOnSpotLeft
	waitmovement 0x0
	msgbox gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Grunt_01, MSG_KEEPOPEN
	closeonkeypress
	spriteface AVERWILL, DOWN
	pause 0x20
	checksound
	sound 0x15
	applymovement AVERWILL, m_AverwillNoticesPlayer
	waitmovement 0x0
	msgboxname gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Averwill_02, MSG_KEEPOPEN, gText_UnknownName
	closeonkeypress
	spriteface GRUNT, DOWN
	pause DELAY_HALFSECOND
	checksound
	sound 0x15
	applymovement GRUNT, m_GruntSurprised
	waitmovement 0x0
	msgbox gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Grunt_02, MSG_KEEPOPEN
	closeonkeypress
	msgboxname gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Averwill_03, MSG_KEEPOPEN, gText_UnknownName
	closeonkeypress
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_1, 0xF @X-Pos equals 0xF
	if equal _call AverwillApproachesPlayerWhenScriptNumberZero
	compare VAR_TEMP_1, 0x10 @X-Pos equals 0x10
	if equal _call AverwillApproachesPlayerWhenScriptNumberOne
	compare VAR_TEMP_1, 0x11 @X-Pos equals 0x11
	if equal _call AverwillApproachesPlayerWhenScriptNumberTwo
	compare VAR_TEMP_1, 0x12 @X-Pos equals 0x12
	if equal _call AverwillApproachesPlayerWhenScriptNumberThree
	spriteface GRUNT, DOWN
	msgboxname gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Averwill_04, MSG_KEEPOPEN, gText_UnknownName
	closeonkeypress
	msgboxname gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Averwill_05, MSG_KEEPOPEN, gText_AverwillName
	closeonkeypress
	trainerbattle3 0x3 0x34 0x0 gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_AverwillLoses
	msgboxname gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Averwill_06, MSG_KEEPOPEN, gText_AverwillName
	closeonkeypress
	spriteface AVERWILL, UP
	pause DELAY_HALFSECOND
	msgboxname gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Averwill_07, MSG_KEEPOPEN, gText_AverwillName
	closeonkeypress
	checksound
	sound 0x15
	applymovement GRUNT, m_GruntGetsYelledAtSad
	waitmovement 0x0
	msgbox gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Grunt_03, MSG_KEEPOPEN
	closeonkeypress
	applymovement GRUNT, m_GruntRunsAway
	waitmovement 0x0
	checksound
	sound 0x9
	hidesprite GRUNT
	pause 0x20
	spriteface AVERWILL, DOWN
	msgboxname gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_Averwill_08, MSG_KEEPOPEN, gText_AverwillName
	closeonkeypress
	compare VAR_TEMP_1, 0xF @X-Pos equals 0xF
	if equal _call AverwillLeavesWhenScriptNumberZero
	compare VAR_TEMP_1, 0x10 @X-Pos equals 0x10
	if equal _call AverwillLeavesWhenScriptNumberOne
	compare VAR_TEMP_1, 0x11 @X-Pos equals 0x11
	if equal _call AverwillLeavesWhenScriptNumberTwo
	compare VAR_TEMP_1, 0x12 @X-Pos equals 0x12
	if equal _call AverwillLeavesWhenScriptNumberThree
	applymovement AVERWILL, m_AverwillWarps
	waitmovement 0x0
	checksound
	sound 0x9
	hidesprite AVERWILL
	pause DELAY_1SECOND
	fadescreen 0x1
	checksound
	sound 0x9
	msgbox gText_WestrayVillage_WestrayCatacombs_FoundRoseOrder_AllGruntsFled, MSG_KEEPOPEN
	closeonkeypress
	pause 0x20
	setflag 0x32 @Hide all Rosé grunts
	fadescreen 0x0
	setvar VAR_MAIN_STORY, MAIN_STORY_PLAYER_DEFEATED_AVERILL_IN_WESTRAY_CATACOMBS
	release
	end

AverwillApproachesPlayerWhenScriptNumberZero:
	applymovement AVERWILL, m_AverwillApproachesPlayerWhenScriptNumberZero
	waitmovement 0x0
	return

AverwillApproachesPlayerWhenScriptNumberOne:
	applymovement AVERWILL, m_AverwillApproachesPlayerWhenScriptNumberOne
	waitmovement 0x0
	return

AverwillApproachesPlayerWhenScriptNumberTwo:
	applymovement AVERWILL, m_AverwillApproachesPlayerWhenScriptNumberTwo
	waitmovement 0x0
	return

AverwillApproachesPlayerWhenScriptNumberThree:
	applymovement AVERWILL, m_AverwillApproachesPlayerWhenScriptNumberThree
	waitmovement 0x0
	return

AverwillLeavesWhenScriptNumberZero:
	applymovement AVERWILL, m_AverwillLeavesWhenScriptNumberZero
	waitmovement 0x0
	return

AverwillLeavesWhenScriptNumberOne:
	applymovement AVERWILL, m_AverwillLeavesWhenScriptNumberOne
	waitmovement 0x0
	return

AverwillLeavesWhenScriptNumberTwo:
	applymovement AVERWILL, m_AverwillLeavesWhenScriptNumberTwo
	waitmovement 0x0
	return

AverwillLeavesWhenScriptNumberThree:
	applymovement AVERWILL, m_AverwillLeavesWhenScriptNumberThree
	waitmovement 0x0
	return

m_GruntStepsOnSpotLeft: .byte pause_short, pause_short, walk_left_onspot, pause_short, pause_short, pause_short, end_m
m_AverwillNoticesPlayer: .byte look_down, exclaim, pause_long, pause_long, pause_long, end_m
m_GruntSurprised: .byte look_down, exclaim, pause_long, pause_long, pause_long, look_left, end_m
m_AverwillApproachesPlayerWhenScriptNumberZero: .byte walk_left, walk_down, walk_down, end_m
m_AverwillApproachesPlayerWhenScriptNumberOne: .byte walk_down, walk_down, end_m
m_AverwillApproachesPlayerWhenScriptNumberTwo: .byte walk_down, walk_right, walk_down, end_m
m_AverwillApproachesPlayerWhenScriptNumberThree: .byte walk_down, walk_right, walk_right, walk_down, end_m
m_GruntGetsYelledAtSad: .byte exclaim, pause_long, pause_long, pause_long, end_m
m_GruntRunsAway: .byte run_right, run_right, run_right, run_right, look_down, pause_long, walk_down_onspot, end_m
m_AverwillLeavesWhenScriptNumberZero: .byte walk_up, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, end_m
m_AverwillLeavesWhenScriptNumberOne: .byte walk_up, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, end_m
m_AverwillLeavesWhenScriptNumberTwo: .byte walk_up, walk_up, walk_right, walk_right, walk_right, walk_right, end_m
m_AverwillLeavesWhenScriptNumberThree: .byte walk_up, walk_up, walk_right, walk_right, walk_right, end_m
m_AverwillWarps: .byte look_down, pause_long, walk_down_onspot, end_m

@;////////////////////////////////////////////////

.global TileScript_WestrayVillage_Gatehouse_WinterGearBarrier
TileScript_WestrayVillage_Gatehouse_WinterGearBarrier:
	lock
	checksound
	sound 0x15
	applymovement 0x1, m_Exclaim
	waitmovement 0x0
	msgbox gText_WestrayVillage_Gatehouse_Guard_YouNeedWinterGear, MSG_KEEPOPEN
	closeonkeypress
	applymovement PLAYER, m_StepLeft
	waitmovement 0x0
	release
	end

m_Exclaim: .byte look_down, exclaim, pause_long, pause_long, pause_long, end_m
m_StepLeft: .byte walk_left_slow, end_m

@;////////////////////////////////////////////////

.equ MAN, 4
.equ JOE, 5
.equ LADY, 6
.equ VAR_MAIN_STORY, 0x4029
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ MAIN_STORY_PLAYER_MET_JOE_IN_WESTRAY_VILLAGE, 0xB

.global TileScript_WestrayVillage_HouseOfJoe_GruntsDiscussion
TileScript_WestrayVillage_HouseOfJoe_GruntsDiscussion:
	lock
	applymovement LADY, m_LadyStepOnSpotLeft
	waitmovement 0x0
	msgbox gText_WestrayVillage_HouseOfJoe_GruntsDiscussion_Lady_01, MSG_KEEPOPEN
	closeonkeypress
	spriteface MAN, UP
	pause 0x10
	msgbox gText_WestrayVillage_HouseOfJoe_GruntsDiscussion_Man_01, MSG_KEEPOPEN
	closeonkeypress
	msgboxname gText_WestrayVillage_HouseOfJoe_GruntsDiscussion_Joe_01, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	spriteface JOE, LEFT
	pause DELAY_HALFSECOND
	checksound
	sound 0x15
	applymovement JOE, m_JoeNoticesPlayer
	waitmovement 0x0
	msgboxname gText_WestrayVillage_HouseOfJoe_GruntsDiscussion_Joe_02, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_2, 0x2 @Y-Pos equals 0x2
	if equal _call PlayerWalksToJoeWhenScriptNumberZero
	compare VAR_TEMP_2, 0x5 @Y-Pos equals 0x5
	if equal _call PlayerWalksToJoeWhenScriptNumberOne
	msgboxname gText_WestrayVillage_HouseOfJoe_GruntsDiscussion_Joe_03, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	checksound
	sound 0x15
	applymovement MAN, m_BothSurprised
	applymovement LADY, m_BothSurprised
	waitmovement 0x0
	msgboxname gText_WestrayVillage_HouseOfJoe_GruntsDiscussion_Joe_04, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	applymovement LADY, m_LadyStepOnSpotLeft
	waitmovement 0x0
	msgbox gText_WestrayVillage_HouseOfJoe_GruntsDiscussion_Lady_02, MSG_KEEPOPEN
	closeonkeypress
	msgboxname gText_WestrayVillage_HouseOfJoe_GruntsDiscussion_Joe_05, MSG_KEEPOPEN, gText_JoeName
	closeonkeypress
	setvar VAR_MAIN_STORY, MAIN_STORY_PLAYER_MET_JOE_IN_WESTRAY_VILLAGE
	release
	end

PlayerWalksToJoeWhenScriptNumberZero:
	applymovement PLAYER, m_WalkToJoeWhenScriptNumberZero
	waitmovement 0x0
	return

PlayerWalksToJoeWhenScriptNumberOne:
	applymovement PLAYER, m_WalkToJoeWhenScriptNumberOne
	waitmovement 0x0
	return

m_LadyStepOnSpotLeft: .byte pause_short, walk_left_onspot, pause_short, pause_short, pause_short, end_m
m_JoeNoticesPlayer: .byte exclaim, pause_long, pause_long, pause_long, end_m
m_WalkToJoeWhenScriptNumberZero: .byte walk_right, walk_right, end_m
m_WalkToJoeWhenScriptNumberOne: .byte walk_right, walk_up, walk_up, walk_up, walk_right, end_m
m_BothSurprised: .byte exclaim, pause_long, pause_long, pause_long, pause_long, end_m
