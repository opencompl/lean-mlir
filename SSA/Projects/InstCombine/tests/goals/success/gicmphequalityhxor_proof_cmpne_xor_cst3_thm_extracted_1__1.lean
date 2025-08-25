
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem cmpne_xor_cst3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 ^^^ 10#32 != x ^^^ 10#32) = ofBool (x_1 != x) :=
sorry