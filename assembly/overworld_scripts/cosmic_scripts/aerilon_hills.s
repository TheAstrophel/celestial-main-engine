.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.equ PROF_AIDE, 1
.equ VAR_MAIN_STORY, 0x4029
.equ VAR_EXTRA, 0x51FD
.equ MAIN_STORY_WARPED_TO_OBSERVATORY, 0x2

.global NPCScript_AerilonHills_AideAtTheBaseOfObservatory
NPCScript_AerilonHills_AideAtTheBaseOfObservatory:
	lock
	faceplayer
	compare VAR_EXTRA 0x1 @Set to 0x1 if [player] says no to avoid a loop
	if equal _goto MetAideBeforeByTalking
	msgboxname gText_AerilonHills_ProfAide_01, MSG_YESNO, gText_AideName
	compare LASTRESULT, 0x1
	if equal _goto PlayerSaysYesByTalking
	compare LASTRESULT, 0x0
	if equal _goto PlayerSaysNoByTalking
	release
	end

PlayerSaysYesByTalking:
	lock
	playsong 0x12E 0x0
	msgboxname gText_AerilonHills_ProfAide_02, MSG_KEEPOPEN, gText_AideName
	closeonkeypress
	call MoveTowardsObservatoryIfPlayerTalksToAide
	opendoor 0x2B 0x2B
	waitdooranim
	applymovement PROF_AIDE, m_ProfAideEntersObservatoryWhenPlayerTalked
	applymovement PLAYER, m_PlayerEntersObservatoryWhenPlayerTalked
	waitmovement 0x0
	closedoor 0x2B 0x2B
	waitdooranim
	hidesprite PROF_AIDE
	setvar VAR_EXTRA, 0 @Will be used later in other scripts
	setvar VAR_MAIN_STORY, MAIN_STORY_WARPED_TO_OBSERVATORY
	setflag 0x2C @Person ID of Aide in A-Map
	setflag 0x4001 @Set so song does not stop
	warp 0xF 0x0 0x1 0xE 0xD
	waitstate
	release
	end

MoveTowardsObservatoryIfPlayerTalksToAide:
	applymovement PROF_AIDE, m_AideWalksToObservatory
	applymovement PLAYER, m_FollowingAide
	waitmovement 0x0
	return

PlayerSaysNoByTalking:
	lock
	msgboxname gText_AerilonHills_ProfAide_03, MSG_KEEPOPEN, gText_AideName
	closeonkeypress
	spriteface PLAYER, DOWN
	spriteface PROF_AIDE, DOWN
	spritebehave PROF_AIDE, 0x16
	setvar VAR_EXTRA, 1 @Set to avoid loop
	release
	end

MetAideBeforeByTalking:
	msgboxname gText_AerilonHills_ProfAide_04, MSG_YESNO, gText_AideName
	compare LASTRESULT, 0x1
	if equal _goto PlayerSaysYesByTalking
	compare LASTRESULT, 0x0
	if equal _goto PlayerSaysNoByTalking
	release
	end

m_ProfAideEntersObservatoryWhenPlayerTalked: .byte walk_up, set_invisible, end_m
m_PlayerEntersObservatoryWhenPlayerTalked: .byte walk_up, walk_up, set_invisible, end_m
m_AideWalksToObservatory: .byte walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAide: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m

#Tile scripts:
.equ PROF_AIDE, 1
.equ VAR_MAIN_STORY, 0x4029
.equ VAR_EXTRA, 0x51FD
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ MAIN_STORY_WARPED_TO_OBSERVATORY, 0x2

