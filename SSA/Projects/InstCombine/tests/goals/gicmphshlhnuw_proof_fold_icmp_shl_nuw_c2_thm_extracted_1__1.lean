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

theorem fold_icmp_shl_nuw_c2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(True ∧ 16#32 <<< x >>> x ≠ 16#32 ∨ x ≥ ↑32) → ofBool (16#32 <<< x <ᵤ 64#32) = ofBool (x <ᵤ 2#32) :=
sorry