
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

theorem t6_ugt_sgt_128_thm.extracted_1._4 : ∀ (x x_1 : BitVec 32),
  ofBool (143#32 <ᵤ x_1 + 16#32) = 1#1 →
    ¬ofBool (127#32 <ₛ x_1) = 1#1 → ¬ofBool (x_1 <ₛ BitVec.ofInt 32 (-16)) = 1#1 → x = x_1 :=
sorry