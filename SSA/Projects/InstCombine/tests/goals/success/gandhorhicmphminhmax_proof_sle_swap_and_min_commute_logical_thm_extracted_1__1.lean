
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem sle_swap_and_min_commute_logical_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x == BitVec.ofInt 8 (-128)) = 1#1 → 0#1 = ofBool (x == BitVec.ofInt 8 (-128)) :=
sorry