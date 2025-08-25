
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_sub_nsw_thm.extracted_1._1 : ∀ (x x_1 : BitVec 17),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 16#17 ≥ ↑17) →
    (x_1 - x).sshiftRight' 16#17 = signExtend 17 (ofBool (x_1 <ₛ x)) :=
sorry