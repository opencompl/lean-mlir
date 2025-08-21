
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

theorem testtrunclowhigh_thm.extracted_1._3 : ∀ (x x_1 : BitVec 16) (x_2 : BitVec 32),
  ¬ofBool (x_2 + 128#32 <ᵤ 256#32) = 1#1 → ofBool (-1#32 <ₛ x_2) = 1#1 → ofBool (x_2 <ₛ 0#32) = 1#1 → x_1 = x :=
sorry