
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gandhxorhmerge_proof
theorem test1_thm (x x_1 x_2 : BitVec 32) : x_2 &&& x_1 ^^^ x_2 &&& x = x_2 &&& (x_1 ^^^ x) := sorry

theorem test2_thm (x x_1 : BitVec 32) : x_1 &&& x ^^^ (x_1 ||| x) = x_1 ^^^ x := sorry

theorem PR75692_1_thm (x : BitVec 32) : (x ^^^ 4#32) &&& (x ^^^ 4294967291#32) = 0#32 := sorry

