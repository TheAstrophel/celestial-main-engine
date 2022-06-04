.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

.global EventScript_Cut
EventScript_Cut:
	special 0x187
	compare LASTRESULT 0x2
	if equal _goto EventScript_Cut_Release
    lockall
	checkitem ITEM_HM01, 0x1 
	compare LASTRESULT, 0x1
	if lessthan _goto EventScript_Cut_CannotUseCut
	setvar 0x8009, 0
	callasm CanAnyPKMNInPartyLearnHM
	compare LASTRESULT, 0x1
	if equal _goto EventScript_Cut_UseCut
	goto EventScript_Cut_ReleaseAll

EventScript_Cut_Release:
	closeonkeypress
	release
	end

EventScript_Cut_CannotUseCut:
	msgbox gText_Cut_PlayerDoesNotHaveCut, MSG_SIGN
	releaseall
	end

EventScript_Cut_UseCut:
	msgbox gText_Cut_CutTreeQuestion, MSG_YESNO
	compare LASTRESULT, 0x0
	if equal _goto EventScript_Cut_Release
	closeonkeypress
	setanimation 0x0 0x8008
	doanimation 0x2
	waitstate
	sound 0x79
	applymovement LASTTALKED, m_TreeCutAnimation
	waitmovement 0x0
	hidesprite LASTTALKED
	releaseall
	end

EventScript_Cut_ReleaseAll:
	closeonkeypress
	releaseall
	end

m_TreeCutAnimation: .byte cut_tree, end_m
