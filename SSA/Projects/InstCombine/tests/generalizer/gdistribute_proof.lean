
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gdistribute_proof
theorem factorize_proof.factorize_thm_1 (e : IntW 32) :
  LLVM.and (LLVM.or e (const? 32 1)) (LLVM.or e (const? 32 2)) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem factorize2_proof.factorize2_thm_1 (e : IntW 32) : sub (mul (const? 32 3) e) (mul (const? 32 2) e) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem factorize3_proof.factorize3_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.and (LLVM.or e (LLVM.or e_1 e_2)) (LLVM.or e e_2) ⊑ LLVM.or e e_2 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem factorize4_proof.factorize4_thm_1 (e e_1 : IntW 32) :
  sub (mul (shl e_1 (const? 32 1)) e) (mul e e_1) ⊑ mul e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem factorize5_proof.factorize5_thm_1 (e e_1 : IntW 32) :
  sub (mul (mul e_1 (const? 32 2)) e) (mul e e_1) ⊑ mul e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem expand_proof.expand_thm_1 (e : IntW 32) :
  LLVM.and (LLVM.or (LLVM.and e (const? 32 1)) (const? 32 2)) (const? 32 1) ⊑ LLVM.and e (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
