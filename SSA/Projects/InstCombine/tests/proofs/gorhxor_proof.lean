
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gorhxor_proof
theorem test1_thm (x x_1 : BitVec 32) : x_1 ||| (x_1 ||| x) ^^^ 4294967295#32 = x_1 ||| x ^^^ 4294967295#32 := sorry

theorem test2_thm (x x_1 : BitVec 32) : x_1 ||| (x ||| x_1) ^^^ 4294967295#32 = x_1 ||| x ^^^ 4294967295#32 := sorry

theorem test3_thm (x x_1 : BitVec 32) : x_1 ||| x_1 ^^^ x ^^^ 4294967295#32 = x_1 ||| x ^^^ 4294967295#32 := sorry

theorem test4_thm (x x_1 : BitVec 32) : x_1 ||| x ^^^ x_1 ^^^ 4294967295#32 = x_1 ||| x ^^^ 4294967295#32 := sorry

theorem test5_thm (x x_1 : BitVec 32) : x_1 ^^^ x ||| x_1 ^^^ 4294967295#32 = x_1 &&& x ^^^ 4294967295#32 := sorry

theorem test5_commuted_x_y_thm (x x_1 : BitVec 64) :
  x_1 ^^^ x ||| x ^^^ 18446744073709551615#64 = x_1 &&& x ^^^ 18446744073709551615#64 := sorry

theorem xor_common_op_commute0_thm (x x_1 : BitVec 8) : x_1 ^^^ x ||| x_1 = x ||| x_1 := sorry

theorem xor_common_op_commute2_thm (x x_1 : BitVec 8) : x_1 ^^^ 5#8 ||| x_1 ^^^ 5#8 ^^^ x = x_1 ^^^ 5#8 ||| x := sorry

theorem xor_common_op_commute3_thm (x x_1 : BitVec 8) : x_1 ^^^ 5#8 ||| x * x ^^^ (x_1 ^^^ 5#8) = x_1 ^^^ 5#8 ||| x * x := sorry

