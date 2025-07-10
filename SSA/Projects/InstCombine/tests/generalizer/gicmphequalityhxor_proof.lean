
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphequalityhxor_proof
theorem cmpeq_xor_cst1_proof.cmpeq_xor_cst1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.xor e (const? 32 10)) e_1 ⊑ icmp IntPred.eq (LLVM.xor e e_1) (const? 32 10) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem cmpeq_xor_cst3_proof.cmpeq_xor_cst3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.xor e (const? 32 10)) (LLVM.xor e_1 (const? 32 10)) ⊑ icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem cmpne_xor_cst1_proof.cmpne_xor_cst1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.xor e (const? 32 10)) e_1 ⊑ icmp IntPred.ne (LLVM.xor e e_1) (const? 32 10) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem cmpne_xor_cst3_proof.cmpne_xor_cst3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.xor e (const? 32 10)) (LLVM.xor e_1 (const? 32 10)) ⊑ icmp IntPred.ne e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem cmpeq_xor_cst1_commuted_proof.cmpeq_xor_cst1_commuted_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (mul e_1 e_1) (LLVM.xor e (const? 32 10)) ⊑
    icmp IntPred.eq (LLVM.xor e (mul e_1 e_1)) (const? 32 10) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo1_proof.foo1_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and e (const? 32 (-2147483648)))
      (LLVM.and (LLVM.xor e_1 (const? 32 (-1))) (const? 32 (-2147483648))) ⊑
    icmp IntPred.slt (LLVM.xor e_1 e) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem foo2_proof.foo2_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and e (const? 32 (-2147483648)))
      (LLVM.xor (LLVM.and e_1 (const? 32 (-2147483648))) (const? 32 (-2147483648))) ⊑
    icmp IntPred.slt (LLVM.xor e_1 e) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
