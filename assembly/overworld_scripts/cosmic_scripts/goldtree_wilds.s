.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_GoldtreeWilds_Nidoran
NPCScript_GoldtreeWilds_Nidoran:
	lock
	faceplayer
	checkflag 0xAF @Set when Energy Powder has been received
	if notequal _goto ReceiveGiftFromNidoran
	checksound
	cry 0x34 0x0
	msgbox gText_GoldtreeWilds_Nidoran_Cry, MSG_KEEPOPEN
	waitcry
	closeonkeypress
	release
	end

ReceiveGiftFromNidoran:
	checksound
	cry 0x34 0x0
	msgbox gText_GoldtreeWilds_Nidoran_GivingGift, MSG_KEEPOPEN
	waitcry
	giveitem 0x1E 0x1, MSG_OBTAIN
	setflag 0xAF @Flag to not obtain Energy Powder again
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_GoldtreeWilds_Pikachu
NPCScript_GoldtreeWilds_Pikachu:
	lock
	faceplayer
	checksound
	cry 0x19 0x0
	msgbox gText_GoldtreeWilds_Pikachu_Cry, MSG_KEEPOPEN
	waitcry
	closeonkeypress
	release
	end

@;////////////////////////////////////////////////

.global NPCScript_GoldtreeWilds_ItemObtainXAttack
NPCScript_GoldtreeWilds_ItemObtainXAttack:
	giveitem 0x4B 0x1, MSG_FIND
	call SetItemFlag_ItemObtainXAttack
	end

SetItemFlag_ItemObtainXAttack:
	setflag 0x167 @Person ID of X-Attack in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_GoldtreeWilds_ItemObtainTM59
NPCScript_GoldtreeWilds_ItemObtainTM59:
	giveitem 0x180 0x1, MSG_FIND
	call SetItemFlag_ItemObtainTM59
	end

SetItemFlag_ItemObtainTM59:
	setflag 0x168 @Person ID of TM59 (Dragon Pulse) in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_GoldtreeWilds_ItemObtainFastBall
NPCScript_GoldtreeWilds_ItemObtainFastBall:
	giveitem 0xF3 0x1, MSG_FIND
	call SetItemFlag_ItemObtainFastBall
	end

SetItemFlag_ItemObtainFastBall:
	setflag 0x169 @Person ID of Fast Ball in A-Map
	return

#Tile scripts:
.global TileScript_GoldtreeWilds_BattleToStopPlayer
TileScript_GoldtreeWilds_BattleToStopPlayer:
	lock
	playsong 0x129 0x0
	getplayerpos 0x51FE, 0x51FF
	compare 0x51FF, 0x32
	if equal _goto OtherGirlAttacks
	compare 0x51FF, 0x33
	if equal _goto OtherGirlAttacks
	msgbox gText_GoldtreeWilds_BattleToStopPlayer_GirlTowardsLeft_01, MSG_KEEPOPEN
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
	spriteface 0x3, RIGHT
	msgbox gText_GoldtreeWilds_BattleToStopPlayer_BothGirls, MSG_KEEPOPEN
	closeonkeypress
	spriteface 0x3, DOWN
	fadedefault
	applymovement PLAYER, m_StepRight
	waitmovement 0x0
	setvar 0x51FE, 0x0
	setvar 0x51FF, 0x0
	release
	end

OtherGirlAttacks:
	msgbox gText_GoldtreeWilds_BattleToStopPlayer_GirlTowardsRight_01, MSG_KEEPOPEN
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
	spriteface 0x6, RIGHT
	msgbox gText_GoldtreeWilds_BattleToStopPlayer_BothGirls, MSG_KEEPOPEN
	closeonkeypress
	spriteface 0x6, UP
	fadedefault
	applymovement PLAYER, m_StepRight
	waitmovement 0x0
	setvar 0x51FE, 0x0
	setvar 0x51FF, 0x0
	release
	end

m_JumpTowardsMeowth: .byte jump_down, end_m
m_JumpAwayFromMeowth: .byte jump_up, look_down, end_m
m_JumpTowardsPikachu: .byte jump_up, end_m
m_WalkAwayFromPikachu: .byte walk_down, look_up, end_m
m_StepRight: .byte walk_right_very_slow, end_m

@;////////////////////////////////////////////////

.equ RIVAL, 17
.equ GRUNT, 18
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_TEAM_ROSé_GRUNT_FLED, 0x9

