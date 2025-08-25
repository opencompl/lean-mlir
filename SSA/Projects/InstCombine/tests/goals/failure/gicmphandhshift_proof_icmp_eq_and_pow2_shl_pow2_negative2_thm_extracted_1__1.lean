
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_and_pow2_shl_pow2_negative2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → zeroExtend 32 (ofBool (2#32 <<< x &&& 14#32 == 0#32)) = zeroExtend 32 (ofBool (2#32 <ᵤ x)) :=
sorry