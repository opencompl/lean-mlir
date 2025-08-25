
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem rem_euclid_2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(8#32 == 0 || 32 != 1 && x == intMin 32 && 8#32 == -1) = true →
    ¬ofBool (-1#32 <ₛ x.srem 8#32) = 1#1 → x.srem 8#32 + 8#32 = x &&& 7#32 :=
sorry