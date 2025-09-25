
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

theorem or_eq_with_one_bit_diff_constants2_logical_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x == 97#32) = 1#1 → ofBool (x == 65#32) = ofBool (x &&& BitVec.ofInt 32 (-33) == 65#32) :=
sorry