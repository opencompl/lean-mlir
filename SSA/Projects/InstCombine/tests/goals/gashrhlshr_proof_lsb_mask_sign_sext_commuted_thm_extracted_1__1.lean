
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

theorem lsb_mask_sign_sext_commuted_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬31#32 ≥ ↑32 → ((x ^^^ -1#32) &&& x + -1#32).sshiftRight' 31#32 = signExtend 32 (ofBool (x == 0#32)) :=
sorry