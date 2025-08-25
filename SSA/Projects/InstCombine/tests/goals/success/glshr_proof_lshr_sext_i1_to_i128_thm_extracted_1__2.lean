
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_sext_i1_to_i128_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬42#128 ≥ ↑128 → ¬x = 1#1 → signExtend 128 x >>> 42#128 = 0#128 :=
sorry