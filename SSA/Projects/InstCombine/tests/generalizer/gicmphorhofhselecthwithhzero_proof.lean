
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphorhofhselecthwithhzero_proof
theorem src_tv_eq_proof.src_tv_eq_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  icmp IntPred.eq (LLVM.or (select e (const? 8 0) (add e_2 (const? 8 1) { «nuw» := true })) e_1) (const? 8 0) ⊑
    LLVM.and (icmp IntPred.eq e_1 (const? 8 0)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_fv_ne_proof.src_fv_ne_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  icmp IntPred.ne (LLVM.or (select e (add e_2 (const? 8 1) { «nuw» := true }) (const? 8 0)) e_1) (const? 8 0) ⊑
    LLVM.or (icmp IntPred.ne e_1 (const? 8 0)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_tv_ne_proof.src_tv_ne_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  icmp IntPred.ne (LLVM.or (select e (const? 8 0) (add e_2 (const? 8 1) { «nuw» := true })) e_1) (const? 8 0) ⊑
    LLVM.or (icmp IntPred.ne e_1 (const? 8 0)) (LLVM.xor e (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem src_fv_eq_proof.src_fv_eq_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) :
  icmp IntPred.eq (LLVM.or (select e (add e_2 (const? 8 1) { «nuw» := true }) (const? 8 0)) e_1) (const? 8 0) ⊑
    LLVM.and (icmp IntPred.eq e_1 (const? 8 0)) (LLVM.xor e (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
