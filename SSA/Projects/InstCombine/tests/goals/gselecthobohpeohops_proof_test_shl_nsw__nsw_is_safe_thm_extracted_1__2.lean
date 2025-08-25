
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

theorem test_shl_nsw__nsw_is_safe_thm.extracted_1._2 : ∀ (x : BitVec 32),
  ofBool (x ||| BitVec.ofInt 32 (-83886080) == BitVec.ofInt 32 (-83886079)) = 1#1 →
    ¬(True ∧ ((x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32).sshiftRight' 2#32 ≠ x ||| BitVec.ofInt 32 (-83886080) ∨
          2#32 ≥ ↑32) →
      ¬(True ∧ ((x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32).sshiftRight' 2#32 ≠ x ||| BitVec.ofInt 32 (-83886080) ∨
            2#32 ≥ ↑32 ∨
              True ∧
                  ((x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32).sshiftRight' 2#32 ≠ x ||| BitVec.ofInt 32 (-83886080) ∨
                2#32 ≥ ↑32) →
        BitVec.ofInt 32 (-335544316) * (x ||| BitVec.ofInt 32 (-83886080)) *
            (x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32 =
          (x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32 * (x ||| BitVec.ofInt 32 (-83886080)) *
            (x ||| BitVec.ofInt 32 (-83886080)) <<< 2#32 :=
sorry