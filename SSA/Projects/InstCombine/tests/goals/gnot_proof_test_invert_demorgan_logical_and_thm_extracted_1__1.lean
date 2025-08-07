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

theorem test_invert_demorgan_logical_and_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬ofBool (x == 27#64) = 1#1 →
    ofBool (x != 27#64) = 1#1 → (ofBool (x == 0#64) ||| 0#1) ^^^ 1#1 = ofBool (x != 0#64) &&& 1#1 :=
sorry