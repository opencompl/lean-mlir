
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gcanonicalizehselectshicmphconditionhbittest_proof
theorem p0_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e_2 (const? 8 1)) (const? 8 1)) e_1 e ⊑
    select (icmp IntPred.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem p1_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.ne (LLVM.and e_2 (const? 8 1)) (const? 8 0)) e_1 e ⊑
    select (icmp IntPred.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n5_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e_2 (const? 8 1)) (const? 8 2)) e_1 e ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n6_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e_2 (const? 8 1)) (const? 8 3)) e_1 e ⊑ e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n7_thm (e e_1 e_2 : IntW 8) :
  select (icmp IntPred.ne (LLVM.and e_2 (const? 8 1)) (const? 8 1)) e_1 e ⊑
    select (icmp IntPred.eq (LLVM.and e_2 (const? 8 1)) (const? 8 0)) e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
