
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsethlowbitshmaskhcanonicalize_proof
theorem shl_add_proof.shl_add_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e) (const? 32 (-1)) ⊑
    LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true }) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_nsw_proof.shl_add_nsw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e) (const? 32 (-1)) { «nsw» := true } ⊑
    LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true }) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_nuw_proof.shl_add_nuw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e) (const? 32 (-1)) { «nuw» := true } ⊑ const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_add_nsw_nuw_proof.shl_add_nsw_nuw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e) (const? 32 (-1)) { «nsw» := true, «nuw» := true } ⊑ const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_add_proof.shl_nsw_add_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nsw» := true }) (const? 32 (-1)) ⊑
    LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true }) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_add_nsw_proof.shl_nsw_add_nsw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nsw» := true }) (const? 32 (-1)) { «nsw» := true } ⊑
    LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true }) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_add_nuw_proof.shl_nsw_add_nuw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nsw» := true }) (const? 32 (-1)) { «nuw» := true } ⊑ const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_add_nsw_nuw_proof.shl_nsw_add_nsw_nuw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nsw» := true }) (const? 32 (-1)) { «nsw» := true, «nuw» := true } ⊑
    const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nuw_add_proof.shl_nuw_add_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nuw» := true }) (const? 32 (-1)) ⊑
    LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true }) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nuw_add_nsw_proof.shl_nuw_add_nsw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nuw» := true }) (const? 32 (-1)) { «nsw» := true } ⊑
    LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true }) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nuw_add_nuw_proof.shl_nuw_add_nuw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nuw» := true }) (const? 32 (-1)) { «nuw» := true } ⊑ const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nuw_add_nsw_nuw_proof.shl_nuw_add_nsw_nuw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nuw» := true }) (const? 32 (-1)) { «nsw» := true, «nuw» := true } ⊑
    const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_nuw_add_proof.shl_nsw_nuw_add_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nsw» := true, «nuw» := true }) (const? 32 (-1)) ⊑
    LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true }) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_nuw_add_nsw_proof.shl_nsw_nuw_add_nsw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nsw» := true, «nuw» := true }) (const? 32 (-1)) { «nsw» := true } ⊑
    LLVM.xor (shl (const? 32 (-1)) e { «nsw» := true }) (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_nuw_add_nuw_proof.shl_nsw_nuw_add_nuw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nsw» := true, «nuw» := true }) (const? 32 (-1)) { «nuw» := true } ⊑
    const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shl_nsw_nuw_add_nsw_nuw_proof.shl_nsw_nuw_add_nsw_nuw_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e { «nsw» := true, «nuw» := true }) (const? 32 (-1)) { «nsw» := true, «nuw» := true } ⊑
    const? 32 (-1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bad_add0_proof.bad_add0_thm_1 (e e_1 : IntW 32) :
  add (shl (const? 32 1) e) e_1 ⊑ add (shl (const? 32 1) e { «nuw» := true }) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bad_add1_proof.bad_add1_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e) (const? 32 1) ⊑
    add (shl (const? 32 1) e { «nuw» := true }) (const? 32 1) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem bad_add2_proof.bad_add2_thm_1 (e : IntW 32) :
  add (shl (const? 32 1) e) (const? 32 (-2)) ⊑ add (shl (const? 32 1) e { «nuw» := true }) (const? 32 (-2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
