
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_test_icmp_non_equality_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x &&& 1073741823#32 <ₛ 0#32) = 1#1 → 2#32 ≥ ↑32 → False :=
sorry