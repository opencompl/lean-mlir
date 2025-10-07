
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

theorem zext_masked_bit_nonzero_to_smaller_bitwidth_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ¬x_1 ≥ ↑32 → zeroExtend 16 (ofBool (1#32 <<< x_1 &&& x != 0#32)) = truncate 16 (x >>> x_1) &&& 1#16 :=
sorry