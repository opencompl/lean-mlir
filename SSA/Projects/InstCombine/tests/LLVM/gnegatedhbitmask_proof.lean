import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem neg_mask1_lshr_thm (x : _root_.BitVec 8) : 
    (x >>> 3 &&& 1#8) * 255#8 = (x <<< 4).sshiftRight 7 := by
  sorry

theorem sub_mask1_lshr_thm (x : _root_.BitVec 8) : 
    (x >>> 1 &&& 1#8) * 255#8 = (x <<< 6).sshiftRight 7 := by
  sorry

