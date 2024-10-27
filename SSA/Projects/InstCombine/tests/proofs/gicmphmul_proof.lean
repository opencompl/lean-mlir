
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gicmphmul_proof
theorem mul_of_pow2s_thm (x x_1 : BitVec 32) : (x_1 &&& 8#32) * (x &&& 16#32) ||| 128#32 = 128#32 := by bv_compare'

