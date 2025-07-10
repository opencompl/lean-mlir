
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gapinthor_proof
theorem test1_proof.test1_thm_1 (e : IntW 23) : LLVM.or e (LLVM.xor (const? 23 (-1)) e) ⊑ const? 23 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e e_1 : IntW 39) :
  LLVM.or
      (LLVM.and (add e (LLVM.and e_1 (const? 39 (-274877906944)))) (LLVM.xor (const? 39 274877906943) (const? 39 (-1))))
      (LLVM.and e (const? 39 274877906943)) ⊑
    add e (LLVM.and e_1 (const? 39 (-274877906944))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e : IntW 1023) :
  LLVM.or e (LLVM.xor (const? 1023 (-1)) e) ⊑ const? 1023 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e e_1 : IntW 399) :
  LLVM.or
      (LLVM.and (add e (LLVM.and e_1 (const? 399 18446742974197923840)))
        (LLVM.xor (const? 399 274877906943) (const? 399 (-1))))
      (LLVM.and e (const? 399 274877906943)) ⊑
    add e (LLVM.and e_1 (const? 399 18446742974197923840)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
