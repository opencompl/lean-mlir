import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



theorem test0_thm (x x_1 x_2 : _root_.BitVec 41) :
  (Option.bind (if 41 ≤ x_1.toNat then none else some (x_2 <<< x_1)) fun a =>
      Option.bind (if 41 ≤ x_1.toNat then none else some (x <<< x_1)) fun a_1 => some (a &&& a_1)) ⊑
    if 41 ≤ x_1.toNat then none else some ((x_2 &&& x) <<< x_1) := by
  sorry

theorem test1_thm (x x_1 x_2 : _root_.BitVec 57) :
  (Option.bind (if 57 ≤ x_1.toNat then none else some (x_2 >>> x_1)) fun a =>
      Option.bind (if 57 ≤ x_1.toNat then none else some (x >>> x_1)) fun a_1 => some (a ||| a_1)) ⊑
    if 57 ≤ x_1.toNat then none else some ((x_2 ||| x) >>> x_1) := by
  sorry

theorem test2_thm (x x_1 x_2 : _root_.BitVec 49) :
  (Option.bind (if 49 ≤ x_1.toNat then none else some (x_2.sshiftRight x_1.toNat)) fun a =>
      Option.bind (if 49 ≤ x_1.toNat then none else some (x.sshiftRight x_1.toNat)) fun a_1 => some (a ^^^ a_1)) ⊑
    if 49 ≤ x_1.toNat then none else some ((x_2 ^^^ x).sshiftRight x_1.toNat) := by
  sorry

