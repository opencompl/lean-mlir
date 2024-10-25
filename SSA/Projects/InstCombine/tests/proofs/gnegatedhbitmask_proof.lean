
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gnegatedhbitmask_proof
theorem neg_mask1_lshr_thm (x : BitVec 8) : -(x >>> 3 &&& 1#8) = (x <<< 4).sshiftRight 7 := by bv_compare'

theorem sub_mask1_lshr_thm (x : BitVec 8) :
  some (10#8 - (x >>> 1 &&& 1#8)) ⊑
    if x.getMsbD 6 = (10#8).msb ∧ ¬((x <<< 6).sshiftRight 7 + 10#8).msb = x.getMsbD 6 then none
    else some ((x <<< 6).sshiftRight 7 + 10#8) := by bv_compare'

theorem sub_mask1_trunc_lshr_thm (x : BitVec 64) :
  some (10#8 - (setWidth 8 (x >>> 15) &&& 1#8)) ⊑
    if
        (setWidth 8 ((x <<< 48).sshiftRight 63)).msb = (10#8).msb ∧
          ¬(setWidth 8 ((x <<< 48).sshiftRight 63) + 10#8).msb = (setWidth 8 ((x <<< 48).sshiftRight 63)).msb then
      none
    else some (setWidth 8 ((x <<< 48).sshiftRight 63) + 10#8) := sorry

theorem sub_sext_mask1_trunc_lshr_thm (x : BitVec 64) :
  some (10#32 - signExtend 32 (setWidth 8 (x >>> 15) &&& 1#8)) ⊑
    (if
            (setWidth 8 ((x <<< 48).sshiftRight 63)).msb = (10#8).msb ∧
              ¬(setWidth 8 ((x <<< 48).sshiftRight 63) + 10#8).msb = (setWidth 8 ((x <<< 48).sshiftRight 63)).msb then
          none
        else some (setWidth 8 ((x <<< 48).sshiftRight 63) + 10#8)).bind
      fun x' => some (setWidth 32 x') := sorry

theorem sub_zext_trunc_lshr_thm (x : BitVec 64) :
  some (10#32 - setWidth 32 (setWidth 1 (x >>> 15))) ⊑
    if
        (setWidth 32 x).getMsbD 16 = (10#32).msb ∧
          ¬((setWidth 32 x <<< 16).sshiftRight 31 + 10#32).msb = (setWidth 32 x).getMsbD 16 then
      none
    else some ((setWidth 32 x <<< 16).sshiftRight 31 + 10#32) := sorry

theorem neg_mask2_lshr_thm (x : BitVec 8) :
  some (-(x >>> 3 &&& 2#8)) ⊑
    if (-signExtend 9 (x >>> 3 &&& 2#8)).msb = (-signExtend 9 (x >>> 3 &&& 2#8)).getMsbD 1 then
      some (-(x >>> 3 &&& 2#8))
    else none := by bv_compare'

theorem neg_signbit_thm (x : BitVec 8) : -setWidth 32 (x >>> 7) = signExtend 32 (x.sshiftRight 7) := sorry

theorem neg_not_signbit2_thm (x : BitVec 8) :
  some (-setWidth 32 (x >>> 6)) ⊑
    if (-signExtend 33 (setWidth 32 (x >>> 6))).msb = (-signExtend 33 (setWidth 32 (x >>> 6))).getMsbD 1 then
      some (-setWidth 32 (x >>> 6))
    else none := sorry

theorem neg_not_signbit3_thm (x : BitVec 8) :
  some (-setWidth 32 (x.sshiftRight 7)) ⊑
    if
        (-signExtend 33 (setWidth 32 (x.sshiftRight 7))).msb =
          (-signExtend 33 (setWidth 32 (x.sshiftRight 7))).getMsbD 1 then
      some (-setWidth 32 (x.sshiftRight 7))
    else none := sorry