.global TileScript_AerilonHills_AideAtTheBaseOfObservatory
TileScript_AerilonHills_AideAtTheBaseOfObservatory:
	lock
	sound 0x15
	applymovement PROF_AIDE, m_LookAtPlayerExclaim
	waitmovement 0x0
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_1, 0x1D @X-Pos equals 0x1D
	if equal _call PlayerFaceRight
	compare VAR_TEMP_1, 0x1F @X-Pos equals 0x1F
	if equal _call PlayerFaceLeft
	compare VAR_EXTRA 0x1 @Set to 0x1 if [player] says no to avoid a loop
	if equal _goto MetAideBefore
	msgboxname gText_AerilonHills_ProfAide_01, MSG_YESNO, gText_AideName
	compare LASTRESULT, 0x1
	if equal _goto PlayerSaysYes
	compare LASTRESULT, 0x0
	if equal _goto PlayerSaysNo
	release
	end

PlayerFaceRight:
	spriteface PLAYER, RIGHT
	return

PlayerFaceLeft:
	spriteface PLAYER, LEFT
	return

PlayerSaysYes:
	lock
	playsong 0x12E 0x0
	msgboxname gText_AerilonHills_ProfAide_02, MSG_KEEPOPEN, gText_AideName
	closeonkeypress
	compare VAR_TEMP_1, 0x1D @X-Pos equals 0x1D
	if equal _call MoveTowardsObservatoryIfScriptNumberZero
	compare VAR_TEMP_1, 0x1F @X-Pos equals 0x1F
	if equal _call MoveTowardsObservatoryIfScriptNumberOne
	opendoor 0x2B 0x2B
	waitdooranim
	applymovement PROF_AIDE, m_ProfAideEntersObservatory
	applymovement PLAYER, m_PlayerEntersObservatory
	waitmovement 0x0
	closedoor 0x2B 0x2B
	waitdooranim
	hidesprite PROF_AIDE
	setvar VAR_EXTRA, 0 @Will be used later in other scripts
	setvar VAR_TEMP_1, 0 @Will be used later in other scripts
	setvar VAR_TEMP_2, 0 @Will be used later in other scripts
	setvar VAR_MAIN_STORY, MAIN_STORY_WARPED_TO_OBSERVATORY
	setflag 0x2C @Person ID of Aide in A-Map
	setflag 0x4001 @Set so song does not stop
	warp 0xF 0x0 0x1 0xE 0xD
	waitstate
	release
	end

MoveTowardsObservatoryIfScriptNumberZero:
	applymovement PROF_AIDE, m_AideWalksToObservatoryIfScriptNumberZero
	applymovement PLAYER, m_FollowingAideIfScriptNumberZero
	waitmovement 0x0
	return

MoveTowardsObservatoryIfScriptNumberOne:
	applymovement PROF_AIDE, m_AideWalksToObservatoryIfScriptNumberOne
	applymovement PLAYER, m_FollowingAideIfScriptNumberOne
	waitmovement 0x0
	return

PlayerSaysNo:
	lock
	msgboxname gText_AerilonHills_ProfAide_03, MSG_KEEPOPEN, gText_AideName
	closeonkeypress
	applymovement PLAYER, m_Leaving
	waitmovement 0x0
	spriteface PROF_AIDE, DOWN
	spritebehave PROF_AIDE, 0x16
	setvar VAR_EXTRA, 1 @Set to avoid loop
	release
	end

MetAideBefore:
	msgboxname gText_AerilonHills_ProfAide_04, MSG_YESNO, gText_AideName
	compare LASTRESULT, 0x1
	if equal _goto PlayerSaysYes
	compare LASTRESULT, 0x0
	if equal _goto PlayerSaysNo
	release
	end

m_LookAtPlayerExclaim: .byte face_player, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, end_m
m_ProfAideEntersObservatory: .byte walk_up, set_invisible, end_m
m_PlayerEntersObservatory: .byte walk_up, walk_up, set_invisible, end_m
m_AideWalksToObservatoryIfScriptNumberZero: .byte walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAideIfScriptNumberZero: .byte walk_right, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_AideWalksToObservatoryIfScriptNumberOne: .byte walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, walk_up, end_m
m_FollowingAideIfScriptNumberOne: .byte walk_left, walk_up, walk_up, walk_up, walk_up, walk_right, walk_right, walk_right, walk_up, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_right, walk_up, walk_up, end_m
m_Leaving: .byte walk_down_very_slow, end_m

