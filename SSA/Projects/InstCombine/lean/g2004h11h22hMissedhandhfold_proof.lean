
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem test21_thm (x : _root_.BitVec 8) : x.sshiftRight 7 &&& 1#8 = x >>> 7 := sorry

