
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gfreehinversion_proof
theorem xor_1_proof.xor_1_thm_1 (e : IntW 8) (e_1 : IntW 1) (e_2 e_3 : IntW 8) :
  LLVM.xor (LLVM.xor (select e_1 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_3 (const? 8 123))) e) (const? 8 (-1)) ⊑
    LLVM.xor (select e_1 e_2 (LLVM.xor e_3 (const? 8 (-124)))) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_2_proof.xor_2_thm_1 (e : IntW 8) (e_1 : IntW 1) (e_2 e_3 : IntW 8) :
  LLVM.xor (LLVM.xor e (select e_1 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_3 (const? 8 123)))) (const? 8 (-1)) ⊑
    LLVM.xor e (select e_1 e_2 (LLVM.xor e_3 (const? 8 (-124)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_1_proof.add_1_thm_1 (e : IntW 8) (e_1 : IntW 1) (e_2 e_3 : IntW 8) :
  LLVM.xor (add (select e_1 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_3 (const? 8 123))) e) (const? 8 (-1)) ⊑
    sub (select e_1 e_2 (LLVM.xor e_3 (const? 8 (-124)))) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_2_proof.add_2_thm_1 (e : IntW 8) (e_1 : IntW 1) (e_2 e_3 : IntW 8) :
  LLVM.xor (add e (select e_1 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_3 (const? 8 123)))) (const? 8 (-1)) ⊑
    sub (select e_1 e_2 (LLVM.xor e_3 (const? 8 (-124)))) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_1_proof.sub_1_thm_1 (e : IntW 8) (e_1 : IntW 1) (e_2 e_3 : IntW 8) :
  LLVM.xor (sub (select e_1 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_3 (const? 8 123))) e) (const? 8 (-1)) ⊑
    add (select e_1 e_2 (LLVM.xor e_3 (const? 8 (-124)))) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_2_proof.sub_2_thm_1 (e : IntW 8) (e_1 : IntW 1) (e_2 e_3 : IntW 8) :
  LLVM.xor (sub e (select e_1 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_3 (const? 8 123)))) (const? 8 (-1)) ⊑
    sub (const? 8 (-2)) (add (select e_1 e_2 (LLVM.xor e_3 (const? 8 (-124)))) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_3_proof.sub_3_thm_1 (e : IntW 128) (e_1 : IntW 1) (e_2 e_3 : IntW 128) :
  LLVM.xor (sub e (select e_1 (LLVM.xor e_2 (const? 128 (-1))) (LLVM.xor e_3 (const? 128 123)))) (const? 128 (-1)) ⊑
    sub (const? 128 (-2)) (add (select e_1 e_2 (LLVM.xor e_3 (const? 128 (-124)))) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_1_proof.ashr_1_thm_1 (e : IntW 8) (e_1 : IntW 1) (e_2 e_3 : IntW 8) :
  LLVM.xor (ashr (select e_1 (LLVM.xor e_2 (const? 8 (-1))) (LLVM.xor e_3 (const? 8 123))) e) (const? 8 (-1)) ⊑
    ashr (select e_1 e_2 (LLVM.xor e_3 (const? 8 (-124)))) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_1_proof.select_1_thm_1 (e : IntW 1) (e_1 e_2 : IntW 8) (e_3 : IntW 1) (e_4 e_5 : IntW 8) :
  LLVM.xor
      (select e (LLVM.xor e_2 (LLVM.xor e_1 (const? 8 45)))
        (select e_3 (LLVM.xor e_4 (const? 8 (-1))) (LLVM.xor e_5 (const? 8 123))))
      (const? 8 (-1)) ⊑
    select e (LLVM.xor (LLVM.xor e_1 e_2) (const? 8 (-46))) (select e_3 e_4 (LLVM.xor e_5 (const? 8 (-124)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_2_proof.select_2_thm_1 (e : IntW 1) (e_1 : IntW 8) (e_2 : IntW 1) (e_3 e_4 : IntW 8) :
  LLVM.xor
      (select e (select e_2 (LLVM.xor e_3 (const? 8 (-1))) (LLVM.xor e_4 (const? 8 123))) (LLVM.xor e_1 (const? 8 45)))
      (const? 8 (-1)) ⊑
    select e (select e_2 e_3 (LLVM.xor e_4 (const? 8 (-124)))) (LLVM.xor e_1 (const? 8 (-46))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_not_nneg2_proof.lshr_not_nneg2_thm_1 (e : IntW 8) :
  LLVM.xor (lshr (LLVM.xor e (const? 8 (-1))) (const? 8 1)) (const? 8 (-1)) ⊑
    LLVM.or (lshr e (const? 8 1)) (const? 8 (-128)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
