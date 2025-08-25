
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_mul_nsw__nsw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x ||| BitVec.ofInt 32 (-83886080) == BitVec.ofInt 32 (-83886079)) = 1#1 →
    ¬(True ∧ (x ||| BitVec.ofInt 32 (-83886080)).smulOverflow 9#32 = true) →
      BitVec.ofInt 32 (-754974711) = (x ||| BitVec.ofInt 32 (-83886080)) * 9#32 :=
sorry