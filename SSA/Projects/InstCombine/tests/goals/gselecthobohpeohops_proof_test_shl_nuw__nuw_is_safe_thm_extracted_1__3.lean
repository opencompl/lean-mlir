
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

theorem test_shl_nuw__nuw_is_safe_thm.extracted_1._3 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& 1073741822#32 == 0#32) = 1#1 →
    ¬(True ∧ (x_1 &&& 1073741822#32) <<< 2#32 >>> 2#32 ≠ x_1 &&& 1073741822#32 ∨
          2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& 1073741822#32) <<< 2#32) ≥ ↑64) →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)).msb = true ∨
            zeroExtend 64 (x_1 <<< 2#32 &&& BitVec.ofInt 32 (-8)) ≥ ↑64 →
        False :=
sorry