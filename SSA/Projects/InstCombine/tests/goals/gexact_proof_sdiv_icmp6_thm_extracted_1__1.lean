
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

theorem sdiv_icmp6_thm.extracted_1._1 : ∀ (x : BitVec 64),
  ¬(True ∧ x.smod (BitVec.ofInt 64 (-5)) ≠ 0 ∨
        (BitVec.ofInt 64 (-5) == 0 || 64 != 1 && x == intMin 64 && BitVec.ofInt 64 (-5) == -1) = true) →
    ofBool (x.sdiv (BitVec.ofInt 64 (-5)) == -1#64) = ofBool (x == 5#64) :=
sorry