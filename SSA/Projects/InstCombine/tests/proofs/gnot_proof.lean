
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gnot_proof
theorem test1_thm (x : BitVec 32) : x ^^^ 4294967295#32 ^^^ 4294967295#32 = x := sorry

theorem not_ashr_not_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some ((x_1 ^^^ 4294967295#32).sshiftRight x.toNat)) fun x' =>
      some (x' ^^^ 4294967295#32)) ⊑
    if 32#32 ≤ x then none else some (x_1.sshiftRight x.toNat) := sorry

theorem not_ashr_const_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some ((214#8).sshiftRight x.toNat)) fun x' => some (x' ^^^ 255#8)) ⊑
    if 8#8 ≤ x then none else some (41#8 >>> x.toNat) := sorry

theorem not_lshr_const_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (42#8 >>> x.toNat)) fun x' => some (x' ^^^ 255#8)) ⊑
    if 8#8 ≤ x then none else some ((213#8).sshiftRight x.toNat) := sorry

theorem not_sub_thm (x : BitVec 32) : 123#32 - x ^^^ 4294967295#32 = x + 4294967172#32 := sorry

theorem not_add_thm (x : BitVec 32) : x + 123#32 ^^^ 4294967295#32 = 4294967172#32 - x := sorry

theorem not_or_neg_thm (x x_1 : BitVec 8) : (-x_1 ||| x) ^^^ 255#8 = x_1 + 255#8 &&& (x ^^^ 255#8) := sorry

theorem test_invert_demorgan_and2_thm (x : BitVec 64) :
  x + 9223372036854775807#64 &&& 9223372036854775807#64 ^^^ 18446744073709551615#64 =
    -x ||| 9223372036854775808#64 := sorry

