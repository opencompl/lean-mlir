
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gshifthamounthreassociationhinhbittesthwithhtruncationhshl_proof
theorem t0_const_after_fold_lshr_shl_ne_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (lshr e_2 (sub (const? 32 32) e_1)) (trunc 32 (shl e (zext 64 (add e_1 (const? 32 (-1)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (zext 64 (lshr e_2 (const? 32 31)) { «nneg» := true })) (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem t10_constants_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.and (lshr e_1 (const? 32 12)) (trunc 32 (shl e (const? 64 14)))) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (lshr e_1 (const? 32 26)) (trunc 32 e)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem n13_overshift_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (lshr e_2 (sub (const? 32 32) e_1)) (trunc 32 (shl e (zext 64 (add e_1 (const? 32 32))))))
      (const? 32 0) ⊑
    icmp IntPred.ne
      (LLVM.and (lshr e_2 (sub (const? 32 32) e_1))
        (trunc 32 (shl e (zext 64 (add e_1 (const? 32 32)) { «nneg» := true }))))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem n14_trunc_of_lshr_thm (e e_1 : IntW 32) (e_2 : IntW 64) :
  icmp IntPred.ne
      (LLVM.and (trunc 32 (lshr e_2 (zext 64 (sub (const? 32 32) e_1)))) (shl e (add e_1 (const? 32 (-1)))))
      (const? 32 0) ⊑
    icmp IntPred.ne
      (LLVM.and (shl e (add e_1 (const? 32 (-1))))
        (trunc 32 (lshr e_2 (zext 64 (sub (const? 32 32) e_1) { «nneg» := true }))))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem n15_variable_shamts_thm (e e_1 : IntW 32) (e_2 e_3 : IntW 64) :
  icmp IntPred.ne (LLVM.and (trunc 32 (shl e_3 e_2)) (lshr e_1 e)) (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (lshr e_1 e) (trunc 32 (shl e_3 e_2))) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
