
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

theorem select_icmp_eq_and_1_0_lshr_tv_thm.extracted_1._4 : ∀ (x x_1 : BitVec 8),
  ¬ofBool (x_1 &&& 1#8 != 0#8) = 1#1 → ¬(1#8 ≥ ↑8 ∨ x_1 <<< 1#8 &&& 2#8 ≥ ↑8) → x = x >>> (x_1 <<< 1#8 &&& 2#8) :=
sorry