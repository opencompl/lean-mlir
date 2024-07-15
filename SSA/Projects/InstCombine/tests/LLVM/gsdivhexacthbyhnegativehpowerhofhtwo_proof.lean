import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem t0_thm (x : _root_.BitVec 8) : 
    x.sdiv 224#8 = x.sshiftRight 5 * 255#8 := by
  sorry

theorem prove_exact_with_high_mask_thm (x : _root_.BitVec 8) : 
    (x &&& 224#8).sdiv 252#8 = (x.sshiftRight 2 &&& 248#8) * 255#8 := by
  sorry

theorem prove_exact_with_high_mask_limit_thm (x : _root_.BitVec 8) : 
    (x &&& 224#8).sdiv 224#8 = x.sshiftRight 5 * 255#8 := by
  sorry

