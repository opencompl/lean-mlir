
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

theorem lshr_shl_pow2_const_xor_thm.extracted_1._2 : ∀ (x : BitVec 16),
  ¬(x ≥ ↑16 ∨ 2#16 ≥ ↑16) → ¬ofBool (x == 7#16) = 1#1 → 256#16 >>> x <<< 2#16 &&& 8#16 ^^^ 8#16 = 8#16 :=
sorry