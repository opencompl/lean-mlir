
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

theorem or_eq_with_one_bit_diff_constants3_logical_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ofBool (x == BitVec.ofInt 8 (-2)) = 1#1 → 1#1 = ofBool (x &&& 127#8 == 126#8) :=
sorry