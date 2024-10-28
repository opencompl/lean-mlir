
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsdivh1_proof
theorem c_thm : LLVM.sdiv (sub (const? 0) (const? (-2147483648))) (const? (-3)) ⊑ const? 715827882 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


