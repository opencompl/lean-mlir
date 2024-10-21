
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section gavghlsb_proof
theorem avg_lsb_thm (x x_1 : BitVec 8) :
  ((if ((x_1 &&& 1#8) + (x &&& 1#8)).msb = true then none
        else
          if (x_1 &&& 1#8) + (x &&& 1#8) < x_1 &&& 1#8 ∨ (x_1 &&& 1#8) + (x &&& 1#8) < x &&& 1#8 then none
          else some ((x_1 &&& 1#8) + (x &&& 1#8))).bind
      fun a => some (a >>> 1)) ⊑
    some (x_1 &&& (x &&& 1#8)) := sorry

