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

theorem positive_different_trunc_both_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (-1#15 <ₛ truncate 15 x) = 1#1 →
    ofBool (x &&& 16384#32 == 0#32) = 1#1 → 0#1 = ofBool (truncate 16 x + 128#16 <ᵤ 256#16) :=
sorry