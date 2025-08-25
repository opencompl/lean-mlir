
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_mask_ashr28_non_pow2_i32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(28#32 ≥ ↑32 ∨ 28#32 ≥ ↑32) →
    28#32 ≥ ↑32 ∨ 28#32 ≥ ↑32 ∨ True ∧ (x.sshiftRight' 28#32 &&& 9#32).saddOverflow (x.sshiftRight' 28#32) = true →
      False :=
sorry