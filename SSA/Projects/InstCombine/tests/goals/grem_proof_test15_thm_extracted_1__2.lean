
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

theorem test15_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(x ≥ ↑32 ∨ zeroExtend 64 (1#32 <<< x) = 0) →
    ¬(True ∧ ((-1#32) <<< x).sshiftRight' x ≠ -1#32 ∨ x ≥ ↑32 ∨ True ∧ (x_1 &&& ((-1#32) <<< x ^^^ -1#32)).msb = true) →
      zeroExtend 64 x_1 % zeroExtend 64 (1#32 <<< x) = zeroExtend 64 (x_1 &&& ((-1#32) <<< x ^^^ -1#32)) :=
sorry