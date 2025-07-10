
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsignmaskhofhsexthvshofhshlhofhzext_proof
theorem t0_proof.t0_thm_1 (e : IntW 16) :
  LLVM.and (shl (zext 32 e) (const? 32 16)) (const? 32 (-2147483648)) ⊑
    LLVM.and (sext 32 e) (const? 32 (-2147483648)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_proof.t1_thm_1 (e : IntW 8) :
  LLVM.and (shl (zext 32 e) (const? 32 24)) (const? 32 (-2147483648)) ⊑
    LLVM.and (sext 32 e) (const? 32 (-2147483648)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n2_proof.n2_thm_1 (e : IntW 16) :
  LLVM.and (shl (zext 32 e) (const? 32 15)) (const? 32 (-2147483648)) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n4_proof.n4_thm_1 (e : IntW 16) :
  LLVM.and (shl (zext 32 e) (const? 32 16)) (const? 32 (-1073741824)) ⊑
    LLVM.and (shl (zext 32 e) (const? 32 16) { «nuw» := true }) (const? 32 (-1073741824)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
