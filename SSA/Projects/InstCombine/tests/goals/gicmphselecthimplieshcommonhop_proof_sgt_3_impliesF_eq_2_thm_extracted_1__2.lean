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

theorem sgt_3_impliesF_eq_2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ofBool (3#8 <ₛ x) = 1#1 → ¬ofBool (x <ₛ 4#8) = 1#1 → ofBool (2#8 == x) = 0#1 :=
sorry