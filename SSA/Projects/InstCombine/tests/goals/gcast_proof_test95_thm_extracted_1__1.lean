
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

theorem test95_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬6#8 ≥ ↑8 →
    6#8 ≥ ↑8 ∨
        True ∧ (truncate 8 x >>> 6#8 &&& 2#8 &&& 40#8 != 0) = true ∨
          True ∧ (truncate 8 x >>> 6#8 &&& 2#8 ||| 40#8).msb = true →
      False :=
sorry