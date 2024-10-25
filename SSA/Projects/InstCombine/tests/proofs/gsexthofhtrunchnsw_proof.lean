
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsexthofhtrunchnsw_proof
theorem narrow_source_matching_signbits_thm (x : BitVec 32) :
  ((if (4294967295#32 <<< (x.toNat &&& 7)).sshiftRight (x.toNat &&& 7) = 4294967295#32 then none
        else if 32#32 ≤ x &&& 7#32 then none else some (4294967295#32 <<< (x.toNat &&& 7))).bind
      fun x => some (signExtend 64 (setWidth 8 x))) ⊑
    (if (4294967295#32 <<< (x.toNat &&& 7)).sshiftRight (x.toNat &&& 7) = 4294967295#32 then none
        else if 32#32 ≤ x &&& 7#32 then none else some (4294967295#32 <<< (x.toNat &&& 7))).bind
      fun x' => some (signExtend 64 x') := sorry

theorem wide_source_matching_signbits_thm (x : BitVec 32) :
  ((if (4294967295#32 <<< (x.toNat &&& 7)).sshiftRight (x.toNat &&& 7) = 4294967295#32 then none
        else if 32#32 ≤ x &&& 7#32 then none else some (4294967295#32 <<< (x.toNat &&& 7))).bind
      fun x => some (signExtend 24 (setWidth 8 x))) ⊑
    (if (4294967295#32 <<< (x.toNat &&& 7)).sshiftRight (x.toNat &&& 7) = 4294967295#32 then none
        else if 32#32 ≤ x &&& 7#32 then none else some (4294967295#32 <<< (x.toNat &&& 7))).bind
      fun x' => some (setWidth 24 x') := sorry

theorem same_source_matching_signbits_thm (x : BitVec 32) :
  ((if (4294967295#32 <<< (x.toNat &&& 7)).sshiftRight (x.toNat &&& 7) = 4294967295#32 then none
        else if 32#32 ≤ x &&& 7#32 then none else some (4294967295#32 <<< (x.toNat &&& 7))).bind
      fun x => some (signExtend 32 (setWidth 8 x))) ⊑
    if (4294967295#32 <<< (x.toNat &&& 7)).sshiftRight (x.toNat &&& 7) = 4294967295#32 then none
    else if 32#32 ≤ x &&& 7#32 then none else some (4294967295#32 <<< (x.toNat &&& 7)) := sorry

theorem same_source_not_matching_signbits_thm (x : BitVec 32) :
  ((if (4294967295#32 <<< (x.toNat &&& 8)).sshiftRight (x.toNat &&& 8) = 4294967295#32 then none
        else if 32#32 ≤ x &&& 8#32 then none else some (4294967295#32 <<< (x.toNat &&& 8))).bind
      fun x => some (signExtend 32 (setWidth 8 x))) ⊑
    Option.bind (if 32#32 ≤ x &&& 8#32 then none else some (4278190080#32 <<< (x.toNat &&& 8))) fun x' =>
      some (x'.sshiftRight 24) := sorry

