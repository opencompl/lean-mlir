
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem max_sub_uge_c32_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x ≤ᵤ 2#32) = 1#1 → ¬ofBool (x <ᵤ 3#32) = 1#1 → x + BitVec.ofInt 32 (-2) = 0#32 :=
sorry