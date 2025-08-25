
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test47_thm.extracted_1._1 : ∀ (x : BitVec 8),
  zeroExtend 64 (signExtend 32 x ||| 42#32) = zeroExtend 64 (signExtend 32 (x ||| 42#8)) :=
sorry