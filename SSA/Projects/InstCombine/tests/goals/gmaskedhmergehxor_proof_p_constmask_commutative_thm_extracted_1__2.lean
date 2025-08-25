
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

theorem p_constmask_commutative_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬(True ∧ (x_1 &&& BitVec.ofInt 32 (-65281) &&& (x &&& 65280#32) != 0) = true) →
    x_1 &&& BitVec.ofInt 32 (-65281) ^^^ x &&& 65280#32 = x_1 &&& BitVec.ofInt 32 (-65281) ||| x &&& 65280#32 :=
sorry