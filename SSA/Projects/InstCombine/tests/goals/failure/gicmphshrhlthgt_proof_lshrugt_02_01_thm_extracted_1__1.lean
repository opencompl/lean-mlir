
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem lshrugt_02_01_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬2#4 ≥ ↑4 → ofBool (1#4 <ᵤ x >>> 2#4) = ofBool (x <ₛ 0#4) :=
sorry