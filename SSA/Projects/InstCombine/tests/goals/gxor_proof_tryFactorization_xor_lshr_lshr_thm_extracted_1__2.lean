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

theorem tryFactorization_xor_lshr_lshr_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(x ≥ ↑32 ∨ x ≥ ↑32) → ¬x ≥ ↑32 → BitVec.ofInt 32 (-3) >>> x ^^^ 5#32 >>> x = BitVec.ofInt 32 (-8) >>> x :=
sorry