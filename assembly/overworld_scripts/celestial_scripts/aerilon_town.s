.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_AerilonTown_BossyGirl
NPCScript_AerilonTown_BossyGirl:
	compare 0x4011, 0x5 @0x4011 is set to 0x5 when [player] meets Rival outside Observatory
	if greaterorequal _goto OtherMessageFromBossyGirl
	msgboxname gText_AerilonTown_BossyGirl_01, MSG_FACE, gText_BossyGirlName
	end
	
OtherMessageFromBossyGirl:
	msgboxname gText_AerilonTown_BossyGirl_02, MSG_FACE, gText_BossyGirlName
	end

#Tile scripts:
.global TileScript_AerilonTown_PlayerTriesToLeave
TileScript_AerilonTown_PlayerTriesToLeave:
	lock
	checksound
	sound 0x15
	applymovement 0x4, m_LookDownExclaim @0x4 is the girl standing at right edge of town
	waitmovement 0x0
	msgboxname gText_AerilonTown_BossyGirl_03, MSG_KEEPOPEN, gText_BossyGirlName
	waitmsg
	closeonkeypress
	applymovement PLAYER, m_StepLeft
	waitmovement 0x0
	release
	end

m_LookDownExclaim: .byte look_down, exclaim, pause_long, pause_long, pause_long, end_m
m_StepLeft: .byte walk_left_slow, end_m

@;////////////////////////////////////////////////

.equ PROF, 7
.equ MOM, 8
.equ VAR_MAIN_STORY, 0x4011
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ MAIN_STORY_LEAVING_TOWN, 0x6

.global TileScript_AerilonTown_PlayerLeavingTown
TileScript_AerilonTown_PlayerLeavingTown:
	lock
	checkflag 0x201 @Flag is set if [player] has already taken parcel from Prof. Almond in his house to avoid loop
	if equal _goto AlreadyMetProfessorWhenLeavingAerilonTown
	pause 0xE
	sound 0x8
	opendoor 0x1C 0xD
	waitdooranim
	showsprite PROF
	clearflag 0x1FF @Person ID of Professor and Mom in A-Map
	applymovement PROF, m_StepOutOfHouse
	waitmovement 0x0
	closedoor 0x1C 0xD
	waitdooranim
	spriteface PROF, RIGHT
	sound 0x15
	applymovement PROF, m_Exclaim
	waitmovement 0x0
	pause 0x3E
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_2, 0xE @Y-Pos equals 0xE
	if equal _call ApproachPlayerWhenScriptNumberThree
	compare VAR_TEMP_2, 0xF @Y-Pos equals 0xF
	if equal _call ApproachPlayerWhenScriptNumberFour
	compare VAR_TEMP_2, 0x10 @Y-Pos equals 0x10
	if equal _call ApproachPlayerWhenScriptNumberFive
	spriteface PLAYER, LEFT
	msgboxname gText_AerilonTown_ProfAlmond_01, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	fanfare 0x13E
	obtainitem 0x15D 0x1
	waitfanfare
	msgboxname gText_AerilonTown_ProfAlmond_01, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	compare VAR_TEMP_2, 0xE @Y-Pos equals 0xE
	if equal _call LeavePlayerWhenScriptNumberThree
	compare VAR_TEMP_2, 0xF @Y-Pos equals 0xF
	if equal _call LeavePlayerWhenScriptNumberFour
	compare VAR_TEMP_2, 0x10 @Y-Pos equals 0x10
	if equal _call LeavePlayerWhenScriptNumberFive
	spriteface PROF, UP
	sound 0x8
	opendoor 0x1C 0xD
	waitdooranim
	applymovement PROF, m_StepInHouse
	waitmovement 0x0
	hidesprite PROF
	closedoor 0x1C 0xD
	waitdooranim
	pause 0x20
	goto AlreadyMetProfessorWhenLeavingAerilonTown

ApproachPlayerWhenScriptNumberThree:
	applymovement PROF, m_MoveTowardsPlayerWhenScriptNumberThree
	waitmovement 0x0
	return

ApproachPlayerWhenScriptNumberFour:
	applymovement PROF, m_MoveTowardsPlayerWhenScriptNumberFour
	waitmovement 0x0
	return

ApproachPlayerWhenScriptNumberFive:
	applymovement PROF, m_MoveTowardsPlayerWhenScriptNumberFive
	waitmovement 0x0
	return

