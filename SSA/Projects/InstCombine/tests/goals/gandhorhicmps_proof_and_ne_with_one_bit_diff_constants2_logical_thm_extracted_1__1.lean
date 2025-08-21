
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem and_ne_with_one_bit_diff_constants2_logical_thm.extracted_1._1 : ∀ (x : BitVec 19),
  ofBool (x != 65#19) = 1#1 → ofBool (x != 193#19) = ofBool (x &&& BitVec.ofInt 19 (-129) != 65#19) :=
sorry