.global TileScript_GoldtreeWilds_PlayerAndRivalConfrontGrunt
TileScript_GoldtreeWilds_PlayerAndRivalConfrontGrunt:
	lock
	spriteface RIVAL, DOWN
	spriteface GRUNT, UP
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_2, 0x6 @Y-Pos equals 0x6
	if equal _call CameraMovesTowardsRivalAndGruntWhenScriptNumberFour
	compare VAR_TEMP_2, 0x7 @Y-Pos equals 0x7
	if equal _call CameraMovesTowardsRivalAndGruntWhenScriptNumberFive
	compare VAR_TEMP_2, 0x8 @Y-Pos equals 0x8
	if equal _call CameraMovesTowardsRivalAndGruntWhenScriptNumberSix
	compare VAR_TEMP_2, 0x9 @Y-Pos equals 0x9
	if equal _call CameraMovesTowardsRivalAndGruntWhenScriptNumberSeven
	pause 0xE
	msgboxname gText_GoldtreeWilds_Rival_01, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	msgboxname gText_GoldtreeWilds_Grunt_01, MSG_KEEPOPEN, gText_GruntName
	closeonkeypress
	pause 0xE
	checksound
	sound 0x15
	applymovement RIVAL, m_Exclaim
	waitmovement 0x0
	msgboxname gText_GoldtreeWilds_Rival_02, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	compare VAR_TEMP_2, 0x6 @Y-Pos equals 0x6
	if equal _call CameraResetsWhenScriptNumberFour
	compare VAR_TEMP_2, 0x7 @Y-Pos equals 0x7
	if equal _call CameraResetsWhenScriptNumberFive
	compare VAR_TEMP_2, 0x8 @Y-Pos equals 0x8
	if equal _call CameraResetsWhenScriptNumberSix
	compare VAR_TEMP_2, 0x9 @Y-Pos equals 0x9
	if equal _call CameraResetsWhenScriptNumberSeven
	compare VAR_TEMP_2, 0x6 @Y-Pos equals 0x6
	if equal _call PlayerMovesTowardRivalWhenScriptNumberFour
	compare VAR_TEMP_2, 0x7 @Y-Pos equals 0x7
	if equal _call PlayerMovesTowardRivalWhenScriptNumberFive
	compare VAR_TEMP_2, 0x8 @Y-Pos equals 0x8
	if equal _call PlayerMovesTowardRivalWhenScriptNumberSix
	compare VAR_TEMP_2, 0x9 @Y-Pos equals 0x9
	if equal _call PlayerMovesTowardRivalWhenScriptNumberSeven
	spriteface RIVAL, DOWN
	playsong 0x11D 0x0
	msgboxname gText_GoldtreeWilds_Rival_03, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	msgboxname gText_GoldtreeWilds_Grunt_02, MSG_KEEPOPEN, gText_GruntName
	closeonkeypress
	cry 0x295 0x0 @Lampent Cry
	waitcry
	checksound
	sound 0xB9
	fadescreenspeed 0x3 0x0
	pause 0x3B
	checksound
	sound 0x11
	applymovement GRUNT, m_GruntRunsAway
	waitmovement 0x0
	hidesprite GRUNT
	pause 0x5A
	fadescreenspeed 0x2 0xD
	fadedefault
	pause 0x1E
	applymovement RIVAL, m_RivalLooksHereAndThere
	waitmovement 0x0
	spriteface RIVAL, LEFT
	msgboxname gText_GoldtreeWilds_Rival_04, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_RivalLeaves
	waitmovement 0x0
	hidesprite RIVAL
	pause 0xE
	setflag 0x30 @Hide Grunt
	setflag 0x30 @Hide Rival
	setvar VAR_MAIN_STORY, MAIN_STORY_TEAM_ROSé_GRUNT_FLED
	setflag 0x231 @Flag of Mom when Player does not go and meet Mom :(
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

m_Exclaim: .byte look_left, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, end_m
m_RivalLooksHereAndThere: .byte look_up, pause_long, pause_long, look_left, pause_long, pause_long, look_right, pause_long, pause_long, look_up, pause_long, pause_long, look_down, pause_long, pause_long, end_m
m_RivalLeaves: .byte walk_right, walk_right, walk_right, walk_right, walk_right, walk_down, walk_down, walk_right, walk_right, walk_right, end_m
m_GruntRunsAway: .byte run_right, run_up, run_right, run_right, run_right, run_right, run_down, run_down, run_right, run_right, end_m
m_MoveCameraTowardsRivalAndGruntWhenScriptNumberFour: .byte walk_right, walk_right, walk_right, walk_down, end_m
m_MoveCameraTowardsRivalAndGruntWhenScriptNumberFive: .byte walk_right, walk_right, walk_right, end_m
m_MoveCameraTowardsRivalAndGruntWhenScriptNumberSix: .byte walk_right, walk_right, walk_right, walk_up, end_m
m_MoveCameraTowardsRivalAndGruntWhenScriptNumberSeven: .byte walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_CameraResetsWhenScriptNumberFour: .byte walk_left, walk_left, walk_left, walk_up, end_m
m_CameraResetsWhenScriptNumberFive: .byte walk_left, walk_left, walk_left, end_m
m_CameraResetsWhenScriptNumberSix: .byte walk_left, walk_left, walk_left, walk_down, end_m
m_CameraResetsWhenScriptNumberSeven: .byte walk_left, walk_left, walk_left, walk_down, walk_down, end_m
m_PlayerMovingTowardRivalWhenScriptNumberFour: .byte run_down, run_right, run_right, end_m
m_PlayerMovingTowardRivalWhenScriptNumberFive: .byte run_right, run_right, end_m
m_PlayerMovingTowardRivalWhenScriptNumberSix: .byte run_up, run_right, run_right, end_m
m_PlayerMovingTowardRivalWhenScriptNumberSeven: .byte run_up, run_up, run_right, run_right, end_m

#@@@@@@@@;Sub-maps;@@@@@@@@
#NPC scripts:
.global NPCScript_GoldtreeWilds_FaeryWoods_ItemObtainHoney
NPCScript_GoldtreeWilds_FaeryWoods_ItemObtainHoney:
	giveitem 0x74 0x1, MSG_FIND
	call SetItemFlag_ItemObtainHoney
	end

SetItemFlag_ItemObtainHoney:
	setflag 0x161 @Person ID of Honey in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_GoldtreeWilds_FaeryWoods_ItemObtainPBall
NPCScript_GoldtreeWilds_FaeryWoods_ItemObtainPBall:
	giveitem 0x4 0x1, MSG_FIND
	call SetItemFlag_ItemObtainPBall
	end

SetItemFlag_ItemObtainPBall:
	setflag 0x162 @Person ID of PBall in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_GoldtreeWilds_FaeryWoods_ItemObtainPotion
NPCScript_GoldtreeWilds_FaeryWoods_ItemObtainPotion:
	giveitem 0xD 0x1, MSG_FIND
	call SetItemFlag_ItemObtainPotion
	end

SetItemFlag_ItemObtainPotion:
	setflag 0x163 @Person ID of Paralyze Heal in A-Map
	return
