
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

theorem zext_lshr_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬4#16 ≥ ↑16 →
    ¬(4#8 ≥ ↑8 ∨ True ∧ (x >>> 4#8 &&& x).msb = true) →
      zeroExtend 16 x >>> 4#16 &&& zeroExtend 16 x = zeroExtend 16 (x >>> 4#8 &&& x) :=
sorry