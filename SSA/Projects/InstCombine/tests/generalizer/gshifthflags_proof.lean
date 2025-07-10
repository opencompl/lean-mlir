
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthflags_proof
theorem shl_add_nuw_proof.shl_add_nuw_thm_1 (e e_1 : IntW 8) :
  shl (LLVM.and e (const? 8 63)) (LLVM.and e_1 (const? 8 2)) ⊑
    shl (LLVM.and e (const? 8 63)) (LLVM.and e_1 (const? 8 2)) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_nuw_and_nsw_proof.shl_add_nuw_and_nsw_thm_1 (e e_1 : IntW 8) :
  shl (LLVM.and e (const? 8 31)) (LLVM.and e_1 (const? 8 2)) ⊑
    shl (LLVM.and e (const? 8 31)) (LLVM.and e_1 (const? 8 2)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_nsw_proof.shl_add_nsw_thm_1 (e e_1 : IntW 8) :
  shl (LLVM.or e (const? 8 (-32))) (LLVM.and e_1 (const? 8 2)) ⊑
    shl (LLVM.or e (const? 8 (-32))) (LLVM.and e_1 (const? 8 2)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_add_exact_proof.lshr_add_exact_thm_1 (e e_1 : IntW 8) :
  lshr (LLVM.and e (const? 8 (-4))) (LLVM.and e_1 (const? 8 2)) ⊑
    lshr (LLVM.and e (const? 8 (-4))) (LLVM.and e_1 (const? 8 2)) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_add_exact_proof.ashr_add_exact_thm_1 (e e_1 : IntW 8) :
  ashr (LLVM.and e (const? 8 (-14))) (LLVM.and e_1 (const? 8 1)) ⊑
    ashr (LLVM.and e (const? 8 (-14))) (LLVM.and e_1 (const? 8 1)) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
