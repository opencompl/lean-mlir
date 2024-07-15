import SSA.Projects.InstCombine.ForLean

import SSA.Projects.InstCombine.LLVM.Semantics

open LLVM



open Std (BitVec)
theorem t2_thm (x x_1 : _root_.BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (214#8 <<< x)) fun a => some (x_1 + a * 255#8)) ⊑
    Option.bind (if 8 ≤ x.toNat then none else some (42#8 <<< x)) fun a => some (a + x_1) := by
  sorry

theorem sub_from_constant_of_add_with_constant_thm (x : _root_.BitVec 8) : 
    11#8 + x * 255#8 + 214#8 = x * 255#8 + 225#8 := by
  sorry

theorem negate_xor_thm (x : _root_.BitVec 4) : 
    (x ^^^ 5#4) * 15#4 = (x ^^^ 10#4) + 1#4 := by
  sorry

theorem negate_shl_xor_thm (x x_1 : _root_.BitVec 4) :
  (Option.bind (if 4 ≤ x.toNat then none else some ((x_1 ^^^ 5#4) <<< x)) fun a => some (a * 15#4)) ⊑
    if 4 ≤ x.toNat then none else some (((x_1 ^^^ 10#4) + 1#4) <<< x) := by
  sorry

theorem negate_sdiv_thm (x : _root_.BitVec 8) : 
    x.sdiv 42#8 * 255#8 = x.sdiv 214#8 := by
  sorry

theorem negate_ashr_thm (x : _root_.BitVec 8) : 
    x.sshiftRight 7 * 255#8 = x >>> 7 := by
  sorry

theorem negate_lshr_thm (x : _root_.BitVec 8) : 
    x >>> 7 * 255#8 = x.sshiftRight 7 := by
  sorry

theorem negation_of_increment_via_or_with_no_common_bits_set_thm (x : _root_.BitVec 8) : 
    (x <<< 1 ||| 1#8) * 255#8 = x <<< 1 ^^^ 255#8 := by
  sorry

theorem negation_of_increment_via_or_disjoint_thm (x : _root_.BitVec 8) : 
    (x ||| 1#8) * 255#8 = x ^^^ 255#8 := by
  sorry

theorem negate_add_with_single_negatible_operand_depth2_thm (x : _root_.BitVec 8) : 
    21#8 * x * 255#8 = x * 235#8 := by
  sorry

