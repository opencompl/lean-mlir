 -- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

theorem test94_thm.extracted_1._1 : ∀ (x : BitVec 32),
  signExtend 64 (signExtend 8 (ofBool (x == BitVec.ofInt 32 (-2))) ^^^ -1#8) =
    signExtend 64 (ofBool (x != BitVec.ofInt 32 (-2))) :=
sorry