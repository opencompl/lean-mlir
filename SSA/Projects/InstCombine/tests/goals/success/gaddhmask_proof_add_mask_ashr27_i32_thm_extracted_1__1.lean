
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_mask_ashr27_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(27#32 ≥ ↑32 ∨ 27#32 ≥ ↑32) →
    27#32 ≥ ↑32 ∨ 27#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 27#32 &&& 8#32).saddOverflow (x.sshiftRight' 27#32) = true →
      False :=
sorry