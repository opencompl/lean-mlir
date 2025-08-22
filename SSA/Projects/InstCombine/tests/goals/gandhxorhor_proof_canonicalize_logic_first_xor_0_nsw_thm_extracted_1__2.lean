
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

theorem canonicalize_logic_first_xor_0_nsw_thm.extracted_1._2 : ∀ (x : BitVec 8),
  ¬(True ∧ x.saddOverflow 96#8 = true) →
    ¬(True ∧ (x ^^^ 31#8).saddOverflow 96#8 = true) → x + 96#8 ^^^ 31#8 = (x ^^^ 31#8) + 96#8 :=
sorry