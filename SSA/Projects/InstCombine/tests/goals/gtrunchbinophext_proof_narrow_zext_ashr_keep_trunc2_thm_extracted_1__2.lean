
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

theorem narrow_zext_ashr_keep_trunc2_thm.extracted_1._2 : ∀ (x x_1 : BitVec 9),
  ¬(True ∧ (signExtend 64 x_1).saddOverflow (signExtend 64 x) = true ∨ 1#64 ≥ ↑64) →
    ¬(True ∧ (zeroExtend 16 x_1).saddOverflow (zeroExtend 16 x) = true ∨
          True ∧ (zeroExtend 16 x_1).uaddOverflow (zeroExtend 16 x) = true ∨ 1#16 ≥ ↑16) →
      truncate 8 ((signExtend 64 x_1 + signExtend 64 x).sshiftRight' 1#64) =
        truncate 8 ((zeroExtend 16 x_1 + zeroExtend 16 x) >>> 1#16) :=
sorry