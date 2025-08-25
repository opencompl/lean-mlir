
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

theorem shl_ashr_pow2_const_case1_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 6#16 ≥ ↑16) → ¬ofBool (x == 7#16) = 1#1 → (4#16 <<< x).sshiftRight' 6#16 &&& 8#16 = 0#16 :=
sorry