
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

theorem prove_exact_with_high_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(BitVec.ofInt 8 (-4) == 0 || 8 != 1 && x &&& BitVec.ofInt 8 (-32) == intMin 8 && BitVec.ofInt 8 (-4) == -1) = true →
    2#8 ≥ ↑8 ∨ True ∧ (0#8).ssubOverflow (x.sshiftRight' 2#8 &&& BitVec.ofInt 8 (-8)) = true → False :=
sorry