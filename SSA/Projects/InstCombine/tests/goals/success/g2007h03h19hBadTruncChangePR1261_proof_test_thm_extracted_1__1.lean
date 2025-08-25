
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_thm.extracted_1._1 : ∀ (x : BitVec 31),
  ¬15#32 ≥ ↑32 → True ∧ (zeroExtend 32 x).uaddOverflow 16384#32 = true ∨ 15#32 ≥ ↑32 → False :=
sorry