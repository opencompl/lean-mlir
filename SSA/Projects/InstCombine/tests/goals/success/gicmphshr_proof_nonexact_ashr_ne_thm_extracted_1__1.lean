
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem nonexact_ashr_ne_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool ((BitVec.ofInt 8 (-128)).sshiftRight' x != -1#8) = ofBool (x != 7#8) :=
sorry