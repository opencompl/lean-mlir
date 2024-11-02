
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsdivhexacthbyhpowerhofhtwo_proof
theorem t0_thm (e : IntW 8) : LLVM.sdiv e (const? 8 32) ⊑ ashr e (const? 8 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem n2_thm (e : IntW 8) :
  LLVM.sdiv e (const? 8 (-128)) ⊑ zext 8 (icmp IntPredicate.eq e (const? 8 (-128))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem shl1_nsw_thm (e e_1 : IntW 8) :
  LLVM.sdiv e_1 (shl (const? 8 1) e { «nsw» := true, «nuw» := false }) ⊑ ashr e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem shl1_nsw_not_exact_thm (e e_1 : IntW 8) :
  LLVM.sdiv e_1 (shl (const? 8 1) e { «nsw» := true, «nuw» := false }) ⊑
    LLVM.sdiv e_1 (shl (const? 8 1) e { «nsw» := true, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem prove_exact_with_high_mask_thm (e : IntW 8) :
  LLVM.sdiv (LLVM.and e (const? 8 (-8))) (const? 8 4) ⊑ LLVM.and (ashr e (const? 8 2)) (const? 8 (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem prove_exact_with_high_mask_limit_thm (e : IntW 8) : LLVM.sdiv (LLVM.and e (const? 8 (-8))) (const? 8 8) ⊑ ashr e (const? 8 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


