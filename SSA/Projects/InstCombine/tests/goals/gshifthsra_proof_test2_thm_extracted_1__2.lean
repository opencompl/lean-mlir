
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

theorem test2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬3#32 ≥ ↑32 →
    ¬(True ∧ (zeroExtend 32 x).saddOverflow 7#32 = true ∨
          True ∧ (zeroExtend 32 x).uaddOverflow 7#32 = true ∨ 3#32 ≥ ↑32) →
      (zeroExtend 32 x + 7#32).sshiftRight' 3#32 = (zeroExtend 32 x + 7#32) >>> 3#32 :=
sorry