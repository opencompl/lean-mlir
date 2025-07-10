
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gomithuremhofhpowerhofhtwohorhzerohwhenhcomparinghwithhzero_proof
theorem p0_scalar_urem_by_const_proof.p0_scalar_urem_by_const_thm_1 (e : IntW 32) :
  icmp IntPred.eq (urem (LLVM.and e (const? 32 128)) (const? 32 6)) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 128)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p1_scalar_urem_by_nonconst_proof.p1_scalar_urem_by_nonconst_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (urem (LLVM.and e (const? 32 128)) (LLVM.or e_1 (const? 32 6))) (const? 32 0) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 128)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p2_scalar_shifted_urem_by_const_proof.p2_scalar_shifted_urem_by_const_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (urem (shl (LLVM.and e (const? 32 1)) e_1) (const? 32 3)) (const? 32 0) ⊑
    icmp IntPred.eq (urem (shl (LLVM.and e (const? 32 1)) e_1 { «nuw» := true }) (const? 32 3)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
