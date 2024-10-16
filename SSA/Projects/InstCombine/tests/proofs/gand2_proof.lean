
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gand2_proof
theorem test2_thm (x x_1 : BitVec 1) : x_1 &&& x &&& x_1 = x_1 &&& x := sorry

theorem test3_thm (x x_1 : BitVec 32) : x_1 &&& (x &&& x_1) = x &&& x_1 := sorry

theorem test9_thm (x : BitVec 64) :
  ((if (-signExtend 65 x).msb = (-signExtend 65 x).getMsbD 1 then some (-x) else none).bind fun a =>
      some (a &&& 1#64)) ⊑
    some (x &&& 1#64) := sorry

theorem test10_thm (x : BitVec 64) :
  ((if (-signExtend 65 x).msb = (-signExtend 65 x).getMsbD 1 then some (-x) else none).bind fun a =>
      (if (-signExtend 65 x).msb = (-signExtend 65 x).getMsbD 1 then some (-x) else none).bind fun a_1 =>
        some (a + (a_1 &&& 1#64))) ⊑
    some (-(x &&& 18446744073709551614#64)) := sorry

theorem and1_shl1_is_cmp_eq_0_multiuse_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun a_1 => some (a + (a_1 &&& 1#8))) ⊑
    (if 1#8 <<< x.toNat >>> x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind fun a =>
      (if 1#8 <<< x.toNat >>> x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind
        fun a_1 =>
        if a + (a_1 &&& 1#8) < a ∨ a + (a_1 &&& 1#8) < a_1 &&& 1#8 then none else some (a + (a_1 &&& 1#8)) := sorry

theorem and1_lshr1_is_cmp_eq_0_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (1#8 >>> x.toNat)) fun a => some (a &&& 1#8)) ⊑
    if 8#8 ≤ x then none else some (1#8 >>> x.toNat) := sorry

theorem and1_lshr1_is_cmp_eq_0_multiuse_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (1#8 >>> x.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x then none else some (1#8 >>> x.toNat)) fun a_1 => some (a + (a_1 &&& 1#8))) ⊑
    Option.bind (if 8#8 ≤ x then none else some (1#8 >>> x.toNat)) fun a =>
      if (a <<< 1).sshiftRight 1 = a then none else if a <<< 1 >>> 1 = a then none else some (a <<< 1) := sorry

theorem test11_thm (x x_1 : BitVec 32) : (x_1 <<< 8 + x &&& 128#32) * x_1 <<< 8 = (x &&& 128#32) * x_1 <<< 8 := sorry

theorem test12_thm (x x_1 : BitVec 32) : (x_1 + x <<< 8 &&& 128#32) * x <<< 8 = (x_1 &&& 128#32) * x <<< 8 := sorry

theorem test13_thm (x x_1 : BitVec 32) : (x_1 - x <<< 8 &&& 128#32) * x <<< 8 = (x_1 &&& 128#32) * x <<< 8 := sorry

theorem test14_thm (x x_1 : BitVec 32) : (x_1 <<< 8 - x &&& 128#32) * x_1 <<< 8 = (-x &&& 128#32) * x_1 <<< 8 := sorry

