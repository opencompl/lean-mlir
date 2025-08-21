
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

theorem xor_i8_to_i64_shl_save_and_ne_thm.extracted_1._2 : ∀ (x : BitVec 64) (x_1 : BitVec 8),
  ofBool (x_1 &&& 1#8 != 0#8) = 1#1 →
    ¬63#64 ≥ ↑64 → x ^^^ BitVec.ofInt 64 (-9223372036854775808) = x ^^^ zeroExtend 64 x_1 <<< 63#64 :=
sorry