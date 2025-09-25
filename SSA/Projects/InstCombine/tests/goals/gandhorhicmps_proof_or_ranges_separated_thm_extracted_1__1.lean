
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem or_ranges_separated_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (5#8 ≤ᵤ x) &&& ofBool (x ≤ᵤ 10#8) ||| ofBool (12#8 ≤ᵤ x) &&& ofBool (x ≤ᵤ 20#8) =
    ofBool (x + BitVec.ofInt 8 (-5) <ᵤ 6#8) ||| ofBool (x + BitVec.ofInt 8 (-12) <ᵤ 9#8) :=
sorry