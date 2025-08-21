
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

theorem test35_with_trunc_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬ofBool (0#32 ≤ₛ truncate 32 x) = 1#1 → ofBool (x &&& 2147483648#64 == 0#64) = 1#1 → 100#32 = 60#32 :=
sorry