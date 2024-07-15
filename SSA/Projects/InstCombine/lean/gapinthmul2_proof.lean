import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem test1_thm (x : _root_.BitVec 177) :
  x * 45671926166590716193865151022383844364247891968#177 = x <<< 155 := sorry

