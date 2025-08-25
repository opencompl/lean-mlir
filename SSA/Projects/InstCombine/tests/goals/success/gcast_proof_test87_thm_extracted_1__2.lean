
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test87_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(True ∧ (signExtend 32 x).smulOverflow 16#32 = true ∨ 16#32 ≥ ↑32) →
    ¬12#16 ≥ ↑16 → truncate 16 ((signExtend 32 x * 16#32).sshiftRight' 16#32) = x.sshiftRight' 12#16 :=
sorry