LeavePlayerWhenScriptNumberThree:
	applymovement PROF, m_MoveAwayFromPlayerWhenScriptNumberThree
	waitmovement 0x0
	return

LeavePlayerWhenScriptNumberFour:
	applymovement PROF, m_MoveAwayFromPlayerWhenScriptNumberFour
	waitmovement 0x0
	return

LeavePlayerWhenScriptNumberFive:
	applymovement PROF, m_MoveAwayFromPlayerWhenScriptNumberFive
	waitmovement 0x0
	return

AlreadyMetProfessorWhenLeavingAerilonTown:
	msgboxname gText_AerilonTown_Mom_01, MSG_KEEPOPEN, gText_MomName
	closeonkeypress
	spriteface PLAYER, LEFT
	showsprite MOM
	spriteface MOM, RIGHT
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_2, 0xE @Y-Pos equals 0xE
	if equal _call SetMomPosition01
	compare VAR_TEMP_2, 0x10 @Y-Pos equals 0x10
	if equal _call SetMomPosition02
	applymovement MOM, m_MomMovesToPlayer
	waitmovement 0x0
	msgboxname gText_AerilonTown_Mom_02, MSG_KEEPOPEN, gText_MomName
	closeonkeypress
	applymovement MOM, m_MomLeaves
	waitmovement 0x0
	pause 0x1E
	hidesprite MOM
	clearflag 0x201 @Prof. Almond flag; cleared since var is set below
	clearflag 0x22F @Mom flag; cleared since var is set below
	setflag 0x1FF @Person ID of Professor and Mom in A-Map
	setvar VAR_TEMP_1, 0 @Will be used later in other scripts
	setvar VAR_TEMP_2, 0 @Will be used later in other scripts
	setvar VAR_MAIN_STORY, MAIN_STORY_LEAVING_TOWN
	release
	end

SetMomPosition01:
	movesprite MOM, 0x19 0xE
	return

SetMomPosition02:
	movesprite MOM, 0x19 0x10
	return

m_StepInHouse: .byte walk_up, end_m
m_StepOutOfHouse: .byte walk_down, end_m
m_Exclaim: .byte exclaim, end_m
m_MoveTowardsPlayerWhenScriptNumberThree: .byte walk_right, walk_right, walk_right, walk_right, end_m
m_MoveTowardsPlayerWhenScriptNumberFour: .byte walk_right, walk_right, walk_down, walk_right, walk_right, end_m
m_MoveTowardsPlayerWhenScriptNumberFive: .byte walk_right, walk_right, walk_down, walk_down, walk_right, walk_right, end_m
m_MoveAwayFromPlayerWhenScriptNumberThree: .byte walk_left, walk_left, walk_left, walk_left, end_m
m_MoveAwayFromPlayerWhenScriptNumberFour: .byte walk_left, walk_left, walk_up, walk_left, walk_left, end_m
m_MoveAwayFromPlayerWhenScriptNumberFive: .byte walk_left, walk_left, walk_up, walk_up, walk_left, walk_left, end_m
m_MomMovesToPlayer: .byte walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, end_m
m_MomLeaves: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, end_m

#Level scripts:
.equ PROF_AIDE, 2
.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_LEAVE_HOUSE, 0x1
.equ MAIN_STORY_TALKED_TO_PROF_AIDE, 0x2

.global gMapScripts_AerilonTown
gMapScripts_AerilonTown:
	mapscript MAP_SCRIPT_ON_LOAD SetMapTileScript_AerilonTown
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AerilonTown
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_AerilonTown
	.byte MAP_SCRIPT_TERMIN

SetMapTileScript_AerilonTown:
	compare 0x4011, 0x5 @0x4011 (var main story) is set to 0x5 when [player] meets Rival outside Observatory
	if lessthan _call SetMapTileScript_AerilonTown_SetClosedDoor
	end

SetMapTileScript_AerilonTown_SetClosedDoor:
	setmaptile 0x1C 0xD 0x313 0x1
	return
	
