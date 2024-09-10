
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2008h05h31hBools_proof
theorem foo1_thm (x x_1 : BitVec 1) : x_1 - x = x ^^^ x_1 := sorry

theorem foo4_thm (x x_1 : BitVec 1) : (if x = 0#1 then none else some (x_1.sdiv x)) ⊑ some x_1 := sorry

