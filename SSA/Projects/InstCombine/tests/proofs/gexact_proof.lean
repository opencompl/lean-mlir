
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gexact_proof
theorem sdiv2_thm (x : BitVec 32) : x.sdiv 8#32 = x.sshiftRight 3 := sorry

theorem sdiv4_thm (x : BitVec 32) : x.sdiv 3#32 * 3#32 = x := sorry

theorem sdiv6_thm (x : BitVec 32) : x.sdiv 3#32 * 4294967293#32 = -x := sorry

theorem mul_of_sdiv_thm (x : BitVec 8) :
  some (x.sdiv 12#8 * 250#8) ⊑
    if (-signExtend 9 (x.sshiftRight 1)).msb = (-signExtend 9 (x.sshiftRight 1)).getMsbD 1 then some (-x.sshiftRight 1)
    else none := sorry

theorem mul_of_sdiv_fail_ub_thm (x : BitVec 8) : x.sdiv 6#8 * 250#8 = -x := sorry

