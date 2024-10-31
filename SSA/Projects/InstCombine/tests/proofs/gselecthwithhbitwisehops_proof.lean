
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gselecthwithhbitwisehops_proof
theorem set_bits_thm (e✝ : IntW 8) (e✝¹ : IntW 1) :
  select e✝¹ (LLVM.or e✝ (const? 5)) (LLVM.and e✝ (const? (-6))) ⊑
    LLVM.or (LLVM.and e✝ (const? (-6))) (select e✝¹ (const? 5) (const? 0)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


