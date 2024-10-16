
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshifthflags_proof
theorem shl_add_nuw_thm (x x_1 : BitVec 8) :
  (if 8#8 ≤ x &&& 2#8 then none else some ((x_1 &&& 63#8) <<< (x.toNat &&& 2))) ⊑
    if (x_1 &&& 63#8) <<< (x.toNat &&& 2) >>> (x.toNat &&& 2) = x_1 &&& 63#8 then none
    else if 8#8 ≤ x &&& 2#8 then none else some ((x_1 &&& 63#8) <<< (x.toNat &&& 2)) := sorry

theorem shl_add_nuw_and_nsw_thm (x x_1 : BitVec 8) :
  (if 8#8 ≤ x &&& 2#8 then none else some ((x_1 &&& 31#8) <<< (x.toNat &&& 2))) ⊑
    if ((x_1 &&& 31#8) <<< (x.toNat &&& 2)).sshiftRight (x.toNat &&& 2) = x_1 &&& 31#8 then none
    else
      if (x_1 &&& 31#8) <<< (x.toNat &&& 2) >>> (x.toNat &&& 2) = x_1 &&& 31#8 then none
      else if 8#8 ≤ x &&& 2#8 then none else some ((x_1 &&& 31#8) <<< (x.toNat &&& 2)) := sorry

theorem shl_add_nsw_thm (x x_1 : BitVec 8) :
  (if 8#8 ≤ x &&& 2#8 then none else some ((x_1 ||| 224#8) <<< (x.toNat &&& 2))) ⊑
    if ((x_1 ||| 224#8) <<< (x.toNat &&& 2)).sshiftRight (x.toNat &&& 2) = x_1 ||| 224#8 then none
    else if 8#8 ≤ x &&& 2#8 then none else some ((x_1 ||| 224#8) <<< (x.toNat &&& 2)) := sorry

