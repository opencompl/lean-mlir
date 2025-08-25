
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_xor_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(3#8 ≥ ↑8 ∨ (42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 3#8 ≥ ↑8) →
    ¬((42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 3#8 ≥ ↑8) →
      (x_1 >>> 3#8 ^^^ x.srem 42#8) <<< 3#8 = x_1 &&& BitVec.ofInt 8 (-8) ^^^ x.srem 42#8 <<< 3#8 :=
sorry