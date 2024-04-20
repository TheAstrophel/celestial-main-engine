.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_ErstoniaCanyon_CheckThisRockDude
NPCScript_ErstoniaCanyon_CheckThisRockDude:
	lock
	faceplayer
	checkflag 0x3ED @Flag of hidden item (Zinc) in A-Map
	if equal _goto AlreadyCheckedRock
	msgbox gText_ErstoniaCanyon_CheckThisRockDude_CheckThisRock, MSG_KEEPOPEN
	closeonkeypress
	spriteface 0x5, UP @0x4 is the Person Event Number
	release
	end

AlreadyCheckedRock:
	msgbox gText_ErstoniaCanyon_CheckThisRockDude_CanFindStuffInRocks, MSG_KEEPOPEN
	closeonkeypress
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCanyon_Clefairy
NPCScript_ErstoniaCanyon_Clefairy:
	lock
	faceplayer
	checksound
	cry 0x23 0x0
	msgbox gText_ErstoniaCanyon_Clefairy_Cry, MSG_KEEPOPEN
	waitcry
	closeonkeypress
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCanyon_Jigglypuff
NPCScript_ErstoniaCanyon_Jigglypuff:
	lock
	faceplayer
	checksound
	cry 0x27 0x0
	msgbox gText_ErstoniaCanyon_Jigglypuff_Cry, MSG_KEEPOPEN
	waitcry
	closeonkeypress
	release
	end

.global NPCScript_ErstoniaCanyon_ItemObtainGreatBall
NPCScript_ErstoniaCanyon_ItemObtainGreatBall:
	giveitem 0x3 0x1, MSG_FIND
	call SetItemFlag_ItemObtainGreatBall
	end

SetItemFlag_ItemObtainGreatBall:
	setflag 0x15A @Person ID of Great Ball in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCanyon_ItemObtainElectricGem
NPCScript_ErstoniaCanyon_ItemObtainElectricGem:
	giveitem 0x29B 0x1, MSG_FIND
	call SetItemFlag_ItemObtainElectricGem
	end

SetItemFlag_ItemObtainElectricGem:
	setflag 0x15B @Person ID of Electric Gem in A-Map
	return

#Tile scripts:
.global TileScript_ErstoniaCanyon_SandstormWeather
TileScript_ErstoniaCanyon_SandstormWeather:
	setweather 0x8
	doweather
	end

@;////////////////////////////////////////////////

.global TileScript_ErstoniaCanyon_ResetWeather
TileScript_ErstoniaCanyon_ResetWeather:
	setweather 0x2
	doweather
	end

#@@@@@@@@;Sub-maps;@@@@@@@@
#NPC Scripts:
.global NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainRareCandy
NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainRareCandy:
	giveitem 0x44 0x1, MSG_FIND
	call SetItemFlag_ItemObtainRareCandy
	end

SetItemFlag_ItemObtainRareCandy:
	setflag 0x15C @Person ID of Rare Candy in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainEscapeRope
NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainEscapeRope:
	giveitem 0x55 0x1, MSG_FIND
	call SetItemFlag_ItemObtainEscapeRope
	end

SetItemFlag_ItemObtainEscapeRope:
	setflag 0x15D @Person ID of Escape Rope in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainParalyzeHeal
NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainParalyzeHeal:
	giveitem 0x12 0x1, MSG_FIND
	call SetItemFlag_ItemObtainParalyzeHeal
	end

SetItemFlag_ItemObtainParalyzeHeal:
	setflag 0x15E @Person ID of Paralyze Heal in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainNugget
NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainNugget:
	giveitem 0x6E 0x1, MSG_FIND
	call SetItemFlag_ItemObtainNugget
	end

SetItemFlag_ItemObtainNugget:
	setflag 0x15F @Person ID of Nugget in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainFireStone
NPCScript_ErstoniaCanyon_RuinwayPassage_ItemObtainFireStone:
	giveitem 0x5F 0x1, MSG_FIND
	call SetItemFlag_ItemObtainFireStone
	end

SetItemFlag_ItemObtainFireStone:
	setflag 0x160 @Person ID of Fire Stone in A-Map
	return

#Tile scripts:
.equ LANDRE, 17
.equ VAR_MAIN_STORY, 0x4029
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ MAIN_STORY_PLAYER_MET_LANDRE_IN_RUINWAY_PASSAGE, 0xA

