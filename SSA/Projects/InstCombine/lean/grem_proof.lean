
import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem test1_thm (x : _root_.BitVec 32) : x + x.sdiv 1#32 * 4294967295#32 = 0#32 := sorry

theorem test3_thm (x : _root_.BitVec 32) : BitVec.ofNat 32 (x.toNat % 8) = x &&& 7#32 := sorry

theorem test7_thm (x : _root_.BitVec 32) : x * 8#32 + (x * 8#32).sdiv 4#32 * 4294967292#32 = 0#32 := sorry

theorem test8_thm (x : _root_.BitVec 32) : x <<< 4 + (x <<< 4).sdiv 8#32 * 4294967288#32 = 0#32 := sorry

theorem test9_thm (x : _root_.BitVec 32) : BitVec.ofNat 32 (x.toNat * 64 % 4294967296 % 32) = 0#32 := sorry

theorem test11_thm (x : _root_.BitVec 32) :
  BitVec.ofNat 32 ((x.toNat &&& 4294967294) * 2 % 4294967296 % 4) = 0#32 := sorry

theorem test12_thm (x : _root_.BitVec 32) :
  (x &&& 4294967292#32) + (x &&& 4294967292#32).sdiv 2#32 * 4294967294#32 = 0#32 := sorry

theorem test13_thm (x : _root_.BitVec 32) :
  Option.map (fun div => x + x * div * 4294967295#32)
      (if x = 0#32 ∨ x = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some (x.sdiv x)) ⊑
    some 0#32 := sorry

theorem test16_thm (x x_1 : _root_.BitVec 32) :
  (if (4 + (x.toNat >>> 11 &&& 4)) % 4294967296 = 0 then none
    else some (BitVec.ofNat 32 (x_1.toNat % ((4 + (x.toNat >>> 11 &&& 4)) % 4294967296)))) ⊑
    some ((x >>> 11 &&& 4#32 ||| 3#32) &&& x_1) := sorry

theorem test19_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a =>
      Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a_1 =>
        Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_2 =>
          if ((a.toNat &&& a_1.toNat) + a_2.toNat) % 4294967296 = 0 then none
          else some (BitVec.ofNat 32 (x_1.toNat % (((a.toNat &&& a_1.toNat) + a_2.toNat) % 4294967296)))) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a =>
      Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a_1 =>
        Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_2 =>
          some ((a &&& a_1) + a_2 + 4294967295#32 &&& x_1) := sorry

theorem test19_commutative0_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_1 =>
        Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_2 =>
          if ((a.toNat &&& a_1.toNat) + a_2.toNat) % 4294967296 = 0 then none
          else some (BitVec.ofNat 32 (x_1.toNat % (((a.toNat &&& a_1.toNat) + a_2.toNat) % 4294967296)))) ⊑
    Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_1 =>
        Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_2 =>
          some ((a &&& a_1) + a_2 + 4294967295#32 &&& x_1) := sorry

theorem test19_commutative1_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_1 =>
        Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a_2 =>
          if (a.toNat + (a_1.toNat &&& a_2.toNat)) % 4294967296 = 0 then none
          else some (BitVec.ofNat 32 (x_1.toNat % ((a.toNat + (a_1.toNat &&& a_2.toNat)) % 4294967296)))) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a =>
      Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_1 =>
        Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a_2 =>
          some (a + (a_1 &&& a_2) + 4294967295#32 &&& x_1) := sorry

theorem test19_commutative2_thm (x x_1 : _root_.BitVec 32) :
  (Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a =>
      Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a_1 =>
        Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_2 =>
          if (a.toNat + (a_1.toNat &&& a_2.toNat)) % 4294967296 = 0 then none
          else some (BitVec.ofNat 32 (x_1.toNat % ((a.toNat + (a_1.toNat &&& a_2.toNat)) % 4294967296)))) ⊑
    Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a =>
      Option.bind (if 32 ≤ x_1.toNat then none else some (1#32 <<< x_1)) fun a_1 =>
        Option.bind (if 32 ≤ x.toNat then none else some (1#32 <<< x)) fun a_2 =>
          some (a + (a_1 &&& a_2) + 4294967295#32 &&& x_1) := sorry

theorem test22_thm (x : _root_.BitVec 32) :
  (x &&& 2147483647#32) + (x &&& 2147483647#32).sdiv 2147483647#32 * 2147483649#32 =
    BitVec.ofNat 32 ((x.toNat &&& 2147483647) % 2147483647) := sorry

