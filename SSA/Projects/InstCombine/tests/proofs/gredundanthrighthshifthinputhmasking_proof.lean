
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gredundanthrighthshifthinputhmasking_proof
theorem t0_lshr_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x_1 then none else some (4294967295#32 <<< x_1.toNat)) fun a =>
      if 32#32 ≤ x_1 then none else some ((a &&& x) >>> x_1.toNat)) ⊑
    (if (4294967295#32 <<< x_1.toNat).sshiftRight x_1.toNat = 4294967295#32 then none
        else if 32#32 ≤ x_1 then none else some (4294967295#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a &&& x) >>> x_1.toNat) := by bv_compare'

theorem t1_sshr_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x_1 then none else some (4294967295#32 <<< x_1.toNat)) fun a =>
      if 32#32 ≤ x_1 then none else some ((a &&& x).sshiftRight x_1.toNat)) ⊑
    (if (4294967295#32 <<< x_1.toNat).sshiftRight x_1.toNat = 4294967295#32 then none
        else if 32#32 ≤ x_1 then none else some (4294967295#32 <<< x_1.toNat)).bind
      fun a => if 32#32 ≤ x_1 then none else some ((a &&& x).sshiftRight x_1.toNat) := by bv_compare'

theorem n13_thm (x x_1 x_2 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x_2 then none else some (4294967295#32 <<< x_2.toNat)) fun a =>
      if 32#32 ≤ x then none else some ((a &&& x_1) >>> x.toNat)) ⊑
    (if (4294967295#32 <<< x_2.toNat).sshiftRight x_2.toNat = 4294967295#32 then none
        else if 32#32 ≤ x_2 then none else some (4294967295#32 <<< x_2.toNat)).bind
      fun a => if 32#32 ≤ x then none else some ((a &&& x_1) >>> x.toNat) := by bv_compare'

