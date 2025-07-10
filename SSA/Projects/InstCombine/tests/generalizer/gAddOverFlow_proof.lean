
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gAddOverFlow_proof
theorem oppositesign_proof.oppositesign_thm_1 (e e_1 : IntW 16) :
  add (LLVM.or e (const? 16 (-32768))) (LLVM.and e_1 (const? 16 32767)) ⊑
    add (LLVM.or e (const? 16 (-32768))) (LLVM.and e_1 (const? 16 32767)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem zero_sign_bit_proof.zero_sign_bit_thm_1 (e : IntW 16) :
  add (LLVM.and e (const? 16 32767)) (const? 16 512) ⊑
    add (LLVM.and e (const? 16 32767)) (const? 16 512) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem zero_sign_bit2_proof.zero_sign_bit2_thm_1 (e e_1 : IntW 16) :
  add (LLVM.and e (const? 16 32767)) (LLVM.and e_1 (const? 16 32767)) ⊑
    add (LLVM.and e (const? 16 32767)) (LLVM.and e_1 (const? 16 32767)) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ripple_nsw1_proof.ripple_nsw1_thm_1 (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? 16 1)) (LLVM.and e (const? 16 (-16385))) ⊑
    add (LLVM.and e_1 (const? 16 1)) (LLVM.and e (const? 16 (-16385))) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ripple_nsw2_proof.ripple_nsw2_thm_1 (e e_1 : IntW 16) :
  add (LLVM.and e (const? 16 (-16385))) (LLVM.and e_1 (const? 16 1)) ⊑
    add (LLVM.and e (const? 16 (-16385))) (LLVM.and e_1 (const? 16 1)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ripple_nsw3_proof.ripple_nsw3_thm_1 (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? 16 (-21845))) (LLVM.and e (const? 16 21843)) ⊑
    add (LLVM.and e_1 (const? 16 (-21845))) (LLVM.and e (const? 16 21843)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ripple_nsw4_proof.ripple_nsw4_thm_1 (e e_1 : IntW 16) :
  add (LLVM.and e (const? 16 21843)) (LLVM.and e_1 (const? 16 (-21845))) ⊑
    add (LLVM.and e (const? 16 21843)) (LLVM.and e_1 (const? 16 (-21845))) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ripple_nsw5_proof.ripple_nsw5_thm_1 (e e_1 : IntW 16) :
  add (LLVM.or e_1 (const? 16 (-21845))) (LLVM.or e (const? 16 (-10923))) ⊑
    add (LLVM.or e_1 (const? 16 (-21845))) (LLVM.or e (const? 16 (-10923))) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ripple_nsw6_proof.ripple_nsw6_thm_1 (e e_1 : IntW 16) :
  add (LLVM.or e (const? 16 (-10923))) (LLVM.or e_1 (const? 16 (-21845))) ⊑
    add (LLVM.or e (const? 16 (-10923))) (LLVM.or e_1 (const? 16 (-21845))) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ripple_no_nsw2_proof.ripple_no_nsw2_thm_1 (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? 16 1)) (LLVM.and e (const? 16 32767)) ⊑
    add (LLVM.and e_1 (const? 16 1)) (LLVM.and e (const? 16 32767)) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR38021_proof.PR38021_thm_1 (e : IntW 8) :
  add (lshr e (const? 8 3)) (const? 8 (-63)) ⊑
    add (lshr e (const? 8 3)) (const? 8 (-63)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
