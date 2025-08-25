
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

theorem xor_lshr_multiuse_thm.extracted_1._1 : ∀ (x x_1 x_2 x_3 : BitVec 8),
  ¬(x_2 ≥ ↑8 ∨
        x_2 ≥ ↑8 ∨
          x_2 ≥ ↑8 ∨
            (x_3 >>> x_2 ^^^ x_1 ^^^ x >>> x_2 == 0 ||
                8 != 1 && x_3 >>> x_2 ^^^ x_1 == intMin 8 && x_3 >>> x_2 ^^^ x_1 ^^^ x >>> x_2 == -1) =
              true) →
    x_2 ≥ ↑8 ∨
        x_2 ≥ ↑8 ∨
          ((x_3 ^^^ x) >>> x_2 ^^^ x_1 == 0 ||
              8 != 1 && x_3 >>> x_2 ^^^ x_1 == intMin 8 && (x_3 ^^^ x) >>> x_2 ^^^ x_1 == -1) =
            true →
      False :=
sorry