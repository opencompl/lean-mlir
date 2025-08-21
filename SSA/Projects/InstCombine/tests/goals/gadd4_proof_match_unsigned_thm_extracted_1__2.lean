
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

theorem match_unsigned_thm.extracted_1._2 : ∀ (x : BitVec 64),
  ¬(299#64 = 0 ∨ 299#64 = 0 ∨ 64#64 = 0) → ¬19136#64 = 0 → x % 299#64 + x / 299#64 % 64#64 * 299#64 = x % 19136#64 :=
sorry