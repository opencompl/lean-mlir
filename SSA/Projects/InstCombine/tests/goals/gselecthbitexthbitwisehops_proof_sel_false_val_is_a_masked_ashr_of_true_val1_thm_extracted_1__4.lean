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

theorem sel_false_val_is_a_masked_ashr_of_true_val1_thm.extracted_1._4 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬ofBool (x_1 &&& BitVec.ofInt 32 (-2147483588) == 0#32) = 1#1 →
    ¬(2#32 ≥ ↑32 ∨ zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32) ≥ ↑64) →
      ¬(2#32 ≥ ↑32 ∨
            True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
              zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64) →
        x.sshiftRight' (zeroExtend 64 ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32)) =
          x.sshiftRight' (zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897))) :=
sorry