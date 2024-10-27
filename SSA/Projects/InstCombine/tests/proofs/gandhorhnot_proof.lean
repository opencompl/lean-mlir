
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gandhorhnot_proof
theorem and_to_xor1_thm (x x_1 : BitVec 32) : (x_1 ||| x) &&& (x_1 &&& x ^^^ 4294967295#32) = x_1 ^^^ x := by bv_compare'

theorem and_to_xor2_thm (x x_1 : BitVec 32) : (x_1 &&& x ^^^ 4294967295#32) &&& (x_1 ||| x) = x_1 ^^^ x := by bv_compare'

theorem and_to_xor3_thm (x x_1 : BitVec 32) : (x_1 ||| x) &&& (x &&& x_1 ^^^ 4294967295#32) = x_1 ^^^ x := by bv_compare'

theorem and_to_xor4_thm (x x_1 : BitVec 32) : (x_1 &&& x ^^^ 4294967295#32) &&& (x ||| x_1) = x ^^^ x_1 := by bv_compare'

theorem or_to_nxor1_thm (x x_1 : BitVec 32) :
  x_1 &&& x ||| (x_1 ||| x) ^^^ 4294967295#32 = x_1 ^^^ x ^^^ 4294967295#32 := by bv_compare'

theorem or_to_nxor2_thm (x x_1 : BitVec 32) :
  x_1 &&& x ||| (x ||| x_1) ^^^ 4294967295#32 = x_1 ^^^ x ^^^ 4294967295#32 := by bv_compare'

theorem or_to_nxor3_thm (x x_1 : BitVec 32) :
  (x_1 ||| x) ^^^ 4294967295#32 ||| x_1 &&& x = x_1 ^^^ x ^^^ 4294967295#32 := by bv_compare'

theorem or_to_nxor4_thm (x x_1 : BitVec 32) :
  (x_1 ||| x) ^^^ 4294967295#32 ||| x &&& x_1 = x ^^^ x_1 ^^^ 4294967295#32 := by bv_compare'

theorem xor_to_xor1_thm (x x_1 : BitVec 32) : x_1 &&& x ^^^ (x_1 ||| x) = x_1 ^^^ x := by bv_compare'

theorem xor_to_xor2_thm (x x_1 : BitVec 32) : x_1 &&& x ^^^ (x ||| x_1) = x_1 ^^^ x := by bv_compare'

theorem xor_to_xor3_thm (x x_1 : BitVec 32) : (x_1 ||| x) ^^^ x_1 &&& x = x_1 ^^^ x := by bv_compare'

theorem xor_to_xor4_thm (x x_1 : BitVec 32) : (x_1 ||| x) ^^^ x &&& x_1 = x ^^^ x_1 := by bv_compare'

theorem PR32830_thm (x x_1 x_2 : BitVec 64) :
  (x_2 ^^^ 18446744073709551615#64 ||| x_1) &&& (x_1 ^^^ 18446744073709551615#64 ||| x) =
    (x_1 ||| x_2 ^^^ 18446744073709551615#64) &&& (x ||| x_1 ^^^ 18446744073709551615#64) := by bv_compare'

theorem simplify_or_common_op_commute0_thm (x x_1 x_2 : BitVec 4) : x_2 &&& x_1 &&& x ^^^ 15#4 ||| x_2 = 15#4 := by bv_compare'

theorem simplify_or_common_op_commute1_thm (x x_1 x_2 : BitVec 4) : x_2 &&& x_1 &&& x ^^^ 15#4 ||| x_1 = 15#4 := by bv_compare'

theorem simplify_or_common_op_commute2_thm (x x_1 x_2 x_3 : BitVec 4) : x_3 * x_3 &&& (x_2 &&& x_1) &&& x ^^^ 15#4 ||| x_2 = 15#4 := by bv_compare'

theorem simplify_and_common_op_commute1_thm (x x_1 x_2 : BitVec 4) : ((x_2 ||| x_1 ||| x) ^^^ 15#4) &&& x_1 = 0#4 := by bv_compare'

theorem simplify_and_common_op_commute2_thm (x x_1 x_2 x_3 : BitVec 4) : ((x_3 * x_3 ||| (x_2 ||| x_1) ||| x) ^^^ 15#4) &&& x_2 = 0#4 := by bv_compare'

theorem reduce_xor_common_op_commute0_thm (x x_1 x_2 : BitVec 4) : x_2 ^^^ x_1 ^^^ x ||| x_2 = x_1 ^^^ x ||| x_2 := by bv_compare'

theorem reduce_xor_common_op_commute1_thm (x x_1 x_2 : BitVec 4) : x_2 ^^^ x_1 ^^^ x ||| x_1 = x_2 ^^^ x ||| x_1 := by bv_compare'

theorem annihilate_xor_common_op_commute2_thm (x x_1 x_2 x_3 : BitVec 4) :
  x_3 * x_3 ^^^ (x_2 ^^^ x_1) ^^^ x ^^^ x_2 = x_1 ^^^ x_3 * x_3 ^^^ x := by bv_compare'

