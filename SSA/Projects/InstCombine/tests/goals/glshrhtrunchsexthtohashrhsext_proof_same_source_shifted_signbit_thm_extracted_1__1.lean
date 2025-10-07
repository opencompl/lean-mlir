
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

theorem same_source_shifted_signbit_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬24#32 ≥ ↑32 → signExtend 32 (truncate 8 (x >>> 24#32)) = x.sshiftRight' 24#32 :=
sorry