# DUPLICATE SCRIPTS HERE

.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@s
#Script for macro:
.macro macromsgbox2 title:req, post:req, type:req
    msgbox \title\post, \type
.endm

.macro npctalking scriptName:req
.global NPCTalkingScript_\scriptName
NPCTalkingScript_\scriptName:
    lock
	faceplayer 
    macromsgbox2 gText_\scriptName, NPC MSG_NORMAL
	closeonkeypress
    end
.endm

#Macro defines:
npctalking AerilonTown_RockyCliffsBoy
npctalking AerilonTown_UselessResearchGirl
npctalking AerilonTown_FatGuy
npctalking AerilonTown_OldMan
npctalking AerilonTown_House_HouseLady
npctalking AerilonTown_House_HouseMan
npctalking AerilonTown_House_HouseGirl
npctalking AerilonHills_AlmondObservatory_FirstAide
npctalking AerilonHills_AlmondObservatory_ThirdAide
npctalking AerilonHills_AlmondObservatory_FourthAide
npctalking AerilonHills_AlmondObservatory_FifthAide
npctalking AerilonHills_AlmondObservatory_SixthAide
npctalking AerilonHills_AlmondObservatory_OfficeOfProfessor_ProfessorAlmond
npctalking AerilonHills_AlmondObservatory_OfficeOfProfessor_Rival
npctalking AerilonPass_OranBerryBoy
npctalking AerilonPass_TallGrassGirl
npctalking GoldtreeVillage_TreasureWoodsBugCatcher
npctalking GoldtreeVillage_NameMysteryBoy
npctalking GoldtreeVillage_PKMNCenterBoy
npctalking GoldtreeVillage_House_PickUpAbilityLady
npctalking GoldtreeVillage_House_LastThirtyYearsMan
npctalking GoldtreeVillage_House_KingsPathMan
npctalking GoldtreeVillage_House_SamuelsWife
npctalking KingsPath_JustADitchMan

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
signpost AerilonHills_MainRoute
signpost AerilonHills_AlmondObservatory
signpost AerilonPass_MainRoute
signpost GoldtreeVillage_MainTown
signpost GoldtreeVillage_RivalHouse
signpost GoldtreeVillage_PKMNCenter_Machine
signpost KingsPath_SmallOpening
