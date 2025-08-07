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

theorem lshr_sext_i1_to_i16_thm.extracted_1._2 : ∀ (x : BitVec 1),
  ¬4#16 ≥ ↑16 → ¬x = 1#1 → signExtend 16 x >>> 4#16 = 0#16 :=
sorry