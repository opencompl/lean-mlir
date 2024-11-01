
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehconstanthlowhbithmaskhandhicmphulehtohicmphule_proof
theorem c0_thm (e : IntW 8) : icmp IntPredicate.ule (LLVM.and e (const? 3)) e ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem cv2_thm (e e_1 : IntW 8) : icmp IntPredicate.ule (LLVM.and (lshr (const? (-1)) e_1) e) e ⊑ const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


