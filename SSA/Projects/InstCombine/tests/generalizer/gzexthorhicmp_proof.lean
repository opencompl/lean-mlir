
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gzexthorhicmp_proof
theorem zext_or_eq_ult_add_proof.zext_or_eq_ult_add_thm_1 (e : IntW 32) :
  zext 32 (LLVM.or (icmp IntPred.ult (add e (const? 32 (-3))) (const? 32 3)) (icmp IntPred.eq e (const? 32 5))) ⊑
    zext 32 (icmp IntPred.ult (add e (const? 32 (-3))) (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_zext_or_eq_ult_add_proof.select_zext_or_eq_ult_add_thm_1 (e : IntW 32) :
  select (icmp IntPred.ult (add e (const? 32 (-3))) (const? 32 2)) (const? 32 1)
      (zext 32 (icmp IntPred.eq e (const? 32 5))) ⊑
    zext 32 (icmp IntPred.ult (add e (const? 32 (-3))) (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
