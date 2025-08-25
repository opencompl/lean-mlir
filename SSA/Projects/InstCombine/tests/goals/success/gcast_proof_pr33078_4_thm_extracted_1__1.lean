
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem pr33078_4_thm.extracted_1._1 : ∀ (x : BitVec 3),
  ¬13#16 ≥ ↑16 →
    13#16 ≥ ↑16 ∨
        True ∧ signExtend 16 (truncate 8 (signExtend 16 x >>> 13#16)) ≠ signExtend 16 x >>> 13#16 ∨
          True ∧ zeroExtend 16 (truncate 8 (signExtend 16 x >>> 13#16)) ≠ signExtend 16 x >>> 13#16 →
      False :=
sorry