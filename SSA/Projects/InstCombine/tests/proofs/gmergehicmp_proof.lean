
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gmergehicmp_proof
theorem or_basic_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e) (const? 8 127))
      (icmp IntPredicate.ne (LLVM.and e (const? 16 (-256))) (const? 16 17664)) ⊑
    icmp IntPredicate.ne e (const? 16 17791) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_basic_commuted_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (LLVM.and e (const? 16 (-256))) (const? 16 32512))
      (icmp IntPredicate.ne (trunc 8 e) (const? 8 69)) ⊑
    icmp IntPredicate.ne e (const? 16 32581) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_nontrivial_mask1_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e) (const? 8 127))
      (icmp IntPredicate.ne (LLVM.and e (const? 16 3840)) (const? 16 1280)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 16 4095)) (const? 16 1407) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_nontrivial_mask2_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e) (const? 8 127))
      (icmp IntPredicate.ne (LLVM.and e (const? 16 (-4096))) (const? 16 20480)) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 16 (-3841))) (const? 16 20607) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_wrong_const1_thm (e : IntW 16) :
  LLVM.or (icmp IntPredicate.ne (trunc 8 e) (const? 8 127))
      (icmp IntPredicate.ne (LLVM.and e (const? 16 (-256))) (const? 16 17665)) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
