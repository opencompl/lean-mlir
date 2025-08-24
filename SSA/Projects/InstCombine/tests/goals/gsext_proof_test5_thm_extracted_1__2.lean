
/-
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
-/

theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬30000#32 = 0 →
    ¬(30000#32 = 0 ∨ True ∧ (x % 30000#32).msb = true) → signExtend 64 (x % 30000#32) = zeroExtend 64 (x % 30000#32) :=
sorry