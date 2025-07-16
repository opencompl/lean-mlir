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

theorem icmp_shl_ne_2_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬((x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true ∨
        (x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true ∨ 1#8 ≥ ↑8) →
    ¬(x == 0 || 8 != 1 && 42#8 == intMin 8 && x == -1) = true →
      ofBool ((42#8).sdiv x != (42#8).sdiv x <<< 1#8) = ofBool ((42#8).sdiv x != 0#8) :=
sorry