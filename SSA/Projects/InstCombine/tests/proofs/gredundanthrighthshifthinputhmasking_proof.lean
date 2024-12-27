
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gredundanthrighthshifthinputhmasking_proof
theorem t0_lshr_thm (e e_1 : IntW 32) :
  lshr (LLVM.and (shl (const? 32 (-1)) e_1) e) e_1 { «exact» := true } ⊑
    lshr (LLVM.and (shl (const? 32 (-1)) e_1 { «nsw» := true, «nuw» := false }) e) e_1 { «exact» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_sshr_thm (e e_1 : IntW 32) :
  ashr (LLVM.and (shl (const? 32 (-1)) e_1) e) e_1 { «exact» := true } ⊑
    ashr (LLVM.and (shl (const? 32 (-1)) e_1 { «nsw» := true, «nuw» := false }) e) e_1 { «exact» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n13_thm (e e_1 e_2 : IntW 32) :
  lshr (LLVM.and (shl (const? 32 (-1)) e_2) e_1) e ⊑
    lshr (LLVM.and (shl (const? 32 (-1)) e_2 { «nsw» := true, «nuw» := false }) e_1) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


