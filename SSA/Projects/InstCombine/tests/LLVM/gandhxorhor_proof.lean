import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem and_xor_not_common_op_thm (x x_1 : _root_.BitVec 32) : 
    (x_1 ^^^ (x ^^^ 4294967295#32)) &&& x_1 = x_1 &&& x := by
  sorry

theorem and_not_xor_common_op_thm (x x_1 : _root_.BitVec 32) : 
    (x_1 ^^^ x ^^^ 4294967295#32) &&& x = x &&& x_1 := by
  sorry

theorem and_shl_thm (x x_1 x_2 x_3 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x_2.toNat then none else some (x_3 <<< x_2)) fun a =>
      Option.bind (if 8 ≤ x_2.toNat then none else some (x_1 <<< x_2)) fun a_1 => some (a &&& (a_1 &&& x))) ⊑
    Option.bind (if 8 ≤ x_2.toNat then none else some ((x_1 &&& x_3) <<< x_2)) fun a => some (a &&& x) := by
  sorry

theorem or_shl_thm (x x_1 x_2 x_3 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x_2.toNat then none else some (x_3 <<< x_2)) fun a =>
      Option.bind (if 8 ≤ x_2.toNat then none else some (x <<< x_2)) fun a_1 => some (a ||| x_1 ||| a_1)) ⊑
    Option.bind (if 8 ≤ x_2.toNat then none else some ((x_3 ||| x) <<< x_2)) fun a => some (a ||| x_1) := by
  sorry

theorem or_lshr_thm (x x_1 x_2 x_3 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x_2.toNat then none else some (x_3 >>> x_2)) fun a =>
      Option.bind (if 8 ≤ x_2.toNat then none else some (x_1 >>> x_2)) fun a_1 => some (a ||| (a_1 ||| x))) ⊑
    Option.bind (if 8 ≤ x_2.toNat then none else some ((x_1 ||| x_3) >>> x_2)) fun a => some (a ||| x) := by
  sorry

theorem xor_lshr_thm (x x_1 x_2 x_3 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x_2.toNat then none else some (x_3 >>> x_2)) fun a =>
      Option.bind (if 8 ≤ x_2.toNat then none else some (x >>> x_2)) fun a_1 => some (a ^^^ x_1 ^^^ a_1)) ⊑
    Option.bind (if 8 ≤ x_2.toNat then none else some ((x_3 ^^^ x) >>> x_2)) fun a => some (a ^^^ x_1) := by
  sorry

