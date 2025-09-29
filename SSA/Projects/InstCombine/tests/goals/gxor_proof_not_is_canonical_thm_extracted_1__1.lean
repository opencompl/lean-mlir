
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem not_is_canonical_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 → ((x_1 ^^^ 1073741823#32) + x) <<< 2#32 = (x + (x_1 ^^^ -1#32)) <<< 2#32 :=
sorry