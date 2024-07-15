import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem test6_thm (x : _root_.BitVec 55) : 
    x <<< 1 * 3#55 = x * 6#55 := by
  sorry

theorem test6a_thm (x : _root_.BitVec 55) : 
    (x * 3#55) <<< 1 = x * 6#55 := by
  sorry

theorem test9_thm (x : _root_.BitVec 17) : 
    x <<< 16 >>> 16 = x &&& 1#17 := by
  sorry

