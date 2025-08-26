
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

theorem signed_sign_bit_extract_trunc_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬63#64 ≥ ↑64 → ofBool (truncate 32 (x.sshiftRight' 63#64) != 0#32) = ofBool (x <ₛ 0#64) :=
sorry