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

theorem fold_add_udiv_urem_to_mul_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(7#32 = 0 ∨ 7#32 = 0) → x / 7#32 * 21#32 + x % 7#32 * 3#32 = x * 3#32 :=
sorry