
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem and_zext_demanded_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬8#16 ≥ ↑16 →
    ¬(8#16 ≥ ↑16 ∨ True ∧ (x >>> 8#16).msb = true) →
      (x_1 ||| 255#32) &&& zeroExtend 32 (x >>> 8#16) = zeroExtend 32 (x >>> 8#16) :=
sorry