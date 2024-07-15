import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem t0_thm (x x_1 : _root_.BitVec 8) : 
    255#8 * x + (x_1 * 255#8 &&& x) = 255#8 * (x_1 + 255#8 &&& x) := by
  sorry

theorem n7_thm (x x_1 : _root_.BitVec 8) : 
    x_1 + 255#8 * (x * 255#8 &&& x_1) = x + 255#8 &&& x_1 := by
  sorry

