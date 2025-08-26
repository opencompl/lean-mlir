
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

theorem src_is_mask_ashr_thm.extracted_1._3 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1) (x_3 : BitVec 8),
  ¬x_2 = 1#1 →
    ¬x ≥ ↑8 →
      ofBool ((x_3 ^^^ 123#8) &&& (15#8).sshiftRight' x <ᵤ x_3 ^^^ 123#8) =
        ofBool ((15#8).sshiftRight' x <ᵤ x_3 ^^^ 123#8) :=
sorry