
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

theorem select_icmp_eq_and_32_0_xor_8_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 32#32 == 0#32) = 1#1 → ¬2#32 ≥ ↑32 → x ^^^ 8#32 = x ^^^ x_1 >>> 2#32 &&& 8#32 :=
sorry