import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem t0_thm (x : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (1#8 <<< x)) fun a =>
      Option.bind (if 8 ≤ x.toNat then none else some (1#8 <<< x)) fun a_1 => some (a + 255#8 ||| a_1)) ⊑
    if 8 ≤ (256 - x.toNat + 7) % 256 then none else some (255#8 >>> (7#8 - x)) := by
  sorry

theorem t1_thm (x : _root_.BitVec 16) :
  (Option.bind (if 16 ≤ x.toNat then none else some (1#16 <<< x)) fun a =>
      Option.bind (if 16 ≤ x.toNat then none else some (1#16 <<< x)) fun a_1 => some (a + 65535#16 ||| a_1)) ⊑
    if 16 ≤ (65536 - x.toNat + 15) % 65536 then none else some (65535#16 >>> (15#16 - x)) := by
  sorry

theorem t9_nocse_thm (x : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (1#8 <<< x)) fun a =>
      Option.bind (if 8 ≤ x.toNat then none else some (1#8 <<< x)) fun a_1 => some (a + 255#8 ||| a_1)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (1#8 <<< x)) fun a =>
      Option.bind (if 8 ≤ x.toNat then none else some (255#8 <<< x)) fun a_1 => some (a ||| a_1 ^^^ 255#8) := by
  sorry

theorem t17_nocse_mismatching_x_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x_1.toNat then none else some (1#8 <<< x_1)) fun a =>
      Option.bind (if 8 ≤ x.toNat then none else some (1#8 <<< x)) fun a_1 => some (a + 255#8 ||| a_1)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (1#8 <<< x)) fun a =>
      Option.bind (if 8 ≤ x_1.toNat then none else some (255#8 <<< x_1)) fun a_1 => some (a ||| a_1 ^^^ 255#8) := by
  sorry

