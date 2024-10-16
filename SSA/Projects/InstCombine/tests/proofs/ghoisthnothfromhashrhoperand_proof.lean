
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ghoisthnothfromhashrhoperand_proof
theorem t0_thm (x x_1 : BitVec 8) :
  (if 8#8 ≤ x then none else some ((x_1 ^^^ 255#8).sshiftRight x.toNat)) ⊑
<<<<<<< HEAD
    Option.bind (if 8#8 ≤ x then none else some (x_1.sshiftRight x.toNat)) fun x' => some (x' ^^^ 255#8) := sorry

theorem t1_thm (x x_1 : BitVec 8) :
  (if 8#8 ≤ x then none else some ((x_1 ^^^ 255#8).sshiftRight x.toNat)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (x_1.sshiftRight x.toNat)) fun x' => some (x' ^^^ 255#8) := sorry
=======
    Option.bind (if 8#8 ≤ x then none else some (x_1.sshiftRight x.toNat)) fun a => some (a ^^^ 255#8) := sorry

theorem t1_thm (x x_1 : BitVec 8) :
  (if 8#8 ≤ x then none else some ((x_1 ^^^ 255#8).sshiftRight x.toNat)) ⊑
    Option.bind (if 8#8 ≤ x then none else some (x_1.sshiftRight x.toNat)) fun a => some (a ^^^ 255#8) := sorry
>>>>>>> 43a49182 (re-ran scripts)

