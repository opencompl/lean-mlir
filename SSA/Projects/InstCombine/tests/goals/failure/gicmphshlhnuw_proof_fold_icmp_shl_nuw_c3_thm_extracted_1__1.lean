
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_icmp_shl_nuw_c3_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ 48#32 <<< x >>> x ≠ 48#32 ∨ x ≥ ↑32) → ofBool (144#32 ≤ᵤ 48#32 <<< x) = ofBool (1#32 <ᵤ x) :=
sorry