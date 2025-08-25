
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

theorem dec_mask_commute_neg_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬((x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true) →
    (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true ∨
        True ∧ ((42#32).sdiv x).saddOverflow (-1#32) = true ∨
          (x == 0 || 32 != 1 && 42#32 == intMin 32 && x == -1) = true →
      False :=
sorry