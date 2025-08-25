
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_exact_lshr_icmp_const_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (31#32 <ᵤ x) = 1#1 → ¬(True ∧ x >>> 5#32 <<< 5#32 ≠ x ∨ 5#32 ≥ ↑32) → 5#32 ≥ ↑32 → False :=
sorry