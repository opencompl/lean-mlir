import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem reassoc_x2_add_nuw_thm (x x_1 : _root_.BitVec 32) : 
    x_1 + 4#32 + x + 8#32 = x_1 + x + 12#32 := by
  sorry

theorem reassoc_x2_mul_nuw_thm (x x_1 : _root_.BitVec 32) : 
    x_1 * 5#32 * x * 9#32 = x_1 * x * 45#32 := by
  sorry

theorem tryFactorization_add_nuw_mul_nuw_thm (x : _root_.BitVec 32) : 
    x + x * 3#32 = x <<< 2 := by
  sorry

theorem tryFactorization_add_nuw_mul_nuw_int_max_thm (x : _root_.BitVec 32) : 
    x + x * 2147483647#32 = x <<< 31 := by
  sorry

theorem tryFactorization_add_mul_nuw_thm (x : _root_.BitVec 32) : 
    x + x * 3#32 = x <<< 2 := by
  sorry

theorem tryFactorization_add_nuw_mul_thm (x : _root_.BitVec 32) : 
    x + x * 3#32 = x <<< 2 := by
  sorry

