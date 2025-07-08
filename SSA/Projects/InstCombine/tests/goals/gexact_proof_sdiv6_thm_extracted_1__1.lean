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

theorem sdiv6_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ x.smod 3#32 ≠ 0 ∨ (3#32 == 0 || 32 != 1 && x == intMin 32 && 3#32 == -1) = true) →
    x.sdiv 3#32 * BitVec.ofInt 32 (-3) = 0#32 - x :=
sorry