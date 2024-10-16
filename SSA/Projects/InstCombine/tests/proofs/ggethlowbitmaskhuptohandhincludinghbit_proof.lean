
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section ggethlowbitmaskhuptohandhincludinghbit_proof
theorem t0_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun a =>
<<<<<<< HEAD
      Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun y' => some (a + 255#8 ||| y')) ⊑
=======
      Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun a_1 => some (a + 255#8 ||| a_1)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
    if 8#8 ≤ 7#8 - x then none else some (255#8 >>> ((256 - x.toNat + 7) % 256)) := sorry

theorem t1_thm (x : BitVec 16) :
  (Option.bind (if 16#16 ≤ x then none else some (1#16 <<< x.toNat)) fun a =>
<<<<<<< HEAD
      Option.bind (if 16#16 ≤ x then none else some (1#16 <<< x.toNat)) fun y' => some (a + 65535#16 ||| y')) ⊑
=======
      Option.bind (if 16#16 ≤ x then none else some (1#16 <<< x.toNat)) fun a_1 => some (a + 65535#16 ||| a_1)) ⊑
>>>>>>> 43a49182 (re-ran scripts)
    if 16#16 ≤ 15#16 - x then none else some (65535#16 >>> ((65536 - x.toNat + 15) % 65536)) := sorry

theorem t9_nocse_thm (x : BitVec 8) :
  (Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun a =>
<<<<<<< HEAD
      Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun y' => some (a + 255#8 ||| y')) ⊑
    (if 1#8 <<< x.toNat >>> x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind fun a =>
      (if (255#8 <<< x.toNat).sshiftRight x.toNat = 255#8 then none
          else if 8#8 ≤ x then none else some (255#8 <<< x.toNat)).bind
        fun x => some (a ||| x ^^^ 255#8) := sorry

theorem t17_nocse_mismatching_x_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (1#8 <<< x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun y' => some (a + 255#8 ||| y')) ⊑
    (if 1#8 <<< x.toNat >>> x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind fun a =>
      (if (255#8 <<< x_1.toNat).sshiftRight x_1.toNat = 255#8 then none
          else if 8#8 ≤ x_1 then none else some (255#8 <<< x_1.toNat)).bind
        fun x => some (a ||| x ^^^ 255#8) := sorry
=======
      Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun a_1 => some (a + 255#8 ||| a_1)) ⊑
    (if 1#8 <<< x.toNat >>> x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind fun a =>
      (if (255#8 <<< x.toNat).sshiftRight x.toNat = 255#8 then none
          else if 8#8 ≤ x then none else some (255#8 <<< x.toNat)).bind
        fun a_1 => some (a ||| a_1 ^^^ 255#8) := sorry

theorem t17_nocse_mismatching_x_thm (x x_1 : BitVec 8) :
  (Option.bind (if 8#8 ≤ x_1 then none else some (1#8 <<< x_1.toNat)) fun a =>
      Option.bind (if 8#8 ≤ x then none else some (1#8 <<< x.toNat)) fun a_1 => some (a + 255#8 ||| a_1)) ⊑
    (if 1#8 <<< x.toNat >>> x.toNat = 1#8 then none else if 8#8 ≤ x then none else some (1#8 <<< x.toNat)).bind fun a =>
      (if (255#8 <<< x_1.toNat).sshiftRight x_1.toNat = 255#8 then none
          else if 8#8 ≤ x_1 then none else some (255#8 <<< x_1.toNat)).bind
        fun a_1 => some (a ||| a_1 ^^^ 255#8) := sorry
>>>>>>> 43a49182 (re-ran scripts)

