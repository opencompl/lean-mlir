
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gapinthnot_proof
theorem test1_thm (e : IntW 33) : LLVM.xor (LLVM.xor e (const? 33 (-1))) (const? 33 (-1)) ⊑ e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test2_thm (e e_1 : IntW 52) :
  LLVM.xor (icmp IntPredicate.ule e_1 e) (const? 1 1) ⊑ icmp IntPredicate.ugt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


