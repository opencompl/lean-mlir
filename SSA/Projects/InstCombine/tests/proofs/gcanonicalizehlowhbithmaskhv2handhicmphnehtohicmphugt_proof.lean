
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gcanonicalizehlowhbithmaskhv2handhicmphnehtohicmphugt_proof
theorem p0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor (shl (const? 8 (-1)) e_1) (const? 8 (-1))) e) e ⊑
    icmp IntPredicate.ne (lshr e e_1) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n0_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor (shl (const? 8 (-1)) e_2) (const? 8 (-1))) e_1) e ⊑
    icmp IntPredicate.ne
      (LLVM.and e_1 (LLVM.xor (shl (const? 8 (-1)) e_2 { «nsw» := true, «nuw» := false }) (const? 8 (-1)))) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor (shl (const? 8 1) e_1) (const? 8 (-1))) e) e ⊑
    icmp IntPredicate.ne (LLVM.and e (shl (const? 8 1) e_1 { «nsw» := false, «nuw» := true })) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor (shl (const? 8 (-1)) e_1) (const? 8 1)) e) e ⊑
    icmp IntPredicate.ne
      (LLVM.and e (LLVM.xor (shl (const? 8 (-1)) e_1 { «nsw» := true, «nuw» := false }) (const? 8 (-2))))
      (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


