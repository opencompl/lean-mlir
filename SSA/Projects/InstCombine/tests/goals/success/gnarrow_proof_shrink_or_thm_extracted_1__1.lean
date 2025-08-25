
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shrink_or_thm.extracted_1._1 : ∀ (x : BitVec 6),
  truncate 3 (x ||| BitVec.ofInt 6 (-31)) = truncate 3 x ||| 1#3 :=
sorry