
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

theorem shl_lshr_pow2_not_const_case2_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 3#16 ≥ ↑16) → ¬ofBool (x == 2#16) = 1#1 → 16#16 <<< x >>> 3#16 &&& 8#16 ^^^ 8#16 = 8#16 :=
sorry