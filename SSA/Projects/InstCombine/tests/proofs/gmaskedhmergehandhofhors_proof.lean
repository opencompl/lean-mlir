
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmaskedhmergehandhofhors_proof
theorem p_thm (x x_1 x_2 : BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1) &&& (x ||| x_2) = (x_1 ||| x_2 ^^^ 4294967295#32) &&& (x ||| x_2) := by bv_compare'

theorem p_commutative2_thm (x x_1 x_2 : BitVec 32) :
  (x_2 ||| x_1) &&& (x_1 ^^^ 4294967295#32 ||| x) = (x_2 ||| x_1) &&& (x ||| x_1 ^^^ 4294967295#32) := by bv_compare'

theorem n2_badmask_thm (x x_1 x_2 x_3 : BitVec 32) :
  (x_3 ^^^ 4294967295#32 ||| x_2) &&& (x_1 ||| x) = (x_2 ||| x_3 ^^^ 4294967295#32) &&& (x_1 ||| x) := by bv_compare'

theorem n3_constmask_samemask_thm (x x_1 : BitVec 32) :
  (x_1 ||| 4294902015#32) &&& (x ||| 4294902015#32) = x_1 &&& x ||| 4294902015#32 := by bv_compare'

