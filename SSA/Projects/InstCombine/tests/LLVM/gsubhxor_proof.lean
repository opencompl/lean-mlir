
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gsubhxor_proof
theorem low_mask_nsw_nuw_thm (x : BitVec 32) : 63#32 - (x &&& 31#32) = x &&& 31#32 ^^^ 63#32 := sorry

theorem xor_add_thm (x : BitVec 32) : (x &&& 31#32 ^^^ 31#32) + 42#32 = 73#32 - (x &&& 31#32) := sorry

