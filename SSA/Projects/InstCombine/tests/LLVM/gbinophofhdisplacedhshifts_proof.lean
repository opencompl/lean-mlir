
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gbinophofhdisplacedhshifts_proof
theorem shl_or_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (16#8 <<< x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some (3#8 <<< ((x.toNat + 1) % 256))) fun a_1 =>
        some (a ||| a_1)) ⊑
    if 8 ≤ x.toNat then none else some (22#8 <<< x.toNat) := sorry

theorem lshr_or_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (16#8 >>> x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some (3#8 >>> ((x.toNat + 1) % 256))) fun a_1 =>
        some (a ||| a_1)) ⊑
    if 8 ≤ x.toNat then none else some (17#8 >>> x.toNat) := sorry

theorem ashr_or_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some ((192#8).sshiftRight x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some ((128#8).sshiftRight ((x.toNat + 1) % 256)))
        fun a_1 => some (a ||| a_1)) ⊑
    if 8 ≤ x.toNat then none else some ((192#8).sshiftRight x.toNat) := sorry

theorem shl_xor_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (16#8 <<< x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some (3#8 <<< ((x.toNat + 1) % 256))) fun a_1 =>
        some (a ^^^ a_1)) ⊑
    if 8 ≤ x.toNat then none else some (22#8 <<< x.toNat) := sorry

theorem lshr_xor_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (16#8 >>> x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some (3#8 >>> ((x.toNat + 1) % 256))) fun a_1 =>
        some (a ^^^ a_1)) ⊑
    if 8 ≤ x.toNat then none else some (17#8 >>> x.toNat) := sorry

theorem ashr_xor_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some ((128#8).sshiftRight x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some ((192#8).sshiftRight ((x.toNat + 1) % 256)))
        fun a_1 => some (a ^^^ a_1)) ⊑
    if 8 ≤ x.toNat then none else some (96#8 >>> x.toNat) := sorry

theorem shl_and_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (48#8 <<< x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some (8#8 <<< ((x.toNat + 1) % 256))) fun a_1 =>
        some (a &&& a_1)) ⊑
    if 8 ≤ x.toNat then none else some (16#8 <<< x.toNat) := sorry

theorem lshr_and_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (48#8 >>> x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some (64#8 >>> ((x.toNat + 1) % 256))) fun a_1 =>
        some (a &&& a_1)) ⊑
    if 8 ≤ x.toNat then none else some (32#8 >>> x.toNat) := sorry

theorem ashr_and_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some ((192#8).sshiftRight x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some ((128#8).sshiftRight ((x.toNat + 1) % 256)))
        fun a_1 => some (a &&& a_1)) ⊑
    if 8 ≤ x.toNat then none else some ((192#8).sshiftRight x.toNat) := sorry

theorem shl_add_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (16#8 <<< x.toNat)) fun a =>
      Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some (7#8 <<< ((x.toNat + 1) % 256))) fun a_1 =>
        some (a + a_1)) ⊑
    if 8 ≤ x.toNat then none else some (30#8 <<< x.toNat) := sorry

theorem shl_or_commuted_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ (x.toNat + 1) % 256 then none else some (3#8 <<< ((x.toNat + 1) % 256))) fun a =>
      Option.bind (if 8 ≤ x.toNat then none else some (16#8 <<< x.toNat)) fun a_1 => some (a ||| a_1)) ⊑
    if 8 ≤ x.toNat then none else some (22#8 <<< x.toNat) := sorry

theorem shl_or_with_or_disjoint_instead_of_add_thm (x : BitVec 8) :
  (Option.bind (if 8 ≤ x.toNat then none else some (16#8 <<< x.toNat)) fun a =>
      Option.bind (if 8 ≤ x.toNat ||| 1 then none else some (3#8 <<< (x.toNat ||| 1))) fun a_1 => some (a ||| a_1)) ⊑
    if 8 ≤ x.toNat then none else some (22#8 <<< x.toNat) := sorry

