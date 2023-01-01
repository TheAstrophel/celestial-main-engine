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

@;////////////////////////////////////////////////

.equ RIVAL, 17
.equ GRUNT, 18
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_TEAM_ETERNAL_GRUNT_FLED, 0x9

.global TileScript_GoldtreeMeadows_PlayerAndRivalConfrontGrunt
TileScript_GoldtreeMeadows_PlayerAndRivalConfrontGrunt:
	lock
	spriteface GRUNT, LEFT
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_1, 0xA @X-Pos equals 0xA
	if equal _call CameraMovesTowardsRivalAndGruntWhenScriptNumberFour
	compare VAR_TEMP_1, 0xB @X-Pos equals 0xB
	if equal _call CameraMovesTowardsRivalAndGruntWhenScriptNumberFive
	compare VAR_TEMP_1, 0xC @X-Pos equals 0xC
	if equal _call CameraMovesTowardsRivalAndGruntWhenScriptNumberSix
	compare VAR_TEMP_1, 0xD @X-Pos equals 0xD
	if equal _call CameraMovesTowardsRivalAndGruntWhenScriptNumberSeven
	pause 0xE
	msgboxname gText_GoldtreeMeadows_Rival_01, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	msgboxname gText_GoldtreeMeadows_Grunt_01, MSG_KEEPOPEN, gText_GruntName
	closeonkeypress
	pause 0xE
	checksound
	sound 0x15
	applymovement RIVAL, m_Exclaim
	waitmovement 0x0
	msgboxname gText_GoldtreeMeadows_Rival_02, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	compare VAR_TEMP_1, 0xA @X-Pos equals 0xA
	if equal _call CameraResetsWhenScriptNumberFour
	compare VAR_TEMP_1, 0xB @X-Pos equals 0xB
	if equal _call CameraResetsWhenScriptNumberFive
	compare VAR_TEMP_1, 0xC @X-Pos equals 0xC
	if equal _call CameraResetsWhenScriptNumberSix
	compare VAR_TEMP_1, 0xD @X-Pos equals 0xD
	if equal _call CameraResetsWhenScriptNumberSeven
	compare VAR_TEMP_1, 0xA @X-Pos equals 0xA
	if equal _call PlayerMovesTowardRivalWhenScriptNumberFour
	compare VAR_TEMP_1, 0xB @X-Pos equals 0xB
	if equal _call PlayerMovesTowardRivalWhenScriptNumberFive
	compare VAR_TEMP_1, 0xC @X-Pos equals 0xC
	if equal _call PlayerMovesTowardRivalWhenScriptNumberSix
	compare VAR_TEMP_1, 0xD @X-Pos equals 0xD
	if equal _call PlayerMovesTowardRivalWhenScriptNumberSeven
	spriteface RIVAL, RIGHT
	playsong 0x11D 0x0
	msgboxname gText_GoldtreeMeadows_Rival_03, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	msgboxname gText_GoldtreeMeadows_Grunt_02, MSG_KEEPOPEN, gText_GruntName
	closeonkeypress
	cry 0x295 0x0 @Lampent Cry
	waitcry
	checksound
	sound 0xB9
	fadescreenspeed 0x3 0x0
	pause 0x3B
	checksound
	sound 0x11
	hidesprite GRUNT
	pause 0x5A
	fadescreenspeed 0x2 0xD
	fadedefault
	pause 0x1E
	applymovement RIVAL, m_RivalLooksHereAndThere
	waitmovement 0x0
	msgboxname gText_GoldtreeMeadows_Rival_04, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_RivalLeaves
	waitmovement 0x0
	hidesprite RIVAL
	pause 0xE
	setflag 0x2E @Hide Grunt
	setflag 0x2F @Hide Rival
	setvar VAR_MAIN_STORY, MAIN_STORY_TEAM_ETERNAL_GRUNT_FLED
	setflag 0x22F @Flag of Mom when Player does not go and meet Mom :(
	release
	end

CameraMovesTowardsRivalAndGruntWhenScriptNumberFour:
	special CAMERA_START
	applymovement CAMERA, m_MoveCameraTowardsRivalAndGruntWhenScriptNumberFour
	waitmovement 0x0
	special CAMERA_END
	return

CameraMovesTowardsRivalAndGruntWhenScriptNumberFive:
	special CAMERA_START
	applymovement CAMERA, m_MoveCameraTowardsRivalAndGruntWhenScriptNumberFive
	waitmovement 0x0
	special CAMERA_END
	return

CameraMovesTowardsRivalAndGruntWhenScriptNumberSix:
	special CAMERA_START
	applymovement CAMERA, m_MoveCameraTowardsRivalAndGruntWhenScriptNumberSix
	waitmovement 0x0
	special CAMERA_END
	return

CameraMovesTowardsRivalAndGruntWhenScriptNumberSeven:
	special CAMERA_START
	applymovement CAMERA, m_MoveCameraTowardsRivalAndGruntWhenScriptNumberSeven
	waitmovement 0x0
	special CAMERA_END
	return

CameraResetsWhenScriptNumberFour:
	special CAMERA_START
	applymovement CAMERA, m_CameraResetsWhenScriptNumberFour
	waitmovement 0x0
	special CAMERA_END
	return

CameraResetsWhenScriptNumberFive:
	special CAMERA_START
	applymovement CAMERA, m_CameraResetsWhenScriptNumberFive
	waitmovement 0x0
	special CAMERA_END
	return

CameraResetsWhenScriptNumberSix:
	special CAMERA_START
	applymovement CAMERA, m_CameraResetsWhenScriptNumberSix
	waitmovement 0x0
	special CAMERA_END
	return

CameraResetsWhenScriptNumberSeven:
	special CAMERA_START
	applymovement CAMERA, m_CameraResetsWhenScriptNumberSeven
	waitmovement 0x0
	special CAMERA_END
	return

PlayerMovesTowardRivalWhenScriptNumberFour:
	applymovement PLAYER, m_PlayerMovingTowardRivalWhenScriptNumberFour
	waitmovement 0x0
	return

PlayerMovesTowardRivalWhenScriptNumberFive:
	applymovement PLAYER, m_PlayerMovingTowardRivalWhenScriptNumberFive
	waitmovement 0x0
	return

PlayerMovesTowardRivalWhenScriptNumberSix:
	applymovement PLAYER, m_PlayerMovingTowardRivalWhenScriptNumberSix
	waitmovement 0x0
	return

PlayerMovesTowardRivalWhenScriptNumberSeven:
	applymovement PLAYER, m_PlayerMovingTowardRivalWhenScriptNumberSeven
	waitmovement 0x0
	return

m_Exclaim: .byte look_down, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, end_m
m_RivalLeaves: .byte walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_RivalLooksHereAndThere: .byte look_up, pause_long, pause_long, look_left, pause_long, pause_long, look_right, pause_long, pause_long, look_up, pause_long, pause_long, look_down, pause_long, pause_long, end_m
m_MoveCameraTowardsRivalAndGruntWhenScriptNumberFour: .byte walk_right, walk_up, walk_up, walk_up, end_m
m_MoveCameraTowardsRivalAndGruntWhenScriptNumberFive: .byte walk_up, walk_up, walk_up, end_m
m_MoveCameraTowardsRivalAndGruntWhenScriptNumberSix: .byte walk_left, walk_up, walk_up, walk_up, end_m
m_MoveCameraTowardsRivalAndGruntWhenScriptNumberSeven: .byte walk_left, walk_left, walk_up, walk_up, walk_up, end_m
m_CameraResetsWhenScriptNumberFour: .byte walk_down, walk_down, walk_down, walk_left, end_m
m_CameraResetsWhenScriptNumberFive: .byte walk_down, walk_down, walk_down, end_m
m_CameraResetsWhenScriptNumberSix: .byte walk_down, walk_down, walk_down, walk_right, end_m
m_CameraResetsWhenScriptNumberSeven: .byte walk_down, walk_down, walk_down, walk_right, walk_right, end_m
m_PlayerMovingTowardRivalWhenScriptNumberFour: .byte run_right, run_up, run_up, end_m
m_PlayerMovingTowardRivalWhenScriptNumberFive: .byte run_up, run_up, end_m
m_PlayerMovingTowardRivalWhenScriptNumberSix: .byte run_left, run_up, run_up, end_m
m_PlayerMovingTowardRivalWhenScriptNumberSeven: .byte run_left, run_left, run_up, run_up, end_m
