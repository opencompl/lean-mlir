
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test3_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬30#32 ≥ ↑32 →
    ¬(30#32 ≥ ↑32 ∨ True ∧ (x &&& 128#32 &&& x >>> 30#32 != 0) = true) →
      (x &&& 128#32) + x >>> 30#32 = x &&& 128#32 ||| x >>> 30#32 :=
sorry