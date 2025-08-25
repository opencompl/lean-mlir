
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._1 : ∀ (x : BitVec 1024),
  ¬(1023#1024 ≥ ↑1024 ∨ 1023#1024 ≥ ↑1024) → (x ^^^ 1#1024 <<< 1023#1024) + 1#1024 <<< 1023#1024 = x :=
sorry