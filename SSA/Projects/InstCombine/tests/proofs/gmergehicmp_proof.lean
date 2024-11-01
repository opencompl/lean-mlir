
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmergehicmp_proof
theorem or_basic_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e) (const? 127))
      (icmp IntPredicate.ne (LLVM.and e (const? (-256))) (const? 17664)) ⊑
    icmp IntPredicate.ne e (const? 17791) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_basic_commuted_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (LLVM.and e (const? (-256))) (const? 32512))
      (icmp IntPredicate.ne (trunc 8 e) (const? 69)) ⊑
    icmp IntPredicate.ne e (const? 32581) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nontrivial_mask1_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e) (const? 127))
      (icmp IntPredicate.ne (LLVM.and e (const? 3840)) (const? 1280)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 4095)) (const? 1407) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_nontrivial_mask2_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e) (const? 127))
      (icmp IntPredicate.ne (LLVM.and e (const? (-4096))) (const? 20480)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? (-3841))) (const? 20607) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem or_wrong_const1_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e) (const? 127))
      (icmp IntPredicate.ne (LLVM.and e (const? (-256))) (const? 17665)) ⊑
    const? 1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


