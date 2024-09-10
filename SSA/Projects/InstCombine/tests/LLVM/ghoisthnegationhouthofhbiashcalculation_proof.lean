
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ghoisthnegationhouthofhbiashcalculation_proof
theorem t0_thm (x x_1 : BitVec 8) : (-x_1 &&& x) - x = -(x_1 + 255#8 &&& x) := sorry

theorem n7_thm (x x_1 : BitVec 8) : x_1 - (-x &&& x_1) = x + 255#8 &&& x_1 := sorry

theorem n9_thm (x x_1 : BitVec 8) : x_1 &&& -x = -x &&& x_1 := sorry

