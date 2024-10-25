
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsethlowbitshmaskhcanonicalize_proof
theorem shl_add_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x' => some (x' + 4294967295#32)) ⊑
    (if (4294967295#32 <<< x.toNat).sshiftRight x.toNat = 4294967295#32 then none
        else if 32#32 ≤ x then none else some (4294967295#32 <<< x.toNat)).bind
      fun x' => some (x' ^^^ 4294967295#32) := by bv_compare'

theorem shl_add_nsw_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x' =>
      if x'.msb = (4294967295#32).msb ∧ ¬(x' + 4294967295#32).msb = x'.msb then none else some (x' + 4294967295#32)) ⊑
    (if (4294967295#32 <<< x.toNat).sshiftRight x.toNat = 4294967295#32 then none
        else if 32#32 ≤ x then none else some (4294967295#32 <<< x.toNat)).bind
      fun x' => some (x' ^^^ 4294967295#32) := by bv_compare'

theorem shl_add_nuw_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x' =>
      if x' + 4294967295#32 < x' ∨ x' + 4294967295#32 < 4294967295#32 then none else some (x' + 4294967295#32)) ⊑
    some 4294967295#32 := by bv_compare'

theorem shl_add_nsw_nuw_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x' =>
      if x'.msb = (4294967295#32).msb ∧ ¬(x' + 4294967295#32).msb = x'.msb then none
      else if x' + 4294967295#32 < x' ∨ x' + 4294967295#32 < 4294967295#32 then none else some (x' + 4294967295#32)) ⊑
    some 4294967295#32 := by bv_compare'

theorem shl_nsw_add_thm (x : BitVec 32) :
  ((if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
        else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' => some (x' + 4294967295#32)) ⊑
    (if (4294967295#32 <<< x.toNat).sshiftRight x.toNat = 4294967295#32 then none
        else if 32#32 ≤ x then none else some (4294967295#32 <<< x.toNat)).bind
      fun x' => some (x' ^^^ 4294967295#32) := by bv_compare'

theorem shl_nsw_add_nsw_thm (x : BitVec 32) :
  ((if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
        else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x'.msb = (4294967295#32).msb ∧ ¬(x' + 4294967295#32).msb = x'.msb then none else some (x' + 4294967295#32)) ⊑
    (if (4294967295#32 <<< x.toNat).sshiftRight x.toNat = 4294967295#32 then none
        else if 32#32 ≤ x then none else some (4294967295#32 <<< x.toNat)).bind
      fun x' => some (x' ^^^ 4294967295#32) := by bv_compare'

theorem shl_nsw_add_nuw_thm (x : BitVec 32) :
  ((if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
        else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x' + 4294967295#32 < x' ∨ x' + 4294967295#32 < 4294967295#32 then none else some (x' + 4294967295#32)) ⊑
    some 4294967295#32 := by bv_compare'

theorem shl_nsw_add_nsw_nuw_thm (x : BitVec 32) :
  ((if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
        else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x'.msb = (4294967295#32).msb ∧ ¬(x' + 4294967295#32).msb = x'.msb then none
      else if x' + 4294967295#32 < x' ∨ x' + 4294967295#32 < 4294967295#32 then none else some (x' + 4294967295#32)) ⊑
    some 4294967295#32 := by bv_compare'

theorem shl_nuw_add_thm (x : BitVec 32) :
  ((if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' => some (x' + 4294967295#32)) ⊑
    (if (4294967295#32 <<< x.toNat).sshiftRight x.toNat = 4294967295#32 then none
        else if 32#32 ≤ x then none else some (4294967295#32 <<< x.toNat)).bind
      fun x' => some (x' ^^^ 4294967295#32) := by bv_compare'

theorem shl_nuw_add_nsw_thm (x : BitVec 32) :
  ((if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x'.msb = (4294967295#32).msb ∧ ¬(x' + 4294967295#32).msb = x'.msb then none else some (x' + 4294967295#32)) ⊑
    (if (4294967295#32 <<< x.toNat).sshiftRight x.toNat = 4294967295#32 then none
        else if 32#32 ≤ x then none else some (4294967295#32 <<< x.toNat)).bind
      fun x' => some (x' ^^^ 4294967295#32) := by bv_compare'

theorem shl_nuw_add_nuw_thm (x : BitVec 32) :
  ((if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x' + 4294967295#32 < x' ∨ x' + 4294967295#32 < 4294967295#32 then none else some (x' + 4294967295#32)) ⊑
    some 4294967295#32 := by bv_compare'

theorem shl_nuw_add_nsw_nuw_thm (x : BitVec 32) :
  ((if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x'.msb = (4294967295#32).msb ∧ ¬(x' + 4294967295#32).msb = x'.msb then none
      else if x' + 4294967295#32 < x' ∨ x' + 4294967295#32 < 4294967295#32 then none else some (x' + 4294967295#32)) ⊑
    some 4294967295#32 := by bv_compare'

theorem shl_nsw_nuw_add_thm (x : BitVec 32) :
  ((if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
        else
          if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none
          else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' => some (x' + 4294967295#32)) ⊑
    (if (4294967295#32 <<< x.toNat).sshiftRight x.toNat = 4294967295#32 then none
        else if 32#32 ≤ x then none else some (4294967295#32 <<< x.toNat)).bind
      fun x' => some (x' ^^^ 4294967295#32) := by bv_compare'

theorem shl_nsw_nuw_add_nsw_thm (x : BitVec 32) :
  ((if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
        else
          if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none
          else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x'.msb = (4294967295#32).msb ∧ ¬(x' + 4294967295#32).msb = x'.msb then none else some (x' + 4294967295#32)) ⊑
    (if (4294967295#32 <<< x.toNat).sshiftRight x.toNat = 4294967295#32 then none
        else if 32#32 ≤ x then none else some (4294967295#32 <<< x.toNat)).bind
      fun x' => some (x' ^^^ 4294967295#32) := by bv_compare'

theorem shl_nsw_nuw_add_nuw_thm (x : BitVec 32) :
  ((if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
        else
          if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none
          else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x' + 4294967295#32 < x' ∨ x' + 4294967295#32 < 4294967295#32 then none else some (x' + 4294967295#32)) ⊑
    some 4294967295#32 := by bv_compare'

theorem shl_nsw_nuw_add_nsw_nuw_thm (x : BitVec 32) :
  ((if (1#32 <<< x.toNat).sshiftRight x.toNat = 1#32 then none
        else
          if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none
          else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' =>
      if x'.msb = (4294967295#32).msb ∧ ¬(x' + 4294967295#32).msb = x'.msb then none
      else if x' + 4294967295#32 < x' ∨ x' + 4294967295#32 < 4294967295#32 then none else some (x' + 4294967295#32)) ⊑
    some 4294967295#32 := by bv_compare'

theorem bad_add0_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)) fun a => some (a + x)) ⊑
    (if 1#32 <<< x_1.toNat >>> x_1.toNat = 1#32 then none
        else if 32#32 ≤ x_1 then none else some (1#32 <<< x_1.toNat)).bind
      fun a => some (a + x) := by bv_compare'

theorem bad_add1_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x' => some (x' + 1#32)) ⊑
    (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' => if x' + 1#32 < x' ∨ x' + 1#32 < 1#32 then none else some (x' + 1#32) := by bv_compare'

theorem bad_add2_thm (x : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun x' => some (x' + 4294967294#32)) ⊑
    (if 1#32 <<< x.toNat >>> x.toNat = 1#32 then none else if 32#32 ≤ x then none else some (1#32 <<< x.toNat)).bind
      fun x' => some (x' + 4294967294#32) := by bv_compare'

