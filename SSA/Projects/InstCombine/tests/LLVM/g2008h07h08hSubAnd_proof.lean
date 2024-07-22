import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem a_thm (x : _root_.BitVec 32) : 
    8#32 + x * 4294967295#32 &&& 7#32 = x * 4294967295#32 &&& 7#32 := by
  sorry

