
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

theorem multiuse_lshr_lshr_thm.extracted_1._2 : ∀ (x : BitVec 9),
  ¬(2#9 ≥ ↑9 ∨ 2#9 ≥ ↑9 ∨ 3#9 ≥ ↑9) → ¬(2#9 ≥ ↑9 ∨ 5#9 ≥ ↑9) → x >>> 2#9 * x >>> 2#9 >>> 3#9 = x >>> 2#9 * x >>> 5#9 :=
sorry