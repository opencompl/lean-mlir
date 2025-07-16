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

theorem test_invert_demorgan_or3_thm.extracted_1._1 : ∀ (x x_1 : BitVec 32),
  (ofBool (x_1 == 178206#32) ||| ofBool (x + BitVec.ofInt 32 (-195102) <ᵤ 1506#32) |||
          ofBool (x + BitVec.ofInt 32 (-201547) <ᵤ 716213#32) |||
        ofBool (x + BitVec.ofInt 32 (-918000) <ᵤ 196112#32)) ^^^
      1#1 =
    ofBool (x_1 != 178206#32) &&& ofBool (x + BitVec.ofInt 32 (-196608) <ᵤ BitVec.ofInt 32 (-1506)) &&&
        ofBool (x + BitVec.ofInt 32 (-917760) <ᵤ BitVec.ofInt 32 (-716213)) &&&
      ofBool (x + BitVec.ofInt 32 (-1114112) <ᵤ BitVec.ofInt 32 (-196112)) :=
sorry