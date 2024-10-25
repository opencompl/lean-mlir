
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gexact_proof
theorem sdiv2_thm (x : BitVec 32) : x.sdiv 8#32 = x.sshiftRight 3 := by bv_compare'

theorem sdiv4_thm (x : BitVec 32) : x.sdiv 3#32 * 3#32 = x := by bv_compare'

theorem sdiv6_thm (x : BitVec 32) : x.sdiv 3#32 * 4294967293#32 = -x := by bv_compare'

theorem udiv1_thm (x x_1 : BitVec 32) :
  (Option.bind (if x = 0#32 then none else some (x_1 / x)) fun a => some (a * x)) ⊑ some x_1 := by bv_compare'

theorem udiv2_thm (x x_1 : BitVec 32) :
  (Option.bind (if 32#32 ≤ x then none else some (1#32 <<< x.toNat)) fun y' =>
      if y' = 0#32 then none else some (x_1 / y')) ⊑
    if 32#32 ≤ x then none else some (x_1 >>> x.toNat) := by bv_compare'

theorem mul_of_udiv_thm (x : BitVec 8) : x / 12#8 * 6#8 = x >>> 1 := by bv_compare'

theorem mul_of_sdiv_thm (x : BitVec 8) :
  some (x.sdiv 12#8 * 250#8) ⊑
    if (-signExtend 9 (x.sshiftRight 1)).msb = (-signExtend 9 (x.sshiftRight 1)).getMsbD 1 then some (-x.sshiftRight 1)
    else none := by bv_compare'

theorem mul_of_udiv_fail_bad_remainder_thm (x : BitVec 8) :
  some (x / 11#8 * 6#8) ⊑
    if twoPow 16 7 <<< 1 ≤ setWidth 16 (x / 11#8) * 6#16 then none else some (x / 11#8 * 6#8) := by bv_compare'

theorem mul_of_sdiv_fail_ub_thm (x : BitVec 8) : x.sdiv 6#8 * 250#8 = -x := by bv_compare'

