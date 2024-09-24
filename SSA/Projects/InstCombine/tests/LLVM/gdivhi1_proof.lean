
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gdivhi1_proof
theorem sdiv_i1_is_op0_thm (x x_1 : BitVec 1) : (if x = 0#1 then none else some (x_1.sdiv x)) ⊑ some x_1 := sorry

