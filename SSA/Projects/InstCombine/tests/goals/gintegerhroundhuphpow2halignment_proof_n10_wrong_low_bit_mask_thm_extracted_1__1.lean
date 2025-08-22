
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

theorem n10_wrong_low_bit_mask_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬ofBool (x &&& 31#8 == 0#8) = 1#1 → x + 16#8 &&& BitVec.ofInt 8 (-16) = (x &&& BitVec.ofInt 8 (-16)) + 16#8 :=
sorry