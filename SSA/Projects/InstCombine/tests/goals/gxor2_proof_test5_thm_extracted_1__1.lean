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

theorem test5_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬8#32 ≥ ↑32 → ((x ^^^ 1234#32) >>> 8#32 ^^^ 1#32) + (x ^^^ 1234#32) = (x >>> 8#32 ^^^ 5#32) + (x ^^^ 1234#32) :=
sorry