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

theorem add_constant_equal_with_the_top_bit_of_demandedbits_insertpt_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  (x_1 + 16#32 ||| x) &&& 24#32 = (x_1 ^^^ 16#32 ||| x) &&& 24#32 :=
sorry