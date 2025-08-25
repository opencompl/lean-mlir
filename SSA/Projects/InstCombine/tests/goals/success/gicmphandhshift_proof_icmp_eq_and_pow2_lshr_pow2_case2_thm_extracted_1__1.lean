
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_and_pow2_lshr_pow2_case2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (4#32 >>> x &&& 8#32 == 0#32)) = 1#32 :=
sorry