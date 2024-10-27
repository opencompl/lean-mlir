
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gudivremhchangehwidth_proof
theorem udiv_i8_thm (x x_1 : BitVec 8) :
  (Option.bind (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 / setWidth 32 x)) fun x' =>
      some (setWidth 8 x')) ⊑
    if x = 0#8 then none else some (x_1 / x) := by bv_compare'

theorem urem_i8_thm (x x_1 : BitVec 8) :
  (Option.bind (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 % setWidth 32 x)) fun x' =>
      some (setWidth 8 x')) ⊑
    if x = 0#8 then none else some (x_1 % x) := by bv_compare'

theorem udiv_i32_thm (x x_1 : BitVec 8) :
  (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 / setWidth 32 x)) ⊑
    Option.bind (if x = 0#8 then none else some (x_1 / x)) fun x' => some (setWidth 32 x') := by bv_compare'

theorem udiv_i32_multiuse_thm (x x_1 : BitVec 8) :
  (Option.bind (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 / setWidth 32 x)) fun a =>
      some (a * (setWidth 32 x_1 + setWidth 32 x))) ⊑
    Option.bind (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 / setWidth 32 x)) fun a =>
      (if
              (setWidth 32 x_1).msb = (setWidth 32 x).msb ∧
                ¬(setWidth 32 x_1 + setWidth 32 x).msb = (setWidth 32 x_1).msb then
            none
          else
            if setWidth 32 x_1 + setWidth 32 x < setWidth 32 x_1 ∨ setWidth 32 x_1 + setWidth 32 x < setWidth 32 x then
              none
            else some (setWidth 32 x_1 + setWidth 32 x)).bind
        fun y' =>
        if
            signExtend 64 a * signExtend 64 y' < signExtend 64 (twoPow 32 31) ∨
              twoPow 64 31 ≤ signExtend 64 a * signExtend 64 y' then
          none
        else if twoPow 64 31 <<< 1 ≤ setWidth 64 a * setWidth 64 y' then none else some (a * y') := by bv_compare'

theorem udiv_illegal_type_thm (x x_1 : BitVec 9) :
  (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 / setWidth 32 x)) ⊑
    Option.bind (if x = 0#9 then none else some (x_1 / x)) fun x' => some (setWidth 32 x') := by bv_compare'

theorem urem_i32_thm (x x_1 : BitVec 8) :
  (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 % setWidth 32 x)) ⊑
    Option.bind (if x = 0#8 then none else some (x_1 % x)) fun x' => some (setWidth 32 x') := by bv_compare'

theorem urem_i32_multiuse_thm (x x_1 : BitVec 8) :
  (Option.bind (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 % setWidth 32 x)) fun a =>
      some (a * (setWidth 32 x_1 + setWidth 32 x))) ⊑
    Option.bind (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 % setWidth 32 x)) fun a =>
      (if
              (setWidth 32 x_1).msb = (setWidth 32 x).msb ∧
                ¬(setWidth 32 x_1 + setWidth 32 x).msb = (setWidth 32 x_1).msb then
            none
          else
            if setWidth 32 x_1 + setWidth 32 x < setWidth 32 x_1 ∨ setWidth 32 x_1 + setWidth 32 x < setWidth 32 x then
              none
            else some (setWidth 32 x_1 + setWidth 32 x)).bind
        fun y' =>
        if
            signExtend 64 a * signExtend 64 y' < signExtend 64 (twoPow 32 31) ∨
              twoPow 64 31 ≤ signExtend 64 a * signExtend 64 y' then
          none
        else if twoPow 64 31 <<< 1 ≤ setWidth 64 a * setWidth 64 y' then none else some (a * y') := by bv_compare'

theorem urem_illegal_type_thm (x x_1 : BitVec 9) :
  (if setWidth 32 x = 0#32 then none else some (setWidth 32 x_1 % setWidth 32 x)) ⊑
    Option.bind (if x = 0#9 then none else some (x_1 % x)) fun x' => some (setWidth 32 x') := by bv_compare'

theorem udiv_i32_c_thm (x : BitVec 8) : setWidth 32 x / 10#32 = setWidth 32 (x / 10#8) := by bv_compare'

theorem udiv_i32_c_multiuse_thm (x : BitVec 8) :
  some (setWidth 32 x + setWidth 32 x / 10#32) ⊑
    if
        (setWidth 32 x / 10#32).msb = (setWidth 32 x).msb ∧
          ¬(setWidth 32 x / 10#32 + setWidth 32 x).msb = (setWidth 32 x / 10#32).msb then
      none
    else
      if
          setWidth 32 x / 10#32 + setWidth 32 x < setWidth 32 x / 10#32 ∨
            setWidth 32 x / 10#32 + setWidth 32 x < setWidth 32 x then
        none
      else some (setWidth 32 x / 10#32 + setWidth 32 x) := by bv_compare'

theorem udiv_illegal_type_c_thm (x : BitVec 9) : setWidth 32 x / 10#32 = setWidth 32 (x / 10#9) := by bv_compare'

theorem urem_i32_c_thm (x : BitVec 8) : setWidth 32 x % 10#32 = setWidth 32 (x % 10#8) := by bv_compare'

theorem urem_i32_c_multiuse_thm (x : BitVec 8) :
  some (setWidth 32 x + setWidth 32 x % 10#32) ⊑
    if
        (setWidth 32 x % 10#32).msb = (setWidth 32 x).msb ∧
          ¬(setWidth 32 x % 10#32 + setWidth 32 x).msb = (setWidth 32 x % 10#32).msb then
      none
    else
      if
          setWidth 32 x % 10#32 + setWidth 32 x < setWidth 32 x % 10#32 ∨
            setWidth 32 x % 10#32 + setWidth 32 x < setWidth 32 x then
        none
      else some (setWidth 32 x % 10#32 + setWidth 32 x) := by bv_compare'

theorem urem_illegal_type_c_thm (x : BitVec 9) : setWidth 32 x % 10#32 = setWidth 32 (x % 10#9) := by bv_compare'

theorem udiv_c_i32_thm (x : BitVec 8) :
  (if setWidth 32 x = 0#32 then none else some (10#32 / setWidth 32 x)) ⊑
    Option.bind (if x = 0#8 then none else some (10#8 / x)) fun x' => some (setWidth 32 x') := by bv_compare'

theorem urem_c_i32_thm (x : BitVec 8) :
  (if setWidth 32 x = 0#32 then none else some (10#32 % setWidth 32 x)) ⊑
    Option.bind (if x = 0#8 then none else some (10#8 % x)) fun x' => some (setWidth 32 x') := by bv_compare'

