
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmaskedhmergehor_proof
theorem p_thm (x x_1 x_2 : BitVec 32) :
  x_2 &&& x_1 ||| (x_1 ^^^ 4294967295#32) &&& x = x_2 &&& x_1 ||| x &&& (x_1 ^^^ 4294967295#32) := sorry

theorem p_commutative0_thm (x x_1 x_2 : BitVec 32) :
  x_2 &&& x_1 ||| (x_2 ^^^ 4294967295#32) &&& x = x_2 &&& x_1 ||| x &&& (x_2 ^^^ 4294967295#32) := sorry

theorem p_commutative2_thm (x x_1 x_2 : BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 ||| x &&& x_2 = x_1 &&& (x_2 ^^^ 4294967295#32) ||| x &&& x_2 := sorry

theorem p_commutative4_thm (x x_1 x_2 : BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 ||| x_2 &&& x = x_1 &&& (x_2 ^^^ 4294967295#32) ||| x_2 &&& x := sorry

theorem n2_badmask_thm (x x_1 x_2 x_3 : BitVec 32) :
  x_3 &&& x_2 ||| (x_1 ^^^ 4294967295#32) &&& x = x_3 &&& x_2 ||| x &&& (x_1 ^^^ 4294967295#32) := sorry

theorem n3_constmask_samemask_thm (x x_1 : BitVec 32) : x_1 &&& 65280#32 ||| x &&& 65280#32 = (x_1 ||| x) &&& 65280#32 := sorry

