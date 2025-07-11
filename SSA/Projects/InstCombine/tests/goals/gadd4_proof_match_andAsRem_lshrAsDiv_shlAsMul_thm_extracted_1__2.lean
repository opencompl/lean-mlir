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

theorem match_andAsRem_lshrAsDiv_shlAsMul_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(6#64 ≥ ↑64 ∨ 9#64 = 0 ∨ 6#64 ≥ ↑64) → ¬576#64 = 0 → (x &&& 63#64) + (x >>> 6#64 % 9#64) <<< 6#64 = x % 576#64 :=
sorry