
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem f_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(1#32 == 0 || 32 != 1 && x ||| 1#32 == intMin 32 && 1#32 == -1) = true →
    ofBool ((x ||| 1#32).srem 1#32 != 0#32) = 0#1 :=
sorry