
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section greassociatehnuw_proof
theorem reassoc_add_nuw_thm (x : BitVec 32) : x + 4#32 + 64#32 = x + 68#32 := sorry

theorem reassoc_sub_nuw_thm (x : BitVec 32) : x - 4#32 - 64#32 = x + 4294967228#32 := sorry

theorem reassoc_mul_nuw_thm (x : BitVec 32) : x * 4#32 * 65#32 = x * 260#32 := sorry

theorem no_reassoc_add_nuw_none_thm (x : BitVec 32) : x + 4#32 + 64#32 = x + 68#32 := sorry

theorem no_reassoc_add_none_nuw_thm (x : BitVec 32) : x + 4#32 + 64#32 = x + 68#32 := sorry

theorem reassoc_x2_add_nuw_thm (x x_1 : BitVec 32) : x_1 + 4#32 + (x + 8#32) = x_1 + x + 12#32 := sorry

theorem reassoc_x2_mul_nuw_thm (x x_1 : BitVec 32) : x_1 * 5#32 * (x * 9#32) = x_1 * x * 45#32 := sorry

theorem reassoc_x2_sub_nuw_thm (x x_1 : BitVec 32) : x_1 - 4#32 - (x - 8#32) = x_1 - x + 4#32 := sorry

theorem tryFactorization_add_nuw_mul_nuw_thm (x : BitVec 32) : x * 3#32 + x = x <<< 2 := sorry

theorem tryFactorization_add_nuw_mul_nuw_int_max_thm (x : BitVec 32) : x * 2147483647#32 + x = x <<< 31 := sorry

theorem tryFactorization_add_mul_nuw_thm (x : BitVec 32) : x * 3#32 + x = x <<< 2 := sorry

theorem tryFactorization_add_nuw_mul_thm (x : BitVec 32) : x * 3#32 + x = x <<< 2 := sorry

theorem tryFactorization_add_nuw_mul_nuw_mul_nuw_var_thm (x x_1 x_2 : BitVec 32) : x_2 * x_1 + x_2 * x = (x_1 + x) * x_2 := sorry

theorem tryFactorization_add_nuw_mul_mul_nuw_var_thm (x x_1 x_2 : BitVec 32) : x_2 * x_1 + x_2 * x = (x_1 + x) * x_2 := sorry

theorem tryFactorization_add_nuw_mul_nuw_mul_var_thm (x x_1 x_2 : BitVec 32) : x_2 * x_1 + x_2 * x = (x_1 + x) * x_2 := sorry

theorem tryFactorization_add_mul_nuw_mul_var_thm (x x_1 x_2 : BitVec 32) : x_2 * x_1 + x_2 * x = (x_1 + x) * x_2 := sorry

