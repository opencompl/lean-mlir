
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

theorem XorZextXor_thm.extracted_1._1 : ∀ (x : BitVec 3), zeroExtend 5 (x ^^^ 3#3) ^^^ 12#5 = zeroExtend 5 x ^^^ 15#5 :=
sorry