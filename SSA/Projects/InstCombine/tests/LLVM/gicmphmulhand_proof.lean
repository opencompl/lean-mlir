import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem pr40493_neg3_thm (x : _root_.BitVec 32) : 
    x * 12#32 &&& 4#32 = x <<< 2 &&& 4#32 := by
  sorry

theorem pr51551_demand3bits_thm (x x_1 : _root_.BitVec 32) : 
    (x_1 &&& 4294967289#32 ||| 1#32) * x &&& 7#32 = x &&& 7#32 := by
  sorry

