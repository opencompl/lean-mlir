
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_ashr_thm.extracted_1._2 : ∀ (x : BitVec 128) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬0#128 ≥ ↑128 → x = x.sshiftRight' 0#128 :=
sorry