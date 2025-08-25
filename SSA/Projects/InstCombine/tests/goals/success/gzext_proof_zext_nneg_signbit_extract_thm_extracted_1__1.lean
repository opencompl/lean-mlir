
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_nneg_signbit_extract_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.msb = true ∨ 31#64 ≥ ↑64) → zeroExtend 64 x >>> 31#64 = 0#64 :=
sorry