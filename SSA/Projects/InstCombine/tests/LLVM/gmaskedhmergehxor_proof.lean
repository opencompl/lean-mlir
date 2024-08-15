import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem p_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 &&& x_1 ^^^ (x_1 ^^^ 4294967295#32) &&& x = x_2 &&& x_1 ||| (x_1 ^^^ 4294967295#32) &&& x := by
  sorry

theorem p_constmask_thm (x x_1 : _root_.BitVec 32) :
  x_1 &&& 65280#32 ^^^ x &&& 4294902015#32 = x_1 &&& 65280#32 ||| x &&& 4294902015#32 := by
  sorry

theorem p_constmask2_thm (x x_1 : _root_.BitVec 32) :
  x_1 &&& 61440#32 ^^^ x &&& 4294902015#32 = x_1 &&& 61440#32 ||| x &&& 4294902015#32 := by
  sorry

theorem p_commutative0_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 &&& x_1 ^^^ (x_2 ^^^ 4294967295#32) &&& x = x_2 &&& x_1 ||| (x_2 ^^^ 4294967295#32) &&& x := by
  sorry

theorem p_commutative2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 ^^^ x &&& x_2 = (x_2 ^^^ 4294967295#32) &&& x_1 ||| x &&& x_2 := by
  sorry

theorem p_commutative4_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 ^^^ x_2 &&& x = (x_2 ^^^ 4294967295#32) &&& x_1 ||| x_2 &&& x := by
  sorry

theorem p_constmask_commutative_thm (x x_1 : _root_.BitVec 32) :
  x_1 &&& 4294902015#32 ^^^ x &&& 65280#32 = x_1 &&& 4294902015#32 ||| x &&& 65280#32 := by
  sorry

