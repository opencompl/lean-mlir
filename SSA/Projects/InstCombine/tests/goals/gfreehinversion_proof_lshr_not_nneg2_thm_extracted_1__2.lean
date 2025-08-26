
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

theorem lshr_not_nneg2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬1#8 ≥ ↑8 →
    ¬(1#8 ≥ ↑8 ∨ True ∧ (x >>> 1#8 &&& BitVec.ofInt 8 (-128) != 0) = true) →
      (x ^^^ -1#8) >>> 1#8 ^^^ -1#8 = x >>> 1#8 ||| BitVec.ofInt 8 (-128) :=
sorry