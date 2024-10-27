
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshifthsra_proof
theorem test1_thm (x : BitVec 8) (x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ setWidth 32 x then none else some (x_1.sshiftRight (x.toNat % 4294967296))) fun x' =>
      some (x' &&& 1#32)) ⊑
    Option.bind (if 32#32 ≤ setWidth 32 x then none else some (x_1 >>> (x.toNat % 4294967296))) fun x' =>
      some (x' &&& 1#32) := by bv_compare'

theorem test2_thm (x : BitVec 8) :
  some ((setWidth 32 x + 7#32).sshiftRight 3) ⊑
    (if (setWidth 32 x).msb = (7#32).msb ∧ ¬(setWidth 32 x + 7#32).msb = (setWidth 32 x).msb then none
        else
          if setWidth 32 x + 7#32 < setWidth 32 x ∨ setWidth 32 x + 7#32 < 7#32 then none
          else some (setWidth 32 x + 7#32)).bind
      fun x' => some (x' >>> 3) := by bv_compare'

theorem ashr_ashr_thm (x : BitVec 32) : (x.sshiftRight 5).sshiftRight 7 = x.sshiftRight 12 := by bv_compare'

theorem ashr_overshift_thm (x : BitVec 32) : (x.sshiftRight 15).sshiftRight 17 = x.sshiftRight 31 := by bv_compare'

theorem hoist_ashr_ahead_of_sext_1_thm (x : BitVec 8) : (signExtend 32 x).sshiftRight 3 = signExtend 32 (x.sshiftRight 3) := by bv_compare'

theorem hoist_ashr_ahead_of_sext_2_thm (x : BitVec 8) : (signExtend 32 x).sshiftRight 8 = signExtend 32 (x.sshiftRight 7) := by bv_compare'

