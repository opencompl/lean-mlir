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

theorem ashr_xor_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ¬((42#32 == 0 || 32 != 1 && x_1 == intMin 32 && 42#32 == -1) = true ∨ 5#32 ≥ ↑32 ∨ 7#32 ≥ ↑32) →
    ¬(12#32 ≥ ↑32 ∨ (42#32 == 0 || 32 != 1 && x_1 == intMin 32 && 42#32 == -1) = true ∨ 7#32 ≥ ↑32) →
      (x_1.srem 42#32 ^^^ x.sshiftRight' 5#32).sshiftRight' 7#32 =
        x.sshiftRight' 12#32 ^^^ (x_1.srem 42#32).sshiftRight' 7#32 :=
sorry