
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gsinkhnothintohanotherhhandhofhlogicalhand_proof
theorem t0_thm (e e_1 e_2 e_3 : IntW 8) (e_4 : IntW 1) :
  select (select (LLVM.xor e_4 (const? 1 1)) (icmp IntPredicate.eq e_3 e_2) (const? 1 0)) e_1 e ⊑
    select (select e_4 (const? 1 1) (icmp IntPredicate.ne e_3 e_2)) e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t0_commutative_thm (e e_1 : IntW 8) (e_2 : IntW 1) (e_3 e_4 : IntW 8) :
  select (select (icmp IntPredicate.eq e_4 e_3) (LLVM.xor e_2 (const? 1 1)) (const? 1 0)) e_1 e ⊑
    select (select (icmp IntPredicate.ne e_4 e_3) (const? 1 1) e_2) e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


