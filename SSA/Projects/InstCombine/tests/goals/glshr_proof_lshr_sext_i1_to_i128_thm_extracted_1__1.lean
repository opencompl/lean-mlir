
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

theorem lshr_sext_i1_to_i128_thm.extracted_1._1 : ∀ (x : BitVec 1),
  ¬42#128 ≥ ↑128 → x = 1#1 → signExtend 128 x >>> 42#128 = 77371252455336267181195263#128 :=
sorry