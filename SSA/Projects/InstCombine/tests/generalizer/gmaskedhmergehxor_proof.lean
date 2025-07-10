
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gmaskedhmergehxor_proof
theorem p_proof.p_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.and e e_2) (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) ⊑
    LLVM.or (LLVM.and e e_2) (LLVM.and e_1 (LLVM.xor e_2 (const? 32 (-1)))) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p_constmask_proof.p_constmask_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e (const? 32 65280)) (LLVM.and e_1 (const? 32 (-65281))) ⊑
    LLVM.or (LLVM.and e (const? 32 65280)) (LLVM.and e_1 (const? 32 (-65281))) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p_constmask2_proof.p_constmask2_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e (const? 32 61440)) (LLVM.and e_1 (const? 32 (-65281))) ⊑
    LLVM.or (LLVM.and e (const? 32 61440)) (LLVM.and e_1 (const? 32 (-65281))) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p_commutative0_proof.p_commutative0_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.and e_2 e) (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) ⊑
    LLVM.or (LLVM.and e_2 e) (LLVM.and e_1 (LLVM.xor e_2 (const? 32 (-1)))) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p_commutative2_proof.p_commutative2_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.and e e_2) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor e_2 (const? 32 (-1)))) (LLVM.and e e_2) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p_commutative4_proof.p_commutative4_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e_2 (const? 32 (-1))) e_1) (LLVM.and e_2 e) ⊑
    LLVM.or (LLVM.and e_1 (LLVM.xor e_2 (const? 32 (-1)))) (LLVM.and e_2 e) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem p_constmask_commutative_proof.p_constmask_commutative_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e_1 (const? 32 (-65281))) (LLVM.and e (const? 32 65280)) ⊑
    LLVM.or (LLVM.and e_1 (const? 32 (-65281))) (LLVM.and e (const? 32 65280)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n2_badmask_proof.n2_badmask_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  LLVM.xor (LLVM.and e_2 e) (LLVM.and (LLVM.xor e_3 (const? 32 (-1))) e_1) ⊑
    LLVM.xor (LLVM.and e_2 e) (LLVM.and e_1 (LLVM.xor e_3 (const? 32 (-1)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n3_constmask_samemask_proof.n3_constmask_samemask_thm_1 (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and e (const? 32 65280)) (LLVM.and e_1 (const? 32 65280)) ⊑
    LLVM.and (LLVM.xor e e_1) (const? 32 65280) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
