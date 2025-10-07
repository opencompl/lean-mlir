
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

theorem add_umin_constant_limit_thm.extracted_1._3 : ∀ (x : BitVec 32),
  ¬(True ∧ x.uaddOverflow 41#32 = true) →
    ¬ofBool (x + 41#32 <ᵤ 42#32) = 1#1 → ofBool (x == 0#32) = 1#1 → 42#32 = 41#32 :=
sorry