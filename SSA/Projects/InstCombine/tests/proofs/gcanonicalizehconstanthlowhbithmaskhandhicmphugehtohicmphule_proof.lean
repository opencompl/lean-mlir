
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gcanonicalizehconstanthlowhbithmaskhandhicmphugehtohicmphule_proof
theorem p0_thm (e : IntW 8) :
  icmp IntPredicate.uge (LLVM.and e (const? 8 3)) e ⊑ icmp IntPredicate.ult e (const? 8 4) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem pv_thm (e e_1 : IntW 8) :
  icmp IntPredicate.uge (LLVM.and (lshr (const? 8 (-1)) e_1) e) e ⊑
    icmp IntPredicate.ule e (lshr (const? 8 (-1)) e_1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n0_thm (e : IntW 8) :
  icmp IntPredicate.uge (LLVM.and e (const? 8 4)) e ⊑
    icmp IntPredicate.eq (LLVM.and e (const? 8 (-5))) (const? 8 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


