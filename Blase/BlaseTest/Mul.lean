import Blase 

/--
error: unsolved goals
w : ℕ
a b : BitVec w
⊢ a * b = a * b
-/
#guard_msgs in theorem bv_mul_comm (a b : BitVec w) : a * b = b * a := by
    bv_multi_width_normalize


