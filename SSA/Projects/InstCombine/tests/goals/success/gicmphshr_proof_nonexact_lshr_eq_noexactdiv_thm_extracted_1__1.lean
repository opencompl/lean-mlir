
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem nonexact_lshr_eq_noexactdiv_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (80#8 >>> x == 31#8) = 0#1 :=
sorry