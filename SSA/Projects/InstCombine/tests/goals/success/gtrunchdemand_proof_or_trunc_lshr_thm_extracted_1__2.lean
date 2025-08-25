
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem or_trunc_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 →
    ¬(1#6 ≥ ↑6 ∨ True ∧ (truncate 6 x >>> 1#6 &&& BitVec.ofInt 6 (-32) != 0) = true) →
      truncate 6 (x >>> 1#8) ||| BitVec.ofInt 6 (-32) = truncate 6 x >>> 1#6 ||| BitVec.ofInt 6 (-32) :=
sorry