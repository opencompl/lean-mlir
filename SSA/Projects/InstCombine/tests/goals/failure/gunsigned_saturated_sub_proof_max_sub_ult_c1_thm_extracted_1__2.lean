
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem max_sub_ult_c1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x <ᵤ 1#32) = 1#1 → 0#32 = signExtend 32 (ofBool (x == 0#32)) :=
sorry