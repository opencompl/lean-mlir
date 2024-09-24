
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gxor_proof
theorem test1_thm (x : BitVec 32) : x ^^^ 0#32 = x := sorry

theorem test3_thm (x : BitVec 32) : x ^^^ x = 0#32 := sorry

theorem test4_thm (x : BitVec 32) : x ^^^ (4294967295#32 ^^^ x) = 4294967295#32 := sorry

theorem test5_thm (x : BitVec 32) : (x ||| 123#32) ^^^ 123#32 = x &&& 4294967172#32 := sorry

theorem test6_thm (x : BitVec 8) : x ^^^ 17#8 ^^^ 17#8 = x := sorry

theorem test7_thm (x x_1 : BitVec 32) : x_1 &&& 7#32 ^^^ x &&& 128#32 = x_1 &&& 7#32 ||| x &&& 128#32 := sorry

