
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section ginstcombinehverifyhknownhbits_proof
theorem pr110631_thm (e : IntW 32) (e_1 : IntW 64) :
  trunc 16
      (LLVM.xor (sext 32 (trunc 16 (trunc 32 (LLVM.and e_1 (zext 64 (LLVM.xor e (const? 32 48991))))))) (const? 32 1)) ⊑
    LLVM.xor (trunc 16 (LLVM.and (LLVM.xor e (const? 32 48991)) (trunc 32 e_1))) (const? 16 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


