
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhofhnegatible_proof
theorem t0_thm (x : BitVec 8) : x - 214#8 = x + 42#8 := sorry

theorem t2_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (214#8 <<< x.toNat)) fun y' => some (x_1 - y')) ⊑
    Option.bind (if 8#8 ≤ x then none else some (42#8 <<< x.toNat)) fun a => some (a + x_1) := sorry

theorem t4_thm (x : BitVec 1) (x_1 : BitVec 8) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 214#8
      | some { toFin := ⟨0, ⋯⟩ } => some 44#8)
      fun y' => some (x_1 - y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 42#8
      | some { toFin := ⟨0, ⋯⟩ } => some 212#8)
      fun a => some (a + x_1) := sorry

theorem PR52261_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 2#32
      | some { toFin := ⟨0, ⋯⟩ } => some 4294967294#32)
      fun x' =>
      Option.bind
        (match some x with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 2#32
        | some { toFin := ⟨0, ⋯⟩ } => some 4294967294#32)
        fun a =>
        (if (-signExtend 33 a).msb = (-signExtend 33 a).getMsbD 1 then some (-a) else none).bind fun y' =>
          some (x' &&& y')) ⊑
    some 2#32 := sorry

theorem t7_thm (x : BitVec 1) (x_1 : BitVec 8) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 0#8
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun y' => some (x_1 - y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 0#8
      | some { toFin := ⟨0, ⋯⟩ } => none)
      fun a => some (a + x_1) := sorry
info: ././././SSA/Projects/InstCombine/tests/LLVM/gsubhofhnegatible.lean:181:17: theorem t7_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1) (x_2 : BitVec 8),
    (Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 0#8
        | some { toFin := ⟨0, ⋯⟩ } => if 8#8 ≤ x then none else some (1#8 <<< x.toNat))
        fun y' => some (x_2 - y')) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 0#8
        | some { toFin := ⟨0, ⋯⟩ } =>
          if (255#8 <<< x.toNat).sshiftRight x.toNat = 255#8 then none
          else if 8#8 ≤ x then none else some (255#8 <<< x.toNat))
        fun a => some (a + x_2) := sorry

theorem neg_of_sub_from_constant_thm (x : BitVec 8) : x - 42#8 = x + 214#8 := sorry

theorem sub_from_constant_of_sub_from_constant_thm (x : BitVec 8) : 11#8 - (42#8 - x) = x + 225#8 := sorry

theorem sub_from_variable_of_sub_from_constant_thm (x x_1 : BitVec 8) : x_1 - (42#8 - x) = x + 214#8 + x_1 := sorry

theorem neg_of_add_with_constant_thm (x : BitVec 8) : 214#8 + -x = 214#8 - x := sorry

theorem sub_from_constant_of_add_with_constant_thm (x : BitVec 8) : 11#8 - (x + 42#8) = 225#8 - x := sorry

theorem t20_thm (x : BitVec 16) (x_1 : BitVec 8) :
  (Option.bind (if 16#16 ≤ x then none else some (65494#16 <<< x.toNat)) fun x => some (x_1 - setWidth 8 x)) ⊑
    Option.bind (if 16#16 ≤ x then none else some (42#16 <<< x.toNat)) fun x => some (x_1 + setWidth 8 x) := sorry

theorem negate_xor_thm (x : BitVec 4) : -(x ^^^ 5#4) = (x ^^^ 10#4) + 1#4 := sorry

theorem negate_shl_xor_thm (x x_1 : BitVec 4) :
  (Option.bind (if 4#4 ≤ x then none else some ((x_1 ^^^ 5#4) <<< x.toNat)) fun a => some (-a)) ⊑
    if 4#4 ≤ x then none else some ((x_1 ^^^ 10#4) <<< x.toNat + 1#4 <<< x.toNat) := sorry

theorem negate_sdiv_thm (x x_1 : BitVec 8) : x_1 - x.sdiv 42#8 = x.sdiv 214#8 + x_1 := sorry

theorem negate_ashr_thm (x x_1 : BitVec 8) : x_1 - x.sshiftRight 7 = x >>> 7 + x_1 := sorry

theorem negate_lshr_thm (x x_1 : BitVec 8) : x_1 - x >>> 7 = x.sshiftRight 7 + x_1 := sorry

theorem negate_sext_thm (x : BitVec 1) (x_1 : BitVec 8) : x_1 - signExtend 8 x = x_1 + setWidth 8 x := sorry

theorem negate_zext_thm (x : BitVec 1) (x_1 : BitVec 8) : x_1 - setWidth 8 x = x_1 + signExtend 8 x := sorry

theorem negation_of_increment_via_or_with_no_common_bits_set_thm (x x_1 : BitVec 8) : x_1 - (x <<< 1 ||| 1#8) = x_1 + (x <<< 1 ^^^ 255#8) := sorry

theorem negation_of_increment_via_or_disjoint_thm (x x_1 : BitVec 8) : x_1 - (x ||| 1#8) = x_1 + (x ^^^ 255#8) := sorry

theorem negate_add_with_single_negatible_operand_thm (x : BitVec 8) : 214#8 + -x = 214#8 - x := sorry

theorem negate_add_with_single_negatible_operand_depth2_thm (x x_1 : BitVec 8) : -((x_1 + 21#8) * x) = (235#8 - x_1) * x := sorry
