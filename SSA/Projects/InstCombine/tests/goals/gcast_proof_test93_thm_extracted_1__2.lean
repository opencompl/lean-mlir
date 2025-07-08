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

theorem test93_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬64#96 ≥ ↑96 → ¬31#32 ≥ ↑32 → truncate 32 (signExtend 96 x >>> 64#96) = x.sshiftRight' 31#32 :=
sorry