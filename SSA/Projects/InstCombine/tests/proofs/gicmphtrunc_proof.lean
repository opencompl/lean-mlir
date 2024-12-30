
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gicmphtrunc_proof
theorem ult_2_thm (e : IntW 32) :
  icmp IntPredicate.ult (trunc 8 e) (const? 8 2) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 254)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_192_thm (e : IntW 32) :
  icmp IntPredicate.ult (trunc 8 e) (const? 8 (-64)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 192)) (const? 32 192) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_3_thm (e : IntW 32) :
  icmp IntPredicate.ugt (trunc 8 e) (const? 8 3) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 252)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_253_thm (e : IntW 32) :
  icmp IntPredicate.ugt (trunc 8 e) (const? 8 (-3)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 254)) (const? 32 254) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_0_thm (e : IntW 32) :
  icmp IntPredicate.slt (trunc 8 e) (const? 8 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 32 128)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_n1_thm (e : IntW 32) :
  icmp IntPredicate.sgt (trunc 8 e) (const? 8 (-1)) ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 32 128)) (const? 32 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl1_trunc_eq0_thm (e : IntW 32) :
  icmp IntPredicate.eq (trunc 16 (shl (const? 32 1) e)) (const? 16 0) ⊑ icmp IntPredicate.ugt e (const? 32 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl1_trunc_sgt0_thm (e : IntW 9) :
  icmp IntPredicate.sgt (trunc 6 (shl (const? 9 1) e)) (const? 6 0) ⊑
    icmp IntPredicate.sgt (trunc 6 (shl (const? 9 1) e { «nsw» := false, «nuw» := true })) (const? 6 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl1_trunc_sgt4_thm (e : IntW 32) :
  icmp IntPredicate.sgt (trunc 16 (shl (const? 32 1) e)) (const? 16 4) ⊑
    icmp IntPredicate.sgt (trunc 16 (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) (const? 16 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


