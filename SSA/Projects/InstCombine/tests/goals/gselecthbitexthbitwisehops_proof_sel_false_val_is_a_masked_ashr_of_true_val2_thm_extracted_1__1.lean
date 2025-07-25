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

theorem sel_false_val_is_a_masked_ashr_of_true_val2_thm.extracted_1._1 : ∀ (x : BitVec 64) (x_1 : BitVec 32),
  ¬2#32 ≥ ↑32 →
    ofBool ((x_1 &&& BitVec.ofInt 32 (-2147483588)).sshiftRight' 2#32 == 0#32) = 1#1 →
      2#32 ≥ ↑32 ∨
          True ∧ (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)).msb = true ∨
            zeroExtend 64 (x_1.sshiftRight' 2#32 &&& BitVec.ofInt 32 (-536870897)) ≥ ↑64 →
        HRefinement.IsRefinedBy (β := PoisonOr (BitVec 64)) (self :=
          @instHRefinementOfRefinement _
            (@PoisonOr.instRefinement _ (@instHRefinementOfRefinement _ InstCombine.instRefinementBitVec)))
          (PoisonOr.value x) PoisonOr.poison :=
sorry