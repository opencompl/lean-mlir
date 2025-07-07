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

theorem add_or_sub_comb_i128_commuted3_nuw_nsw_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(True ∧ (x * x ||| 0#128 - x * x).saddOverflow (x * x) = true ∨
        True ∧ (x * x ||| 0#128 - x * x).uaddOverflow (x * x) = true) →
    (x * x ||| 0#128 - x * x) + x * x = x * x :=
sorry