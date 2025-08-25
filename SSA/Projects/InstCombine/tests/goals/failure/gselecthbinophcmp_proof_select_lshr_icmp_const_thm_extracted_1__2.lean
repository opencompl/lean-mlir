
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem select_lshr_icmp_const_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (31#32 <ᵤ x) = 1#1 → ¬5#32 ≥ ↑32 → 0#32 = x >>> 5#32 :=
sorry