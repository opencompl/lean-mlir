
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gmaskedhmergehadd_proof
theorem p_thm (x x_1 x_2 : BitVec 32) :
  (x_2 &&& x_1) + ((x_1 ^^^ 4294967295#32) &&& x) = x_2 &&& x_1 ||| x &&& (x_1 ^^^ 4294967295#32) := sorry

theorem p_constmask_thm (x x_1 : BitVec 32) :
  (x_1 &&& 65280#32) + (x &&& 4294902015#32) = x_1 &&& 65280#32 ||| x &&& 4294902015#32 := sorry

theorem p_constmask2_thm (x x_1 : BitVec 32) :
  (x_1 &&& 61440#32) + (x &&& 4294902015#32) = x_1 &&& 61440#32 ||| x &&& 4294902015#32 := sorry

theorem p_commutative0_thm (x x_1 x_2 : BitVec 32) :
  (x_2 &&& x_1) + ((x_2 ^^^ 4294967295#32) &&& x) = x_2 &&& x_1 ||| x &&& (x_2 ^^^ 4294967295#32) := sorry

theorem p_commutative2_thm (x x_1 x_2 : BitVec 32) :
  ((x_2 ^^^ 4294967295#32) &&& x_1) + (x &&& x_2) = x_1 &&& (x_2 ^^^ 4294967295#32) ||| x &&& x_2 := sorry

theorem p_commutative4_thm (x x_1 x_2 : BitVec 32) :
  ((x_2 ^^^ 4294967295#32) &&& x_1) + (x_2 &&& x) = x_1 &&& (x_2 ^^^ 4294967295#32) ||| x_2 &&& x := sorry

theorem p_constmask_commutative_thm (x x_1 : BitVec 32) :
  (x_1 &&& 4294902015#32) + (x &&& 65280#32) = x_1 &&& 4294902015#32 ||| x &&& 65280#32 := sorry

theorem n2_badmask_thm (x x_1 : BitVec 32) : (x_1 ^^^ 4294967295#32) &&& x = x &&& (x_1 ^^^ 4294967295#32) := sorry

theorem n3_constmask_samemask_thm (x x_1 : BitVec 32) :
  some ((x_1 &&& 65280#32) + (x &&& 65280#32)) ⊑
    if
        (x_1.msb && (65280#32).msb) = (x.msb && (65280#32).msb) ∧
          ¬((x_1 &&& 65280#32) + (x &&& 65280#32)).msb = (x_1.msb && (65280#32).msb) then
      none
    else
      if
          (x_1 &&& 65280#32) + (x &&& 65280#32) < x_1 &&& 65280#32 ∨
            (x_1 &&& 65280#32) + (x &&& 65280#32) < x &&& 65280#32 then
        none
      else some ((x_1 &&& 65280#32) + (x &&& 65280#32)) := sorry

