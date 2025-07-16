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

theorem lshr_xor_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(3#8 ≥ ↑8 ∨ (42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 3#8 ≥ ↑8) →
    ¬((42#8 == 0 || 8 != 1 && x == intMin 8 && 42#8 == -1) = true ∨ 3#8 ≥ ↑8) →
      (x_1 >>> 3#8 ^^^ x.srem 42#8) <<< 3#8 = x_1 &&& BitVec.ofInt 8 (-8) ^^^ x.srem 42#8 <<< 3#8 :=
sorry