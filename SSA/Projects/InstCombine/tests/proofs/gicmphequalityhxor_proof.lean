
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gicmphequalityhxor_proof
theorem cmpeq_xor_cst1_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.xor e_1 (const? 32 10)) e ⊑ icmp IntPred.eq (LLVM.xor e_1 e) (const? 32 10) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem cmpeq_xor_cst3_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.xor e_1 (const? 32 10)) (LLVM.xor e (const? 32 10)) ⊑ icmp IntPred.eq e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem cmpne_xor_cst1_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.xor e_1 (const? 32 10)) e ⊑ icmp IntPred.ne (LLVM.xor e_1 e) (const? 32 10) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem cmpne_xor_cst3_thm (e e_1 : IntW 32) :
  icmp IntPred.ne (LLVM.xor e_1 (const? 32 10)) (LLVM.xor e (const? 32 10)) ⊑ icmp IntPred.ne e_1 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem cmpeq_xor_cst1_commuted_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (mul e_1 e_1) (LLVM.xor e (const? 32 10)) ⊑
    icmp IntPred.eq (LLVM.xor e (mul e_1 e_1)) (const? 32 10) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo1_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and e_1 (const? 32 (-2147483648)))
      (LLVM.and (LLVM.xor e (const? 32 (-1))) (const? 32 (-2147483648))) ⊑
    icmp IntPred.slt (LLVM.xor e e_1) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo2_thm (e e_1 : IntW 32) :
  icmp IntPred.eq (LLVM.and e_1 (const? 32 (-2147483648)))
      (LLVM.xor (LLVM.and e (const? 32 (-2147483648))) (const? 32 (-2147483648))) ⊑
    icmp IntPred.slt (LLVM.xor e e_1) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
