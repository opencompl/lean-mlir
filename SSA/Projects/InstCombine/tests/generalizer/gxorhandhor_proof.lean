
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gxorhandhor_proof
theorem xor_logic_and_logic_or1_proof.xor_logic_and_logic_or1_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e e_1 (const? 1 0)) (select e (const? 1 1) e_2) ⊑ select e (LLVM.xor e_1 (const? 1 1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_logic_and_logic_or2_proof.xor_logic_and_logic_or2_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e e_1 (const? 1 0)) (select e_2 (const? 1 1) e) ⊑ select e (LLVM.xor e_1 (const? 1 1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_logic_and_logic_or4_proof.xor_logic_and_logic_or4_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e_1 e (const? 1 0)) (select e (const? 1 1) e_2) ⊑ select e (LLVM.xor e_1 (const? 1 1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_and_logic_or1_proof.xor_and_logic_or1_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (LLVM.and e e_1) (select e (const? 1 1) e_2) ⊑ select e (LLVM.xor e_1 (const? 1 1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_and_logic_or2_proof.xor_and_logic_or2_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (LLVM.and e_1 e) (select e_2 (const? 1 1) e) ⊑ select e (LLVM.xor e_1 (const? 1 1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_logic_and_or1_proof.xor_logic_and_or1_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e e_1 (const? 1 0)) (LLVM.or e_2 e) ⊑ select e (LLVM.xor e_1 (const? 1 1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_logic_and_or2_proof.xor_logic_and_or2_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e_1 e (const? 1 0)) (LLVM.or e e_2) ⊑ select e (LLVM.xor e_1 (const? 1 1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_and_or_proof.xor_and_or_thm_1 (e e_1 e_2 : IntW 1) :
  LLVM.xor (LLVM.and e e_1) (LLVM.or e_2 e) ⊑ select e (LLVM.xor e_1 (const? 1 1)) e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
