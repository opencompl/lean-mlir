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

theorem add_nsw_const_const_sub_nsw_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 1#8 = true ∨ True ∧ (BitVec.ofInt 8 (-127)).ssubOverflow (x + 1#8) = true) →
    ¬(True ∧ (BitVec.ofInt 8 (-128)).ssubOverflow x = true) →
      BitVec.ofInt 8 (-127) - (x + 1#8) = BitVec.ofInt 8 (-128) - x :=
sorry