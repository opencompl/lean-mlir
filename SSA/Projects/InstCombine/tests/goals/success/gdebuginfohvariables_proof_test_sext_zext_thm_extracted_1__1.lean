
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_sext_zext_thm.extracted_1._1 : ∀ (x : BitVec 16), signExtend 64 (zeroExtend 32 x) = zeroExtend 64 x :=
sorry