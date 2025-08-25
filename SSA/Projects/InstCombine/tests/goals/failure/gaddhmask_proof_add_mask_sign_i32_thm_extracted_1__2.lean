
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_mask_sign_i32_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(31#32 ≥ ↑32 ∨ 31#32 ≥ ↑32) →
    ¬ofBool (x <ₛ 0#32) = 1#1 → (x.sshiftRight' 31#32 &&& 8#32) + x.sshiftRight' 31#32 = 0#32 :=
sorry