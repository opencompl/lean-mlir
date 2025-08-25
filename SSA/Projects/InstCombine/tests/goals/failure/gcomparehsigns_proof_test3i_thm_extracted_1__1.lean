
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3i_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(29#32 ≥ ↑32 ∨ 29#32 ≥ ↑32) →
    zeroExtend 32 (ofBool (x_1 >>> 29#32 ||| 35#32 == x >>> 29#32 ||| 35#32)) =
      zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
sorry