
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gredundanthlefthshifthinputhmaskinghpr49778_proof
theorem src_proof.src_thm_1 (e : IntW 1) :
  shl (LLVM.and (LLVM.xor (shl (const? 32 (-1)) (zext 32 e)) (const? 32 (-1))) (zext 32 e)) (zext 32 e) ⊑
    shl (LLVM.and (LLVM.xor (shl (const? 32 (-1)) (zext 32 e) { «nsw» := true }) (const? 32 (-1))) (zext 32 e))
      (zext 32 e) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
