
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gadd2_proof
theorem test2_thm (x : BitVec 32) : (x &&& 7#32) + (x &&& 32#32) = x &&& 39#32 := sorry

theorem test3_thm (x : BitVec 32) : (x &&& 128#32) + x >>> 30 = x &&& 128#32 ||| x >>> 30 := sorry

theorem test4_thm (x : BitVec 32) : x + x = x <<< 1 := sorry

theorem test9_thm (x : BitVec 16) : x * 2#16 + x * 32767#16 = x * 32769#16 := sorry

theorem test10_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + ((x.sshiftRight 3 ||| 2863311530#32) ^^^ 1431655765#32) =
    x_1 - (x.sshiftRight 3 &&& 1431655765#32) := sorry

theorem test11_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + ((x ||| 2863311530#32) ^^^ 1431655765#32) = x_1 - (x &&& 1431655765#32) := sorry

theorem test12_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + ((x ||| 2863311530#32) ^^^ 1431655765#32) = x_1 - (x &&& 1431655765#32) := sorry

theorem test13_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + ((x ||| 2863311529#32) ^^^ 1431655766#32) = x_1 - (x &&& 1431655766#32) := sorry

theorem test14_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + ((x ||| 2863311529#32) ^^^ 1431655766#32) = x_1 - (x &&& 1431655766#32) := sorry

theorem test15_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + (x &&& 2863311529#32 ^^^ 2863311529#32) = x_1 - (x ||| 1431655766#32) := sorry

theorem test16_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + (x &&& 2863311529#32 ^^^ 2863311529#32) = x_1 - (x ||| 1431655766#32) := sorry

theorem test17_thm (x x_1 : BitVec 32) :
  (x_1 &&& 2863311530#32 ^^^ 2863311531#32) + x = x - (x_1 ||| 1431655765#32) := sorry

theorem test18_thm (x x_1 : BitVec 32) :
  x_1 + 1#32 + (x &&& 2863311530#32 ^^^ 2863311530#32) = x_1 - (x ||| 1431655765#32) := sorry

theorem add_nsw_mul_nsw_thm (x : BitVec 16) : x + x + x = x * 3#16 := sorry

theorem mul_add_to_mul_1_thm (x : BitVec 16) : x + x * 8#16 = x * 9#16 := sorry

theorem mul_add_to_mul_2_thm (x : BitVec 16) : x * 8#16 + x = x * 9#16 := sorry

theorem mul_add_to_mul_3_thm (x : BitVec 16) : x * 2#16 + x * 3#16 = x * 5#16 := sorry

theorem mul_add_to_mul_4_thm (x : BitVec 16) : x * 2#16 + x * 7#16 = x * 9#16 := sorry

theorem mul_add_to_mul_5_thm (x : BitVec 16) : x * 3#16 + x * 7#16 = x * 10#16 := sorry

theorem mul_add_to_mul_6_thm (x x_1 : BitVec 32) : x_1 * x + x_1 * x * 5#32 = x_1 * x * 6#32 := sorry

theorem mul_add_to_mul_7_thm (x : BitVec 16) : x + x * 32767#16 = x <<< 15 := sorry

theorem mul_add_to_mul_8_thm (x : BitVec 16) : x * 16383#16 + x * 16384#16 = x * 32767#16 := sorry

theorem mul_add_to_mul_9_thm (x : BitVec 16) : x * 16384#16 + x * 16384#16 = x <<< 15 := sorry

