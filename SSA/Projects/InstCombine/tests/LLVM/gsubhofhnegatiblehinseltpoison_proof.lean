
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhofhnegatiblehinseltpoison_proof
theorem t0_thm (x : BitVec 8) : x - 214#8 = x + 42#8 := sorry

theorem t2_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (214#8 <<< x.toNat)) fun a => some (x_1 - a)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (42#8 <<< x.toNat)) fun a => some (a + x_1) := sorry

theorem neg_of_sub_from_constant_thm (x : BitVec 8) : x - 42#8 = x + 214#8 := sorry

theorem sub_from_constant_of_sub_from_constant_thm (x : BitVec 8) : 11#8 - (42#8 - x) = x + 225#8 := sorry

theorem sub_from_variable_of_sub_from_constant_thm (x x_1 : BitVec 8) : x_1 - (42#8 - x) = x + 214#8 + x_1 := sorry

theorem neg_of_add_with_constant_thm (x : BitVec 8) : 214#8 + -x = 214#8 - x := sorry

theorem sub_from_constant_of_add_with_constant_thm (x : BitVec 8) : 11#8 - (x + 42#8) = 225#8 - x := sorry

theorem negate_xor_thm (x : BitVec 4) : -(x ^^^ 5#4) = (x ^^^ 10#4) + 1#4 := sorry

theorem negate_shl_xor_thm (x x_1 : BitVec 4) :
  (Option.bind (if 4#4 ≤ x then none else some ((x_1 ^^^ 5#4) <<< x.toNat)) fun a => some (-a)) ⊑
    if 4#4 ≤ x then none else some ((x_1 ^^^ 10#4) <<< x.toNat + 1#4 <<< x.toNat) := sorry

theorem negate_sdiv_thm (x x_1 : BitVec 8) : x_1 - x.sdiv 42#8 = x.sdiv 214#8 + x_1 := sorry

theorem negate_ashr_thm (x x_1 : BitVec 8) : x_1 - x.sshiftRight 7 = x >>> 7 + x_1 := sorry

theorem negate_lshr_thm (x x_1 : BitVec 8) : x_1 - x >>> 7 = x.sshiftRight 7 + x_1 := sorry

theorem negation_of_increment_via_or_with_no_common_bits_set_thm (x x_1 : BitVec 8) : x_1 - (x <<< 1 ||| 1#8) = x_1 + (x <<< 1 ^^^ 255#8) := sorry

theorem negate_add_with_single_negatible_operand_thm (x : BitVec 8) : 214#8 + -x = 214#8 - x := sorry

theorem negate_add_with_single_negatible_operand_depth2_thm (x x_1 : BitVec 8) : -((x_1 + 21#8) * x) = (235#8 - x_1) * x := sorry

