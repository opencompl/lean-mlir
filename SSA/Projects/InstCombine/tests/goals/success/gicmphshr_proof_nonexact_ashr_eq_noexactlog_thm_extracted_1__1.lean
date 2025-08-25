
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem nonexact_ashr_eq_noexactlog_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool ((BitVec.ofInt 8 (-90)).sshiftRight' x == BitVec.ofInt 8 (-30)) = 0#1 :=
sorry