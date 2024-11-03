
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gshifthamounthreassociationhinhbittest_proof
theorem t0_const_lshr_shl_ne_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (shl e_1 (const? 32 1)) (lshr e (const? 32 1))) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e (const? 32 2)) e_1) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_const_shl_lshr_ne_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_1 (const? 32 1)) (shl e (const? 32 1))) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e_1 (const? 32 2)) e) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t2_const_lshr_shl_eq_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (LLVM.and (shl e_1 (const? 32 1)) (lshr e (const? 32 1))) (const? 32 0) ⊑
    icmp IntPredicate.eq (LLVM.and (lshr e (const? 32 2)) e_1) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_const_after_fold_lshr_shl_ne_thm (e e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_2 (sub (const? 32 32) e_1)) (shl e (add e_1 (const? 32 (-1))))) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e_2 (const? 32 31)) e) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t4_const_after_fold_lshr_shl_ne_thm (e e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (shl e_2 (sub (const? 32 32) e_1)) (lshr e (add e_1 (const? 32 (-1))))) (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e (const? 32 31)) e_2) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


