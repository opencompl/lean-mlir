
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem in_constant_varx_mone_thm.extracted_1._1 : ∀ (x : BitVec 4),
  (x ^^^ -1#4) &&& 1#4 ^^^ -1#4 = x ||| BitVec.ofInt 4 (-2) :=
sorry