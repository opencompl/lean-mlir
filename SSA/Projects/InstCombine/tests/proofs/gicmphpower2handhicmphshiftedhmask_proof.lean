
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphpower2handhicmphshiftedhmask_proof
theorem icmp_power2_and_icmp_shifted_mask_2147483648_1610612736_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ult e (const? 32 (-2147483648)))
      (icmp IntPred.ne (LLVM.and e (const? 32 1610612736)) (const? 32 1610612736)) ⊑
    icmp IntPred.ult e (const? 32 1610612736) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_1610612736_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 1610612736)) (const? 32 1610612736))
      (icmp IntPred.ult e (const? 32 (-2147483648))) ⊑
    icmp IntPred.ult e (const? 32 1610612736) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_2147483648_2147483647_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ult e (const? 32 (-2147483648)))
      (icmp IntPred.ne (LLVM.and e (const? 32 2147483647)) (const? 32 2147483647)) ⊑
    icmp IntPred.ult e (const? 32 2147483647) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_2147483647_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 2147483647)) (const? 32 2147483647))
      (icmp IntPred.ult e (const? 32 (-2147483648))) ⊑
    icmp IntPred.ult e (const? 32 2147483647) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_2147483648_805306368_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ult e (const? 32 1073741824))
      (icmp IntPred.ne (LLVM.and e (const? 32 805306368)) (const? 32 805306368)) ⊑
    icmp IntPred.ult e (const? 32 805306368) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_2147483648_805306368_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 805306368)) (const? 32 805306368))
      (icmp IntPred.ult e (const? 32 1073741824)) ⊑
    icmp IntPred.ult e (const? 32 805306368) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_1073741824_1073741823_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ult e (const? 32 1073741824))
      (icmp IntPred.ne (LLVM.and e (const? 32 1073741823)) (const? 32 1073741823)) ⊑
    icmp IntPred.ult e (const? 32 1073741823) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_1073741824_1073741823_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 1073741823)) (const? 32 1073741823))
      (icmp IntPred.ult e (const? 32 1073741824)) ⊑
    icmp IntPred.ult e (const? 32 1073741823) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_8_7_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ult e (const? 32 8)) (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7)) ⊑
    icmp IntPred.ult e (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_8_7_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7)) (icmp IntPred.ult e (const? 32 8)) ⊑
    icmp IntPred.ult e (const? 32 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_8_6_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ult e (const? 32 8)) (icmp IntPred.ne (LLVM.and e (const? 32 6)) (const? 32 6)) ⊑
    icmp IntPred.ult e (const? 32 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem icmp_power2_and_icmp_shifted_mask_swapped_8_6_thm (e : IntW 32) :
  LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 6)) (const? 32 6)) (icmp IntPred.ult e (const? 32 8)) ⊑
    icmp IntPred.ult e (const? 32 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
