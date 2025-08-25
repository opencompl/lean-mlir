
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem nonexact_ashr_eq_exactdiv_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool ((BitVec.ofInt 8 (-80)).sshiftRight' x == BitVec.ofInt 8 (-5)) = ofBool (x == 4#8) :=
sorry