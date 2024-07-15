import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem srem2_ashr_mask_thm (x : _root_.BitVec 32) :
  (x + x.sdiv 2#32 * 4294967294#32).sshiftRight 31 &&& 2#32 = x + x.sdiv 2#32 * 4294967294#32 &&& 2#32 := sorry

