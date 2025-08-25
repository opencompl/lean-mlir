
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

theorem add_nsw_poison_constant_fold_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬(True ∧ (65#8).saddOverflow 64#8 = true) → 65#8 + 64#8 = BitVec.ofInt 8 (-127) :=
sorry