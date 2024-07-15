
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem PR75692_1_thm (x : _root_.BitVec 32) : (x ^^^ 4#32) &&& (x ^^^ 4294967291#32) = 0#32 := sorry

