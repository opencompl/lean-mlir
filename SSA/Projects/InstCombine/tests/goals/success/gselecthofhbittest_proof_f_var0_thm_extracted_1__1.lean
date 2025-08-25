
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem f_var0_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x == 0#32) = 1#1 →
    ¬1#32 ≥ ↑32 → x_1 >>> 1#32 &&& 1#32 = zeroExtend 32 (ofBool (x_1 &&& (x ||| 2#32) != 0#32)) :=
sorry