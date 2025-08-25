
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem scalar_i32_shl_and_negC_slt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x ≥ ↑32 → ofBool (x_1 <<< x &&& BitVec.ofInt 32 (-8) <ₛ 0#32) = ofBool (x_1 <<< x <ₛ 0#32) :=
sorry