
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsinkhnothintohanotherhhandhofhlogicalhor_proof
theorem t0_proof.t0_thm_1 (e : IntW 1) (e_1 e_2 e_3 e_4 : IntW 8) :
  select (select (LLVM.xor e (const? 1 1)) (const? 1 1) (icmp IntPred.eq e_1 e_2)) e_3 e_4 ⊑
    select (select e (icmp IntPred.ne e_1 e_2) (const? 1 0)) e_4 e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t0_commutative_proof.t0_commutative_thm_1 (e : IntW 1) (e_1 e_2 e_3 e_4 : IntW 8) :
  select (select (icmp IntPred.eq e_1 e_2) (const? 1 1) (LLVM.xor e (const? 1 1))) e_3 e_4 ⊑
    select (select (icmp IntPred.ne e_1 e_2) e (const? 1 0)) e_4 e_3 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
