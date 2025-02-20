
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gsubhorhandhxor_proof
theorem sub_to_xor_thm (e e_1 : IntW 32) : sub (LLVM.or e_1 e) (LLVM.and e_1 e) ⊑ LLVM.xor e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_to_xor_or_commuted_thm (e e_1 : IntW 32) : sub (LLVM.or e_1 e) (LLVM.and e e_1) ⊑ LLVM.xor e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sub_to_xor_and_commuted_thm (e e_1 : IntW 32) : sub (LLVM.or e_1 e) (LLVM.and e e_1) ⊑ LLVM.xor e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
