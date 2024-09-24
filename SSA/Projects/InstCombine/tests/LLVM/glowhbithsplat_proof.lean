
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section glowhbithsplat_proof
theorem t0_thm (x : BitVec 8) : (x <<< 7).sshiftRight 7 = -(x &&& 1#8) := sorry

theorem t1_otherbitwidth_thm (x : BitVec 16) : (x <<< 15).sshiftRight 15 = -(x &&& 1#16) := sorry

