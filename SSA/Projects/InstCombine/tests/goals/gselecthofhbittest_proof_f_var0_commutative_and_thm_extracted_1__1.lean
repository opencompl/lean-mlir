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

theorem f_var0_commutative_and_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  ofBool (x_1 &&& x == 0#32) = 1#1 →
    ¬1#32 ≥ ↑32 → x >>> 1#32 &&& 1#32 = zeroExtend 32 (ofBool (x &&& (x_1 ||| 2#32) != 0#32)) :=
sorry