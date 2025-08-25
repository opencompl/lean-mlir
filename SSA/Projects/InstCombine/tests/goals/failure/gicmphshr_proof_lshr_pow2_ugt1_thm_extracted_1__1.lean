
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_pow2_ugt1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬x ≥ ↑8 → ofBool (1#8 <ᵤ BitVec.ofInt 8 (-128) >>> x) = ofBool (x <ᵤ 7#8) :=
sorry