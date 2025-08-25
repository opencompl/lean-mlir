
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_ashr_and_i32_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 31#32 ≥ ↑32) →
    ofBool (x_1 <ₛ x) = 1#1 → (x_1 - x).sshiftRight' 31#32 &&& x = x :=
sorry