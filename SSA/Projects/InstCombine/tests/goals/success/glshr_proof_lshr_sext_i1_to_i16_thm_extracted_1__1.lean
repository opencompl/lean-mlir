
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_sext_i1_to_i16_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬4#16 ≥ ↑16 → x = 1#1 → signExtend 16 x >>> 4#16 = 4095#16 :=
sorry