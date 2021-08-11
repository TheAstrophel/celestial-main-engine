.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_AerilonTown_BossyGirl
NPCScript_AerilonTown_BossyGirl:
	compare 0x4011, 0x3 @0x4011 is set to 0x3 when [player] has received starter
	if equal _goto OtherMessageFromBossyGirl
	msgbox gText_AerilonTown_BossyGirl_01, MSG_FACE
	end
	
OtherMessageFromBossyGirl:
	msgbox gText_AerilonTown_BossyGirl_02, MSG_FACE
	end

#Tile scripts:
.global TileScript_AerilonTown_PlayerTriesToLeave
TileScript_AerilonTown_PlayerTriesToLeave:
	lock
	checksound
	sound 0x15
	applymovement 0x4, m_LookDownExclaim @0x4 is the girl standing at right edge of town
	waitmovement 0x0
	msgbox gText_AerilonTown_BossyGirl_03, MSG_KEEPOPEN
	waitmsg
	closeonkeypress
	applymovement PLAYER, m_StepLeft
	waitmovement 0x0
	release
	end

m_LookDownExclaim: .byte look_down, exclaim, pause_long, pause_long, pause_long, end_m
m_StepLeft: .byte walk_left_slow, end_m

#Level scripts:
.equ PROF_AIDE, 2
.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_LEAVE_HOUSE, 0x1
.equ MAIN_STORY_TALKED_TO_PROF_AIDE, 0x2

.global gMapScripts_AerilonTown
gMapScripts_AerilonTown:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AerilonTown
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_AerilonTown
	.byte MAP_SCRIPT_TERMIN
	
LevelScripts_AerilonTown: 
	levelscript VAR_MAIN_STORY, MAIN_STORY_LEAVE_HOUSE, LevelScript_AerilonTown
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AerilonTown:
	lockall
	msgbox gText_AerilonTown_Aide_01, MSG_KEEPOPEN
	closeonkeypress
	checksound
	sound 0x15
	applymovement PLAYER, m_LookRightQuestion
	waitmovement 0x0
	applymovement PROF_AIDE, m_WalkLeftTowardsPlayer
	waitmovement 0x0
	msgbox gText_AerilonTown_Aide_02, MSG_KEEPOPEN
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
	preparemsg gText_AerilonTown_PlayerHouse_Mom_01
	waitmsg
	pause 0x3A
	closeonkeypress
	applymovement MOM, m_MomMoveToPlayer
	waitmovement 0x0
	spriteface PLAYER, DOWN
	msgbox gText_AerilonTown_PlayerHouse_Mom_02a MSG_KEEPOPEN
	fanfare 0x10D
	msgbox gText_AerilonTown_PlayerHouse_Mom_02b MSG_KEEPOPEN
	waitfanfare
	msgbox gText_AerilonTown_PlayerHouse_Mom_02c MSG_KEEPOPEN
	closeonkeypress
	applymovement MOM, m_MomMoveBackToSpot
	waitmovement 0x0
	setflag 0x82F @Enable running shoes
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_MOM
	releaseall
	end

m_LookUpExclaim: .byte look_up, exclaim, end_m
m_MomMoveToPlayer: .byte walk_right, walk_right, walk_up, end_m
m_MomMoveBackToSpot: .byte walk_down, walk_left, walk_left, end_m
