
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 111),
  ¬(110#111 ≥ ↑111 ∨ 110#111 ≥ ↑111) → (x ^^^ 1#111 <<< 110#111) + 1#111 <<< 110#111 = x :=
sorry