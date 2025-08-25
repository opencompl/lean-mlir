
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test69_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 128#32 != 0#32) = 1#1 → ¬6#32 ≥ ↑32 → x ||| 2#32 = x ||| x_1 >>> 6#32 &&& 2#32 ^^^ 2#32 :=
sorry