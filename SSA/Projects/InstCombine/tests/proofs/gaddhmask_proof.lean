
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gaddhmask_proof
theorem add_mask_ashr28_i32_thm (x : BitVec 32) : (x.sshiftRight 28 &&& 8#32) + x.sshiftRight 28 = x >>> 28 &&& 7#32 := by bv_compare'

theorem add_mask_ashr28_non_pow2_i32_thm (x : BitVec 32) :
  some ((x.sshiftRight 28 &&& 9#32) + x.sshiftRight 28) ⊑
    if
        (x.msb = true → (9#32).msb = true) ∧
          ¬((x.sshiftRight 28 &&& 9#32) + x.sshiftRight 28).msb = (x.msb && (9#32).msb) then
      none
    else some ((x.sshiftRight 28 &&& 9#32) + x.sshiftRight 28) := by bv_compare'

theorem add_mask_ashr27_i32_thm (x : BitVec 32) :
  some ((x.sshiftRight 27 &&& 8#32) + x.sshiftRight 27) ⊑
    if
        (x.msb = true → (8#32).msb = true) ∧
          ¬((x.sshiftRight 27 &&& 8#32) + x.sshiftRight 27).msb = (x.msb && (8#32).msb) then
      none
    else some ((x.sshiftRight 27 &&& 8#32) + x.sshiftRight 27) := by bv_compare'

