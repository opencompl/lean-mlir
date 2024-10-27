
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gunfoldhmaskedhmergehwithhconsthmaskhscalar_proof
theorem scalar0_thm (x x_1 : BitVec 4) : (x_1 ^^^ x) &&& 1#4 ^^^ x = x_1 &&& 1#4 ||| x &&& 14#4 := by bv_compare'

theorem scalar1_thm (x x_1 : BitVec 4) : (x_1 ^^^ x) &&& 14#4 ^^^ x = x_1 &&& 14#4 ||| x &&& 1#4 := by bv_compare'

theorem in_constant_varx_mone_thm (x : BitVec 4) : (x ^^^ 15#4) &&& 1#4 ^^^ 15#4 = x ||| 14#4 := by bv_compare'

theorem in_constant_varx_14_thm (x : BitVec 4) : (x ^^^ 14#4) &&& 1#4 ^^^ 14#4 = x ||| 14#4 := by bv_compare'

theorem in_constant_mone_vary_thm (x : BitVec 4) : (x ^^^ 15#4) &&& 1#4 ^^^ x = x ||| 1#4 := by bv_compare'

theorem in_constant_14_vary_thm (x : BitVec 4) : (x ^^^ 14#4) &&& 1#4 ^^^ x = x &&& 14#4 := by bv_compare'

theorem c_1_0_0_thm (x x_1 : BitVec 4) : (x_1 ^^^ x) &&& 14#4 ^^^ x_1 = x &&& 14#4 ||| x_1 &&& 1#4 := by bv_compare'

theorem c_0_1_0_thm (x x_1 : BitVec 4) : (x_1 ^^^ x) &&& 14#4 ^^^ x_1 = x &&& 14#4 ||| x_1 &&& 1#4 := by bv_compare'

theorem c_1_1_0_thm (x x_1 : BitVec 4) : (x_1 ^^^ x) &&& 14#4 ^^^ x = x_1 &&& 14#4 ||| x &&& 1#4 := by bv_compare'

theorem commutativity_constant_14_vary_thm (x : BitVec 4) : x ^^^ (x ^^^ 14#4) &&& 1#4 = x &&& 14#4 := by bv_compare'

