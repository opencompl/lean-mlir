import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem scalar_thm (x x_1 x_2 : _root_.BitVec 4) :
  (x_2 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_1 = (x_2 ^^^ x_1) &&& x ^^^ x_2 := by
  sorry

theorem in_constant_varx_mone_invmask_thm (x x_1 : _root_.BitVec 4) : 
    (x_1 ^^^ 15#4) &&& (x ^^^ 15#4) ^^^ 15#4 = x_1 ||| x := by
  sorry

theorem in_constant_varx_6_invmask_thm (x x_1 : _root_.BitVec 4) :
  (x_1 ^^^ 6#4) &&& (x ^^^ 15#4) ^^^ 6#4 = (x_1 ^^^ 6#4) &&& x ^^^ x_1 := by
  sorry

theorem in_constant_mone_vary_invmask_thm (x x_1 : _root_.BitVec 4) : 
    (15#4 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_1 = x ^^^ 15#4 ||| x_1 := by
  sorry

theorem in_constant_6_vary_invmask_thm (x x_1 : _root_.BitVec 4) :
  (x_1 ^^^ 6#4) &&& (x ^^^ 15#4) ^^^ x_1 = (x_1 ^^^ 6#4) &&& x ^^^ 6#4 := by
  sorry

theorem c_1_0_0_thm (x x_1 x_2 : _root_.BitVec 4) :
  (x_2 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_2 = (x_2 ^^^ x_1) &&& x ^^^ x_1 := by
  sorry

theorem c_0_1_0_thm (x x_1 x_2 : _root_.BitVec 4) :
  (x_2 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_2 = (x_2 ^^^ x_1) &&& x ^^^ x_1 := by
  sorry

theorem c_1_1_0_thm (x x_1 x_2 : _root_.BitVec 4) :
  (x_2 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_1 = (x_2 ^^^ x_1) &&& x ^^^ x_2 := by
  sorry

theorem commutativity_constant_varx_6_invmask_thm (x x_1 : _root_.BitVec 4) :
  (x_1 ^^^ 15#4) &&& (x ^^^ 6#4) ^^^ 6#4 = (x ^^^ 6#4) &&& x_1 ^^^ x := by
  sorry

theorem commutativity_constant_6_vary_invmask_thm (x x_1 : _root_.BitVec 4) :
  (x_1 ^^^ 15#4) &&& (x ^^^ 6#4) ^^^ x = (x ^^^ 6#4) &&& x_1 ^^^ 6#4 := by
  sorry