@#Level scripts:
.equ RIVAL, 2
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_MEETING_RIVAL_OUTSIDE_OBSERVATORY, 0x4
.equ MAIN_STORY_MET_RIVAL_OUTSIDE_OBSERVATORY, 0x5

.global gMapScripts_AerilonHills
gMapScripts_AerilonHills:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AerilonHills
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_AerilonHills
	.byte MAP_SCRIPT_TERMIN

LevelScripts_AerilonHills:
	levelscript VAR_MAIN_STORY, MAIN_STORY_MEETING_RIVAL_OUTSIDE_OBSERVATORY, LevelScript_AerilonHills
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AerilonHills:
	lock
	pause 0x5
	sound 0x15
	applymovement RIVAL, m_RivalNoticesPlayer
	waitmovement 0x0
	msgboxname gText_AerilonHills_Rival_01, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_RivalLeaves
	waitmovement 0x0
	pause 0x1E
	setvar VAR_MAIN_STORY, MAIN_STORY_MET_RIVAL_OUTSIDE_OBSERVATORY
	hidesprite RIVAL
	setflag 0x2B @Person ID of Rival in A-Map
	release
	end

m_RivalNoticesPlayer: .byte look_up, exclaim, pause_long, pause_long, pause_long, pause_short, pause_short, walk_up, walk_up, end_m
m_RivalLeaves: .byte walk_down, walk_down, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, end_m

MapEntryScript_AerilonHills:
	compare VAR_MAIN_STORY, MAIN_STORY_MEETING_RIVAL_OUTSIDE_OBSERVATORY
	if equal _call MapEntryScript_AerilonHills_MeetingRivalOutsideObservatory
	end
	
MapEntryScript_AerilonHills_MeetingRivalOutsideObservatory:
	showsprite RIVAL
	clearflag 0x2B @Person ID Rival in A-Map
	return

#@@@@@@@@;Sub-maps;@@@@@@@@
#NPC scripts:
.global NPCScript_AerilonHills_AlmondObservatory_SecondAide @Could not include in macros
NPCScript_AerilonHills_AlmondObservatory_SecondAide:
	lock
	msgbox gText_AerilonHills_AlmondObservatory_SecondAide, MSG_SIGN
	end

@;////////////////////////////////////////////////

.global NPCScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_ProfAlmondIdle
NPCScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_ProfAlmondIdle:
	lock
	faceplayer
	msgboxname gText_AerilonHills_AlmondObservatory_ProfAlmondIdle, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	spriteface 0x4, LEFT
	end

@;////////////////////////////////////////////////

.global NPCScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_RivalIdle
NPCScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_RivalIdle:
	lock
	faceplayer
	msgboxname gText_AerilonHills_AlmondObservatory_RivalIdle, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	spriteface 0x5, LEFT
	end

@;////////////////////////////////////////////////

.equ TREECKO, 1
.equ TORCHIC, 2
.equ MUDKIP, 3
.equ PROF, 4
.equ RIVAL, 5
.equ FLAG_TREECKO, 0x28
.equ FLAG_TORCHIC, 0x29
.equ FLAG_MUDKIP, 0x2A
.equ VAR_MAIN_STORY, 0x4029
.equ VAR_STARTER_MON, 0x51F0
.equ VAR_TEMP_1, 0x51FE
.equ VAR_TEMP_2, 0x51FF
.equ MAIN_STORY_RECEIVED_STARTER, 0x4

