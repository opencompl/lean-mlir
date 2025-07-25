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

theorem test68_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 128#32 == 0#32) = 1#1 → ¬6#32 ≥ ↑32 → x ||| 2#32 = x ||| x_1 >>> 6#32 &&& 2#32 :=
sorry