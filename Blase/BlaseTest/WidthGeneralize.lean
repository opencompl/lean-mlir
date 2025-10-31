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
