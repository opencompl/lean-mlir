
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthshift_proof
theorem test6_thm (x : BitVec 55) : x <<< 1 * 3#55 = x * 6#55 := sorry

theorem test6a_thm (x : BitVec 55) : (x * 3#55) <<< 1 = x * 6#55 := sorry

theorem test8_thm (x : BitVec 7) : x <<< 7 = 0#7 := sorry

theorem test9_thm (x : BitVec 17) : x <<< 16 >>> 16 = x &&& 1#17 := sorry

