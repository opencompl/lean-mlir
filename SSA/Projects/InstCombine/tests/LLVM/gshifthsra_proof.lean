import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem ashr_ashr_thm (x : _root_.BitVec 32) : 
    (x.sshiftRight 5).sshiftRight 7 = x.sshiftRight 12 := by
  sorry

theorem ashr_overshift_thm (x : _root_.BitVec 32) : 
    (x.sshiftRight 15).sshiftRight 17 = x.sshiftRight 31 := by
  sorry

