.thumb
.align 2

.include "../xse_commands.s"
.include "../xse_defines.s"
.include "../asm_defines.s"

#@@@@@@@@;Master Map;@@@@@@@@
#Tile scripts:


#Level scripts:
.global gMapScripts_RuinwayPassage
gMapScripts_RuinwayPassage:
	mapscript MAP_SCRIPT_ON_TRANSITION MapEntryScript_RuinwayPassage
	.byte MAP_SCRIPT_TERMIN

MapEntryScript_RuinwayPassage:
	setworldmapflag 0x8A5
	end
