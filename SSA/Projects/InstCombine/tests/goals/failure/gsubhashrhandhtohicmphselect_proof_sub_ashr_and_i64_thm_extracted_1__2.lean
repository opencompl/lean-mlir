
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_ashr_and_i64_thm.extracted_1._2 : ∀ (x x_1 : BitVec 64),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 63#64 ≥ ↑64) →
    ¬ofBool (x_1 <ₛ x) = 1#1 → (x_1 - x).sshiftRight' 63#64 &&& x = 0#64 :=
sorry