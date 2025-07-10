
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcanonicalizehlowhbithmaskhv2handhicmphnehtohicmphugt_proof
theorem p0_proof.p0_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.and (LLVM.xor (shl (const? 8 (-1)) e_1) (const? 8 (-1))) e) e ⊑
    icmp IntPred.ne (lshr e e_1) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n0_proof.n0_thm_1 (e e_1 e_2 : IntW 8) :
  icmp IntPred.ne (LLVM.and (LLVM.xor (shl (const? 8 (-1)) e_1) (const? 8 (-1))) e) e_2 ⊑
    icmp IntPred.ne (LLVM.and e (LLVM.xor (shl (const? 8 (-1)) e_1 { «nsw» := true }) (const? 8 (-1)))) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n1_proof.n1_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.and (LLVM.xor (shl (const? 8 1) e_1) (const? 8 (-1))) e) e ⊑
    icmp IntPred.ne (LLVM.and e (shl (const? 8 1) e_1 { «nuw» := true })) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n2_proof.n2_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.ne (LLVM.and (LLVM.xor (shl (const? 8 (-1)) e_1) (const? 8 1)) e) e ⊑
    icmp IntPred.ne (LLVM.and e (LLVM.xor (shl (const? 8 (-1)) e_1 { «nsw» := true }) (const? 8 (-2))))
      (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
