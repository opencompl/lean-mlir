import Blase
open BitVec

/--
error: unsolved goals
⊢ ∀ (w w_1 : ℕ) (x : BitVec w) (y : BitVec w_1), zeroExtend w_1 x + y = y + zeroExtend w_1 x
---
trace: ⊢ ∀ (w w_1 : ℕ) (x : BitVec w) (y : BitVec w_1), zeroExtend w_1 x + y = y + zeroExtend w_1 x
-/
#guard_msgs in theorem generalize (x : BitVec 3) (y : BitVec 4) : 
      x.zeroExtend _ + y = y + x.zeroExtend _ := by
  bv_generalize
  trace_state


/--
error: (kernel) application type mismatch
  instHAndOfAndOp
argument has type
  AndOp (BitVec 64)
but function has type
  [AndOp (BitVec w)] → HAnd (BitVec w) (BitVec w) (BitVec w)
-/
#guard_msgs in
theorem test_thm.extracted_1._1 : ∀ (x : BitVec 64), zeroExtend 64 (truncate 32 x) = x &&& 4294967295#64 := by
  intros
  bv_generalize +specialize
  intros
  sorry
  done

