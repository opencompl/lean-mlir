import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem p0_scalar_thm (x x_1 : _root_.BitVec 32) : 
    x_1 + (x ^^^ 4294967295#32) * 4294967295#32 = x_1 + x + 1#32 := by
  sorry

