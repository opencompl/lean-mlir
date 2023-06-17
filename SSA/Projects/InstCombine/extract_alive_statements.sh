#!/usr/bin/env sh

ALIVE_FILE="InstCombineAlive.lean"
INST_COMBINE_PREFIX="SSA/Projects/InstCombine"
OUTPUT_FILE="InstCombineAliveStatements.lean"
THEOREMS_TEMP_FILE="theorems_temp_file.tmp"
LEAN_DEV_ROOT="../../../"
PREAMBLE="import SSA.Projects.InstCombine.InstCombineBase"

cd "$LEAN_DEV_ROOT" || exit
echo "$PREAMBLE" > "$INST_COMBINE_PREFIX/$OUTPUT_FILE"
gsed -i "s/sorry/print_goal_as_error/" "$INST_COMBINE_PREFIX/$ALIVE_FILE"
lake env lean "$INST_COMBINE_PREFIX/$ALIVE_FILE" | gsed "s/.*error:/INSERT_THEOREM\n/" >> "$INST_COMBINE_PREFIX/$OUTPUT_FILE"
rg "theorem" $INST_COMBINE_PREFIX/$ALIVE_FILE | gsed 's/:.*/:/' | gsed 's/alive_/bitvec_/' > $THEOREMS_TEMP_FILE

#sed's R command will read one line at a time from a file and insert it
gsed -i "/INSERT_THEOREM/R $THEOREMS_TEMP_FILE" "$INST_COMBINE_PREFIX/$OUTPUT_FILE"

#cleanup
rm $THEOREMS_TEMP_FILE
gsed -i "s/INSERT_THEOREM/:=sorry\n/" "$INST_COMBINE_PREFIX/$OUTPUT_FILE" #add sorries
gsed -i "2d" "$INST_COMBINE_PREFIX/$OUTPUT_FILE" #remove first instance
echo "\n:=sorry" >> "$INST_COMBINE_PREFIX/$OUTPUT_FILE"  #add last one
