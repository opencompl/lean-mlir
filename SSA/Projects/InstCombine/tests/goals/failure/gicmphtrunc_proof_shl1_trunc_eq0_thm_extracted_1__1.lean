
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl1_trunc_eq0_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 → ofBool (truncate 16 (1#32 <<< x) == 0#16) = ofBool (15#32 <ᵤ x) :=
sorry