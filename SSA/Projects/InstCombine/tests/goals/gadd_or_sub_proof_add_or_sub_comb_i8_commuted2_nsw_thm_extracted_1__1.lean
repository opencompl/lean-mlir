
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

theorem add_or_sub_comb_i8_commuted2_nsw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ (x * x).saddOverflow (0#8 - x * x ||| x * x) = true) → True ∧ (x * x).saddOverflow (-1#8) = true → False :=
sorry