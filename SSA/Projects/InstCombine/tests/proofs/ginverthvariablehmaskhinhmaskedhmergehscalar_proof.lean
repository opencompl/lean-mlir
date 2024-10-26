
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ginverthvariablehmaskhinhmaskedhmergehscalar_proof
theorem scalar_thm (x x_1 x_2 : BitVec 4) :
  (x_2 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_1 = (x_2 ^^^ x_1) &&& x ^^^ x_2 := sorry

theorem in_constant_varx_mone_invmask_thm (x x_1 : BitVec 4) : (x_1 ^^^ 15#4) &&& (x ^^^ 15#4) ^^^ 15#4 = x_1 ||| x := sorry

theorem in_constant_varx_6_invmask_thm (x x_1 : BitVec 4) : (x_1 ^^^ 6#4) &&& (x ^^^ 15#4) ^^^ 6#4 = (x_1 ^^^ 6#4) &&& x ^^^ x_1 := sorry

theorem in_constant_mone_vary_invmask_thm (x x_1 : BitVec 4) : (15#4 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_1 = x_1 ||| x ^^^ 15#4 := sorry

theorem in_constant_6_vary_invmask_thm (x x_1 : BitVec 4) : (x_1 ^^^ 6#4) &&& (x ^^^ 15#4) ^^^ x_1 = (x_1 ^^^ 6#4) &&& x ^^^ 6#4 := sorry

theorem c_1_0_0_thm (x x_1 x_2 : BitVec 4) :
  (x_2 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_2 = (x_2 ^^^ x_1) &&& x ^^^ x_1 := sorry

theorem c_0_1_0_thm (x x_1 x_2 : BitVec 4) :
  (x_2 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_2 = (x_2 ^^^ x_1) &&& x ^^^ x_1 := sorry

theorem c_1_1_0_thm (x x_1 x_2 : BitVec 4) :
  (x_2 ^^^ x_1) &&& (x ^^^ 15#4) ^^^ x_1 = (x_2 ^^^ x_1) &&& x ^^^ x_2 := sorry

theorem commutativity_constant_varx_6_invmask_thm (x x_1 : BitVec 4) : (x_1 ^^^ 15#4) &&& (x ^^^ 6#4) ^^^ 6#4 = (x ^^^ 6#4) &&& x_1 ^^^ x := sorry

theorem commutativity_constant_6_vary_invmask_thm (x x_1 : BitVec 4) : (x_1 ^^^ 15#4) &&& (x ^^^ 6#4) ^^^ x = (x ^^^ 6#4) &&& x_1 ^^^ 6#4 := sorry

