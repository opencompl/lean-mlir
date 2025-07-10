
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecth2_proof
theorem ashr_exact_poison_constant_fold_proof.ashr_exact_poison_constant_fold_thm_1 (e : IntW 1) (e_1 : IntW 8) :
  ashr (select e e_1 (const? 8 42)) (const? 8 3) { «exact» := true } ⊑
    select e (ashr e_1 (const? 8 3)) (const? 8 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_exact_proof.ashr_exact_thm_1 (e : IntW 1) (e_1 : IntW 8) :
  ashr (select e e_1 (const? 8 16)) (const? 8 3) { «exact» := true } ⊑
    select e (ashr e_1 (const? 8 3) { «exact» := true }) (const? 8 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_nuw_poison_constant_fold_proof.shl_nsw_nuw_poison_constant_fold_thm_1 (e : IntW 1) (e_1 : IntW 8) :
  shl (const? 8 16) (select e (const? 8 3) e_1) { «nsw» := true, «nuw» := true } ⊑
    select e (const? 8 (-128)) (shl (const? 8 16) e_1 { «nsw» := true, «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_nuw_proof.shl_nsw_nuw_thm_1 (e : IntW 1) (e_1 : IntW 8) :
  shl (const? 8 7) (select e (const? 8 3) e_1) { «nsw» := true, «nuw» := true } ⊑
    select e (const? 8 56) (shl (const? 8 7) e_1 { «nsw» := true, «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nsw_poison_constant_fold_proof.add_nsw_poison_constant_fold_thm_1 (e : IntW 1) (e_1 : IntW 8) :
  add (select e e_1 (const? 8 65)) (const? 8 64) { «nsw» := true } ⊑
    select e (add e_1 (const? 8 64) { «nsw» := true }) (const? 8 (-127)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nsw_proof.add_nsw_thm_1 (e : IntW 1) (e_1 : IntW 8) :
  add (select e e_1 (const? 8 7)) (const? 8 64) { «nsw» := true } ⊑
    select e (add e_1 (const? 8 64) { «nsw» := true }) (const? 8 71) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
