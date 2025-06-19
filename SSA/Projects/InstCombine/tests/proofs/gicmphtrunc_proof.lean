
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphtrunc_proof
theorem ult_2_thm (e : IntW 32) :
  icmp IntPred.ult (trunc 8 e) (const? 8 2) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 254)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ult_192_thm (e : IntW 32) :
  icmp IntPred.ult (trunc 8 e) (const? 8 (-64)) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 192)) (const? 32 192) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_3_thm (e : IntW 32) :
  icmp IntPred.ugt (trunc 8 e) (const? 8 3) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 252)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ugt_253_thm (e : IntW 32) :
  icmp IntPred.ugt (trunc 8 e) (const? 8 (-3)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 254)) (const? 32 254) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_0_thm (e : IntW 32) :
  icmp IntPred.slt (trunc 8 e) (const? 8 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 128)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sgt_n1_thm (e : IntW 32) :
  icmp IntPred.sgt (trunc 8 e) (const? 8 (-1)) ⊑
    icmp IntPred.eq (LLVM.and e (const? 32 128)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl1_trunc_eq0_thm (e : IntW 32) :
  icmp IntPred.eq (trunc 16 (shl (const? 32 1) e)) (const? 16 0) ⊑ icmp IntPred.ugt e (const? 32 15) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl1_trunc_sgt0_thm (e : IntW 9) :
  icmp IntPred.sgt (trunc 6 (shl (const? 9 1) e)) (const? 6 0) ⊑
    icmp IntPred.sgt (trunc 6 (shl (const? 9 1) e { «nsw» := false, «nuw» := true })) (const? 6 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shl1_trunc_sgt4_thm (e : IntW 32) :
  icmp IntPred.sgt (trunc 16 (shl (const? 32 1) e)) (const? 16 4) ⊑
    icmp IntPred.sgt (trunc 16 (shl (const? 32 1) e { «nsw» := false, «nuw» := true })) (const? 16 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
