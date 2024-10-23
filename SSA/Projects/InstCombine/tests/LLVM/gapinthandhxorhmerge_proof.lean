
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthandhxorhmerge_proof
theorem test1_thm (x x_1 x_2 : BitVec 57) : x_2 &&& x_1 ^^^ x_2 &&& x = x_2 &&& (x_1 ^^^ x) := sorry

theorem test2_thm (x x_1 : BitVec 23) : x_1 &&& x ^^^ (x_1 ||| x) = x_1 ^^^ x := sorry

