
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section grotate_proof
theorem rotateleft_9_neg_mask_wide_amount_commute_thm (x : BitVec 33) (x_1 : BitVec 9) :
  (Option.bind (if 33#33 ≤ x &&& 8#33 then none else some (setWidth 33 x_1 <<< (x.toNat &&& 8))) fun a =>
      Option.bind
        (if 33#33 ≤ -x &&& 8#33 then none else some (setWidth 33 x_1 >>> ((8589934592 - x.toNat) % 8589934592 &&& 8)))
        fun x => some (setWidth 9 a ||| setWidth 9 x)) ⊑
    (if (setWidth 33 x_1 <<< (x.toNat &&& 8)).sshiftRight (x.toNat &&& 8) = setWidth 33 x_1 then none
        else
          if setWidth 33 x_1 <<< (x.toNat &&& 8) >>> (x.toNat &&& 8) = setWidth 33 x_1 then none
          else if 33#33 ≤ x &&& 8#33 then none else some (setWidth 33 x_1 <<< (x.toNat &&& 8))).bind
      fun a =>
      Option.bind
        (if 33#33 ≤ -x &&& 8#33 then none else some (setWidth 33 x_1 >>> ((8589934592 - x.toNat) % 8589934592 &&& 8)))
        fun x => some (setWidth 9 a ||| setWidth 9 x) := by bv_compare'

