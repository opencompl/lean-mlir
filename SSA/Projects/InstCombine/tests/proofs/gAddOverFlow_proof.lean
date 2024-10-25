
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gAddOverFlow_proof
theorem oppositesign_thm (x x_1 : BitVec 16) :
  some ((x_1 ||| 32768#16) + (x &&& 32767#16)) ⊑
    if
        (x_1.msb || (32768#16).msb) = (x.msb && (32767#16).msb) ∧
          ¬((x_1 ||| 32768#16) + (x &&& 32767#16)).msb = (x_1.msb || (32768#16).msb) then
      none
    else some ((x_1 ||| 32768#16) + (x &&& 32767#16)) := by bv_compare'

theorem zero_sign_bit_thm (x : BitVec 16) :
  some ((x &&& 32767#16) + 512#16) ⊑
    if (x &&& 32767#16) + 512#16 < x &&& 32767#16 ∨ (x &&& 32767#16) + 512#16 < 512#16 then none
    else some ((x &&& 32767#16) + 512#16) := by bv_compare'

theorem zero_sign_bit2_thm (x x_1 : BitVec 16) :
  some ((x_1 &&& 32767#16) + (x &&& 32767#16)) ⊑
    if
        (x_1 &&& 32767#16) + (x &&& 32767#16) < x_1 &&& 32767#16 ∨
          (x_1 &&& 32767#16) + (x &&& 32767#16) < x &&& 32767#16 then
      none
    else some ((x_1 &&& 32767#16) + (x &&& 32767#16)) := by bv_compare'

theorem ripple_nsw1_thm (x x_1 : BitVec 16) :
  some ((x_1 &&& 1#16) + (x &&& 49151#16)) ⊑
    if (x.msb = true → (49151#16).msb = false) ∧ ((x_1 &&& 1#16) + (x &&& 49151#16)).msb = true then none
    else
      if (x_1 &&& 1#16) + (x &&& 49151#16) < x_1 &&& 1#16 ∨ (x_1 &&& 1#16) + (x &&& 49151#16) < x &&& 49151#16 then none
      else some ((x_1 &&& 1#16) + (x &&& 49151#16)) := by bv_compare'

theorem ripple_nsw2_thm (x x_1 : BitVec 16) :
  some ((x_1 &&& 49151#16) + (x &&& 1#16)) ⊑
    if
        (x_1.msb = true → (49151#16).msb = false) ∧
          ¬((x_1 &&& 49151#16) + (x &&& 1#16)).msb = (x_1.msb && (49151#16).msb) then
      none
    else
      if (x_1 &&& 49151#16) + (x &&& 1#16) < x_1 &&& 49151#16 ∨ (x_1 &&& 49151#16) + (x &&& 1#16) < x &&& 1#16 then none
      else some ((x_1 &&& 49151#16) + (x &&& 1#16)) := by bv_compare'

theorem ripple_nsw3_thm (x x_1 : BitVec 16) :
  some ((x_1 &&& 43691#16) + (x &&& 21843#16)) ⊑
    if
        (x_1.msb && (43691#16).msb) = (x.msb && (21843#16).msb) ∧
          ¬((x_1 &&& 43691#16) + (x &&& 21843#16)).msb = (x_1.msb && (43691#16).msb) then
      none
    else
      if
          (x_1 &&& 43691#16) + (x &&& 21843#16) < x_1 &&& 43691#16 ∨
            (x_1 &&& 43691#16) + (x &&& 21843#16) < x &&& 21843#16 then
        none
      else some ((x_1 &&& 43691#16) + (x &&& 21843#16)) := by bv_compare'

theorem ripple_nsw4_thm (x x_1 : BitVec 16) :
  some ((x_1 &&& 21843#16) + (x &&& 43691#16)) ⊑
    if
        (x_1.msb && (21843#16).msb) = (x.msb && (43691#16).msb) ∧
          ¬((x_1 &&& 21843#16) + (x &&& 43691#16)).msb = (x_1.msb && (21843#16).msb) then
      none
    else
      if
          (x_1 &&& 21843#16) + (x &&& 43691#16) < x_1 &&& 21843#16 ∨
            (x_1 &&& 21843#16) + (x &&& 43691#16) < x &&& 43691#16 then
        none
      else some ((x_1 &&& 21843#16) + (x &&& 43691#16)) := by bv_compare'

theorem ripple_nsw5_thm (x x_1 : BitVec 16) :
  some ((x_1 ||| 43691#16) + (x ||| 54613#16)) ⊑
    if
        (x_1.msb || (43691#16).msb) = (x.msb || (54613#16).msb) ∧
          ¬((x_1 ||| 43691#16) + (x ||| 54613#16)).msb = (x_1.msb || (43691#16).msb) then
      none
    else some ((x_1 ||| 43691#16) + (x ||| 54613#16)) := by bv_compare'

theorem ripple_nsw6_thm (x x_1 : BitVec 16) :
  some ((x_1 ||| 54613#16) + (x ||| 43691#16)) ⊑
    if
        (x_1.msb || (54613#16).msb) = (x.msb || (43691#16).msb) ∧
          ¬((x_1 ||| 54613#16) + (x ||| 43691#16)).msb = (x_1.msb || (54613#16).msb) then
      none
    else some ((x_1 ||| 54613#16) + (x ||| 43691#16)) := by bv_compare'

theorem ripple_no_nsw2_thm (x x_1 : BitVec 16) :
  some ((x_1 &&& 1#16) + (x &&& 32767#16)) ⊑
    if (x_1 &&& 1#16) + (x &&& 32767#16) < x_1 &&& 1#16 ∨ (x_1 &&& 1#16) + (x &&& 32767#16) < x &&& 32767#16 then none
    else some ((x_1 &&& 1#16) + (x &&& 32767#16)) := by bv_compare'

theorem PR38021_thm (x : BitVec 8) :
  some (x >>> 3 + 193#8) ⊑
    if (193#8).msb = false ∧ (x >>> 3 + 193#8).msb = true then none
    else if x >>> 3 + 193#8 < x >>> 3 ∨ x >>> 3 + 193#8 < 193#8 then none else some (x >>> 3 + 193#8) := by bv_compare'

