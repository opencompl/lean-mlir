
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmaskedhmergehandhofhors_proof
theorem p_commutative0_thm (x x_1 x_2 : BitVec 32) :
  (x_2 ||| x_1 ^^^ 4294967295#32) &&& (x ||| x_1) = (x_1 ^^^ 4294967295#32 ||| x_2) &&& (x ||| x_1) := sorry

theorem p_commutative4_thm (x x_1 x_2 : BitVec 32) :
  (x_2 ||| x_1) &&& (x ||| x_1 ^^^ 4294967295#32) = (x_2 ||| x_1) &&& (x_1 ^^^ 4294967295#32 ||| x) := sorry

theorem n3_constmask_samemask_thm (x x_1 : BitVec 32) :
  (x_1 ||| 4294902015#32) &&& (x ||| 4294902015#32) = x_1 &&& x ||| 4294902015#32 := sorry

