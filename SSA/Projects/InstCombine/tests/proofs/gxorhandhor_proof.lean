
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gxorhandhor_proof
theorem xor_logic_and_logic_or1_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e_2 e_1 (const? 1 0)) (select e_2 (const? 1 1) e) ⊑ select e_2 (LLVM.xor e_1 (const? 1 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_logic_and_logic_or2_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e_2 e_1 (const? 1 0)) (select e (const? 1 1) e_2) ⊑ select e_2 (LLVM.xor e_1 (const? 1 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_logic_and_logic_or4_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e_2 e_1 (const? 1 0)) (select e_1 (const? 1 1) e) ⊑ select e_1 (LLVM.xor e_2 (const? 1 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_and_logic_or1_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (LLVM.and e_2 e_1) (select e_2 (const? 1 1) e) ⊑ select e_2 (LLVM.xor e_1 (const? 1 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_and_logic_or2_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (LLVM.and e_2 e_1) (select e (const? 1 1) e_1) ⊑ select e_1 (LLVM.xor e_2 (const? 1 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_logic_and_or1_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e_2 e_1 (const? 1 0)) (LLVM.or e e_2) ⊑ select e_2 (LLVM.xor e_1 (const? 1 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_logic_and_or2_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (select e_2 e_1 (const? 1 0)) (LLVM.or e_1 e) ⊑ select e_1 (LLVM.xor e_2 (const? 1 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_and_or_thm (e e_1 e_2 : IntW 1) :
  LLVM.xor (LLVM.and e_2 e_1) (LLVM.or e e_2) ⊑ select e_2 (LLVM.xor e_1 (const? 1 1)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
