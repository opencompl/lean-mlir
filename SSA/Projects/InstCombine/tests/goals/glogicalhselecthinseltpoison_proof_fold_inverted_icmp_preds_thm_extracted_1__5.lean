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

theorem fold_inverted_icmp_preds_thm.extracted_1._5 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (x_3 <ₛ x_2) = 1#1 → ¬ofBool (x_2 ≤ₛ x_3) = 1#1 → 0#32 ||| 0#32 = 0#32 ||| x :=
sorry