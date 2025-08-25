
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_and1_lshr_pow2_minus_one_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (7#32 >>> x &&& 1#32 == 0#32)) = zeroExtend 32 (ofBool (2#32 <ᵤ x)) :=
sorry