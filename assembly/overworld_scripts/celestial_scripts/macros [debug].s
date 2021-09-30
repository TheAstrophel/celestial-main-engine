# DUPLICATE SCRIPTS HERE

.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Script for macro:
.macro macromsgbox1 title:req, post:req, type:req
    msgbox \title\post, \type
.endm

.macro signpost scriptName:req
.global SignpostScript_\scriptName
SignpostScript_\scriptName:
    macromsgbox1 gText_\scriptName, Sign MSG_SIGN
    end
.endm

#Macro defines:
signpost AerilonTown_PlayerRoom_PrettyPicture
signpost AerilonTown_PlayerRoom_GameConsole
signpost AerilonTown_PlayerHouse
signpost AerilonTown_MainTown
signpost AerilonTown_AlmondResidence

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#Script for macro:
.macro macromsgbox2 title:req, post:req, type:req
    msgbox \title\post, \type
.endm

.macro npctalking scriptName:req
.global NPCTalkingScript_\scriptName
NPCTalkingScript_\scriptName:
    macromsgbox2 gText_\scriptName, NPC MSG_FACE
    end
.endm

#Macro defines:
npctalking AerilonTown_RockyCliffsBoy
npctalking AerilonTown_UselessResearchGirl
npctalking AerilonTown_FatGuy
npctalking AerilonTown_OldMan
npctalking AerilonTown_HouseLady
npctalking AerilonTown_HouseMan
npctalking AerilonTown_HouseGirl
npctalking AerilonHills_AlmondObservatory_FirstAide
npctalking AerilonHills_AlmondObservatory_ThirdAide
npctalking AerilonHills_AlmondObservatory_FourthAide
npctalking AerilonHills_AlmondObservatory_FifthAide
