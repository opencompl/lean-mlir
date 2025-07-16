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

theorem test_thm.extracted_1._2 : ∀ (x : BitVec 31),
  ¬15#32 ≥ ↑32 →
    ¬(True ∧ (zeroExtend 32 x).uaddOverflow 16384#32 = true ∨ 15#32 ≥ ↑32) →
      truncate 16 ((signExtend 32 x + 16384#32) >>> 15#32) = truncate 16 ((zeroExtend 32 x + 16384#32) >>> 15#32) :=
sorry