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

theorem sext_thm.extracted_1._1 : ∀ (x : BitVec 4),
  ¬(True ∧ (zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8))).saddOverflow (BitVec.ofInt 7 (-8)) = true) →
    zeroExtend 7 (x ^^^ BitVec.ofInt 4 (-8)) + BitVec.ofInt 7 (-8) = signExtend 7 x :=
sorry