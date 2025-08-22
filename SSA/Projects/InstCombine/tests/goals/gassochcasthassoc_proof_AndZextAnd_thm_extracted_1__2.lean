
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

theorem AndZextAnd_thm.extracted_1._2 : ∀ (x : BitVec 3),
  ¬(True ∧ (x &&& 2#3).msb = true) → zeroExtend 5 (x &&& 3#3) &&& 14#5 = zeroExtend 5 (x &&& 2#3) :=
sorry