
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section g2010h11h23hDistributed_proof
theorem foo_proof.foo_thm_1 (e e_1 : IntW 32) :
  sub (mul (add e_1 e { «nsw» := true }) e_1 { «nsw» := true }) (mul e_1 e_1 { «nsw» := true }) ⊑ mul e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bar_proof.bar_thm_1 (e e_1 : IntW 64) :
  icmp IntPred.eq (LLVM.and e_1 (LLVM.xor (LLVM.and e_1 e) (const? 64 (-1)))) (const? 64 0) ⊑
    icmp IntPred.eq (LLVM.and e_1 (LLVM.xor e (const? 64 (-1)))) (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
