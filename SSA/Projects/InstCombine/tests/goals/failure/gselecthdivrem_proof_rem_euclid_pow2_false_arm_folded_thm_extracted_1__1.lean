
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem rem_euclid_pow2_false_arm_folded_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(2#32 == 0 || 32 != 1 && x == intMin 32 && 2#32 == -1) = true →
    ofBool (0#32 ≤ₛ x.srem 2#32) = 1#1 → x.srem 2#32 = x &&& 1#32 :=
sorry