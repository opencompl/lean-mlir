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

theorem foo_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬ofBool (zeroExtend 32 (x &&& 255#16) <ᵤ 255#32) = 1#1 → truncate 16 255#32 &&& 255#16 = x &&& 255#16 :=
sorry