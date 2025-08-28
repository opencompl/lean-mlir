
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

theorem select_icmp_and_2147483648_ne_0_xor_2147483648_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ¬ofBool (x &&& BitVec.ofInt 32 (-2147483648) == 0#32) = 1#1 →
    x ^^^ BitVec.ofInt 32 (-2147483648) = x &&& 2147483647#32 :=
sorry