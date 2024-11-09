
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gselecthcmpheqhophfold_proof
theorem replace_with_y_noundef_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPredicate.eq e_2 e_1) (LLVM.and e_2 e_1) e ⊑ select (icmp IntPredicate.eq e_2 e_1) e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


