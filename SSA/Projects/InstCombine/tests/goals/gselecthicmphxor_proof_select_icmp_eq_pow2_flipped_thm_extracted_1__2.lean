
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

theorem select_icmp_eq_pow2_flipped_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 4#8 == 0#8) = 1#1 → x = x ||| 4#8 :=
sorry