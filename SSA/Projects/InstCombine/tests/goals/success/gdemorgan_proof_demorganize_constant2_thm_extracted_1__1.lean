
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem demorganize_constant2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  (x ||| 15#32) ^^^ -1#32 = x &&& BitVec.ofInt 32 (-16) ^^^ BitVec.ofInt 32 (-16) :=
sorry