
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhxor_proof
theorem low_mask_nsw_nuw_thm (x : BitVec 32) : 63#32 - (x &&& 31#32) = x &&& 31#32 ^^^ 63#32 := sorry

theorem arbitrary_mask_sub_i8_thm (x : BitVec 8) :
  some (11#8 - (x &&& 10#8)) ⊑
    if (11#9 - signExtend 9 (x &&& 10#8)).msb = (11#9 - signExtend 9 (x &&& 10#8)).getMsbD 1 then
      if 11#8 < x &&& 10#8 then none else some (11#8 - (x &&& 10#8))
    else none := sorry

theorem not_masked_sub_i8_thm (x : BitVec 8) :
  some (11#8 - (x &&& 7#8)) ⊑
    if (11#9 - signExtend 9 (x &&& 7#8)).msb = (11#9 - signExtend 9 (x &&& 7#8)).getMsbD 1 then
      if 11#8 < x &&& 7#8 then none else some (11#8 - (x &&& 7#8))
    else none := sorry

theorem xor_add_thm (x : BitVec 32) :
  some ((x &&& 31#32 ^^^ 31#32) + 42#32) ⊑
    if (73#33 - signExtend 33 (x &&& 31#32)).msb = (73#33 - signExtend 33 (x &&& 31#32)).getMsbD 1 then
      if 73#32 < x &&& 31#32 then none else some (73#32 - (x &&& 31#32))
    else none := sorry

