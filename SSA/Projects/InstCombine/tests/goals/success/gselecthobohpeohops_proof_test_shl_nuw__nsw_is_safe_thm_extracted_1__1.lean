
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
-/
open BitVec

theorem test_shl_nuw__nsw_is_safe_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ofBool (x ||| BitVec.ofInt 32 (-83886080) == BitVec.ofInt 32 (-83886079)) = 1#1 →
    ¬(True ∧ (x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32 >>> 2#32 ≠ x ||| BitVec.ofInt 32 (-83886080) ∨ 2#32 ≥ ↑32) →
      BitVec.ofInt 32 (-335544316) * (x ||| BitVec.ofInt 32 (-83886080)) *
          (x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32 =
        0#32 :=
sorry