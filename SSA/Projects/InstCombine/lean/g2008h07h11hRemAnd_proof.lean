
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem a_thm (x : _root_.BitVec 32) : x + x.sdiv 8#32 * 4294967288#32 &&& 1#32 = x &&& 1#32 := sorry

