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

theorem test13_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(3#32 ≥ ↑32 ∨ True ∧ (x >>> 3#32 &&& 1#32).saddOverflow (-1#32) = true) →
    signExtend 32 (ofBool (x &&& 8#32 == 0#32)) = (x >>> 3#32 &&& 1#32) + -1#32 :=
sorry