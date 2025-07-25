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

theorem lshr_add_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(5#8 ≥ ↑8 ∨ (42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 5#8 ≥ ↑8) →
    ¬((42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 5#8 ≥ ↑8) →
      (x_1 >>> 5#8 + x.srem 42#8) <<< 5#8 = x_1 + x.srem 42#8 <<< 5#8 &&& BitVec.ofInt 8 (-32) :=
sorry