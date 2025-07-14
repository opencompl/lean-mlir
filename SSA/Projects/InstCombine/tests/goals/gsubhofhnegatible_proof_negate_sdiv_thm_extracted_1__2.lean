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

theorem negate_sdiv_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true →
    ¬(BitVec.ofInt 8 (-42) == 0 || 8 != 1 && x == intMin 8 && BitVec.ofInt 8 (-42) == -1) = true →
      x_1 - x.sdiv 42#8 = x.sdiv (BitVec.ofInt 8 (-42)) + x_1 :=
sorry