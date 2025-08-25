
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬1#32 ≥ ↑32 →
    ¬(1#32 ≥ ↑32 ∨ True ∧ (x >>> 1#32).uaddOverflow 2147483647#32 = true) →
      zeroExtend 64 (x >>> 1#32) + 2147483647#64 = zeroExtend 64 (x >>> 1#32 + 2147483647#32) :=
sorry