
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

theorem no_shift_xor_multiuse_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (0#32 != x_1 &&& 4096#32) = 1#1 →
    ofBool (x_1 &&& 4096#32 == 0#32) = 1#1 →
      x * (x &&& BitVec.ofInt 32 (-4097)) = (x &&& BitVec.ofInt 32 (-4097)) * (x &&& BitVec.ofInt 32 (-4097)) :=
sorry