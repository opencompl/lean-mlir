
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_zext_xor_sandwich_thm.extracted_1._1 : ∀ (x : BitVec 1),
  zeroExtend 32 (x ^^^ 1#1) ^^^ 2#32 = zeroExtend 32 x ^^^ 3#32 :=
sorry