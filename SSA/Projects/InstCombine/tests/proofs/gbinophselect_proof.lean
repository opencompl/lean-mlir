
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gbinophselect_proof
theorem mul_sel_op0_thm (x : BitVec 32) (x_1 : BitVec 1) :
  (Option.bind
      (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 0#32
      | some { toFin := ⟨0, ⋯⟩ } => if x = 0#32 then none else some (42#32 / x))
      fun a => some (a * x)) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 0#32
    | some { toFin := ⟨0, ⋯⟩ } => some 42#32 := sorry

theorem ashr_sel_op1_thm (x : BitVec 1) :
  (Option.bind
      (match some x with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some 2#32
      | some { toFin := ⟨0, ⋯⟩ } => some 0#32)
      fun y' => if 32#32 ≤ y' then none else some ((4294967294#32).sshiftRight y'.toNat)) ⊑
    match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some 4294967295#32
    | some { toFin := ⟨0, ⋯⟩ } => some 4294967294#32 := sorry

