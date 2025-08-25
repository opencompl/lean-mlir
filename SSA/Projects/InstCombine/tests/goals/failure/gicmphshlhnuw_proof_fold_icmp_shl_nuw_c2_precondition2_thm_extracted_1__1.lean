
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_icmp_shl_nuw_c2_precondition2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ 127#32 <<< x >>> x ≠ 127#32 ∨ x ≥ ↑32) → ofBool (127#32 <<< x <ᵤ 63#32) = 0#1 :=
sorry