
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem add_select_not_zext_thm.extracted_1._1 : ∀ (x : BitVec 1),
  x = 1#1 → 64#64 + zeroExtend 64 (x ^^^ 1#1) = 64#64 :=
sorry