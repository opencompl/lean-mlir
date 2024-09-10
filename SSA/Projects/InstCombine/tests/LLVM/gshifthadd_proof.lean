
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshifthadd_proof
theorem ashr_C1_add_A_C2_i32_thm (x : BitVec 32) :
  (if 32 ≤ ((x.toNat &&& 65535) + 5) % 4294967296 then none
    else some ((6#32).sshiftRight (((x.toNat &&& 65535) + 5) % 4294967296))) ⊑
    some 0#32 := sorry

theorem lshr_C1_add_A_C2_i32_thm (x : BitVec 32) :
  (if 32 ≤ ((x.toNat &&& 65535) + 5) % 4294967296 then none
    else some (6#32 <<< (((x.toNat &&& 65535) + 5) % 4294967296))) ⊑
    if 32 ≤ x.toNat &&& 65535 then none else some (192#32 <<< (x.toNat &&& 65535)) := sorry

theorem shl_add_nuw_thm (x : BitVec 32) :
  (if 32 ≤ (x.toNat + 5) % 4294967296 then none else some (6#32 <<< ((x.toNat + 5) % 4294967296))) ⊑
    if 32 ≤ x.toNat then none else some (192#32 <<< x.toNat) := sorry

theorem shl_nuw_add_nuw_thm (x : BitVec 32) :
  (if 32 ≤ (x.toNat + 1) % 4294967296 then none else some (1#32 <<< ((x.toNat + 1) % 4294967296))) ⊑
    if 32 ≤ x.toNat then none else some (2#32 <<< x.toNat) := sorry

theorem shl_nsw_add_nuw_thm (x : BitVec 32) :
  (if 32 ≤ (x.toNat + 1) % 4294967296 then none else some (4294967295#32 <<< ((x.toNat + 1) % 4294967296))) ⊑
    if 32 ≤ x.toNat then none else some (4294967294#32 <<< x.toNat) := sorry

theorem lshr_exact_add_nuw_thm (x : BitVec 32) :
  (if 32 ≤ (x.toNat + 1) % 4294967296 then none else some (4#32 >>> ((x.toNat + 1) % 4294967296))) ⊑
    if 32 ≤ x.toNat then none else some (2#32 >>> x.toNat) := sorry