theorem test8_thm (x x_1 : BitVec 32) : x_1 ||| x ^^^ (x_1 ^^^ 4294967295#32) = x_1 ||| x ^^^ 4294967295#32 := sorry

theorem test9_thm (x x_1 : BitVec 32) : x_1 ||| x_1 ^^^ 4294967295#32 ^^^ x = x_1 ||| x ^^^ 4294967295#32 := sorry

theorem test10_thm (x x_1 : BitVec 32) :
  x_1 ^^^ x ||| x ^^^ 4294967295#32 ^^^ x_1 = x_1 ^^^ x ||| x ^^^ x_1 ^^^ 4294967295#32 := sorry

theorem test10_commuted_thm (x x_1 : BitVec 32) :
  x_1 ^^^ 4294967295#32 ^^^ x ||| x ^^^ x_1 = x ^^^ x_1 ||| x_1 ^^^ x ^^^ 4294967295#32 := sorry

theorem test11_thm (x x_1 : BitVec 32) : (x_1 ||| x) &&& (x_1 ^^^ 4294967295#32 ^^^ x) = x &&& x_1 := sorry

theorem test12_thm (x x_1 : BitVec 32) : (x_1 ^^^ 4294967295#32 ^^^ x) &&& (x_1 ||| x) = x &&& x_1 := sorry

theorem test12_commuted_thm (x x_1 : BitVec 32) : (x_1 ^^^ 4294967295#32 ^^^ x) &&& (x ||| x_1) = x &&& x_1 := sorry

theorem test13_thm (x x_1 : BitVec 32) : (x_1 ||| x) ^^^ (x_1 ^^^ x) = x &&& x_1 := sorry

theorem test14_thm (x x_1 : BitVec 32) :
  (x_1 ||| x ^^^ 4294967295#32) ^^^ (x_1 ^^^ 4294967295#32 ||| x) = x_1 ^^^ x := sorry

theorem test14_commuted_thm (x x_1 : BitVec 32) :
  (x_1 ^^^ 4294967295#32 ||| x) ^^^ (x ^^^ 4294967295#32 ||| x_1) = x ^^^ x_1 := sorry

theorem test15_thm (x x_1 : BitVec 32) :
  x_1 &&& (x ^^^ 4294967295#32) ^^^ (x_1 ^^^ 4294967295#32) &&& x = x_1 ^^^ x := sorry

theorem test15_commuted_thm (x x_1 : BitVec 32) :
  (x_1 ^^^ 4294967295#32) &&& x ^^^ (x ^^^ 4294967295#32) &&& x_1 = x ^^^ x_1 := sorry

theorem or_and_xor_not_constant_commute0_thm (x x_1 : BitVec 32) : (x_1 ^^^ x) &&& 1#32 ||| x &&& 4294967294#32 = x_1 &&& 1#32 ^^^ x := sorry

theorem or_and_xor_not_constant_commute1_thm (x x_1 : BitVec 9) : (x_1 ^^^ x) &&& 42#9 ||| x_1 &&& 469#9 = x &&& 42#9 ^^^ x_1 := sorry

theorem not_or_xor_thm (x : BitVec 8) : (x ^^^ 255#8 ||| 7#8) ^^^ 12#8 = x &&& 248#8 ^^^ 243#8 := sorry

theorem xor_or_thm (x : BitVec 8) : x ^^^ 32#8 ||| 7#8 = x &&& 248#8 ^^^ 39#8 := sorry

theorem xor_or2_thm (x : BitVec 8) : x ^^^ 33#8 ||| 7#8 = x &&& 248#8 ^^^ 39#8 := sorry

theorem xor_or_xor_thm (x : BitVec 8) : (x ^^^ 33#8 ||| 7#8) ^^^ 12#8 = x &&& 248#8 ^^^ 43#8 := sorry

theorem or_xor_or_thm (x : BitVec 8) : (x ||| 33#8) ^^^ 12#8 ||| 7#8 = x &&& 216#8 ^^^ 47#8 := sorry

theorem test17_thm (x x_1 : BitVec 8) :
  (x_1 ^^^ x ||| x ^^^ 33#8 ^^^ x_1) * (x ^^^ 33#8 ^^^ x_1) =
    (x_1 ^^^ x ||| x ^^^ x_1 ^^^ 33#8) * (x ^^^ x_1 ^^^ 33#8) := sorry

theorem test18_thm (x x_1 : BitVec 8) :
  (x_1 ^^^ 33#8 ^^^ x ||| x ^^^ x_1) * (x_1 ^^^ 33#8 ^^^ x) =
    (x_1 ^^^ x ^^^ 33#8 ||| x ^^^ x_1) * (x_1 ^^^ x ^^^ 33#8) := sorry

theorem test19_thm (x x_1 : BitVec 32) :
  (x_1 ||| x) ^^^ (x_1 ^^^ 4294967295#32 ||| x ^^^ 4294967295#32) = x_1 ^^^ x ^^^ 4294967295#32 := sorry

theorem test20_thm (x x_1 : BitVec 32) :
  (x_1 ||| x) ^^^ (x ^^^ 4294967295#32 ||| x_1 ^^^ 4294967295#32) = x_1 ^^^ x ^^^ 4294967295#32 := sorry

theorem test21_thm (x x_1 : BitVec 32) :
  (x_1 ^^^ 4294967295#32 ||| x ^^^ 4294967295#32) ^^^ (x_1 ||| x) = x_1 ^^^ x ^^^ 4294967295#32 := sorry

theorem test22_thm (x x_1 : BitVec 32) :
  (x_1 ^^^ 4294967295#32 ||| x ^^^ 4294967295#32) ^^^ (x ||| x_1) = x ^^^ x_1 ^^^ 4294967295#32 := sorry

theorem test23_thm (x : BitVec 8) : ((x ||| 254#8) ^^^ 13#8 ||| 1#8) ^^^ 12#8 = 255#8 := sorry

theorem PR45977_f1_thm (x x_1 : BitVec 32) :
  (x_1 ||| x) ^^^ 4294967295#32 ||| (x_1 ^^^ 4294967295#32) &&& x = x_1 ^^^ 4294967295#32 := sorry

theorem PR45977_f2_thm (x x_1 : BitVec 32) : (x_1 ||| x) ^^^ (x_1 ||| x ^^^ 4294967295#32) = x_1 ^^^ 4294967295#32 := sorry

theorem or_xor_common_op_commute0_thm (x x_1 x_2 : BitVec 8) : x_2 ||| x_1 ||| x_2 ^^^ x = x_2 ||| x_1 ||| x := sorry

theorem or_xor_common_op_commute5_thm (x x_1 x_2 : BitVec 8) : x_2 ^^^ x_1 ||| (x ||| x_2) = x ||| x_2 ||| x_1 := sorry

theorem or_xor_common_op_commute6_thm (x x_1 x_2 : BitVec 8) : x_2 ^^^ x_1 ||| (x_1 ||| x) = x_1 ||| x ||| x_2 := sorry

theorem or_xor_common_op_commute7_thm (x x_1 x_2 : BitVec 8) : x_2 ^^^ x_1 ||| (x ||| x_1) = x ||| x_1 ||| x_2 := sorry

theorem or_not_xor_common_op_commute0_thm (x x_1 x_2 : BitVec 4) : x_2 ^^^ 15#4 ||| x_1 ||| x_2 ^^^ x = x_1 ||| x_2 &&& x ^^^ 15#4 := sorry

theorem or_not_xor_common_op_commute2_thm (x x_1 x_2 : BitVec 8) :
  x_2 ^^^ x_1 ||| (-x ||| x_2 ^^^ 255#8) = x_2 &&& x_1 ^^^ 255#8 ||| -x := sorry

theorem or_not_xor_common_op_commute3_thm (x x_1 x_2 : BitVec 8) :
  -x_2 ||| x_1 ^^^ 255#8 ||| x_1 ^^^ x = x_1 &&& x ^^^ 255#8 ||| -x_2 := sorry

theorem or_not_xor_common_op_commute5_thm (x x_1 x_2 : BitVec 8) :
  x_2 ^^^ x_1 ||| (x_1 ^^^ 255#8 ||| x) = x ||| x_2 &&& x_1 ^^^ 255#8 := sorry

theorem or_not_xor_common_op_commute6_thm (x x_1 x_2 : BitVec 8) :
  x_2 ^^^ x_1 ||| (-x ||| x_1 ^^^ 255#8) = x_2 &&& x_1 ^^^ 255#8 ||| -x := sorry

theorem or_not_xor_common_op_commute7_thm (x x_1 x_2 : BitVec 8) :
  -x_2 ||| x_1 ^^^ 255#8 ||| x ^^^ x_1 = x &&& x_1 ^^^ 255#8 ||| -x_2 := sorry

theorem or_nand_xor_common_op_commute0_thm (x x_1 x_2 : BitVec 4) : x_2 &&& x_1 ^^^ 15#4 ||| x_2 ^^^ x = x_2 &&& x_1 &&& x ^^^ 15#4 := sorry

theorem PR75692_1_thm (x : BitVec 32) : x ^^^ 4#32 ||| x ^^^ 4294967291#32 = 4294967295#32 := sorry

theorem or_xor_not_thm (x x_1 : BitVec 32) : x_1 ^^^ (x ^^^ 4294967295#32) ||| x = x ||| x_1 ^^^ 4294967295#32 := sorry

theorem or_xor_and_commuted1_thm (x x_1 : BitVec 32) :
  x_1 * x_1 ||| x_1 * x_1 ^^^ 4294967295#32 ^^^ x = x_1 * x_1 ||| x ^^^ 4294967295#32 := sorry

theorem or_xor_and_commuted2_thm (x x_1 : BitVec 32) :
  x_1 * x_1 ^^^ (x * x ^^^ 4294967295#32) ||| x * x = x * x ||| x_1 * x_1 ^^^ 4294967295#32 := sorry

theorem or_xor_tree_0000_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ||| x_1 * 42#32 ^^^ x * 42#32 ^^^ x_2 * 42#32 =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_0001_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ||| x_2 * 42#32 ^^^ x * 42#32 ^^^ x_1 * 42#32 =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_0010_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 ^^^ x_1 * 42#32 ^^^ x_2 * 42#32 =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_0011_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 ^^^ x_2 * 42#32 ^^^ x_1 * 42#32 =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_0100_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ||| x_2 * 42#32 ^^^ (x_1 * 42#32 ^^^ x * 42#32) =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_0101_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ||| x_1 * 42#32 ^^^ (x_2 * 42#32 ^^^ x * 42#32) =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_0110_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ||| x_2 * 42#32 ^^^ (x * 42#32 ^^^ x_1 * 42#32) =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_0111_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ||| x_1 * 42#32 ^^^ (x * 42#32 ^^^ x_2 * 42#32) =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_1000_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ^^^ x * 42#32 ||| x * 42#32 ^^^ x_2 * 42#32 =
    x * 42#32 ^^^ x_2 * 42#32 ||| x_1 * 42#32 := sorry

theorem or_xor_tree_1001_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ^^^ x * 42#32 ||| x_2 * 42#32 ^^^ x * 42#32 =
    x_2 * 42#32 ^^^ x * 42#32 ||| x_1 * 42#32 := sorry

theorem or_xor_tree_1010_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ^^^ x * 42#32 ||| x * 42#32 ^^^ x_1 * 42#32 =
    x * 42#32 ^^^ x_1 * 42#32 ||| x_2 * 42#32 := sorry

theorem or_xor_tree_1011_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ x_1 * 42#32 ^^^ x * 42#32 ||| x_1 * 42#32 ^^^ x * 42#32 =
    x_1 * 42#32 ^^^ x * 42#32 ||| x_2 * 42#32 := sorry

theorem or_xor_tree_1100_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ (x_1 * 42#32 ^^^ x * 42#32) ||| x_2 * 42#32 ^^^ x_1 * 42#32 =
    x_2 * 42#32 ^^^ x_1 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_1101_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ (x_1 * 42#32 ^^^ x * 42#32) ||| x_1 * 42#32 ^^^ x_2 * 42#32 =
    x_1 * 42#32 ^^^ x_2 * 42#32 ||| x * 42#32 := sorry

theorem or_xor_tree_1110_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ (x_1 * 42#32 ^^^ x * 42#32) ||| x_2 * 42#32 ^^^ x * 42#32 =
    x_2 * 42#32 ^^^ x * 42#32 ||| x_1 * 42#32 := sorry

theorem or_xor_tree_1111_thm (x x_1 x_2 : BitVec 32) :
  x_2 * 42#32 ^^^ (x_1 * 42#32 ^^^ x * 42#32) ||| x * 42#32 ^^^ x_2 * 42#32 =
    x * 42#32 ^^^ x_2 * 42#32 ||| x_1 * 42#32 := sorry

