
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

theorem fold_icmp_shl_nuw_c1_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(12#32 ≥ ↑32 ∨
        True ∧ 2#32 <<< (x >>> 12#32 &&& 15#32) >>> (x >>> 12#32 &&& 15#32) ≠ 2#32 ∨ x >>> 12#32 &&& 15#32 ≥ ↑32) →
    ofBool (2#32 <<< (x >>> 12#32 &&& 15#32) <ᵤ 4#32) = ofBool (x &&& 61440#32 == 0#32) :=
sorry