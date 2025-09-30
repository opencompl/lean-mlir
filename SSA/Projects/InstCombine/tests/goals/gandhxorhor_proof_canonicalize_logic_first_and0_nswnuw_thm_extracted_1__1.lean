
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

theorem canonicalize_logic_first_and0_nswnuw_thm.extracted_1._1 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 48#8 = true ∨ True ∧ x.uaddOverflow 48#8 = true) →
    True ∧ (x &&& BitVec.ofInt 8 (-10)).saddOverflow 48#8 = true ∨
        True ∧ (x &&& BitVec.ofInt 8 (-10)).uaddOverflow 48#8 = true →
      False :=
sorry