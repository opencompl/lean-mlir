import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem flip_add_of_shift_neg_thm (x x_1 x_2 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x_1.toNat then none else some ((x_2 * 255#8) <<< x_1)) fun a => some (a + x)) ⊑
    Option.bind (if 8 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a => some (x - a) := by
  sorry

