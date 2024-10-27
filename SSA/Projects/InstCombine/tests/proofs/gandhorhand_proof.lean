
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gandhorhand_proof
theorem test1_thm (x x_1 : BitVec 32) : (x_1 &&& 7#32 ||| x &&& 8#32) &&& 7#32 = x_1 &&& 7#32 := by bv_compare'

theorem test2_thm (x : BitVec 8) (x_1 : BitVec 32) : (x_1 ||| setWidth 32 x) &&& 65536#32 = x_1 &&& 65536#32 := by bv_compare'

theorem test3_thm (x x_1 : BitVec 32) : (x_1 ||| x <<< 1) &&& 1#32 = x_1 &&& 1#32 := by bv_compare'

theorem test4_thm (x x_1 : BitVec 32) : (x_1 ||| x >>> 31) &&& 2#32 = x_1 &&& 2#32 := by bv_compare'

theorem or_test1_thm (x : BitVec 32) : x &&& 1#32 ||| 1#32 = 1#32 := by bv_compare'

theorem or_test2_thm (x : BitVec 8) : x <<< 7 ||| 128#8 = 128#8 := by bv_compare'

