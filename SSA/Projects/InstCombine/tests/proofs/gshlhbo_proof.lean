
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gshlhbo_proof
theorem lshr_add_thm (x x_1 : BitVec 8) :
  (x_1 &&& 224#8) + (x - x.sdiv 42#8 * 42#8) <<< 5 = x_1 + (x - x.sdiv 42#8 * 42#8) <<< 5 &&& 224#8 := sorry

theorem lshr_sub_thm (x x_1 : BitVec 8) :
  some ((x_1 - x_1.sdiv 42#8 * 42#8 - x >>> 3) <<< 3) ⊑
    (if
            (signExtend 9 (x_1 - x_1.sdiv 42#8 * 42#8) - signExtend 9 (x >>> 3)).msb =
              (signExtend 9 (x_1 - x_1.sdiv 42#8 * 42#8) - signExtend 9 (x >>> 3)).getMsbD 1 then
          some (x_1 - x_1.sdiv 42#8 * 42#8 - x >>> 3)
        else none).bind
      fun x' => some (x' <<< 3) := sorry

theorem lshr_and_thm (x x_1 : BitVec 8) :
  (x_1 >>> 6 &&& x - x.sdiv 42#8 * 42#8) <<< 6 = x_1 &&& (x - x.sdiv 42#8 * 42#8) <<< 6 := sorry

theorem lshr_or_thm (x x_1 : BitVec 8) :
  (x_1 - x_1.sdiv 42#8 * 42#8 ||| x >>> 4) <<< 4 = x &&& 240#8 ||| (x_1 - x_1.sdiv 42#8 * 42#8) <<< 4 := sorry

theorem lshr_xor_thm (x x_1 : BitVec 8) :
  (x_1 >>> 3 ^^^ x - x.sdiv 42#8 * 42#8) <<< 3 = x_1 &&& 248#8 ^^^ (x - x.sdiv 42#8 * 42#8) <<< 3 := sorry

theorem lshr_and_add_thm (x x_1 : BitVec 8) :
  (x_1 - x_1.sdiv 42#8 * 42#8) <<< 3 + (x >>> 3 &&& 12#8) <<< 3 =
    (x &&& 96#8) + (x_1 - x_1.sdiv 42#8 * 42#8) <<< 3 := sorry

theorem lshr_and_sub_thm (x x_1 : BitVec 8) :
  some ((x_1 - x_1.sdiv 42#8 * 42#8 - (x >>> 2 &&& 13#8)) <<< 2) ⊑
    (if
            (signExtend 9 (x_1 - x_1.sdiv 42#8 * 42#8) - signExtend 9 (x >>> 2 &&& 13#8)).msb =
              (signExtend 9 (x_1 - x_1.sdiv 42#8 * 42#8) - signExtend 9 (x >>> 2 &&& 13#8)).getMsbD 1 then
          some (x_1 - x_1.sdiv 42#8 * 42#8 - (x >>> 2 &&& 13#8))
        else none).bind
      fun x' => some (x' <<< 2) := sorry

theorem lshr_and_and_thm (x x_1 : BitVec 8) :
  (x_1 >>> 2 &&& 13#8 &&& x - x.sdiv 42#8 * 42#8) <<< 2 = x_1 &&& 52#8 &&& (x - x.sdiv 42#8 * 42#8) <<< 2 := sorry

theorem lshr_and_or_thm (x x_1 : BitVec 8) :
  (x_1 - x_1.sdiv 42#8 * 42#8 ||| x >>> 2 &&& 13#8) <<< 2 = x &&& 52#8 ||| (x_1 - x_1.sdiv 42#8 * 42#8) <<< 2 := sorry

theorem lshr_and_or_disjoint_thm (x x_1 : BitVec 8) :
  (x_1 - x_1.sdiv 42#8 * 42#8 ||| x >>> 2 &&& 13#8) <<< 2 = x &&& 52#8 ||| (x_1 - x_1.sdiv 42#8 * 42#8) <<< 2 := sorry

theorem ashr_and_or_disjoint_thm (x x_1 : BitVec 8) :
  (x_1 - x_1.sdiv 42#8 * 42#8 ||| x.sshiftRight 2 &&& 13#8) <<< 2 =
    x &&& 52#8 ||| (x_1 - x_1.sdiv 42#8 * 42#8) <<< 2 := sorry

theorem lshr_and_xor_thm (x x_1 : BitVec 8) :
  (x_1 >>> 2 &&& 13#8 ^^^ x - x.sdiv 42#8 * 42#8) <<< 2 = x_1 &&& 52#8 ^^^ (x - x.sdiv 42#8 * 42#8) <<< 2 := sorry

theorem lshr_add_and_shl_thm (x x_1 : BitVec 32) : x_1 <<< 5 + (x >>> 5 &&& 127#32) <<< 5 = (x &&& 4064#32) + x_1 <<< 5 := sorry

theorem shl_add_and_lshr_thm (x : BitVec 32) : (x >>> 4 &&& 8#32) <<< 4 = x &&& 128#32 := sorry

