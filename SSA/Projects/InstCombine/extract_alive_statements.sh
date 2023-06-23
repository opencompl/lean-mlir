#!/usr/bin/env sh

ALIVE_FILE="InstCombineAlive.lean"
INST_COMBINE_PREFIX="SSA/Projects/InstCombine"
OUTPUT_FILE="InstCombineAliveStatements.lean"
THEOREMS_TEMP_FILE="theorems_temp_file.tmp"
LEAN_DEV_ROOT="../../../"
PREAMBLE="import SSA.Projects.InstCombine.InstCombineBase\nimport SSA.Projects.InstCombine.Tactic"

cd "$LEAN_DEV_ROOT" || exit
echo "$PREAMBLE" > "$INST_COMBINE_PREFIX/$OUTPUT_FILE"
lake env lean "$INST_COMBINE_PREFIX/$ALIVE_FILE" | gsed "s/no goals to be solved/True/" | gsed "s/.*error:/INSERT_THEOREM\n/" >> "$INST_COMBINE_PREFIX/$OUTPUT_FILE"
rg "theorem" $INST_COMBINE_PREFIX/$ALIVE_FILE | gsed 's/:.*/:/' | gsed 's/alive_/bitvec_/' > $THEOREMS_TEMP_FILE

#sed's R command will read one line at a time from a file and insert it
gsed -i "/_THEOREM/R $THEOREMS_TEMP_FILE" "$INST_COMBINE_PREFIX/$OUTPUT_FILE"
gsed -i "s/INSERT_THEOREM/:= alive_auto\n      try sorry\n/" "$INST_COMBINE_PREFIX/$OUTPUT_FILE" #add sorries
gsed -i "2d" "$INST_COMBINE_PREFIX/$OUTPUT_FILE" #remove first instance
echo "\n:=sorry" >> "$INST_COMBINE_PREFIX/$OUTPUT_FILE"  #add last one

#now replace print_goal_as_error's with recovered theorem statements
gsed -i -e "s/theorem /     apply /" -e "s/://" "$THEOREMS_TEMP_FILE"
gsed -i "/print_goal_as_error/R $THEOREMS_TEMP_FILE" "$INST_COMBINE_PREFIX/$ALIVE_FILE"
gsed -i "/print_goal_as_error/d" "$INST_COMBINE_PREFIX/$ALIVE_FILE"
gsed -i "/import SSA.Projects.InstCombine.InstCombineBase/a import SSA.Projects.InstCombine.${OUTPUT_FILE%.*}" "$INST_COMBINE_PREFIX/$ALIVE_FILE"

#cleanup
rm $THEOREMS_TEMP_FILE
