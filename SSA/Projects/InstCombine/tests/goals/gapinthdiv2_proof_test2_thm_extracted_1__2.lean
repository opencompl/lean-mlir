
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

theorem test2_thm.extracted_1._2 : ∀ (x : BitVec 499),
  ¬(197#499 ≥ ↑499 ∨ 4096#499 <<< 197#499 = 0) → ¬209#499 ≥ ↑499 → x / 4096#499 <<< 197#499 = x >>> 209#499 :=
sorry