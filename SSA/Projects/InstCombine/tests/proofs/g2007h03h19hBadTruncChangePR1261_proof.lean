
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2007h03h19hBadTruncChangePR1261_proof
theorem test_thm (x : BitVec 31) :
  some (setWidth 16 ((signExtend 32 x + 16384#32) >>> 15)) ⊑
    (if setWidth 32 x + 16384#32 < setWidth 32 x ∨ setWidth 32 x + 16384#32 < 16384#32 then none
        else some (setWidth 32 x + 16384#32)).bind
      fun x => some (setWidth 16 (x >>> 15)) := sorry

