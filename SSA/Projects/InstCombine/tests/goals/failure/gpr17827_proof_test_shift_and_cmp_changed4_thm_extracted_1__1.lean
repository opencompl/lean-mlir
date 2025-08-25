
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shift_and_cmp_changed4_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬5#8 ≥ ↑8 → ofBool (x >>> 5#8 &&& BitVec.ofInt 8 (-64) <ₛ 32#8) = 1#1 :=
sorry