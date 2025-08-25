
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_ashr_or_i32_commute_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ x.ssubOverflow x_1 = true ∨ 31#32 ≥ ↑32) →
    ¬ofBool (x <ₛ x_1) = 1#1 → x_1 ||| (x - x_1).sshiftRight' 31#32 = x_1 :=
sorry