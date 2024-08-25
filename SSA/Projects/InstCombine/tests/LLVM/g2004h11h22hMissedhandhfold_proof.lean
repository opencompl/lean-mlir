import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem test21_thm (x : _root_.BitVec 8) : 
    x.sshiftRight 7 &&& 1#8 = x >>> 7 := by
  sorry

