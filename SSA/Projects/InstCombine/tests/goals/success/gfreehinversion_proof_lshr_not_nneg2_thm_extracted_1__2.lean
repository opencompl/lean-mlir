
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_not_nneg2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 →
    ¬(1#8 ≥ ↑8 ∨ True ∧ (x >>> 1#8 &&& BitVec.ofInt 8 (-128) != 0) = true) →
      (x ^^^ -1#8) >>> 1#8 ^^^ -1#8 = x >>> 1#8 ||| BitVec.ofInt 8 (-128) :=
sorry