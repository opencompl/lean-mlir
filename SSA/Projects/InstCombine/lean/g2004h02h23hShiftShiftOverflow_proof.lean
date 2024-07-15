import SSA.Projects.InstCombine.ForLean
open Std (BitVec)
theorem test_thm (x : _root_.BitVec 32) : (x.sshiftRight 17).sshiftRight 17 = x.sshiftRight 31 := sorry

theorem test2_thm (x : _root_.BitVec 32) : x <<< 34 = 0#32 := sorry