LevelScripts_AerilonTown: 
	levelscript VAR_MAIN_STORY, MAIN_STORY_LEAVE_HOUSE, LevelScript_AerilonTown
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AerilonTown:
	lockall
	msgboxname gText_AerilonTown_Aide_01, MSG_KEEPOPEN, gText_UnknownName
	closeonkeypress
	checksound
	sound 0x15
	applymovement PLAYER, m_LookRightQuestion
	waitmovement 0x0
	applymovement PROF_AIDE, m_WalkLeftTowardsPlayer
	waitmovement 0x0
	msgboxname gText_AerilonTown_Aide_02, MSG_KEEPOPEN, gText_AideName
	closeonkeypress
	applymovement PROF_AIDE, m_WalkRightAwayFromPlayer
	waitmovement 0x0
	pause 0x1E
	hidesprite 0x2
	setflag 0x1FF @Person ID of Aide in A-Map
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_PROF_AIDE
	releaseall
	end
	
m_LookRightQuestion: .byte look_right, say_question, pause_long, end_m
m_WalkLeftTowardsPlayer: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, end_m
m_WalkRightAwayFromPlayer: .byte walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, end_m

MapEntryScript_AerilonTown:
	setworldmapflag 0x890
	end

#@@@@@@@@;Sub-maps;@@@@@@@@
#NPC scripts:
.global NPCScript_AerilonTown_HouseOfProfessor_ProfessorAlmond
NPCScript_AerilonTown_HouseOfProfessor_ProfessorAlmond:
	compare 0x4011, 0x8
	if greaterorequal _goto PlayerHasDelieverdParcelToFatherOfRival
	compare 0x4011, 0x6 @0x4011 is set to 0x6 when Mom sees of [player]; since flag is cleared in that script, added compare var as to avoid loop
	if greaterorequal _goto AlreadyMetProfessor
	checkflag 0x201 @0x201 is set in this script as to avoid loop; it is cleared when Mom meets at edge of Aerilon Town (Mom sees of [player])
	if equal _goto AlreadyMetProfessor
	lock
	faceplayer
	msgboxname gText_AerilonTown_HouseOfProfessor_ProfAlmond_01, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	fanfare 0x13E
	obtainitem 0x15D 0x1
	waitfanfare
	msgboxname gText_AerilonTown_HouseOfProfessor_ProfAlmond_02, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	setflag 0x201 @To avoid loop
	setflag 0x22F @For if [player] goes and meets Mom instead of leaving town
	spriteface 0x1, RIGHT
	release
	end

AlreadyMetProfessor:
	lock
	msgboxname gText_AerilonTown_HouseOfProfessor_ProfAlmond_03, MSG_FACE, gText_ProfAlmondName
	spriteface 0x1, RIGHT
	release
	end

PlayerHasDelieverdParcelToFatherOfRival:
	msgboxname gText_AerilonTown_HouseOfProfessor_ProfAlmond_04, MSG_FACE, gText_ProfAlmondName
	spriteface 0x1, RIGHT
	release
	end

@;////////////////////////////////////////////////

.equ MOM, 1
.equ VAR_MAIN_STORY, 0x4011

.global NPCScript_AerilonTown_PlayerHouse_PlayerMom
NPCScript_AerilonTown_PlayerHouse_PlayerMom:
	lock
	compare VAR_MAIN_STORY, 0x1
	if equal _goto PlayerAlreadyTalkedWithMom
	compare VAR_MAIN_STORY, 0x2
	if equal _goto PlayerAlreadyMetAide
	compare VAR_MAIN_STORY, 0x5
	if equal _goto PlayerMetRival
	compare VAR_MAIN_STORY, 0x6
	if equal _goto PlayerAlreadyMetProfessor
	compare VAR_MAIN_STORY, 0x7
	if equal _goto PlayerAlreadyDefeatedRival
	checkflag 0x22F
	if equal _goto MomUniversal @Alternate name: AlreadyVisitedGoldtreeVillageAndTalkedToMomBeforeOrDidNotTalkWithMomAnd
	compare VAR_MAIN_STORY, 0x8
	if greaterorequal _goto PlayerAlreadyVisitedGoldtree
	release
	end

MomUniversal: @Alternate name: AlreadyVisitedGoldtreeVillageAndTalkedToMomBeforeOrDidNotTalkWithMomAnd
	faceplayer
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_Universal_01, MSG_KEEPOPEN, gText_MomName
	closeonkeypress
	call HealPlayerParty
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_Universal_02, MSG_FACE, gText_MomName
	spriteface MOM, LEFT
	release
	end

PlayerAlreadyTalkedWithMom:
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_01, MSG_FACE, gText_MomName
	spriteface MOM, LEFT
	release
	end

PlayerAlreadyMetAide:
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_02, MSG_FACE, gText_MomName
	release
	end

