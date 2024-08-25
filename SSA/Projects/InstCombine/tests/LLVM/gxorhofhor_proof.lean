import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem t1_thm (x : _root_.BitVec 4) : 
    (x ||| 12#4) ^^^ 10#4 = x &&& 3#4 ^^^ 6#4 := by
  sorry

