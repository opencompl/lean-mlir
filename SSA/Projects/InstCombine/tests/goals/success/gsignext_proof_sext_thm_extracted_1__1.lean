
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sext_thm.extracted_1._1 : ∀ (x : BitVec 16),
  (zeroExtend 32 x ^^^ 32768#32) + BitVec.ofInt 32 (-32768) = signExtend 32 x :=
sorry