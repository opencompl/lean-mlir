import EvaluationHarness.Basic
import Std.Tactic.BVDecide

open BitVec

#evaluation in
theorem test_with_1_thm.extracted_1._1 : ∀ (x : BitVec 32),
    ¬x ≥ ↑32 → 1#32 <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) := by
  bv_decide

#evaluation in
theorem test_with_3_thm.extracted_1._1 : ∀ (x : BitVec 32),
    ¬x ≥ ↑32 → 3#32 <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) := by
  bv_decide

#evaluation in
theorem test_with_5_thm.extracted_1._1 : ∀ (x : BitVec 32),
    ¬x ≥ ↑32 → 5#32 <<< x &&& 1#32 = zeroExtend 32 (ofBool (x == 0#32)) := by
  fail
