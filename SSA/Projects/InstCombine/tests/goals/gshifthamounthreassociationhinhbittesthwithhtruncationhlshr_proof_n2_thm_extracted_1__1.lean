
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

theorem n2_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬(32#32 - x_1 ≥ ↑32 ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64) →
    32#32 - x_1 ≥ ↑32 ∨
        True ∧ (x_1 + BitVec.ofInt 32 (-16)).msb = true ∨ zeroExtend 64 (x_1 + BitVec.ofInt 32 (-16)) ≥ ↑64 →
      False :=
sorry