
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

theorem select_icmp_ne_0_and_32_xor_4096_thm.extracted_1._2 : ∀ (x x_1 : BitVec 32),
  ofBool (0#32 != x_1 &&& 32#32) = 1#1 → ¬7#32 ≥ ↑32 → x = x_1 <<< 7#32 &&& 4096#32 ^^^ x ^^^ 4096#32 :=
sorry