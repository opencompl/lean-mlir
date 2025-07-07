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

theorem test3i_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬(29#32 ≥ ↑32 ∨ 29#32 ≥ ↑32) →
    zeroExtend 32 (ofBool (x_1 >>> 29#32 ||| 35#32 == x >>> 29#32 ||| 35#32)) =
      zeroExtend 32 (ofBool (-1#32 <ₛ x_1 ^^^ x)) :=
sorry