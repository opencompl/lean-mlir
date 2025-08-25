
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshr_pow2_ugt_thm.extracted_1._1 : ∀ (x : BitVec 8), ¬x ≥ ↑8 → ofBool (1#8 <ᵤ 2#8 >>> x) = ofBool (x == 0#8) :=
sorry