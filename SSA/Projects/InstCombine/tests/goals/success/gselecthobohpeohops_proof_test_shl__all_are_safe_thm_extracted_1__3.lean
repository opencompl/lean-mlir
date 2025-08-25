
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shl__all_are_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 15#32 == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 15#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨ True ∧ (x_1 <<< 2#32 &&& 60#32).msb = true ∨ zeroExtend 64 (x_1 <<< 2#32 &&& 60#32) ≥ ↑64 → False :=
sorry