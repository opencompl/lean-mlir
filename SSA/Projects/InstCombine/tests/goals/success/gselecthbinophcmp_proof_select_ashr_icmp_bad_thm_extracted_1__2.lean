
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_ashr_icmp_bad_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 == 1#32) = 1#1 → ¬x_1 ≥ ↑32 → ¬1#32 ≥ ↑32 → x.sshiftRight' x_1 = x.sshiftRight' 1#32 :=
sorry