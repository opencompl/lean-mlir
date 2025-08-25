
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem not_bool_add_lshr_thm.extracted_1._1 : ∀ (x x_1 : BitVec 2),
  ¬2#4 ≥ ↑4 → (zeroExtend 4 x_1 + zeroExtend 4 x) >>> 2#4 = zeroExtend 4 (ofBool (x_1 ^^^ -1#2 <ᵤ x)) :=
sorry