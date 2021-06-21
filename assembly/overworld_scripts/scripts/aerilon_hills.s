# ALL DUPLICATE SCRIPTS IN MACROS.S

.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# NPC scripts:

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Sign scripts:

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Tile scripts:

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
# Level scripts:

.equ VAR_MAIN_STORY, 0x4011
.equ MAIN_STORY_GOING_TO_PROFESSOR_LAB, 0x2
.equ MAIN_STORY_TALKED_TO_PROFESSOR_LAB, 0x3

.equ PROF_AIDE, 4
.equ PROF, 1

.global gMapScripts_AlmondLab
gMapScripts_AlmondLab:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AlmondLab
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_AlmondLab
	.byte MAP_SCRIPT_TERMIN

LevelScripts_AlmondLab:
	levelscript VAR_MAIN_STORY, MAIN_STORY_GOING_TO_PROFESSOR_LAB, LevelScript_AlmondLab
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AlmondLab:
	lockall
	applymovement PROF_AIDE m_GoToProfessor
	applymovement PLAYER m_GoToProfessor
	waitmovement 0x0
	clearflag 0x4001
	playsong2 0x0
	fadedefault
	msgbox gText_AlmondLab_Aide1 0x4
	closeonkeypress
	applymovement PROF m_ProfStepOnSpot
	waitmovement 0x0
	msgbox gText_AlmondLab_Prof1 0x4
	closeonkeypress
	msgbox gText_AlmondLab_Aide2 0x4
	closeonkeypress
	spriteface PROF_AIDE DOWN
	pause 0x14
	msgbox gText_AlmondLab_Aide3 0x4
	closeonkeypress
	applymovement PROF_AIDE m_ProfAideLeave
	waitmovement 0x0
	applymovement PLAYER m_PlayerStepUp
	waitmovement 0x0
	msgbox gText_AlmondLab_Prof2 0x4
	closeonkeypress
	applymovement PROF m_ProfStepUpAndLeave
	waitmovement 0x0
	sound 0x9
	applymovement PROF m_Vanish
	waitmovement 0x0
	applymovement PLAYER m_PlayerStepUpAndLeave
	waitmovement 0x0
	sound 0x9
	applymovement PLAYER m_Vanish
	waitmovement 0x0
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_PROFESSOR_LAB
	clearflag 0x1FF
	clearflag 0x200
	warp 0xF 0x1 0x1 0x0 0x0
	release
	end

m_GoToProfessor: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_ProfStepOnSpot: .byte pause_short, pause_short, walk_down_onspot, pause_short, pause_short, pause_short, end_m
m_ProfAideLeave: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, pause_short, pause_short, end_m
m_PlayerStepUp: .byte walk_up, pause_short, pause_short, pause_short, end_m
m_ProfStepUpAndLeave: .byte walk_up, walk_up, walk_up, walk_up, end_m
m_PlayerStepUpAndLeave: .byte walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_Vanish: .byte pause_short, set_invisible, end_m

MapEntryScript_AlmondLab:
	compare 0x4011 0x2
	if equal _call MapEntryScript_AlmondLab_FirstTimeEntering
	end
	
MapEntryScript_AlmondLab_FirstTimeEntering:
	spriteface 0x4 UP
	movesprite2 0x4 0xA 0xD
	playsong2 0x12E
	return
