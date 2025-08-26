
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

theorem test3_thm.extracted_1._4 : ∀ (x : BitVec 1) (x_1 : BitVec 59),
  ¬x = 1#1 → ¬4096#59 = 0 → ¬12#59 ≥ ↑59 → x_1 / 4096#59 = x_1 >>> 12#59 :=
sorry