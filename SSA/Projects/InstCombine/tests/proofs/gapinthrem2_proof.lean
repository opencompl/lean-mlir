
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gapinthrem2_proof
theorem test1_thm (x : BitVec 333) : x % 70368744177664#333 = x &&& 70368744177663#333 := sorry

theorem test2_thm (x : BitVec 499) :
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 4bf2f937 (Re-ran the sccripts)
  (Option.bind (if 499 % 2 ^ 499 ≤ 111 % 2 ^ 499 then none else some (4096#499 <<< (111 % 2 ^ 499))) fun y' =>
      if y' = 0#499 then none else some (x % y')) ⊑
    some (x &&& 10633823966279326983230456482242756607#499) := sorry

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> edb64a33 (Updated tests)
theorem test3_thm (x : BitVec 1) (x_1 : BitVec 599) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 70368744177664#599
      | some { toFin := ⟨0, ⋯⟩ } => some 4096#599)
      fun y' => if y' = 0#599 then none else some (x_1 % y')) ⊑
    Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 70368744177663#599
      | some { toFin := ⟨0, ⋯⟩ } => some 4095#599)
      fun y' => some (x_1 &&& y') := sorry

<<<<<<< HEAD
=======
  (Option.bind (if 499 % 2 ^ 499 ≤ 111 % 2 ^ 499 then none else some (4096#499 <<< (111 % 2 ^ 499))) fun a =>
      if a = 0#499 then none else some (x % a)) ⊑
    some (x &&& 10633823966279326983230456482242756607#499) := sorry

>>>>>>> 43a49182 (re-ran scripts)
=======
>>>>>>> 4bf2f937 (Re-ran the sccripts)
=======
>>>>>>> edb64a33 (Updated tests)
