
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test2_thm.extracted_1._1 : ∀ (x : BitVec 499),
  ¬(111#499 ≥ ↑499 ∨ 4096#499 <<< 111#499 = 0) →
    x % 4096#499 <<< 111#499 = x &&& 10633823966279326983230456482242756607#499 :=
sorry