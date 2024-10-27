
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gpr53357_proof
theorem src_thm (x x_1 : BitVec 32) :
  (x_1 &&& x) + ((x_1 ||| x) ^^^ 4294967295#32) = x_1 ^^^ x ^^^ 4294967295#32 := by bv_compare'

theorem src2_thm (x x_1 : BitVec 32) :
  (x_1 &&& x) + ((x ||| x_1) ^^^ 4294967295#32) = x_1 ^^^ x ^^^ 4294967295#32 := by bv_compare'

theorem src3_thm (x x_1 : BitVec 32) :
  (x_1 &&& x) + ((x ^^^ 4294967295#32) &&& (x_1 ^^^ 4294967295#32)) = x_1 ^^^ x ^^^ 4294967295#32 := by bv_compare'

theorem src4_thm (x x_1 : BitVec 32) :
  (x_1 &&& x) + ((x ||| x_1) ^^^ 4294967295#32) = x_1 ^^^ x ^^^ 4294967295#32 := by bv_compare'

theorem src5_thm (x x_1 : BitVec 32) :
  ((x_1 ||| x) ^^^ 4294967295#32) + (x_1 &&& x) = x_1 ^^^ x ^^^ 4294967295#32 := by bv_compare'

