
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gnothadd_proof
theorem basic_proof.basic_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e (const? 8 (-1))) e_1) (const? 8 (-1)) ⊑ sub e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem basic_com_add_proof.basic_com_add_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (add e (LLVM.xor e_1 (const? 8 (-1)))) (const? 8 (-1)) ⊑ sub e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem basic_preserve_nsw_proof.basic_preserve_nsw_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e (const? 8 (-1))) e_1 { «nsw» := true }) (const? 8 (-1)) ⊑
    sub e e_1 { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem basic_preserve_nuw_proof.basic_preserve_nuw_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e (const? 8 (-1))) e_1 { «nuw» := true }) (const? 8 (-1)) ⊑
    sub e e_1 { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem basic_preserve_nuw_nsw_proof.basic_preserve_nuw_nsw_thm_1 (e e_1 : IntW 8) :
  LLVM.xor (add (LLVM.xor e (const? 8 (-1))) e_1 { «nsw» := true, «nuw» := true }) (const? 8 (-1)) ⊑
    sub e e_1 { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
