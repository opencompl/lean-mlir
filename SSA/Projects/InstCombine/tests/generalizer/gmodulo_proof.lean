
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gmodulo_proof
theorem modulo2_proof.modulo2_thm_1 (e : IntW 32) :
  add (select (icmp IntPred.slt (LLVM.srem e (const? 32 2)) (const? 32 0)) (const? 32 2) (const? 32 0))
      (LLVM.srem e (const? 32 2)) { «nsw» := true } ⊑
    LLVM.and e (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem modulo4_proof.modulo4_thm_1 (e : IntW 32) :
  add (select (icmp IntPred.slt (LLVM.srem e (const? 32 4)) (const? 32 0)) (const? 32 4) (const? 32 0))
      (LLVM.srem e (const? 32 4)) { «nsw» := true } ⊑
    LLVM.and e (const? 32 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem modulo32_proof.modulo32_thm_1 (e : IntW 32) :
  add (select (icmp IntPred.slt (LLVM.srem e (const? 32 32)) (const? 32 0)) (const? 32 32) (const? 32 0))
      (LLVM.srem e (const? 32 32)) { «nsw» := true } ⊑
    LLVM.and e (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
