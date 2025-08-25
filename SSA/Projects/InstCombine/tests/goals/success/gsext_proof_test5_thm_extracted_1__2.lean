
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬30000#32 = 0 →
    ¬(30000#32 = 0 ∨ True ∧ (x % 30000#32).msb = true) → signExtend 64 (x % 30000#32) = zeroExtend 64 (x % 30000#32) :=
sorry