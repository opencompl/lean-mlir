
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem negate_xor_thm.extracted_1._1 : ∀ (x : BitVec 4), 0#4 - (x ^^^ 5#4) = (x ^^^ BitVec.ofInt 4 (-6)) + 1#4 :=
sorry