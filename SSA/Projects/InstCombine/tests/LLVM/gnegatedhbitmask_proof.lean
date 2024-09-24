
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gnegatedhbitmask_proof
theorem neg_mask1_lshr_thm (x : BitVec 8) : -(x >>> 3 &&& 1#8) = (x <<< 4).sshiftRight 7 := sorry

theorem sub_mask1_lshr_thm (x : BitVec 8) : 10#8 - (x >>> 1 &&& 1#8) = (x <<< 6).sshiftRight 7 + 10#8 := sorry

