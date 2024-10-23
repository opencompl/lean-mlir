
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthsub_proof
theorem test5_thm (x x_1 x_2 : BitVec 19) : x_2 - (x_1 - x) = x - x_1 + x_2 := sorry

theorem test6_thm (x x_1 : BitVec 57) : x_1 - (x_1 &&& x) = x_1 &&& (x ^^^ 144115188075855871#57) := sorry

theorem test7_thm (x : BitVec 77) : 151115727451828646838271#77 - x = x ^^^ 151115727451828646838271#77 := sorry

theorem test8_thm (x : BitVec 27) : 9#27 * x - x = x <<< 3 := sorry

theorem test9_thm (x : BitVec 42) : x - 3#42 * x = x * 4398046511102#42 := sorry

theorem test12_thm (x : BitVec 43) : -x.sshiftRight 42 = x >>> 42 := sorry

theorem test13_thm (x : BitVec 79) : -x >>> 78 = x.sshiftRight 78 := sorry

theorem test16_thm (x : BitVec 51) : -x.sdiv 1123#51 = x.sdiv 2251799813684125#51 := sorry

