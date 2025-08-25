
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

theorem ashr_can_be_lshr_2_thm.extracted_1._1 : ∀ (x : BitVec 32),
  ¬(34#64 ≥ ↑64 ∨
        True ∧
            (zeroExtend 64 x ||| 4278190080#64) <<< 34#64 >>> 32#64 <<< 32#64 ≠
              (zeroExtend 64 x ||| 4278190080#64) <<< 34#64 ∨
          32#64 ≥ ↑64 ∨
            True ∧
              signExtend 64 (truncate 32 (((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64)) ≠
                ((zeroExtend 64 x ||| 4278190080#64) <<< 34#64).sshiftRight' 32#64) →
    2#32 ≥ ↑32 → False :=
sorry