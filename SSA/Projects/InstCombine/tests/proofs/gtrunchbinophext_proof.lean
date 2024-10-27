
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gtrunchbinophext_proof
theorem narrow_sext_and_thm (x : BitVec 32) (x_1 : BitVec 16) :
  setWidth 16 (signExtend 32 x_1) &&& setWidth 16 x = x_1 &&& setWidth 16 x := sorry

theorem narrow_sext_or_thm (x : BitVec 32) (x_1 : BitVec 16) :
  setWidth 16 (signExtend 32 x_1) ||| setWidth 16 x = x_1 ||| setWidth 16 x := sorry

theorem narrow_sext_xor_thm (x : BitVec 32) (x_1 : BitVec 16) :
  setWidth 16 (signExtend 32 x_1) ^^^ setWidth 16 x = x_1 ^^^ setWidth 16 x := sorry

theorem narrow_sext_add_thm (x : BitVec 32) (x_1 : BitVec 16) :
  setWidth 16 (signExtend 32 x_1 + x) = x_1 + setWidth 16 x := sorry

theorem narrow_zext_add_thm (x : BitVec 32) (x_1 : BitVec 16) : setWidth 16 (setWidth 32 x_1 + x) = x_1 + setWidth 16 x := sorry

theorem narrow_sext_sub_thm (x : BitVec 32) (x_1 : BitVec 16) :
  setWidth 16 (signExtend 32 x_1 - x) = x_1 - setWidth 16 x := sorry

theorem narrow_zext_sub_thm (x : BitVec 32) (x_1 : BitVec 16) : setWidth 16 (setWidth 32 x_1 - x) = x_1 - setWidth 16 x := sorry

theorem narrow_sext_mul_thm (x : BitVec 32) (x_1 : BitVec 16) :
  setWidth 16 (signExtend 32 x_1 * x) = x_1 * setWidth 16 x := sorry

theorem narrow_zext_mul_thm (x : BitVec 32) (x_1 : BitVec 16) : setWidth 16 (setWidth 32 x_1 * x) = x_1 * setWidth 16 x := sorry

theorem narrow_zext_ashr_keep_trunc_thm (x x_1 : BitVec 8) :
  ((if x_1.msb = x.msb ∧ ¬(signExtend 32 x_1 + signExtend 32 x).msb = x_1.msb then none
        else some (signExtend 32 x_1 + signExtend 32 x)).bind
      fun x => some (setWidth 8 (x.sshiftRight 1))) ⊑
    (if x_1.msb = x.msb ∧ ¬(signExtend 16 x_1 + signExtend 16 x).msb = x_1.msb then none
        else some (signExtend 16 x_1 + signExtend 16 x)).bind
      fun x => some (setWidth 8 (x >>> 1)) := sorry

theorem narrow_zext_ashr_keep_trunc2_thm (x x_1 : BitVec 9) :
  ((if x_1.msb = x.msb ∧ ¬(signExtend 64 x_1 + signExtend 64 x).msb = x_1.msb then none
        else some (signExtend 64 x_1 + signExtend 64 x)).bind
      fun x => some (setWidth 8 (x.sshiftRight 1))) ⊑
    (if
            (setWidth 16 x_1).msb = (setWidth 16 x).msb ∧
              ¬(setWidth 16 x_1 + setWidth 16 x).msb = (setWidth 16 x_1).msb then
          none
        else
          if setWidth 16 x_1 + setWidth 16 x < setWidth 16 x_1 ∨ setWidth 16 x_1 + setWidth 16 x < setWidth 16 x then
            none
          else some (setWidth 16 x_1 + setWidth 16 x)).bind
      fun x => some (setWidth 8 (x >>> 1)) := sorry

theorem narrow_zext_ashr_keep_trunc3_thm (x x_1 : BitVec 8) :
  ((if x_1.msb = x.msb ∧ ¬(signExtend 64 x_1 + signExtend 64 x).msb = x_1.msb then none
        else some (signExtend 64 x_1 + signExtend 64 x)).bind
      fun x => some (setWidth 7 (x.sshiftRight 1))) ⊑
    (if
            (setWidth 14 x_1).msb = (setWidth 14 x).msb ∧
              ¬(setWidth 14 x_1 + setWidth 14 x).msb = (setWidth 14 x_1).msb then
          none
        else
          if setWidth 14 x_1 + setWidth 14 x < setWidth 14 x_1 ∨ setWidth 14 x_1 + setWidth 14 x < setWidth 14 x then
            none
          else some (setWidth 14 x_1 + setWidth 14 x)).bind
      fun x => some (setWidth 7 (x >>> 1)) := sorry

theorem dont_narrow_zext_ashr_keep_trunc_thm (x x_1 : BitVec 8) :
  ((if x_1.msb = x.msb ∧ ¬(signExtend 16 x_1 + signExtend 16 x).msb = x_1.msb then none
        else some (signExtend 16 x_1 + signExtend 16 x)).bind
      fun x => some (setWidth 8 (x.sshiftRight 1))) ⊑
    (if x_1.msb = x.msb ∧ ¬(signExtend 16 x_1 + signExtend 16 x).msb = x_1.msb then none
        else some (signExtend 16 x_1 + signExtend 16 x)).bind
      fun x => some (setWidth 8 (x >>> 1)) := sorry

