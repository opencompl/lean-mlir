
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem wrongimm2_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ¬(6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16) →
    6#8 ≥ ↑8 ∨ 8#16 ≥ ↑16 ∨ True ∧ zeroExtend 16 (truncate 8 (x >>> 8#16)) ≠ x >>> 8#16 → False :=
sorry