PlayerMetRival:
	checkflag 0x22F @This flag checks whether [player] talked to Mom after receiving starter
	if equal _goto PlayerHasAlreadyTakenParcelFromProfessorAlmondInAerilonTown
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_03, MSG_FACE, gText_MomName
	spriteface MOM, LEFT
	release
	end

PlayerHasAlreadyTakenParcelFromProfessorAlmondInAerilonTown:
	faceplayer
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_04, MSG_KEEPOPEN, gText_MomName
	closeonkeypress
	clearflag 0x201 @This flag is later used in scripts, so it has been been cleared
	clearflag 0x22F @Since var is set below, no use for this flag to be set
	setvar VAR_MAIN_STORY, 0x6 @This var is also set to 0x6 in a script when [player] is leaving Aerilon Town without meeting Mom
	spriteface MOM, LEFT
	release
	end

PlayerAlreadyMetProfessor:
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_05, MSG_FACE, gText_MomName
	spriteface MOM, LEFT
	release
	end

PlayerAlreadyDefeatedRival:
	faceplayer
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_HealPKMN, MSG_KEEPOPEN, gText_MomName
	closeonkeypress
	call HealPlayerParty
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_InformPlayerToComeBack, MSG_FACE, gText_MomName
	spriteface MOM, LEFT
	release
	end

PlayerAlreadyVisitedGoldtree: 
	faceplayer
	msgboxname gText_AerilonTown_PlayerHouse_PlayerMom_06, MSG_KEEPOPEN, gText_MomName
	closeonkeypress
	setflag 0x22F @Set again so mom says something different and heals party
	spriteface MOM, LEFT
	release
	end

HealPlayerParty:
	fadescreen 0x1
	fanfare 0x100
	waitfanfare
	special 0x0
	fadescreen 0x0
	return

#Sign scripts:
.global SignScript_AerilonTown_PlayerRoom_PersonalComputer
SignScript_AerilonTown_PlayerRoom_PersonalComputer:
	special 0x187
	compare LASTRESULT, 0x2
	if equal _goto EndScript
	lock
	setvar 0x8004, 0x20
	special 0x17D
	setvar 0x8004, 0x1
	special 0xD6
	sound 0x4
	msgbox gText_AerilonTown_PlayerRoom_PersonalComputerBootUp, MSG_KEEPOPEN
	special 0xF9
	waitstate
	special 0x190
	release
	end

EndScript:
	releaseall
	end

#Level scripts:
.equ MOM, 1
.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_WOKE_UP_IN_HOUSE, 0x0
.equ MAIN_STORY_TALKED_TO_MOM, 0x1

.global gMapScripts_AerilonTown_PlayerHouse
gMapScripts_AerilonTown_PlayerHouse:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AerilonTown_PlayerHouse
	.byte MAP_SCRIPT_TERMIN

LevelScripts_AerilonTown_PlayerHouse:
	levelscript VAR_MAIN_STORY, MAIN_STORY_WOKE_UP_IN_HOUSE, LevelScript_AerilonTown_PlayerHouse
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AerilonTown_PlayerHouse:
	lockall
	checksound
	sound 0x15
	applymovement MOM, m_LookUpExclaim
	waitmovement 0x0
	pause 0x1E
	msgboxname gText_AerilonTown_PlayerHouse_Mom_01, MSG_KEEPOPEN, gText_MomName
	closeonkeypress
	applymovement MOM, m_MomMoveToPlayer
	waitmovement 0x0
	spriteface PLAYER, DOWN
	msgboxname gText_AerilonTown_PlayerHouse_Mom_02a MSG_KEEPOPEN, gText_MomName
	fanfare 0x10D
	msgbox gText_AerilonTown_PlayerHouse_Mom_02b MSG_KEEPOPEN
	waitfanfare
	msgboxname gText_AerilonTown_PlayerHouse_Mom_02c MSG_KEEPOPEN, gText_MomName
	closeonkeypress
	applymovement MOM, m_MomMoveBackToSpot
	waitmovement 0x0
	setflag 0x82F @Enable running shoes
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_MOM
	releaseall
	end

m_LookUpExclaim: .byte look_up, exclaim, pause_long, pause_long, end_m
m_MomMoveToPlayer: .byte walk_right, walk_right, walk_up, end_m
m_MomMoveBackToSpot: .byte walk_down, walk_left, walk_left, end_m
