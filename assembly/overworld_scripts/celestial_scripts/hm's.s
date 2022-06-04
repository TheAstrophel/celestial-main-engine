.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

.global EventScript_Cut
EventScript_Cut:
	special 0x187
	compare LASTRESULT, 0x2
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

@;////////////////////////////////////////////////

.global EventScript_RockSmash
EventScript_RockSmash:
	special 0x187
	compare LASTRESULT, 0x2
	if equal _goto EventScript_RockSmash_Release
	lockall
	checkitem ITEM_HM06, 0x1 
	compare LASTRESULT, 0x1
	if lessthan _goto EventScript_RockSmash_CannotUseRockSmash
	setvar 0x8009, 1
	callasm CanAnyPKMNInPartyLearnHM
	compare LASTRESULT, 0x1
	if lessthan _goto EventScript_RockSmash_CannotUseRockSmash
	msgbox gText_RockSmash_RockSmashQuestion, MSG_YESNO
	compare LASTRESULT, 0x0
	if equal _goto EventScript_RockSmash_ReleaseAll
	closeonkeypress
	setanimation 0x0 0x8008
	doanimation 0x25
	waitstate
	goto EventScript_RockSmash_UseRockSmash

EventScript_RockSmash_Release:
	release
	end

EventScript_RockSmash_CannotUseRockSmash:
	msgbox gText_RockSmash_PlayerDoesNotHaveRockSmash, MSG_SIGN 
	end

EventScript_RockSmash_ReleaseAll:
	closeonkeypress
	releaseall
	end

EventScript_RockSmash_UseRockSmash:
	applymovement LASTTALKED, m_RockSmashAnimation
	waitmovement 0x0
	hidesprite LASTTALKED
	special 0xAB
	compare LASTRESULT 0x0
	if 0x1 _goto EventScript_RockSmash_ReleaseAllTwo
	waitstate
	releaseall
	end

EventScript_RockSmash_ReleaseAllTwo:
	releaseall
	end

m_RockSmashAnimation: .byte smash_rock, end_m

@;////////////////////////////////////////////////

.global EventScript_Strength
EventScript_Strength:
	special 0x187
	compare LASTRESULT, 0x2
	if equal _goto EventScript_Strength_Release
	lockall
	checkflag 0x805
	if 0x1 _goto EventScript_Strength_PlayerHasUsedStrength
	checkitem ITEM_HM04, 0x1 
    compare LASTRESULT, 0x1
	if lessthan _goto EventScript_Strength_CannotUseStrength
	setvar 0x8009, 2
	callasm CanAnyPKMNInPartyLearnHM
	compare LASTRESULT, 0x1
	if lessthan _goto EventScript_Strength_CannotUseStrength
	goto EventScript_Strength_UseStrength

EventScript_Strength_Release:
	release
	end

EventScript_Strength_CannotUseStrength:
	msgbox gText_Strength_PlayerDoesNotHaveStrength, MSG_SIGN 
	end

EventScript_Strength_PlayerHasUsedStrength:
	msgbox gText_Strength_PlayerHasUsedStrength, MSG_SIGN 
	end

EventScript_Strength_ReleaseAll:
	closeonkeypress
	releaseall
	end

EventScript_Strength_UseStrength:
	msgbox gText_Strength_StrengthQuestion, MSG_YESNO
	compare LASTRESULT, 0x0
	if equal _goto EventScript_Strength_ReleaseAll
	closeonkeypress
	setanimation 0x0 0x8008
	doanimation 0x28
	waitstate
	bufferpokemon 0x0 0x800A
	setflag 0x805
	msgbox gText_Strength_PKMNUsedStrength, MSG_SIGN 
	end
