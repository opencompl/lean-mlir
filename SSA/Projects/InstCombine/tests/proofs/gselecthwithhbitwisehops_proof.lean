
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gselecthwithhbitwisehops_proof
theorem set_bits_thm (x : BitVec 1) :
  (match some x with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => none
    | some { toFin := ⟨0, ⋯⟩ } => none) ⊑
    none := by bv_compare'
info: ././././SSA/Projects/InstCombine/tests/LLVM/gselecthwithhbitwisehops.lean:49:17: theorem set_bits_thm :
  ∀ (x : BitVec 8) (x_1 : BitVec 1),
    (match some x_1 with
      | none => none
      | some { toFin := ⟨1, ⋯⟩ } => some (x ||| 5#8)
      | some { toFin := ⟨0, ⋯⟩ } => some (x &&& 250#8)) ⊑
      Option.bind
        (match some x_1 with
        | none => none
        | some { toFin := ⟨1, ⋯⟩ } => some 5#8
        | some { toFin := ⟨0, ⋯⟩ } => some 0#8)
        fun y' => some (x &&& 250#8 ||| y') := by bv_compare'

