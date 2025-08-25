
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem zext_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 →
    ¬(4#8 ≥ ↑8 ∨ True ∧ (x >>> 4#8 &&& x).msb = true) →
      zeroExtend 16 x >>> 4#16 &&& zeroExtend 16 x = zeroExtend 16 (x >>> 4#8 &&& x) :=
sorry