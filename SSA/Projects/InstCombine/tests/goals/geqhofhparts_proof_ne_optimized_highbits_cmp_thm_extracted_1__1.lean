
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

theorem ne_optimized_highbits_cmp_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (16777215#32 <ᵤ x_1 ^^^ x) ||| ofBool (truncate 24 x != truncate 24 x_1) = ofBool (x_1 != x) :=
sorry