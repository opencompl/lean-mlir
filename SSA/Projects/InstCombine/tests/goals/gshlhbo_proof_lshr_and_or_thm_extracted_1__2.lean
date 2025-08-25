
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

theorem lshr_and_or_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 2#8 ≥ ↑8 ∨ 2#8 ≥ ↑8) →
    ¬((42#8 == 0 || 8 != 1 && x_1 == intMin 8 && 42#8 == -1) = true ∨ 2#8 ≥ ↑8) →
      (x_1.srem 42#8 ||| x >>> 2#8 &&& 13#8) <<< 2#8 = x &&& 52#8 ||| x_1.srem 42#8 <<< 2#8 :=
sorry