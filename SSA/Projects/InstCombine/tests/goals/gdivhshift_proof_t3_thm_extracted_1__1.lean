
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

theorem t3_thm.extracted_1._1 : ∀ (x : BitVec 32) (x_1 : BitVec 64),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (4#32 <<< x) = 0) → True ∧ (x + 2#32).msb = true ∨ zeroExtend 64 (x + 2#32) ≥ ↑64 → False :=
sorry