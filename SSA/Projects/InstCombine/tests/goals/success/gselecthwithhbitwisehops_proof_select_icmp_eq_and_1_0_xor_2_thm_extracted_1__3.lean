
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_icmp_eq_and_1_0_xor_2_thm.extracted_1._3 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1#32 == 0#32) = 1#1 → 1#32 ≥ ↑32 → False :=
sorry