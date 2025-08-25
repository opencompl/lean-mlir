
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sub_ashr_or_i8_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ x_1.ssubOverflow x = true ∨ 7#8 ≥ ↑8) → ¬ofBool (x_1 <ₛ x) = 1#1 → (x_1 - x).sshiftRight' 7#8 ||| x = x :=
sorry