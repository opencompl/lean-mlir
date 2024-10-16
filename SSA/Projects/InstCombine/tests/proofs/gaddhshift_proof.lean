
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gaddhshift_proof
theorem flip_add_of_shift_neg_thm (x x_1 x_2 : BitVec 8) :
  ((if ((-x_2) <<< x_1.toNat).sshiftRight x_1.toNat = -x_2 then none
        else
          if (-x_2) <<< x_1.toNat >>> x_1.toNat = -x_2 then none
          else if 8#8 ≤ x_1 then none else some ((-x_2) <<< x_1.toNat)).bind
      fun a => some (a + x)) ⊑
    Option.bind (if 8#8 ≤ x_1 then none else some (x_2 <<< x_1.toNat)) fun y' => some (x - y') := sorry

