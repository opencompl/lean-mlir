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

theorem sextinreg2_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬(24#32 ≥ ↑32 ∨ True ∧ x <<< 24#32 >>> 24#32 <<< 24#32 ≠ x <<< 24#32 ∨ 24#32 ≥ ↑32) →
    (x &&& 255#32 ^^^ 128#32) + BitVec.ofInt 32 (-128) = (x <<< 24#32).sshiftRight' 24#32 :=
sorry