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

theorem dont_narrow_zext_ashr_keep_trunc_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(True ∧ (signExtend 16 x_1).saddOverflow (signExtend 16 x) = true ∨ 1#16 ≥ ↑16) →
    truncate 8 ((signExtend 16 x_1 + signExtend 16 x).sshiftRight' 1#16) =
      truncate 8 ((signExtend 16 x_1 + signExtend 16 x) >>> 1#16) :=
sorry