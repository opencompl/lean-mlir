
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem t1_thm (x : _root_.BitVec 4) : (x ||| 12#4) ^^^ 10#4 = x &&& 3#4 ^^^ 6#4 := sorry

