
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

theorem test8_thm.extracted_1._1 : ∀ (x : BitVec 128),
  ¬(127#128 ≥ ↑128 ∨ 120#128 ≥ ↑128 ∨ 127#128 ≥ ↑128) →
    (x ^^^ (1#128 <<< 127#128).sshiftRight' 120#128) + 1#128 <<< 127#128 =
      x ^^^ 170141183460469231731687303715884105600#128 :=
sorry