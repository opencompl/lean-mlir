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

theorem test_with_neg_5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → BitVec.ofInt 32 (-5) <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) :=
sorry