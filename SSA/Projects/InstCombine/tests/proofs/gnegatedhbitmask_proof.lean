
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gnegatedhbitmask_proof
theorem neg_mask1_lshr_thm (x : BitVec 8) : -(x >>> 3 &&& 1#8) = (x <<< 4).sshiftRight 7 := sorry

theorem sub_mask1_lshr_thm (x : BitVec 8) :
  some (10#8 - (x >>> 1 &&& 1#8)) ⊑
    if x.getMsbD 6 = (10#8).msb ∧ ¬((x <<< 6).sshiftRight 7 + 10#8).msb = x.getMsbD 6 then none
    else some ((x <<< 6).sshiftRight 7 + 10#8) := sorry

theorem neg_mask2_lshr_thm (x : BitVec 8) :
  some (-(x >>> 3 &&& 2#8)) ⊑
    if (-signExtend 9 (x >>> 3 &&& 2#8)).msb = (-signExtend 9 (x >>> 3 &&& 2#8)).getMsbD 1 then
      some (-(x >>> 3 &&& 2#8))
    else none := sorry

