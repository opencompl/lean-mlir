
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gorhxorhxor_proof
theorem or_xor_xor_normal_variant1_thm (x x_1 : BitVec 1) : x_1 &&& x ^^^ x_1 ||| x_1 &&& x ^^^ x = x_1 ^^^ x := sorry

theorem or_xor_xor_normal_variant2_thm (x x_1 : BitVec 8) : x_1 &&& x ^^^ x ||| x_1 ^^^ x_1 &&& x = x_1 ^^^ x := sorry

theorem or_xor_xor_normal_variant3_thm (x x_1 : BitVec 16) : x_1 ^^^ x_1 &&& x ||| x ^^^ x_1 &&& x = x_1 ^^^ x := sorry

theorem or_xor_xor_normal_variant4_thm (x x_1 : BitVec 64) : x_1 &&& x ^^^ x_1 ||| x_1 &&& x ^^^ x = x_1 ^^^ x := sorry

theorem or_xor_xor_normal_binops_thm (x x_1 x_2 : BitVec 32) :
  x_2 ^^^ x_1 ^^^ (x_2 ^^^ x_1) &&& (x ^^^ x_1) ||| x ^^^ x_1 ^^^ (x_2 ^^^ x_1) &&& (x ^^^ x_1) = x_2 ^^^ x := sorry

