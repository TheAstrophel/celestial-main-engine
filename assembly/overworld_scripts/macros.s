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
signpost AerilonTown_PlayerRoomPrettyPic
signpost AerilonTown_PlayerRoomNES

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
