import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem sub_not_thm (x x_1 : _root_.BitVec 8) : 
    x_1 + x * 255#8 ^^^ 255#8 = x + (x_1 ^^^ 255#8) := by
  sorry

theorem dec_sub_thm (x x_1 : _root_.BitVec 8) : 
    x_1 + x * 255#8 + 255#8 = x_1 + (x ^^^ 255#8) := by
  sorry

theorem sub_inc_thm (x x_1 : _root_.BitVec 8) : 
    x_1 + x * 255#8 + 255#8 = x_1 + (x ^^^ 255#8) := by
  sorry

theorem sub_dec_thm (x x_1 : _root_.BitVec 8) : 
    x_1 + 255#8 + 255#8 * x = x_1 + (x ^^^ 255#8) := by
  sorry

