
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

theorem or_basic_commuted_thm.extracted_1._1 : ∀ (x : BitVec 16),
  ofBool (x &&& BitVec.ofInt 16 (-256) != 32512#16) ||| ofBool (truncate 8 x != 69#8) = ofBool (x != 32581#16) :=
sorry