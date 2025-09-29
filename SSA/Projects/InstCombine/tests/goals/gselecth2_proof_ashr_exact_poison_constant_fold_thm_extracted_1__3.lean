
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

theorem ashr_exact_poison_constant_fold_thm.extracted_1._3 : ∀ (x : BitVec 8) (x_1 : BitVec 1),
  ¬x_1 = 1#1 → ¬(True ∧ 42#8 >>> 3#8 <<< 3#8 ≠ 42#8 ∨ 3#8 ≥ ↑8) → (42#8).sshiftRight' 3#8 = 5#8 :=
sorry