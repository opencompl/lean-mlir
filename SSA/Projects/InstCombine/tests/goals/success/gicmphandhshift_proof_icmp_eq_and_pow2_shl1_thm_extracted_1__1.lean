
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_and_pow2_shl1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (1#32 <<< x &&& 16#32 == 0#32)) = zeroExtend 32 (ofBool (x != 4#32)) :=
sorry