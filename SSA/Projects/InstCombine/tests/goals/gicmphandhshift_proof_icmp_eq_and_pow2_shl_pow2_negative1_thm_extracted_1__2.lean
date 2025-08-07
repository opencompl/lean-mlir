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

theorem icmp_eq_and_pow2_shl_pow2_negative1_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬x ≥ ↑32 →
    ¬(x ≥ ↑32 ∨ 4#32 ≥ ↑32) →
      zeroExtend 32 (ofBool (11#32 <<< x &&& 16#32 == 0#32)) = 11#32 <<< x >>> 4#32 &&& 1#32 ^^^ 1#32 :=
sorry