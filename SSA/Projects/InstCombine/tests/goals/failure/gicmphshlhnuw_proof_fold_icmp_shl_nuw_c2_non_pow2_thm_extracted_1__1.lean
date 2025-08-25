
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem fold_icmp_shl_nuw_c2_non_pow2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ 48#32 <<< x >>> x ≠ 48#32 ∨ x ≥ ↑32) → ofBool (48#32 <<< x <ᵤ 192#32) = ofBool (x <ᵤ 2#32) :=
sorry