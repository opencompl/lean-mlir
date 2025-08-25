
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_xor_zext_sandwich_thm.extracted_1._1 : ∀ (x : BitVec 1),
  zeroExtend 64 (zeroExtend 32 x ^^^ 1#32) = zeroExtend 64 (x ^^^ 1#1) :=
sorry