.global NPCScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_StarterOptions
NPCScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_StarterOptions:
	lock
	faceplayer
	compare VAR_MAIN_STORY, MAIN_STORY_RECEIVED_STARTER
	if greaterorequal _goto LastStarter
	spriteface PROF, LEFT
	spriteface RIVAL, LEFT
	getplayerpos VAR_TEMP_1, VAR_TEMP_2
	compare VAR_TEMP_1, 0x3 @X-Pos equals 0x3
	if equal _call FirstStarter
	compare VAR_TEMP_1, 0x4 @X-Pos equals 0x4
	if equal _call FirstStarter
	compare VAR_TEMP_1, 0x5 @X-Pos equals 0x5
	if equal _call SecondStarter
	compare VAR_TEMP_1, 0x6 @X-Pos equals 0x6
	if equal _call ThirdStarter
	compare VAR_TEMP_1, 0x7 @X-Pos equals 0x7
	if equal _call ThirdStarter
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_ProfCongratulates, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	applymovement PROF, m_ProfLeavesOffice
	waitmovement 0x0
	checksound
	sound 0x9
	hidesprite PROF
	setmaptile 0x5 0x7 0x89 0x0
	special 0x8E
	pause 0x1E
	setvar VAR_MAIN_STORY, MAIN_STORY_RECEIVED_STARTER
	setflag 0x2D @Person ID of Professor in A-Map
	setflag 0x2C @Person ID of Rival in A-Map
	end

m_ProfLeavesOffice: .byte walk_left, walk_left, walk_down, walk_down, walk_down, pause_long, walk_down_onspot, end_m

FirstStarter:
	setvar VAR_STARTER_MON, 0x1
	spriteface PROF, LEFT
	showpokepic 0x115 0xA 0x3
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_TreeckoPrompt, MSG_YESNO, gText_ProfAlmondSmallName
	compare LASTRESULT 0x0
	if equal _goto ReleaseEnd
	hidepokepic
	hidesprite LASTTALKED
	msgbox gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_EnergecticPokemon, MSG_KEEPOPEN
	setflag 0x828
	givepokemon 0x115 0x5 0x0 0x0 0x0 0x0 @Treecko
	bufferpokemon 0x0 0x115
	preparemsg gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_ReceivedStarter
	waitmsg
	fanfare 0x13E
	waitfanfare
	msgbox gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_NicknamePokemonPrompt, MSG_YESNO
	compare LASTRESULT 0x1
	if equal _call NicknameStarter
	closeonkeypress
	applymovement RIVAL, m_MoveTowardsTorchic
	waitmovement 0x0
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_PreRivalSelectsPokemon, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	hidesprite TORCHIC
	bufferpokemon 0x0 0x118
	preparemsg gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_RivalSelectsPokemon
	waitmsg
	fanfare 0x13E
	waitfanfare
	spriteface RIVAL, LEFT
	spriteface PLAYER, RIGHT
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_RivalSpeaksBeforeLeaving, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_LeaveOfficeWithTorchic
	waitmovement 0x0
	checksound
	sound 0x9
	hidesprite RIVAL
	pause 0x1E
	setflag FLAG_TREECKO
	setflag FLAG_TORCHIC
	return

m_MoveTowardsTorchic: .byte walk_left, walk_left, walk_up, walk_up, end_m
m_LeaveOfficeWithTorchic: .byte walk_down, walk_down, walk_down, walk_down, pause_long, walk_down_onspot, end_m

SecondStarter:
	setvar VAR_STARTER_MON, 0x2
	spriteface PROF, LEFT
	showpokepic 0x118 0xA 0x3
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_TorchicPrompt, MSG_YESNO, gText_ProfAlmondSmallName
	compare LASTRESULT 0x0
	if equal _goto ReleaseEnd
	hidepokepic
	hidesprite LASTTALKED
	msgbox gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_EnergecticPokemon, MSG_KEEPOPEN
	setflag 0x828
	givepokemon 0x118 0x64 0x0 0x0 0x0 0x0 @Torchic @debug
	bufferpokemon 0x0 0x118
	preparemsg gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_ReceivedStarter
	waitmsg
	fanfare 0x13E
	waitfanfare
	msgbox gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_NicknamePokemonPrompt, MSG_YESNO
	compare LASTRESULT 0x1
	if equal _call NicknameStarter
	closeonkeypress
	applymovement RIVAL, m_MoveTowardsMudkip
	waitmovement 0x0
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_PreRivalSelectsPokemon, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	hidesprite MUDKIP
	bufferpokemon 0x0 0x11B
	preparemsg gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_RivalSelectsPokemon
	waitmsg
	fanfare 0x13E
	waitfanfare
	spriteface RIVAL, LEFT
	spriteface PLAYER, RIGHT
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_RivalSpeaksBeforeLeaving, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_LeaveOfficeWithMudkip
	waitmovement 0x0
	checksound
	sound 0x9
	hidesprite RIVAL
	pause 0x1E
	setflag FLAG_TORCHIC
	setflag FLAG_MUDKIP
	return

