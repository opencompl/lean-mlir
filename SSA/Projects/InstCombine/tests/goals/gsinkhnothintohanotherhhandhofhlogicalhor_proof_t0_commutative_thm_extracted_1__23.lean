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

theorem t0_commutative_thm.extracted_1._23 : ∀ (x x_1 : BitVec 8) (x_2 : BitVec 1) (x_3 x_4 : BitVec 8),
  ¬ofBool (x_4 == x_3) = 1#1 → ¬ofBool (x_4 != x_3) = 1#1 → x_2 ^^^ 1#1 = 1#1 → 0#1 = 1#1 → x_1 = x :=
sorry