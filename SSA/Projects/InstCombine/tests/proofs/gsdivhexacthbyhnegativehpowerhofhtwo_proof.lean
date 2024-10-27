
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsdivhexacthbyhnegativehpowerhofhtwo_proof
theorem t0_thm (x : BitVec 8) :
  some (x.sdiv 224#8) ⊑
    if (-signExtend 9 (x.sshiftRight 5)).msb = (-signExtend 9 (x.sshiftRight 5)).getMsbD 1 then some (-x.sshiftRight 5)
    else none := sorry

theorem prove_exact_with_high_mask_thm (x : BitVec 8) :
  some ((x &&& 224#8).sdiv 252#8) ⊑
    if (-signExtend 9 (x.sshiftRight 2 &&& 248#8)).msb = (-signExtend 9 (x.sshiftRight 2 &&& 248#8)).getMsbD 1 then
      some (-(x.sshiftRight 2 &&& 248#8))
    else none := sorry

theorem prove_exact_with_high_mask_limit_thm (x : BitVec 8) :
  some ((x &&& 224#8).sdiv 224#8) ⊑
    if (-signExtend 9 (x.sshiftRight 5)).msb = (-signExtend 9 (x.sshiftRight 5)).getMsbD 1 then some (-x.sshiftRight 5)
    else none := sorry

