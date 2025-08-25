
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

theorem icmp_shl_uge_2_thm.extracted_1._1 : ∀ (x : BitVec 5),
  ¬1#5 ≥ ↑5 → ofBool ((10#5 + x) <<< 1#5 ≤ᵤ 10#5 + x) = ofBool (x + 10#5 <ₛ 1#5) :=
sorry