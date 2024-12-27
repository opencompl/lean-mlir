
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxRecDepth 3000

section gdemorganhsinkhnothintohxor_proof
theorem positive_easyinvert_thm (e : IntW 16) (e_1 : IntW 8) :
  LLVM.xor (LLVM.xor (icmp IntPredicate.slt e_1 (const? 8 0)) (icmp IntPredicate.slt e (const? 16 0))) (const? 1 1) ⊑
    LLVM.xor (icmp IntPredicate.slt e_1 (const? 8 0)) (icmp IntPredicate.sgt e (const? 16 (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


