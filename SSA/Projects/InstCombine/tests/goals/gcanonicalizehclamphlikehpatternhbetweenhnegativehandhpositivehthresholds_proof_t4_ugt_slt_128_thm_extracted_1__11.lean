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

theorem t4_ugt_slt_128_thm.extracted_1._11 : ∀ (x x_1 x_2 : BitVec 32),
  ofBool (143#32 <ᵤ x_2 + 16#32) = 1#1 →
    ofBool (x_2 <ₛ 128#32) = 1#1 →
      ¬ofBool (127#32 <ₛ x_2) = 1#1 → ¬ofBool (x_2 <ₛ BitVec.ofInt 32 (-16)) = 1#1 → x_1 = x_2 :=
sorry