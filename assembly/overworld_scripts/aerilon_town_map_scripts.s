.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.global MapScripts_AerilonTown_PlayerRoom
PlayerRoomSetHealingPlace:
	compare 0x4056 0x0
	if equal _call SetHealingPlace
	end
	
SetHealingPlace:
	sethealingplace 0x1
	return
	
PlayerRoomSpriteFace:
	spriteface 0xFF look_up
	setvar 0x4056 0x1
	end

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

.global MapScripts_AerilonTown_PlayerHouse
AerilonTown_PlayerHouse:
	lockall
	checksound
	sound 0x15
	applymovement 0x0 move1
	waitmovement 0x0
	pause 0x1E
	preparemsg gText_AerilonTown_Mom1
	waitmsg
	pause 0x55
	closeonkeypress
	applymovement 0x0 move2
	waitmovement 0x0
	spriteface 0xFF look_down
	msgbox gText_AerilonTown_Mom2a MSG_KEEPOPEN
	fanfare 0x10D
	msgbox gText_AerilonTown_Mom2b MSG_KEEPOPEN
	waitfanfare
	closeonkeypress
	msgbox gText_AerilonTown_Mom2c MSG_KEEPOPEN
	closeonkeypress
	applymovement 0x0 move3
	waitmovement 0x0
	setflag 0x82F
	releaseall
	end

move1:
.byte look_up, end_m
.byte exclaim, end_m
.byte end_m, end_m

move2:
.byte walk_right, end_m
.byte walk_right, end_m
.byte walk_up, end_m
.byte end_m, end_m

move3:
.byte walk_down, end_m
.byte walk_left, end_m
.byte walk_left, end_m
.byte end_m, end_m
