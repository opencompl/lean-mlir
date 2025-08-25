
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr33078_3_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬12#16 ≥ ↑16 →
    12#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 4 (signExtend 16 x >>> 12#16)) ≠ signExtend 16 x >>> 12#16 → False :=
sorry