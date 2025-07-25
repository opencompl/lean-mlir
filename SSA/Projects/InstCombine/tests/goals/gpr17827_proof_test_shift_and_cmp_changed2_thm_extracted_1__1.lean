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

theorem test_shift_and_cmp_changed2_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬5#8 ≥ ↑8 → ofBool (x <<< 5#8 &&& BitVec.ofInt 8 (-64) <ᵤ 32#8) = ofBool (x &&& 6#8 == 0#8) :=
sorry