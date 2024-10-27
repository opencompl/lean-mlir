
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gdistribute_proof
theorem factorize_thm (x : BitVec 32) : (x ||| 1#32) &&& (x ||| 2#32) = x := by bv_compare'

theorem factorize2_thm (x : BitVec 32) : 3#32 * x - 2#32 * x = x := by bv_compare'

theorem factorize3_thm (x x_1 x_2 : BitVec 32) : (x_2 ||| (x_1 ||| x)) &&& (x_2 ||| x) = x_2 ||| x := by bv_compare'

theorem factorize4_thm (x x_1 : BitVec 32) : x_1 <<< 1 * x - x * x_1 = x_1 * x := by bv_compare'

theorem factorize5_thm (x x_1 : BitVec 32) : x_1 * 2#32 * x - x * x_1 = x_1 * x := by bv_compare'

theorem expand_thm (x : BitVec 32) : (x &&& 1#32 ||| 2#32) &&& 1#32 = x &&& 1#32 := by bv_compare'

