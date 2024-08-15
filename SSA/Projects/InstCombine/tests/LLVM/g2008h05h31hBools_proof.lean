import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem foo4_thm (x x_1 : _root_.BitVec 1) : 
    (if x = 0#1 then none else some (x_1.sdiv x)) ⊑ some x_1 := by
  sorry

