
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_icmp_shl_nuw_c2_div_non_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ 2#32 <<< x >>> x ≠ 2#32 ∨ x ≥ ↑32) → ofBool (2#32 <<< x <ᵤ 60#32) = ofBool (x <ᵤ 5#32) :=
sorry