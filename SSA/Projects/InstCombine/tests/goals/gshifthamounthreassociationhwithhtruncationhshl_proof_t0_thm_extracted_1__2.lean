
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

theorem t0_thm.extracted_1._2 : ∀ (x : BitVec 16) (x_1 : BitVec 32),
  ¬(zeroExtend 32 (32#16 - x) ≥ ↑32 ∨ x + BitVec.ofInt 16 (-24) ≥ ↑16) →
    ¬8#16 ≥ ↑16 →
      truncate 16 (x_1 <<< zeroExtend 32 (32#16 - x)) <<< (x + BitVec.ofInt 16 (-24)) = truncate 16 x_1 <<< 8#16 :=
sorry