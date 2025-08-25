
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_ashr_thm.extracted_1._4 : ∀ (x x_1 : BitVec 128) (x_2 : BitVec 1),
  ¬x_2 = 1#1 → ¬0#128 ≥ ↑128 → x_1 = x_1.sshiftRight' 0#128 :=
sorry