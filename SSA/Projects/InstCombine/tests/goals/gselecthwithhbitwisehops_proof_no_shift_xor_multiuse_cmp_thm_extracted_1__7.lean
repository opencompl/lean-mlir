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

theorem no_shift_xor_multiuse_cmp_thm.extracted_1._7 : ∀ (x x_1 x_2 x_3 : BitVec 32),
  ¬ofBool (0#32 != x_3 &&& 4096#32) = 1#1 →
    ofBool (x_3 &&& 4096#32 == 0#32) = 1#1 → (x_2 ||| 4096#32) * x = (x_2 ||| x_3 &&& 4096#32 ^^^ 4096#32) * x :=
sorry