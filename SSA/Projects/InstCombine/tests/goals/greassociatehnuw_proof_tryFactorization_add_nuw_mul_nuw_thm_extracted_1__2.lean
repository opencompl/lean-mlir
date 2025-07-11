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

theorem tryFactorization_add_nuw_mul_nuw_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(True ∧ x.umulOverflow 3#32 = true ∨ True ∧ (x * 3#32).uaddOverflow x = true) →
    ¬(True ∧ x <<< 2#32 >>> 2#32 ≠ x ∨ 2#32 ≥ ↑32) → x * 3#32 + x = x <<< 2#32 :=
sorry