
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

theorem eq_commuted_thm.extracted_1._1 : ∀ (x x_1 : BitVec 8),
  ¬(x == 0 || 8 != 1 && 43#8 == intMin 8 && x == -1) = true →
    ofBool (x_1 == 0#8) ||| ofBool ((43#8).sdiv x <ᵤ x_1) = ofBool ((43#8).sdiv x ≤ᵤ x_1 + -1#8) :=
sorry