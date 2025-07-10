
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsdivhexacthbyhpowerhofhtwo_proof
theorem t0_proof.t0_thm_1 (e : IntW 8) :
  LLVM.sdiv e (const? 8 32) { «exact» := true } ⊑ ashr e (const? 8 5) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n2_proof.n2_thm_1 (e : IntW 8) :
  LLVM.sdiv e (const? 8 (-128)) ⊑ zext 8 (icmp IntPred.eq e (const? 8 (-128))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl1_nsw_proof.shl1_nsw_thm_1 (e e_1 : IntW 8) :
  LLVM.sdiv e (shl (const? 8 1) e_1 { «nsw» := true }) { «exact» := true } ⊑ ashr e e_1 { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl1_nsw_not_exact_proof.shl1_nsw_not_exact_thm_1 (e e_1 : IntW 8) :
  LLVM.sdiv e (shl (const? 8 1) e_1 { «nsw» := true }) ⊑
    LLVM.sdiv e (shl (const? 8 1) e_1 { «nsw» := true, «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem prove_exact_with_high_mask_proof.prove_exact_with_high_mask_thm_1 (e : IntW 8) :
  LLVM.sdiv (LLVM.and e (const? 8 (-8))) (const? 8 4) ⊑ LLVM.and (ashr e (const? 8 2)) (const? 8 (-2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem prove_exact_with_high_mask_limit_proof.prove_exact_with_high_mask_limit_thm_1 (e : IntW 8) :
  LLVM.sdiv (LLVM.and e (const? 8 (-8))) (const? 8 8) ⊑ ashr e (const? 8 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
