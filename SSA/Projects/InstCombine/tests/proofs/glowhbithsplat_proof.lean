
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section glowhbithsplat_proof
theorem t0_thm (x : BitVec 8) :
  some ((x <<< 7).sshiftRight 7) ⊑
    if (-signExtend 9 (x &&& 1#8)).msb = (-signExtend 9 (x &&& 1#8)).getMsbD 1 then some (-(x &&& 1#8))
    else none := sorry

theorem t1_otherbitwidth_thm (x : BitVec 16) :
  some ((x <<< 15).sshiftRight 15) ⊑
    if (-signExtend 17 (x &&& 1#16)).msb = (-signExtend 17 (x &&& 1#16)).getMsbD 1 then some (-(x &&& 1#16))
    else none := sorry

