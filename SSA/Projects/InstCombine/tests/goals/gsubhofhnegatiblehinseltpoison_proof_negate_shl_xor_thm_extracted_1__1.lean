
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

theorem negate_shl_xor_thm.extracted_1._1 : ∀ (x x_1 : BitVec 4),
  ¬x ≥ ↑4 → 0#4 - (x_1 ^^^ 5#4) <<< x = ((x_1 ^^^ BitVec.ofInt 4 (-6)) + 1#4) <<< x :=
sorry