.global TileScript_ErstoniaCanyon_RuinwayPassage_PlayerFindsLandre
TileScript_ErstoniaCanyon_RuinwayPassage_PlayerFindsLandre:
	lock
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_2, 0x2C @Y-Pos equals 0x2C
	if equal _call CameraMovesTowardsLandreWhenScriptNumberZero
	compare VAR_TEMP_2, 0x2D @Y-Pos equals 0x2D
	if equal _call CameraMovesTowardsLandreWhenScriptNumberOne
	pause 0xE
	msgboxname gText_ErstoniaCanyon_RuinwayPassage_Landre_01, MSG_KEEPOPEN, gText_UnknownName
	closeonkeypress
	pause 0x1E
	spriteface LANDRE, LEFT
	pause 0x1C
	checksound
	sound 0x15
	applymovement LANDRE, m_Exclaim
	waitmovement 0x0
	compare VAR_TEMP_2, 0x2C @Y-Pos equals 0x2C
	if equal _call ApproachPlayerWhenScriptNumberZero
	compare VAR_TEMP_2, 0x2D @Y-Pos equals 0x2D
	if equal _call ApproachPlayerWhenScriptNumberOne
	pause 0xE
	msgboxname gText_ErstoniaCanyon_RuinwayPassage_Landre_02, MSG_KEEPOPEN, gText_UnknownName
	closeonkeypress
	msgboxname gText_ErstoniaCanyon_RuinwayPassage_Landre_03, MSG_KEEPOPEN, gText_LandreName
	closeonkeypress
	compare VAR_TEMP_2, 0x2C @Y-Pos equals 0x2C
	if equal _call LeavePlayerWhenScriptNumberZero
	compare VAR_TEMP_2, 0x2D @Y-Pos equals 0x2D
	if equal _call LeavePlayerWhenScriptNumberOne
	pause 0xE
	hidesprite 0x2B
	hidesprite LANDRE
	setflag 0x2B @Hide Caretaker that blocks Erstonia Gym
	setflag 0x2C @Hide Landre
	setvar VAR_TEMP_1, 0 @Will be used later in other scripts
	setvar VAR_TEMP_2, 0 @Will be used later in other scripts
	setvar 0x402D 0x1 @debug
	setvar VAR_MAIN_STORY, MAIN_STORY_PLAYER_MET_LANDRE_IN_RUINWAY_PASSAGE
	release
	end

CameraMovesTowardsLandreWhenScriptNumberZero:
	special CAMERA_START
	applymovement CAMERA, m_MoveCameraTowardsLandreWhenScriptNumberZero
	waitmovement 0x0
	special CAMERA_END
	return

CameraMovesTowardsLandreWhenScriptNumberOne:
	special CAMERA_START
	applymovement CAMERA, m_MoveCameraTowardsLandreWhenScriptNumberOne
	waitmovement 0x0
	special CAMERA_END
	return

ApproachPlayerWhenScriptNumberZero:
	special CAMERA_START
	applymovement LANDRE, m_LandreMoveTowardsPlayerWhenScriptNumberZero
	applymovement CAMERA, m_MoveCameraWithLandreWhenScriptNumberZero
	waitmovement 0x0
	special CAMERA_END
	return

ApproachPlayerWhenScriptNumberOne:
	special CAMERA_START
	applymovement LANDRE, m_LandreMoveTowardsPlayerWhenScriptNumberOne
	applymovement CAMERA, m_MoveCameraWithLandreWhenScriptNumberOne
	waitmovement 0x0
	special CAMERA_END
	return

LeavePlayerWhenScriptNumberZero:
	applymovement LANDRE, m_LandreLeavesWhenScriptNumberZero
	waitmovement 0x0
	return

LeavePlayerWhenScriptNumberOne:
	applymovement LANDRE, m_LandreLeavesWhenScriptNumberOne
	waitmovement 0x0
	return

m_Exclaim: .byte exclaim, pause_long, pause_long, pause_long, pause_long, end_m
m_MoveCameraTowardsLandreWhenScriptNumberZero: .byte walk_right, walk_right, walk_right, walk_right, walk_right, end_m
m_MoveCameraTowardsLandreWhenScriptNumberOne: .byte walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, end_m
m_MoveCameraWithLandreWhenScriptNumberZero: .byte walk_left, walk_left, walk_left, walk_left, walk_left, end_m
m_LandreMoveTowardsPlayerWhenScriptNumberZero: .byte walk_left, walk_left, walk_left, walk_left, end_m
m_MoveCameraWithLandreWhenScriptNumberOne: .byte walk_left, walk_left, walk_left, walk_left, walk_down, walk_left, end_m
m_LandreMoveTowardsPlayerWhenScriptNumberOne: .byte walk_left, walk_left, walk_left, walk_left, walk_down, look_left, end_m
m_LandreLeavesWhenScriptNumberZero: .byte walk_down, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, end_m
m_LandreLeavesWhenScriptNumberOne: .byte walk_up, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, end_m

#Level scripts:
.global gMapScripts_ErstoniaCanyon_RuinwayPassage
gMapScripts_ErstoniaCanyon_RuinwayPassage:
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_ErstoniaCanyon_RuinwayPassage
	.byte MAP_SCRIPT_TERMIN

MapEntryScript_ErstoniaCanyon_RuinwayPassage:
	setworldmapflag 0x8A5
	end
