
/-
-- auto-generated from 'SSA/Projects/InstCombine/scripts/extract-goals.py'
import SSA.Projects.InstCombine.TacticAuto
import LeanMLIR.Dialects.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false
-/

theorem shl_xor_xor_bad_mask_distribute_thm.extracted_1._2 : ∀ (x x_1 : BitVec 8),
  ¬(1#8 ≥ ↑8 ∨ 1#8 ≥ ↑8) →
    ¬1#8 ≥ ↑8 → x_1 <<< 1#8 ^^^ (x <<< 1#8 ^^^ BitVec.ofInt 8 (-68)) = (x ^^^ x_1) <<< 1#8 ^^^ BitVec.ofInt 8 (-68) :=
sorry