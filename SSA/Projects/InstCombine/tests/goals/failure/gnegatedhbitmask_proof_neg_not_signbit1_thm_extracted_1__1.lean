
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem neg_not_signbit1_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬7#8 ≥ ↑8 → 1#32 - zeroExtend 32 (x >>> 7#8) = zeroExtend 32 (ofBool (-1#8 <ₛ x)) :=
sorry