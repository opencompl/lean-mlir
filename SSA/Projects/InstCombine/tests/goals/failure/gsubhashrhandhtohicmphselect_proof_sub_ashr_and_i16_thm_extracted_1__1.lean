
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_ashr_and_i16_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 15#16 ≥ ↑16) →
    ofBool (x_1 <ₛ x) = 1#1 → (x_1 - x).sshiftRight' 15#16 &&& x = x :=
sorry