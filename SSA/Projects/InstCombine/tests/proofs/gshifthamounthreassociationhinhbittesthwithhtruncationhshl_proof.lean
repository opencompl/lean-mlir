
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthamounthreassociationhinhbittesthwithhtruncationhshl_proof
theorem t0_const_after_fold_lshr_shl_ne_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_2 (sub (const? 32) e_1)) (trunc 32 (shl e (zext 64 (add e_1 (const? (-1)))))))
      (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (zext 64 (lshr e_2 (const? 31)))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t10_constants_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (lshr e_1 (const? 12)) (trunc 32 (shl e (const? 14)))) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e_1 (const? 26)) (trunc 32 e)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n14_trunc_of_lshr_thm (e e_1 : IntW 32) (e_2 : IntW 64) :
  icmp IntPredicate.ne (LLVM.and (trunc 32 (lshr e_2 (zext 64 (sub (const? 32) e_1)))) (shl e (add e_1 (const? (-1)))))
      (const? 0) ⊑
    icmp IntPredicate.ne
      (LLVM.and (shl e (add e_1 (const? (-1)))) (trunc 32 (lshr e_2 (zext 64 (sub (const? 32) e_1)))))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n15_variable_shamts_thm (e e_1 : IntW 32) (e_2 e_3 : IntW 64) :
  icmp IntPredicate.ne (LLVM.and (trunc 32 (shl e_3 e_2)) (lshr e_1 e)) (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e_1 e) (trunc 32 (shl e_3 e_2))) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


