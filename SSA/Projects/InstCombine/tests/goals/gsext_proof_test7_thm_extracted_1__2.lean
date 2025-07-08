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

theorem test7_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ (20000#32).ssubOverflow (x &&& 511#32) = true ∨
        True ∧ (20000#32).usubOverflow (x &&& 511#32) = true ∨ True ∧ (20000#32 - (x &&& 511#32)).msb = true) →
    signExtend 64 (20000#32 - (x &&& 511#32)) = zeroExtend 64 (20000#32 - (x &&& 511#32)) :=
sorry