m_MoveTowardsMudkip: .byte walk_left, walk_up, walk_up, end_m
m_LeaveOfficeWithMudkip: .byte walk_down, walk_down, walk_down, walk_left, walk_down, pause_long, walk_down_onspot, end_m

ThirdStarter:
	setvar VAR_STARTER_MON, 0x3
	showpokepic 0x11B 0xA 0x3
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_MudkipPrompt, MSG_YESNO, gText_ProfAlmondSmallName
	compare LASTRESULT 0x0
	if equal _goto ReleaseEnd
	hidepokepic
	hidesprite LASTTALKED
	msgbox gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_EnergecticPokemon, MSG_KEEPOPEN
	setflag 0x828
	givepokemon 0x11B 0x5 0x0 0x0 0x0 0x0 @Mudkip
	bufferpokemon 0x0 0x11B
	preparemsg gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_ReceivedStarter
	waitmsg
	fanfare 0x13E
	waitfanfare
	msgbox gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_NicknamePokemonPrompt, MSG_YESNO
	compare LASTRESULT 0x1
	if equal _call NicknameStarter
	closeonkeypress
	applymovement RIVAL, m_MoveTowardsTreecko
	waitmovement 0x0
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_PreRivalSelectsPokemon, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	hidesprite TREECKO
	bufferpokemon 0x0 0x115
	preparemsg gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_RivalSelectsPokemon
	waitmsg
	fanfare 0x13E
	waitfanfare
	spriteface RIVAL, RIGHT
	spriteface PLAYER, LEFT
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_RivalSpeaksBeforeLeaving, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_LeaveOfficeWithTreecko
	waitmovement 0x0
	checksound
	sound 0x9
	hidesprite RIVAL
	pause 0x1E
	spriteface PLAYER, DOWN
	spriteface PROF, UP
	setflag FLAG_MUDKIP
	setflag FLAG_TREECKO
	return

m_MoveTowardsTreecko: .byte walk_left, walk_left, walk_left, walk_up, walk_up, end_m
m_LeaveOfficeWithTreecko: .byte walk_down, walk_down, walk_right, walk_down, walk_down, pause_long, walk_down_onspot, end_m

ReleaseEnd:
	hidepokepic
	release
	end

NicknameStarter:
	fadescreen 0x1
	special 0x9E
	waitstate
	return

LastStarter:
	msgbox gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_LastStarter, MSG_FACE
	release
	end

#Tile scripts:
.equ PROF, 4

.global TileScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_TryingToLeave @Before receiving starter
TileScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_TryingToLeave:
	lock
	spriteface PROF, DOWN
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_TryingToLeavePrompt, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	applymovement PLAYER, m_WalkUp
	waitmovement 0x0
	spriteface PROF, LEFT
	release
	end

m_WalkUp: .byte walk_up_very_slow, pause_short, end_m

#Level scripts:
.equ PROF, 1
.equ PROF_AIDE, 2
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_GOING_TO_PROFESSOR, 0x2
.equ MAIN_STORY_TALKED_TO_PROFESSOR, 0x2

.global gMapScripts_AerilonHills_AlmondObservatory
gMapScripts_AerilonHills_AlmondObservatory:
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AerilonHills_AlmondObservatory
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_AerilonHills_AlmondObservatory
	.byte MAP_SCRIPT_TERMIN

