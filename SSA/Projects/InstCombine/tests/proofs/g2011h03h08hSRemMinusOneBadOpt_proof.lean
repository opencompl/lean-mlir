
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec

section g2011h03h08hSRemMinusOneBadOpt_proof
theorem test_thm (x : BitVec 64) :
  Option.map (fun div => (setWidth 32 x ||| 4294967294#32) - div * 4294967295#32)
      (if setWidth 32 x ||| 4294967294#32 = intMin 32 then none
      else some ((setWidth 32 x ||| 4294967294#32).sdiv 4294967295#32)) ⊑
    some 0#32 := by bv_compare'

