import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem test1_thm (x : _root_.BitVec 17) : 
    x * 1024#17 = x <<< 10 := by
  sorry

