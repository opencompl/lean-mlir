
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_icmp_shl_nuw_c2_indivisible_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ 16#32 <<< x >>> x ≠ 16#32 ∨ x ≥ ↑32) → ofBool (16#32 <<< x <ᵤ 63#32) = ofBool (x <ᵤ 2#32) :=
sorry