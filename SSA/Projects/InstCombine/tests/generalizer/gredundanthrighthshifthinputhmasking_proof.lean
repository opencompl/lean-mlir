
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gredundanthrighthshifthinputhmasking_proof
theorem t0_lshr_proof.t0_lshr_thm_1 (e e_1 : IntW 32) :
  lshr (LLVM.and (shl (const? 32 (-1)) e_1) e) e_1 { «exact» := true } ⊑
    lshr (LLVM.and (shl (const? 32 (-1)) e_1 { «nsw» := true }) e) e_1 { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_sshr_proof.t1_sshr_thm_1 (e e_1 : IntW 32) :
  ashr (LLVM.and (shl (const? 32 (-1)) e_1) e) e_1 { «exact» := true } ⊑
    ashr (LLVM.and (shl (const? 32 (-1)) e_1 { «nsw» := true }) e) e_1 { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n13_proof.n13_thm_1 (e e_1 e_2 : IntW 32) :
  lshr (LLVM.and (shl (const? 32 (-1)) e_1) e) e_2 ⊑
    lshr (LLVM.and (shl (const? 32 (-1)) e_1 { «nsw» := true }) e) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
