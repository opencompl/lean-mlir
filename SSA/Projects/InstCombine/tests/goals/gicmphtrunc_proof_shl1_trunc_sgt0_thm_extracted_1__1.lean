
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

theorem shl1_trunc_sgt0_thm.extracted_1._1 : ∀ (x : BitVec 9),
  ¬x ≥ ↑9 → True ∧ 1#9 <<< x >>> x ≠ 1#9 ∨ x ≥ ↑9 → False :=
sorry