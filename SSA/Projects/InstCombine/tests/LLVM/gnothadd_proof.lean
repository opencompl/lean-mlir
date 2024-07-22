import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem basic_thm (x x_1 : _root_.BitVec 8) : 
    (x_1 ^^^ 255#8) + x ^^^ 255#8 = x * 255#8 + x_1 := by
  sorry

theorem basic_com_add_thm (x x_1 : _root_.BitVec 8) : 
    x_1 + (x ^^^ 255#8) ^^^ 255#8 = x_1 * 255#8 + x := by
  sorry

theorem basic_preserve_nsw_thm (x x_1 : _root_.BitVec 8) : 
    (x_1 ^^^ 255#8) + x ^^^ 255#8 = x * 255#8 + x_1 := by
  sorry

theorem basic_preserve_nuw_thm (x x_1 : _root_.BitVec 8) : 
    (x_1 ^^^ 255#8) + x ^^^ 255#8 = x * 255#8 + x_1 := by
  sorry

theorem basic_preserve_nuw_nsw_thm (x x_1 : _root_.BitVec 8) : 
    (x_1 ^^^ 255#8) + x ^^^ 255#8 = x * 255#8 + x_1 := by
  sorry

