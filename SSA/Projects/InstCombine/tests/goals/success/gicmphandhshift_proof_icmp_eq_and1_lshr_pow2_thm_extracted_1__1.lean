
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_and1_lshr_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (8#32 >>> x &&& 1#32 == 0#32)) = zeroExtend 32 (ofBool (x != 3#32)) :=
sorry