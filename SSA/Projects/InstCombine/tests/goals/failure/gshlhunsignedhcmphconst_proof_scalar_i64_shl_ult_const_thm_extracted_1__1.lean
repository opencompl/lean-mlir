
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i64_shl_ult_const_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬25#64 ≥ ↑64 → ofBool (x <<< 25#64 <ᵤ 8589934592#64) = ofBool (x &&& 549755813632#64 == 0#64) :=
sorry