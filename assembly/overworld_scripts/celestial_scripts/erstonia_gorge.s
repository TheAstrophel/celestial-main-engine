.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#NPC scripts:
.global NPCScript_ErstoniaGorge_ItemObtainGreatBall
NPCScript_ErstoniaGorge_ItemObtainGreatBall:
	giveitem 0x3 0x1, MSG_FIND
	call SetItemFlag_ItemObtainGreatBall
	end

SetItemFlag_ItemObtainGreatBall:
	setflag 0x15A @Person ID of Apicot Berry in A-Map
	return

@;////////////////////////////////////////////////

.global NPCScript_ErstoniaGorge_ItemObtainElectricGem
NPCScript_ErstoniaGorge_ItemObtainElectricGem:
	giveitem 0x29B 0x1, MSG_FIND
	call SetItemFlag_ItemObtainElectricGem
	end

SetItemFlag_ItemObtainElectricGem:
	setflag 0x15B @Person ID of Electric Gem in A-Map
	return
