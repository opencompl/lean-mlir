
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshifthlogic_proof
theorem shl_and_thm (x x_1 : BitVec 8) : (x_1 <<< 3 &&& x) <<< 2 = x_1 <<< 5 &&& x <<< 2 := sorry

theorem shl_or_thm (x x_1 : BitVec 16) :
  some ((x_1 - x_1.sdiv 42#16 * 42#16 ||| x <<< 5) <<< 7) ⊑
    (if ((x_1 - x_1.sdiv 42#16 * 42#16) <<< 7).sshiftRight 7 = x_1 - x_1.sdiv 42#16 * 42#16 then none
        else some ((x_1 - x_1.sdiv 42#16 * 42#16) <<< 7)).bind
      fun y' => some (x <<< 12 ||| y') := sorry

theorem shl_xor_thm (x x_1 : BitVec 32) : (x_1 <<< 5 ^^^ x) <<< 7 = x_1 <<< 12 ^^^ x <<< 7 := sorry

theorem lshr_and_thm (x x_1 : BitVec 64) :
  (x_1 - x_1.sdiv 42#64 * 42#64 &&& x >>> 5) >>> 7 = x >>> 12 &&& (x_1 - x_1.sdiv 42#64 * 42#64) >>> 7 := sorry

theorem ashr_xor_thm (x x_1 : BitVec 32) :
  (x_1 - x_1.sdiv 42#32 * 42#32 ^^^ x.sshiftRight 5).sshiftRight 7 =
    x.sshiftRight 12 ^^^ (x_1 - x_1.sdiv 42#32 * 42#32).sshiftRight 7 := sorry

theorem lshr_mul_thm (x : BitVec 64) :
  ((if twoPow 128 63 <<< 1 ≤ setWidth 128 x * 52#128 then none else some (x * 52#64)).bind fun x' => some (x' >>> 2)) ⊑
    if signExtend 128 x * 13#128 < signExtend 128 (twoPow 64 63) ∨ twoPow 128 63 ≤ signExtend 128 x * 13#128 then none
    else if twoPow 128 63 <<< 1 ≤ setWidth 128 x * 13#128 then none else some (x * 13#64) := sorry

theorem lshr_mul_nuw_nsw_thm (x : BitVec 64) :
  ((if signExtend 128 x * 52#128 < signExtend 128 (twoPow 64 63) ∨ twoPow 128 63 ≤ signExtend 128 x * 52#128 then none
        else if twoPow 128 63 <<< 1 ≤ setWidth 128 x * 52#128 then none else some (x * 52#64)).bind
      fun x' => some (x' >>> 2)) ⊑
    if signExtend 128 x * 13#128 < signExtend 128 (twoPow 64 63) ∨ twoPow 128 63 ≤ signExtend 128 x * 13#128 then none
    else if twoPow 128 63 <<< 1 ≤ setWidth 128 x * 13#128 then none else some (x * 13#64) := sorry

theorem shl_sub_thm (x x_1 : BitVec 8) : (x_1 <<< 3 - x) <<< 2 = x_1 <<< 5 - x <<< 2 := sorry

theorem shl_sub_no_commute_thm (x x_1 : BitVec 8) : (x_1 - x <<< 3) <<< 2 = x_1 <<< 2 - x <<< 5 := sorry

