import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem add_mask_ashr28_i32_thm (x : _root_.BitVec 32) : 
    (x.sshiftRight 28 &&& 8#32) + x.sshiftRight 28 = x >>> 28 &&& 7#32 := by
  sorry

