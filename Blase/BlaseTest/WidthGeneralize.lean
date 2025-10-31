import Blase

/--
error: unsolved goals
⊢ ∀ (w w_1 : ℕ) (x : BitVec w) (y : BitVec w_1), BitVec.zeroExtend w_1 x + y = y + BitVec.zeroExtend w_1 x
---
trace: ⊢ ∀ (w w_1 : ℕ) (x : BitVec w) (y : BitVec w_1), BitVec.zeroExtend w_1 x + y = y + BitVec.zeroExtend w_1 x
-/
#guard_msgs in theorem generalize (x : BitVec 3) (y : BitVec 4) : 
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  bv_generalize
  trace_state


/- See that this produces an ill-typed term, so we fail. -/
open BitVec in
theorem test_thm.extracted_1._1 : ∀ (x : BitVec 64), zeroExtend 64 (truncate 32 x) = x &&& 4294967295#64 := by
  intros
  bv_generalize +specialize
  intros
  bv_decide
  done

