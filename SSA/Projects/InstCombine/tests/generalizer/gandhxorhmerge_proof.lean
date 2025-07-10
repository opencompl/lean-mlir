
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gandhxorhmerge_proof
theorem test1_proof.test1_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.and e_2 e) (LLVM.and e_2 e_1) ⊑ LLVM.and e_2 (LLVM.xor e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e_1 e) (LLVM.or e_1 e) ⊑ LLVM.xor e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR38781_proof.PR38781_thm_1 (e e_1 : IntW 32) :
  LLVM.and (LLVM.xor (lshr e_1 (const? 32 31)) (const? 32 1)) (LLVM.xor (lshr e (const? 32 31)) (const? 32 1)) ⊑
    zext 32 (icmp IntPred.sgt (LLVM.or e_1 e) (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR75692_1_proof.PR75692_1_thm_1 (e : IntW 32) :
  LLVM.and (LLVM.xor e (const? 32 4)) (LLVM.xor e (const? 32 (-5))) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
