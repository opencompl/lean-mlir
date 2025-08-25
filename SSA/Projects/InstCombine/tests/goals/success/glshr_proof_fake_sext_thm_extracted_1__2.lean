
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fake_sext_thm.extracted_1._2 : ∀ (x : BitVec 3),
  ¬17#18 ≥ ↑18 → ¬(2#3 ≥ ↑3 ∨ True ∧ (x >>> 2#3).msb = true) → signExtend 18 x >>> 17#18 = zeroExtend 18 (x >>> 2#3) :=
sorry