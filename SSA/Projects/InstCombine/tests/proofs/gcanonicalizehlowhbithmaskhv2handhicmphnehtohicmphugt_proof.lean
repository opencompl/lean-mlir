
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehlowhbithmaskhv2handhicmphnehtohicmphugt_proof
theorem p0_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor (shl (const? (-1)) e_1) (const? (-1))) e) e ⊑
    icmp IntPredicate.ne (lshr e e_1) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n0_thm (e e_1 e_2 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor (shl (const? (-1)) e_2) (const? (-1))) e_1) e ⊑
    icmp IntPredicate.ne
      (LLVM.and e_1 (LLVM.xor (shl (const? (-1)) e_2 { «nsw» := true, «nuw» := false }) (const? (-1)))) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n1_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor (shl (const? 1) e_1) (const? (-1))) e) e ⊑
    icmp IntPredicate.ne (LLVM.and e (shl (const? 1) e_1 { «nsw» := false, «nuw» := true })) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem n2_thm (e e_1 : IntW 8) :
  icmp IntPredicate.ne (LLVM.and (LLVM.xor (shl (const? (-1)) e_1) (const? 1)) e) e ⊑
    icmp IntPredicate.ne (LLVM.and e (LLVM.xor (shl (const? (-1)) e_1 { «nsw» := true, «nuw» := false }) (const? (-2))))
      (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