LevelScripts_AerilonHills_AlmondObservatory:
	levelscript VAR_MAIN_STORY, MAIN_STORY_GOING_TO_PROFESSOR, LevelScript_AerilonHills_AlmondObservatory
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AerilonHills_AlmondObservatory:
	lockall
	applymovement PROF_AIDE, m_MoveTowardsProfessor
	applymovement PLAYER, m_MoveTowardsProfessor
	waitmovement 0x0
	clearflag 0x4001 @Had been set so song does not stop
	playsong2 0x0
	fadedefault
	msgboxname gText_AerilonHills_AlmondObservatory_Aide_01, MSG_KEEPOPEN, gText_AideName
	closeonkeypress
	applymovement PROF, m_ProfStepOnSpot
	waitmovement 0x0
	msgboxname gText_AerilonHills_AlmondObservatory_Prof_01, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	msgboxname gText_AerilonHills_AlmondObservatory_Aide_02, MSG_KEEPOPEN, gText_AideName
	closeonkeypress
	spriteface PROF_AIDE, DOWN
	pause 0x20
	msgboxname gText_AerilonHills_AlmondObservatory_Aide_03, MSG_KEEPOPEN, gText_AideName
	closeonkeypress
	applymovement PROF_AIDE, m_ProfAideLeave
	waitmovement 0x0
	applymovement PLAYER, m_PlayerStepUp
	waitmovement 0x0
	msgboxname gText_AerilonHills_AlmondObservatory_Prof_02, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	applymovement PROF, m_ProfStepUpAndLeave
	waitmovement 0x0
	sound 0x9
	applymovement PROF, m_SetInvisible
	waitmovement 0x0
	applymovement PLAYER, m_PlayerStepUpAndLeave
	waitmovement 0x0
	applymovement PLAYER, m_SetInvisible
	waitmovement 0x0
	setvar VAR_MAIN_STORY, MAIN_STORY_TALKED_TO_PROFESSOR
	warp 0xF 0x1 0x1 0x0 0x0
	waitstate
	release
	end

m_MoveTowardsProfessor: .byte walk_up, walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_ProfStepOnSpot: .byte pause_short, pause_short, walk_down_onspot, pause_short, pause_short, pause_short, end_m
m_ProfAideLeave: .byte walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, walk_left, pause_short, pause_short, end_m
m_PlayerStepUp: .byte walk_up, pause_short, pause_short, pause_short, end_m
m_ProfStepUpAndLeave: .byte walk_up, walk_up, walk_up, walk_up, end_m
m_PlayerStepUpAndLeave: .byte walk_up, walk_up, walk_up, walk_up, walk_up, end_m
m_SetInvisible: .byte pause_short, set_invisible, end_m

MapEntryScript_AerilonHills_AlmondObservatory:
	compare VAR_MAIN_STORY, MAIN_STORY_GOING_TO_PROFESSOR
	if equal _call MapEntryScript_AerilonHills_AlmondObservatory_FirstTimeEntering
	end
	
MapEntryScript_AerilonHills_AlmondObservatory_FirstTimeEntering:
	spriteface PROF_AIDE, UP
	movesprite2 PROF_AIDE, 0xA 0xD
	playsong2 0x12E
	return

@;////////////////////////////////////////////////

.equ PROF, 4
.equ RIVAL, 5
.equ VAR_MAIN_STORY, 0x4029
.equ MAIN_STORY_RECEIVING_STARTER, 0x2
.equ MAIN_STORY_GOING_TO_GET_STARTER, 0x3

.global gMapScripts_AerilonHills_AlmondObservatory_OfficeOfProfessor
gMapScripts_AerilonHills_AlmondObservatory_OfficeOfProfessor:
	mapscript MAP_SCRIPT_ON_LOAD SetmaptileScript_AerilonHills_AlmondObservatory_OfficeOfProfessor
	mapscript MAP_SCRIPT_ON_FRAME_TABLE LevelScripts_AerilonHills_AlmondObservatory_OfficeOfProfessor
	mapscript MAP_SCRIPT_ON_WARP_INTO_MAP_TABLE SecondaryLevelScripts_AlmondObservatory_OfficeOfProfessor
	.byte MAP_SCRIPT_TERMIN

