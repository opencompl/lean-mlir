
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gapinthandhcompare_proof
theorem test1_thm (e e_1 : IntW 33) :
  icmp IntPred.ne (LLVM.and e_1 (const? 33 65280)) (LLVM.and e (const? 33 65280)) ⊑
    icmp IntPred.ne (LLVM.and (LLVM.xor e_1 e) (const? 33 65280)) (const? 33 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry


theorem test2_thm (e e_1 : IntW 999) :
  icmp IntPred.ne (LLVM.and e_1 (const? 999 65280)) (LLVM.and e (const? 999 65280)) ⊑
    icmp IntPred.ne (LLVM.and (LLVM.xor e_1 e) (const? 999 65280)) (const? 999 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    extract_goals
    all_goals sorry
