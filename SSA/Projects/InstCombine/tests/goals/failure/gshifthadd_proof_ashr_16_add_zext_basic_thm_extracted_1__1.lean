
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem ashr_16_add_zext_basic_thm.extracted_1._1 : ∀ (x x_1 : BitVec 16),
  ¬16#32 ≥ ↑32 → (zeroExtend 32 x_1 + zeroExtend 32 x) >>> 16#32 = zeroExtend 32 (ofBool (x_1 ^^^ -1#16 <ᵤ x)) :=
sorry