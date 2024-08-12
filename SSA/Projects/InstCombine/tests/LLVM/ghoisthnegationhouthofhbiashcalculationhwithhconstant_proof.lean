import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem t0_thm (x : _root_.BitVec 8) : 
    (x &&& 42#8) + x * 255#8 = (x &&& 213#8) * 255#8 := by
  sorry

theorem n5_thm (x : _root_.BitVec 8) : 
    x + (x &&& 42#8) * 255#8 = x &&& 213#8 := by
  sorry

