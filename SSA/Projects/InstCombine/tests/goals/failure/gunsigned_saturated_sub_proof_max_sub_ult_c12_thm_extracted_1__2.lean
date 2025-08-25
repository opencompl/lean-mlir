
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem max_sub_ult_c12_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x <ᵤ 1#32) = 1#1 → ¬ofBool (x == 0#32) = 1#1 → x + BitVec.ofInt 32 (-2) = 0#32 :=
sorry