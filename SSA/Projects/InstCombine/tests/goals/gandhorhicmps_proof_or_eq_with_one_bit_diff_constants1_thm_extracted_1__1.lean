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

theorem or_eq_with_one_bit_diff_constants1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x == 50#32) ||| ofBool (x == 51#32) = ofBool (x &&& BitVec.ofInt 32 (-2) == 50#32) :=
sorry