
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_icmp_shl_nuw_c2_precondition3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ 1#32 <<< x >>> x ≠ 1#32 ∨ x ≥ ↑32) → ofBool (1#32 <<< x <ᵤ 1#32) = 0#1 :=
sorry