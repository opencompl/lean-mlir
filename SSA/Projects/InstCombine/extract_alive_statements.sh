#!/usr/bin/env sh
# Released under Apache 2.0 license as described in the file LICENSE.

ALIVE_FILE="Alive.lean"
INST_COMBINE_PREFIX="SSA/Projects/InstCombine"
OUTPUT_FILE="AliveStatements.lean"
THEOREMS_TEMP_FILE="theorems_temp_file.tmp"
LEAN_DEV_ROOT="../../../"
PREAMBLE="/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.LLVM.Semantics
import Std.Data.BitVec
import Mathlib.Data.BitVec.Lemmas

open LLVM
open BitVec"

cd "$LEAN_DEV_ROOT" || exit
echo "$PREAMBLE" > "$INST_COMBINE_PREFIX/$OUTPUT_FILE"
lake env lean "$INST_COMBINE_PREFIX/$ALIVE_FILE" | sed "s/no goals to be solved/True/" | sed "s/.*error:/INSERT_THEOREM\n/" >> "$INST_COMBINE_PREFIX/$OUTPUT_FILE"
rg "theorem" $INST_COMBINE_PREFIX/$ALIVE_FILE | sed 's/:.*/:/' | sed 's/alive_/bitvec_/' > $THEOREMS_TEMP_FILE

#sed's R command will read one line at a time from a file and insert it
sed -i "/_THEOREM/R $THEOREMS_TEMP_FILE" "$INST_COMBINE_PREFIX/$OUTPUT_FILE"
sed -i "s/INSERT_THEOREM/:= by alive_auto\n      try sorry\n/" "$INST_COMBINE_PREFIX/$OUTPUT_FILE" #add sorries
sed -i -e "4d" -e "5d" "$INST_COMBINE_PREFIX/$OUTPUT_FILE" #remove first instance of by alive_auto and sorry
echo "\n:=sorry" >> "$INST_COMBINE_PREFIX/$OUTPUT_FILE"  #add last one

#now replace print_goal_as_error's with recovered theorem statements
sed -i -e "s/theorem /     apply /" -e "s/://" "$THEOREMS_TEMP_FILE"
sed -i "/print_goal_as_error/R $THEOREMS_TEMP_FILE" "$INST_COMBINE_PREFIX/$ALIVE_FILE"
sed -i "/print_goal_as_error/d" "$INST_COMBINE_PREFIX/$ALIVE_FILE"
sed -i "/import SSA.Projects.InstCombine.Base/a import SSA.Projects.InstCombine.${OUTPUT_FILE%.*}" "$INST_COMBINE_PREFIX/$ALIVE_FILE"

#cleanup
rm $THEOREMS_TEMP_FILE
