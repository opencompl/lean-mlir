
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem clear_to_clear_decomposebittest_thm.extracted_1._3 : ∀ (x : BitVec 8),
  ¬ofBool (-1#8 <ₛ x) = 1#1 → True ∧ (x &&& BitVec.ofInt 8 (-128) &&& 3#8 != 0) = true → False :=
sorry