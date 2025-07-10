
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section ghighhbithsignmaskhwithhtrunc_proof
theorem t0_proof.t0_thm_1 (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (lshr e (const? 64 63))) ⊑ trunc 32 (ashr e (const? 64 63)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_exact_proof.t1_exact_thm_1 (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (lshr e (const? 64 63) { «exact» := true })) ⊑
    trunc 32 (ashr e (const? 64 63) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t2_proof.t2_thm_1 (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (ashr e (const? 64 63))) ⊑
    trunc 32 (lshr e (const? 64 63)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_exact_proof.t3_exact_thm_1 (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (ashr e (const? 64 63) { «exact» := true })) ⊑
    trunc 32 (lshr e (const? 64 63) { «exact» := true }) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n9_proof.n9_thm_1 (e : IntW 64) :
  sub (const? 32 0) (trunc 32 (lshr e (const? 64 62))) ⊑
    sub (const? 32 0) (trunc 32 (lshr e (const? 64 62)) { «nsw» := true, «nuw» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n10_proof.n10_thm_1 (e : IntW 64) :
  sub (const? 32 1) (trunc 32 (lshr e (const? 64 63))) ⊑
    add (trunc 32 (ashr e (const? 64 63)) { «nsw» := true }) (const? 32 1) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
