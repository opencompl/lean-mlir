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

theorem prove_exact_with_high_mask_limit_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(8#8 == 0 || 8 != 1 && x &&& BitVec.ofInt 8 (-8) == intMin 8 && 8#8 == -1) = true →
    ¬3#8 ≥ ↑8 → (x &&& BitVec.ofInt 8 (-8)).sdiv 8#8 = x.sshiftRight' 3#8 :=
sorry