theorem not_and_and_not_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some (a &&& (x_1 ^^^ 4294967295#32) &&& (x ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some (a &&& ((x_1 ||| x) ^^^ 4294967295#32)) := by
  sorry

theorem not_and_and_not_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& (x ^^^ 4294967295#32) = ((x_2 ||| x) ^^^ 4294967295#32) &&& x_1 := by
  sorry

theorem not_or_or_not_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some (a ||| x_1 ^^^ 4294967295#32 ||| x ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some (a ||| x_1 &&& x ^^^ 4294967295#32) := by
  sorry

theorem not_or_or_not_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 ^^^ 4294967295#32 ||| x_1 ||| x ^^^ 4294967295#32 = x_2 &&& x ^^^ 4294967295#32 ||| x_1 := by
  sorry

theorem or_not_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| ((x_2 ||| x) ^^^ 4294967295#32) &&& x_1 =
    (x_1 ^^^ x) &&& (x_2 ^^^ 4294967295#32) := by
  sorry

theorem or_not_and_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 => some (((x_2 ||| a) ^^^ 4294967295#32) &&& x ||| a_1 &&& ((x_2 ||| x) ^^^ 4294967295#32))) ⊑
    Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
      fun a => some ((a ^^^ x) &&& (x_2 ^^^ 4294967295#32)) := by
  sorry

theorem or_not_and_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& ((x_1 ||| x) ^^^ 4294967295#32) ||| ((x_1 ||| a_1) ^^^ 4294967295#32) &&& x)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ^^^ x) &&& (x_1 ^^^ 4294967295#32)) := by
  sorry

theorem or_not_and_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| ((x ||| x_1) ^^^ 4294967295#32) &&& x_2 =
    (x_2 ^^^ x) &&& (x_1 ^^^ 4294967295#32) := by
  sorry

theorem or_not_and_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& ((x_1 ||| x) ^^^ 4294967295#32) ||| ((x_1 ||| a_1) ^^^ 4294967295#32) &&& x)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ^^^ x) &&& (x_1 ^^^ 4294967295#32)) := by
  sorry

theorem or_not_and_commute5_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 =>
        Option.bind
          (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
          fun a_2 =>
          Option.bind
            (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
            fun a_3 => some (a &&& ((a_1 ||| x) ^^^ 4294967295#32) ||| ((a_2 ||| a_3) ^^^ 4294967295#32) &&& x)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 => some ((a ^^^ x) &&& (a_1 ^^^ 4294967295#32)) := by
  sorry

theorem or_not_and_commute6_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| ((x ||| x_2) ^^^ 4294967295#32) &&& x_1 =
    (x_1 ^^^ x) &&& (x_2 ^^^ 4294967295#32) := by
  sorry

theorem or_not_and_commute7_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| ((x_1 ||| x) ^^^ 4294967295#32) &&& x_2 =
    (x_2 ^^^ x) &&& (x_1 ^^^ 4294967295#32) := by
  sorry

theorem or_not_and_commute8_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 =>
        Option.bind
          (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
          fun a_2 =>
          Option.bind
            (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
            fun a_3 => some (((a ||| a_1) ^^^ 4294967295#32) &&& x ||| a_2 &&& ((x ||| a_3) ^^^ 4294967295#32))) ⊑
    Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ^^^ x) &&& (a_1 ^^^ 4294967295#32)) := by
  sorry

theorem or_not_and_commute9_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 =>
        Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
          fun a_2 =>
          Option.bind
            (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
            fun a_3 =>
            Option.bind
              (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
              fun a_4 =>
              Option.bind
                (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
                fun a_5 =>
                some (((a ||| a_1) ^^^ 4294967295#32) &&& a_2 ||| a_3 &&& ((a_4 ||| a_5) ^^^ 4294967295#32))) ⊑
    Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
      fun a =>
      Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
        fun a_1 =>
        Option.bind
          (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
          fun a_2 => some ((a ^^^ a_1) &&& (a_2 ^^^ 4294967295#32)) := by
  sorry

theorem and_not_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x_2 &&& x ^^^ 4294967295#32 ||| x_1) =
    (x_1 ^^^ x) &&& x_2 ^^^ 4294967295#32 := by
  sorry

theorem and_not_or_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 => some ((x_2 &&& a ^^^ 4294967295#32 ||| x) &&& (a_1 ||| x_2 &&& x ^^^ 4294967295#32))) ⊑
    Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
      fun a => some ((a ^^^ x) &&& x_2 ^^^ 4294967295#32) := by
  sorry

theorem and_not_or_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| x_1 &&& x ^^^ 4294967295#32) &&& (x_1 &&& a_1 ^^^ 4294967295#32 ||| x))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ^^^ x) &&& x_1 ^^^ 4294967295#32) := by
  sorry

theorem and_not_or_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x &&& x_1 ^^^ 4294967295#32 ||| x_2) =
    (x_2 ^^^ x) &&& x_1 ^^^ 4294967295#32 := by
  sorry

theorem and_not_or_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| x_1 &&& x ^^^ 4294967295#32) &&& (x_1 &&& a_1 ^^^ 4294967295#32 ||| x))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ^^^ x) &&& x_1 ^^^ 4294967295#32) := by
  sorry

theorem and_not_or_commute5_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 =>
        Option.bind
          (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
          fun a_2 =>
          Option.bind
            (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
            fun a_3 => some ((a ||| a_1 &&& x ^^^ 4294967295#32) &&& (a_2 &&& a_3 ^^^ 4294967295#32 ||| x))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 => some ((a ^^^ x) &&& a_1 ^^^ 4294967295#32) := by
  sorry

theorem and_not_or_commute6_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x &&& x_2 ^^^ 4294967295#32 ||| x_1) =
    (x_1 ^^^ x) &&& x_2 ^^^ 4294967295#32 := by
  sorry

theorem and_not_or_commute7_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x_1 &&& x ^^^ 4294967295#32 ||| x_2) =
    (x_2 ^^^ x) &&& x_1 ^^^ 4294967295#32 := by
  sorry

theorem and_not_or_commute8_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 =>
        Option.bind
          (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
          fun a_2 =>
          Option.bind
            (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
            fun a_3 => some ((a &&& a_1 ^^^ 4294967295#32 ||| x) &&& (a_2 ||| x &&& a_3 ^^^ 4294967295#32))) ⊑
    Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ^^^ x) &&& a_1 ^^^ 4294967295#32) := by
  sorry

theorem and_not_or_commute9_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
        fun a_1 =>
        Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
          fun a_2 =>
          Option.bind
            (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
            fun a_3 =>
            Option.bind
              (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
              fun a_4 =>
              Option.bind
                (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
                fun a_5 => some ((a &&& a_1 ^^^ 4294967295#32 ||| a_2) &&& (a_3 ||| a_4 &&& a_5 ^^^ 4294967295#32))) ⊑
    Option.bind (if x_1 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_1 = 4294967295#32 then none else some ((42#32).sdiv x_1))
      fun a =>
      Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
        fun a_1 =>
        Option.bind
          (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
          fun a_2 => some ((a ^^^ a_1) &&& a_2 ^^^ 4294967295#32) := by
  sorry

theorem or_and_not_not_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| (x ||| x_2) ^^^ 4294967295#32 =
    (x_1 &&& x ||| x_2) ^^^ 4294967295#32 := by
  sorry

theorem or_and_not_not_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& ((x_1 ||| x) ^^^ 4294967295#32) ||| (a_1 ||| x_1) ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a &&& x ||| x_1) ^^^ 4294967295#32) := by
  sorry

theorem or_and_not_not_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| (x ||| x_2) ^^^ 4294967295#32 =
    (x_1 &&& x ||| x_2) ^^^ 4294967295#32 := by
  sorry

theorem or_and_not_not_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| (x ||| x_1) ^^^ 4294967295#32 =
    (x_2 &&& x ||| x_1) ^^^ 4294967295#32 := by
  sorry

theorem or_and_not_not_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| (x_2 ||| x) ^^^ 4294967295#32 =
    (x_1 &&& x ||| x_2) ^^^ 4294967295#32 := by
  sorry

theorem or_and_not_not_commute5_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ||| x_1) ^^^ 4294967295#32 ||| ((x_1 ||| x) ^^^ 4294967295#32) &&& x_2 =
    (x &&& x_2 ||| x_1) ^^^ 4294967295#32 := by
  sorry

theorem or_and_not_not_commute6_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& ((x_1 ||| x) ^^^ 4294967295#32) ||| (a_1 ||| x) ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a &&& x_1 ||| x) ^^^ 4294967295#32) := by
  sorry

theorem or_and_not_not_commute7_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| (x_1 ||| x) ^^^ 4294967295#32 =
    (x_2 &&& x ||| x_1) ^^^ 4294967295#32 := by
  sorry

theorem and_or_not_not_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x &&& x_2 ^^^ 4294967295#32) =
    (x_1 ||| x) &&& x_2 ^^^ 4294967295#32 := by
  sorry

theorem and_or_not_not_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| x_1 &&& x ^^^ 4294967295#32) &&& (a_1 &&& x_1 ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ||| x) &&& x_1 ^^^ 4294967295#32) := by
  sorry

theorem and_or_not_not_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x &&& x_2 ^^^ 4294967295#32) =
    (x_1 ||| x) &&& x_2 ^^^ 4294967295#32 := by
  sorry

theorem and_or_not_not_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x &&& x_1 ^^^ 4294967295#32) =
    (x_2 ||| x) &&& x_1 ^^^ 4294967295#32 := by
  sorry

theorem and_or_not_not_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x_2 &&& x ^^^ 4294967295#32) =
    (x_1 ||| x) &&& x_2 ^^^ 4294967295#32 := by
  sorry

theorem and_or_not_not_commute5_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32) &&& (x_1 &&& x ^^^ 4294967295#32 ||| x_2) =
    (x ||| x_2) &&& x_1 ^^^ 4294967295#32 := by
  sorry

theorem and_or_not_not_commute6_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| x_1 &&& x ^^^ 4294967295#32) &&& (a_1 &&& x ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ||| x_1) &&& x ^^^ 4294967295#32) := by
  sorry

theorem and_or_not_not_commute7_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& (x_1 &&& x ^^^ 4294967295#32) =
    (x_2 ||| x) &&& x_1 ^^^ 4294967295#32 := by
  sorry

theorem and_or_not_not_wrong_a_thm (x x_1 x_2 x_3 : _root_.BitVec 32) :
  (x_3 &&& x_2 ^^^ 4294967295#32 ||| x_1) &&& (x_1 &&& x ^^^ 4294967295#32) =
    x_1 &&& x ^^^ (x_3 &&& x_2 ^^^ 4294967295#32 ||| x_1) := by
  sorry

theorem and_not_or_or_not_or_xor_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| (x_2 ^^^ x_1 ||| x) ^^^ 4294967295#32 =
    (x_2 ||| x_1) &&& (x_2 ^^^ x_1 ||| x) ^^^ 4294967295#32 := by
  sorry

theorem and_not_or_or_not_or_xor_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| (x_1 ^^^ x_2 ||| x) ^^^ 4294967295#32 =
    (x_2 ||| x_1) &&& (x_1 ^^^ x_2 ||| x) ^^^ 4294967295#32 := by
  sorry

theorem and_not_or_or_not_or_xor_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& ((x_1 ||| x) ^^^ 4294967295#32) ||| (x_1 ^^^ x ||| a_1) ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((x_1 ||| x) &&& (x_1 ^^^ x ||| a) ^^^ 4294967295#32) := by
  sorry

theorem and_not_or_or_not_or_xor_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x ||| (x_1 ^^^ x_2 ||| x) ^^^ 4294967295#32 =
    (x_2 ||| x_1) &&& (x_1 ^^^ x_2 ||| x) ^^^ 4294967295#32 := by
  sorry

theorem and_not_or_or_not_or_xor_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& ((x_1 ||| x) ^^^ 4294967295#32) ||| (a_1 ||| x_1 ^^^ x) ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((x_1 ||| x) &&& (a ||| x_1 ^^^ x) ^^^ 4294967295#32) := by
  sorry

theorem and_not_or_or_not_or_xor_commute5_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ x_1 ||| x) ^^^ 4294967295#32 ||| ((x_2 ||| x_1) ^^^ 4294967295#32) &&& x =
    (x_2 ||| x_1) &&& (x_2 ^^^ x_1 ||| x) ^^^ 4294967295#32 := by
  sorry

theorem or_not_and_and_not_and_xor_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& ((x_2 ^^^ x_1) &&& x ^^^ 4294967295#32) =
    (x_2 ^^^ x_1) &&& x ^^^ (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) := by
  sorry

theorem or_not_and_and_not_and_xor_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& ((x_1 ^^^ x_2) &&& x ^^^ 4294967295#32) =
    (x_1 ^^^ x_2) &&& x ^^^ (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) := by
  sorry

theorem or_not_and_and_not_and_xor_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| x_1 &&& x ^^^ 4294967295#32) &&& ((x_1 ^^^ x) &&& a_1 ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((x_1 ^^^ x) &&& a ^^^ (a_1 ||| x_1 &&& x ^^^ 4294967295#32)) := by
  sorry

theorem or_not_and_and_not_and_xor_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) &&& ((x_1 ^^^ x_2) &&& x ^^^ 4294967295#32) =
    (x_1 ^^^ x_2) &&& x ^^^ (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) := by
  sorry

theorem or_not_and_and_not_and_xor_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| x_1 &&& x ^^^ 4294967295#32) &&& (a_1 &&& (x_1 ^^^ x) ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& (x_1 ^^^ x) ^^^ (a_1 ||| x_1 &&& x ^^^ 4294967295#32)) := by
  sorry

theorem or_not_and_and_not_and_xor_commute5_thm (x x_1 x_2 : _root_.BitVec 32) :
  ((x_2 ^^^ x_1) &&& x ^^^ 4294967295#32) &&& (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) =
    (x_2 ^^^ x_1) &&& x ^^^ (x_2 &&& x_1 ^^^ 4294967295#32 ||| x) := by
  sorry

theorem not_and_and_or_not_or_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& x ||| (x_1 ||| x_2 ||| x) ^^^ 4294967295#32 =
    (x ^^^ x_1 ||| x_2) ^^^ 4294967295#32 := by
  sorry

theorem not_and_and_or_not_or_or_commute1_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& x ||| (x ||| x_2 ||| x_1) ^^^ 4294967295#32 =
    (x ^^^ x_1 ||| x_2) ^^^ 4294967295#32 := by
  sorry

theorem not_and_and_or_not_or_or_commute2_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& x ||| (x_1 ||| x ||| x_2) ^^^ 4294967295#32 =
    (x ^^^ x_1 ||| x_2) ^^^ 4294967295#32 := by
  sorry

theorem not_and_and_or_not_or_or_commute1_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& x ||| (x ||| x_2 ||| x_1) ^^^ 4294967295#32 =
    (x ^^^ x_1 ||| x_2) ^^^ 4294967295#32 := by
  sorry

theorem not_and_and_or_not_or_or_commute2_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 &&& x_1 &&& (x ^^^ 4294967295#32) ||| (x_2 ||| x ||| x_1) ^^^ 4294967295#32 =
    (x_2 ^^^ x_1 ||| x) ^^^ 4294967295#32 := by
  sorry

theorem not_and_and_or_not_or_or_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& x ||| (x_2 ||| x_1 ||| x) ^^^ 4294967295#32 =
    (x ^^^ x_1 ||| x_2) ^^^ 4294967295#32 := by
  sorry

theorem not_and_and_or_not_or_or_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a =>
      Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
        fun a_1 => some ((x_2 ^^^ 4294967295#32) &&& x_1 &&& a ||| (a_1 ||| (x_1 ||| x_2)) ^^^ 4294967295#32)) ⊑
    Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a =>
      some ((a ^^^ x_1 ||| x_2) ^^^ 4294967295#32) := by
  sorry

theorem not_and_and_or_not_or_or_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& (x_1 ^^^ 4294967295#32) &&& x ||| (a_1 ||| x_1 ||| x) ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ^^^ x ||| x_1) ^^^ 4294967295#32) := by
  sorry

theorem not_and_and_or_not_or_or_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& ((x_1 ^^^ 4294967295#32) &&& x) ||| (x ||| x_1 ||| a_1) ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ^^^ x ||| x_1) ^^^ 4294967295#32) := by
  sorry

theorem not_or_or_and_not_and_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1 ||| x) &&& (x_1 &&& x_2 &&& x ^^^ 4294967295#32) =
    x ^^^ x_1 ||| x_2 ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_not_and_and_commute1_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1 ||| x) &&& (x &&& x_2 &&& x_1 ^^^ 4294967295#32) =
    x ^^^ x_1 ||| x_2 ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_not_and_and_commute2_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1 ||| x) &&& (x_1 &&& x &&& x_2 ^^^ 4294967295#32) =
    x ^^^ x_1 ||| x_2 ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_not_and_and_commute1_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1 ||| x) &&& (x &&& x_2 &&& x_1 ^^^ 4294967295#32) =
    x ^^^ x_1 ||| x_2 ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_not_and_and_commute2_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ||| x_1 ||| x ^^^ 4294967295#32) &&& (x_2 &&& x &&& x_1 ^^^ 4294967295#32) =
    x_2 ^^^ x_1 ||| x ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_not_and_and_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1 ||| x) &&& (x_2 &&& x_1 &&& x ^^^ 4294967295#32) =
    x ^^^ x_1 ||| x_2 ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_not_and_and_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a =>
      Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x))
        fun a_1 => some ((x_2 ^^^ 4294967295#32 ||| x_1 ||| a) &&& (a_1 &&& (x_1 &&& x_2) ^^^ 4294967295#32))) ⊑
    Option.bind (if x = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x = 4294967295#32 then none else some ((42#32).sdiv x)) fun a =>
      some (a ^^^ x_1 ||| x_2 ^^^ 4294967295#32) := by
  sorry

theorem not_or_or_and_not_and_and_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| x_1 ^^^ 4294967295#32 ||| x) &&& (a_1 &&& x_1 &&& x ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some (a ^^^ x ||| x_1 ^^^ 4294967295#32) := by
  sorry

theorem not_or_or_and_not_and_and_commute4_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| (x_1 ^^^ 4294967295#32 ||| x)) &&& (x &&& x_1 &&& a_1 ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some (a ^^^ x ||| x_1 ^^^ 4294967295#32) := by
  sorry

theorem not_and_and_or_no_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& x ||| (x_1 ||| x_2) ^^^ 4294967295#32 =
    (x_1 ^^^ 4294967295#32 ||| x) &&& (x_2 ^^^ 4294967295#32) := by
  sorry

theorem not_and_and_or_no_or_commute1_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  x_2 &&& x_1 &&& (x ^^^ 4294967295#32) ||| (x_1 ||| x) ^^^ 4294967295#32 =
    (x_1 ^^^ 4294967295#32 ||| x_2) &&& (x ^^^ 4294967295#32) := by
  sorry

theorem not_and_and_or_no_or_commute2_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& x ||| (x ||| x_2) ^^^ 4294967295#32 =
    (x ^^^ 4294967295#32 ||| x_1) &&& (x_2 ^^^ 4294967295#32) := by
  sorry

theorem not_and_and_or_no_or_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32) &&& x_1 &&& x ||| (x_2 ||| x_1) ^^^ 4294967295#32 =
    (x_1 ^^^ 4294967295#32 ||| x) &&& (x_2 ^^^ 4294967295#32) := by
  sorry

theorem not_and_and_or_no_or_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some (a &&& (x_1 ^^^ 4294967295#32) &&& x ||| (a_1 ||| x_1) ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ^^^ 4294967295#32 ||| x) &&& (x_1 ^^^ 4294967295#32)) := by
  sorry

theorem not_and_and_or_no_or_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some (a &&& ((x_1 ^^^ 4294967295#32) &&& x) ||| (x ||| x_1) ^^^ 4294967295#32)) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ||| x ^^^ 4294967295#32) &&& (x_1 ^^^ 4294967295#32)) := by
  sorry

theorem not_or_or_and_no_and_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1 ||| x) &&& (x_1 &&& x_2 ^^^ 4294967295#32) =
    (x_1 ^^^ 4294967295#32) &&& x ||| x_2 ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_no_and_commute1_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ||| x_1 ||| x ^^^ 4294967295#32) &&& (x_1 &&& x ^^^ 4294967295#32) =
    (x_1 ^^^ 4294967295#32) &&& x_2 ||| x ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_no_and_commute2_or_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1 ||| x) &&& (x &&& x_2 ^^^ 4294967295#32) =
    (x ^^^ 4294967295#32) &&& x_1 ||| x_2 ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_no_and_commute1_thm (x x_1 x_2 : _root_.BitVec 32) :
  (x_2 ^^^ 4294967295#32 ||| x_1 ||| x) &&& (x_2 &&& x_1 ^^^ 4294967295#32) =
    (x_1 ^^^ 4294967295#32) &&& x ||| x_2 ^^^ 4294967295#32 := by
  sorry

theorem not_or_or_and_no_and_commute2_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a =>
      Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
        fun a_1 => some ((a ||| x_1 ^^^ 4294967295#32 ||| x) &&& (a_1 &&& x_1 ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ^^^ 4294967295#32) &&& x ||| x_1 ^^^ 4294967295#32) := by
  sorry

theorem not_or_or_and_no_and_commute3_thm (x x_1 x_2 : _root_.BitVec 32) :
  (Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some ((a ||| (x_1 ^^^ 4294967295#32 ||| x)) &&& (x &&& x_1 ^^^ 4294967295#32))) ⊑
    Option.bind (if x_2 = 0#32 ∨ 42#32 = LLVM.intMin 32 ∧ x_2 = 4294967295#32 then none else some ((42#32).sdiv x_2))
      fun a => some (a &&& (x ^^^ 4294967295#32) ||| x_1 ^^^ 4294967295#32) := by
  sorry

theorem and_orn_xor_thm (x x_1 : _root_.BitVec 4) : 
    (x_1 ^^^ 15#4 ||| x) &&& (x_1 ^^^ x) = (x_1 ^^^ 15#4) &&& x := by
  sorry

theorem and_orn_xor_commute8_thm (x x_1 : _root_.BitVec 32) :
  (x_1 ^ 2 ^^^ x ^ 2) &&& (x_1 ^ 2 ||| x ^ 2 ^^^ 4294967295#32) = x_1 ^ 2 &&& (x ^ 2 ^^^ 4294967295#32) := by
  sorry

theorem canonicalize_logic_first_or0_thm (x : _root_.BitVec 32) : 
    x + 112#32 ||| 15#32 = 112#32 + (x ||| 15#32) := by
  sorry

theorem canonicalize_logic_first_or0_nsw_thm (x : _root_.BitVec 32) : 
    x + 112#32 ||| 15#32 = 112#32 + (x ||| 15#32) := by
  sorry

theorem canonicalize_logic_first_or0_nswnuw_thm (x : _root_.BitVec 32) : 
    x + 112#32 ||| 15#32 = 112#32 + (x ||| 15#32) := by
  sorry

theorem canonicalize_logic_first_and0_thm (x : _root_.BitVec 8) : 
    x + 48#8 &&& 246#8 = 48#8 + (x &&& 246#8) := by
  sorry

theorem canonicalize_logic_first_and0_nsw_thm (x : _root_.BitVec 8) : 
    x + 48#8 &&& 246#8 = 48#8 + (x &&& 246#8) := by
  sorry

theorem canonicalize_logic_first_and0_nswnuw_thm (x : _root_.BitVec 8) : 
    x + 48#8 &&& 246#8 = 48#8 + (x &&& 246#8) := by
  sorry

theorem canonicalize_logic_first_xor_0_thm (x : _root_.BitVec 8) : 
    x + 96#8 ^^^ 31#8 = 96#8 + (x ^^^ 31#8) := by
  sorry

theorem canonicalize_logic_first_xor_0_nsw_thm (x : _root_.BitVec 8) : 
    x + 96#8 ^^^ 31#8 = 96#8 + (x ^^^ 31#8) := by
  sorry

theorem canonicalize_logic_first_xor_0_nswnuw_thm (x : _root_.BitVec 8) : 
    x + 96#8 ^^^ 31#8 = 96#8 + (x ^^^ 31#8) := by
  sorry

