
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gdivhshift_proof
theorem t7_thm (x : BitVec 32) :
  ((if (x <<< 2).sshiftRight 2 = x then none else some (x <<< 2)).bind fun a =>
      if x = 0#32 ∨ a = intMin 32 ∧ x = 4294967295#32 then none else some (a.sdiv x)) ⊑
    some 4#32 := sorry

theorem t10_thm (x x_1 : BitVec 32) :
  ((if (x_1 <<< x.toNat).sshiftRight x.toNat = x_1 then none
        else if 32#32 ≤ x then none else some (x_1 <<< x.toNat)).bind
      fun a => if x_1 = 0#32 ∨ a = intMin 32 ∧ x_1 = 4294967295#32 then none else some (a.sdiv x_1)) ⊑
    if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
    else
      if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat) := sorry

theorem sdiv_mul_shl_nsw_thm (x x_1 x_2 : BitVec 5) :
  ((if
            signExtend 10 x_2 * signExtend 10 x_1 < signExtend 10 (twoPow 5 4) ∨
              twoPow 10 4 ≤ signExtend 10 x_2 * signExtend 10 x_1 then
          none
        else some (x_2 * x_1)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else if 5#5 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun a_1 => if a_1 = 0#5 ∨ a = intMin 5 ∧ a_1 = 31#5 then none else some (a.sdiv a_1)) ⊑
    (if 1#5 <<< x.toNat >>> x.toNat = 1#5 then none else if 5#5 ≤ x then none else some (1#5 <<< x.toNat)).bind fun a =>
      if a = 0#5 ∨ x_1 = intMin 5 ∧ a = 31#5 then none else some (x_1.sdiv a) := sorry

theorem sdiv_mul_shl_nsw_exact_commute1_thm (x x_1 x_2 : BitVec 5) :
  ((if
            signExtend 10 x_2 * signExtend 10 x_1 < signExtend 10 (twoPow 5 4) ∨
              twoPow 10 4 ≤ signExtend 10 x_2 * signExtend 10 x_1 then
          none
        else some (x_2 * x_1)).bind
      fun a =>
      (if (x_1 <<< x.toNat).sshiftRight x.toNat = x_1 then none
          else if 5#5 ≤ x then none else some (x_1 <<< x.toNat)).bind
        fun a_1 => if a_1 = 0#5 ∨ a = intMin 5 ∧ a_1 = 31#5 then none else some (a.sdiv a_1)) ⊑
    (if 1#5 <<< x.toNat >>> x.toNat = 1#5 then none else if 5#5 ≤ x then none else some (1#5 <<< x.toNat)).bind fun a =>
      if a = 0#5 ∨ x_2 = intMin 5 ∧ a = 31#5 then none else some (x_2.sdiv a) := sorry

theorem sdiv_shl_shl_nsw2_nuw_thm (x x_1 x_2 : BitVec 8) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else if 8#8 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x <<< x_1.toNat).sshiftRight x_1.toNat = x then none
          else
            if x <<< x_1.toNat >>> x_1.toNat = x then none else if 8#8 ≤ x_1 then none else some (x <<< x_1.toNat)).bind
        fun a_1 => if a_1 = 0#8 ∨ a = intMin 8 ∧ a_1 = 255#8 then none else some (a.sdiv a_1)) ⊑
    if x = 0#8 ∨ x_2 = intMin 8 ∧ x = 255#8 then none else some (x_2.sdiv x) := sorry

theorem sdiv_shl_pair_const_thm (x : BitVec 32) :
  ((if (x <<< 2).sshiftRight 2 = x then none else some (x <<< 2)).bind fun a =>
      (if (x <<< 1).sshiftRight 1 = x then none else some (x <<< 1)).bind fun a_1 =>
        if a_1 = 0#32 ∨ a = intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    some 2#32 := sorry

theorem sdiv_shl_pair1_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else
            if x_2 <<< x.toNat >>> x.toNat = x_2 then none else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun a_1 => if a_1 = 0#32 ∨ a = intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    (if (1#32 <<< x_1.toNat).sshiftRight x_1.toNat = 1#32 then none
        else
          if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
          else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry

theorem sdiv_shl_pair2_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else
          if x_2 <<< x_1.toNat >>> x_1.toNat = x_2 then none
          else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun a_1 => if a_1 = 0#32 ∨ a = intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    (if (1#32 <<< x_1.toNat).sshiftRight x_1.toNat = 1#32 then none
        else
          if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
          else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry

theorem sdiv_shl_pair3_thm (x x_1 x_2 : BitVec 32) :
  ((if (x_2 <<< x_1.toNat).sshiftRight x_1.toNat = x_2 then none
        else if 32#32 ≤ x_1 then none else some (x_2 <<< x_1.toNat)).bind
      fun a =>
      (if (x_2 <<< x.toNat).sshiftRight x.toNat = x_2 then none
          else if 32#32 ≤ x then none else some (x_2 <<< x.toNat)).bind
        fun a_1 => if a_1 = 0#32 ∨ a = intMin 32 ∧ a_1 = 4294967295#32 then none else some (a.sdiv a_1)) ⊑
    (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
        else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x then none else some (a >>> x.toNat) := sorry

