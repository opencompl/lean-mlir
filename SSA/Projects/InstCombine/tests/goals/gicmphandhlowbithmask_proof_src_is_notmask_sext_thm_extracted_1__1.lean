
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

theorem src_is_notmask_sext_thm.extracted_1._1 : ∀ (x : BitVec 8) (x_1 : BitVec 16),
  ¬x ≥ ↑8 →
    ofBool (x_1 ^^^ 123#16 ≤ᵤ (signExtend 16 (BitVec.ofInt 8 (-8) <<< x) ^^^ -1#16) &&& (x_1 ^^^ 123#16)) =
      ofBool (signExtend 16 (BitVec.ofInt 8 (-8) <<< x) ≤ᵤ x_1 ^^^ BitVec.ofInt 16 (-128)) :=
sorry