
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_and_pow2_minus1_shl1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (1#32 <<< x &&& 15#32 == 0#32)) = zeroExtend 32 (ofBool (3#32 <ᵤ x)) :=
sorry