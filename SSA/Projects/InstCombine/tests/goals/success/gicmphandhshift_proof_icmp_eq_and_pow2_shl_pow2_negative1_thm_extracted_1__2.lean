
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem icmp_eq_and_pow2_shl_pow2_negative1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 →
    ¬(x ≥ ↑32 ∨ 4#32 ≥ ↑32) →
      zeroExtend 32 (ofBool (11#32 <<< x &&& 16#32 == 0#32)) = 11#32 <<< x >>> 4#32 &&& 1#32 ^^^ 1#32 :=
sorry