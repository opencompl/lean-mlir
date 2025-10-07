
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

theorem test5_thm.extracted_1._2 : ∀ (x : BitVec 8) (x_1 : BitVec 32),
  ¬(zeroExtend 32 x ≥ ↑32 ∨ 32#32 <<< zeroExtend 32 x = 0) →
    ¬(True ∧ x.msb = true ∨ True ∧ 32#32 <<< zeroExtend 32 x >>> zeroExtend 32 x ≠ 32#32 ∨ zeroExtend 32 x ≥ ↑32) →
      x_1 % 32#32 <<< zeroExtend 32 x = x_1 &&& 32#32 <<< zeroExtend 32 x + -1#32 :=
sorry