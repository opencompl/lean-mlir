
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gconditionalhnegation_proof
theorem t0_thm (x : BitVec 8) (x_1 : BitVec 1) :
  some (signExtend 8 x_1 + x ^^^ signExtend 8 x_1) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some (-x)
    | some { toFin := ⟨0, ⋯⟩ } => some x := sorry

theorem t1_thm (x : BitVec 8) (x_1 : BitVec 1) :
  some (signExtend 8 x_1 + x ^^^ signExtend 8 x_1) ⊑
    match some x_1 with
    | none => none
    | some { toFin := ⟨1, ⋯⟩ } => some (-x)
    | some { toFin := ⟨0, ⋯⟩ } => some x := sorry

theorem t2_thm (x : BitVec 1) (x_1 : BitVec 8) (x_2 : BitVec 1) :
  signExtend 8 x_2 + x_1 ^^^ signExtend 8 x = x_1 + signExtend 8 x_2 ^^^ signExtend 8 x := sorry

theorem t3_thm (x : BitVec 8) (x_1 : BitVec 2) :
  signExtend 8 x_1 + x ^^^ signExtend 8 x_1 = x + signExtend 8 x_1 ^^^ signExtend 8 x_1 := sorry