.global SetmaptileScript_AerilonHills_AlmondObservatory_OfficeOfProfessor
SetmaptileScript_AerilonHills_AlmondObservatory_OfficeOfProfessor:
	compare VAR_MAIN_STORY, MAIN_STORY_GOING_TO_GET_STARTER
	if greaterorequal _call SetmaptileScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_DoorMat
	end

SetmaptileScript_AerilonHills_AlmondObservatory_OfficeOfProfessor_DoorMat:
	setmaptile 0x5 0x7 0x89 0x0
	end

LevelScripts_AerilonHills_AlmondObservatory_OfficeOfProfessor:
	levelscript VAR_MAIN_STORY, MAIN_STORY_RECEIVING_STARTER, LevelScript_AerilonHills_AlmondObservatory_OfficeOfProfessor
	.hword LEVEL_SCRIPT_TERMIN

LevelScript_AerilonHills_AlmondObservatory_OfficeOfProfessor:
	lockall
	applymovement PLAYER, m_MoveUpTowardsProfessor
	waitmovement 0x0
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_Prof_01, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	checksound
	sound 0x15
	applymovement PLAYER, m_Exclaim
	waitmovement 0x0
	pause 0x50
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_Prof_02, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	showsprite RIVAL
	spriteface RIVAL, UP
	clearflag 0x2C @Person ID of Rival in A-Map
	checksound
	sound 0x9
	pause 0x20
	applymovement RIVAL, m_WalkTowardsPlayerAndProfessor
	waitmovement 0x0
	spriteface PROF, LEFT
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_Rival_01, MSG_KEEPOPEN, gText_UnknownName
	closeonkeypress
	pause 0x20
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_Prof_03, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	spriteface PROF, DOWN
	pause 0x20
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_Prof_04, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	call NamingRival
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_Prof_05, MSG_KEEPOPEN, gText_ProfAlmondName
	closeonkeypress
	applymovement PROF, m_StepRightAndLookLeft
	waitmovement 0x0
	applymovement RIVAL, m_StepInfrontOfPlayer
	waitmovement 0x0
	msgboxname gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_Rival_02, MSG_KEEPOPEN, gText_RivalName
	closeonkeypress
	applymovement RIVAL, m_StepRightAndLookLeftAtPlayer
	waitmovement 0x0
	pause 0x20
	setvar VAR_MAIN_STORY, MAIN_STORY_GOING_TO_GET_STARTER
	releaseall
	end

NamingRival:
	fadescreen 0x1
	callasm 0x871BC01 @Rival naming routine
	fadescreen 0x0
	msgbox gText_AerilonHills_AlmondObservatory_OfficeOfProfessor_ConfirmRivalName, MSG_YESNO
	compare LASTRESULT, 0x0
	if equal _goto NamingRival
	closeonkeypress
	return

m_MoveUpTowardsProfessor: .byte walk_up, walk_up, end_m
m_Exclaim: .byte exclaim, end_m
m_WalkTowardsPlayerAndProfessor: .byte walk_up, walk_left, walk_up, walk_up, look_right, end_m
m_StepRightAndLookLeft: .byte walk_right, walk_right, look_left, end_m
m_StepInfrontOfPlayer: .byte walk_right, look_down, end_m
m_StepRightAndLookLeftAtPlayer: .byte walk_right, walk_down, walk_right, look_left, end_m

SecondaryLevelScripts_AlmondObservatory_OfficeOfProfessor:
	levelscript VAR_MAIN_STORY, MAIN_STORY_RECEIVING_STARTER, SecondaryLevelScript_AlmondObservatory_OfficeOfProfessor
	.hword LEVEL_SCRIPT_TERMIN

SecondaryLevelScript_AlmondObservatory_OfficeOfProfessor:
	spriteface PLAYER, UP
	end
