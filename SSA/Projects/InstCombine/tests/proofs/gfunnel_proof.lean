
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gfunnel_proof
theorem unmasked_shlop_insufficient_mask_shift_amount_thm (x x_1 x_2 : BitVec 16) :
  (Option.bind
      (if 16#16 ≤ 8#16 - (x_1 &&& 15#16) then none else some (x_2 <<< ((65536 - (x_1.toNat &&& 15) + 8) % 65536)))
      fun a =>
      Option.bind (if 16#16 ≤ x_1 &&& 15#16 then none else some ((x &&& 255#16) >>> (x_1.toNat &&& 15))) fun x =>
        some (setWidth 8 a ||| setWidth 8 x)) ⊑
    (if (8#17 - signExtend 17 (x_1 &&& 15#16)).msb = (8#17 - signExtend 17 (x_1 &&& 15#16)).getMsbD 1 then
          some (8#16 - (x_1 &&& 15#16))
        else none).bind
      fun a =>
      Option.bind (if 16#16 ≤ a then none else some (x_2 <<< a.toNat)) fun a =>
        Option.bind (if 16#16 ≤ x_1 &&& 15#16 then none else some ((x &&& 255#16) >>> (x_1.toNat &&& 15))) fun x =>
          some (setWidth 8 a ||| setWidth 8 x) := by bv_compare'

