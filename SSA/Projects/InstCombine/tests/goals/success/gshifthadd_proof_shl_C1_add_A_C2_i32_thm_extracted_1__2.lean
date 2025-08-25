
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem shl_C1_add_A_C2_i32_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬zeroExtend 32 x + 5#32 ≥ ↑32 →
    ¬(True ∧ x.msb = true ∨ zeroExtend 32 x ≥ ↑32) → 6#32 <<< (zeroExtend 32 x + 5#32) = 192#32 <<< zeroExtend 32 x :=
sorry