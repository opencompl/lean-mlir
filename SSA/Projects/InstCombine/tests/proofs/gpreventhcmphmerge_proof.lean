
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gpreventhcmphmerge_proof
theorem test1_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.eq (LLVM.xor e_1 (const? 32 5)) (const? 32 10))
      (icmp IntPred.eq (LLVM.xor e_1 (const? 32 5)) e) ⊑
    LLVM.or (icmp IntPred.eq e_1 (const? 32 15)) (icmp IntPred.eq (LLVM.xor e_1 e) (const? 32 5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test1_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.xor e_1 (const? 32 5)) (const? 32 10)) (const? 1 1)
      (icmp IntPred.eq (LLVM.xor e_1 (const? 32 5)) e) ⊑
    select (icmp IntPred.eq e_1 (const? 32 15)) (const? 1 1)
      (icmp IntPred.eq (LLVM.xor e_1 e) (const? 32 5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test2_thm (e e_1 : IntW 32) :
  LLVM.xor (icmp IntPred.eq (LLVM.xor e_1 e) (const? 32 0))
      (icmp IntPred.eq (LLVM.xor e_1 e) (const? 32 32)) ⊑
    LLVM.xor (icmp IntPred.eq e_1 e) (icmp IntPred.eq (LLVM.xor e_1 e) (const? 32 32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 0))
      (icmp IntPred.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 31)) ⊑
    LLVM.or (icmp IntPred.eq e_1 e)
      (icmp IntPred.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 31)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test3_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPred.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 0)) (const? 1 1)
      (icmp IntPred.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 31)) ⊑
    select (icmp IntPred.eq e_1 e) (const? 1 1)
      (icmp IntPred.eq (sub e_1 e { «nsw» := true, «nuw» := false }) (const? 32 31)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
