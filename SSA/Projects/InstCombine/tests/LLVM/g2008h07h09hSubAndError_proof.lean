import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem foo_thm (x : _root_.BitVec 32) :
  5#32 + x * 4294967295#32 &&& 2#32 = x * 4294967295#32 + 1#32 &&& 2#32 := by
  sorry

