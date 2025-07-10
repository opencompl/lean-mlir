
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gadd2_proof
theorem test1_proof.test1_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  LLVM.and (add (shl (zext 64 e_1) (const? 64 32)) e) (const? 64 123) ⊑ LLVM.and e (const? 64 123) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test2_proof.test2_thm_1 (e : IntW 32) :
  add (LLVM.and e (const? 32 7)) (LLVM.and e (const? 32 32)) ⊑ LLVM.and e (const? 32 39) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 32) :
  add (LLVM.and e (const? 32 128)) (lshr e (const? 32 30)) ⊑
    LLVM.or (LLVM.and e (const? 32 128)) (lshr e (const? 32 30)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e : IntW 32) :
  add e e { «nuw» := true } ⊑ shl e (const? 32 1) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 16) :
  add (mul e (const? 16 2)) (mul e (const? 16 32767)) ⊑ mul e (const? 16 (-32767)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1))
      (LLVM.xor (LLVM.or (ashr e (const? 32 3)) (const? 32 (-1431655766))) (const? 32 1431655765)) ⊑
    sub e_1 (LLVM.and (ashr e (const? 32 3)) (const? 32 1431655765)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1)) (LLVM.xor (LLVM.or e (const? 32 (-1431655766))) (const? 32 1431655765)) ⊑
    sub e_1 (LLVM.and e (const? 32 1431655765)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_proof.test12_thm_1 (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1) { «nsw» := true }) (LLVM.xor (LLVM.or e (const? 32 (-1431655766))) (const? 32 1431655765))
      { «nsw» := true } ⊑
    sub e_1 (LLVM.and e (const? 32 1431655765)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1)) (LLVM.xor (LLVM.or e (const? 32 (-1431655767))) (const? 32 1431655766)) ⊑
    sub e_1 (LLVM.and e (const? 32 1431655766)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test14_proof.test14_thm_1 (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1) { «nsw» := true }) (LLVM.xor (LLVM.or e (const? 32 (-1431655767))) (const? 32 1431655766))
      { «nsw» := true } ⊑
    sub e_1 (LLVM.and e (const? 32 1431655766)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test15_proof.test15_thm_1 (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1)) (LLVM.xor (LLVM.and e (const? 32 (-1431655767))) (const? 32 (-1431655767))) ⊑
    sub e_1 (LLVM.or e (const? 32 1431655766)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test16_proof.test16_thm_1 (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1) { «nsw» := true })
      (LLVM.xor (LLVM.and e (const? 32 (-1431655767))) (const? 32 (-1431655767))) { «nsw» := true } ⊑
    sub e_1 (LLVM.or e (const? 32 1431655766)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test17_proof.test17_thm_1 (e e_1 : IntW 32) :
  add (LLVM.xor (LLVM.and e (const? 32 (-1431655766))) (const? 32 (-1431655765))) e_1 { «nsw» := true } ⊑
    sub e_1 (LLVM.or e (const? 32 1431655765)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test18_proof.test18_thm_1 (e e_1 : IntW 32) :
  add (add e_1 (const? 32 1) { «nsw» := true })
      (LLVM.xor (LLVM.and e (const? 32 (-1431655766))) (const? 32 (-1431655766))) { «nsw» := true } ⊑
    sub e_1 (LLVM.or e (const? 32 1431655765)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nsw_mul_nsw_proof.add_nsw_mul_nsw_thm_1 (e : IntW 16) :
  add (add e e { «nsw» := true }) e { «nsw» := true } ⊑ mul e (const? 16 3) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_1_proof.mul_add_to_mul_1_thm_1 (e : IntW 16) :
  add e (mul e (const? 16 8) { «nsw» := true }) { «nsw» := true } ⊑ mul e (const? 16 9) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_2_proof.mul_add_to_mul_2_thm_1 (e : IntW 16) :
  add (mul e (const? 16 8) { «nsw» := true }) e { «nsw» := true } ⊑ mul e (const? 16 9) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_3_proof.mul_add_to_mul_3_thm_1 (e : IntW 16) :
  add (mul e (const? 16 2)) (mul e (const? 16 3)) { «nsw» := true } ⊑ mul e (const? 16 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_4_proof.mul_add_to_mul_4_thm_1 (e : IntW 16) :
  add (mul e (const? 16 2) { «nsw» := true }) (mul e (const? 16 7) { «nsw» := true }) { «nsw» := true } ⊑
    mul e (const? 16 9) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_5_proof.mul_add_to_mul_5_thm_1 (e : IntW 16) :
  add (mul e (const? 16 3) { «nsw» := true }) (mul e (const? 16 7) { «nsw» := true }) { «nsw» := true } ⊑
    mul e (const? 16 10) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_6_proof.mul_add_to_mul_6_thm_1 (e e_1 : IntW 32) :
  add (mul e e_1 { «nsw» := true }) (mul (mul e e_1 { «nsw» := true }) (const? 32 5) { «nsw» := true })
      { «nsw» := true } ⊑
    mul (mul e e_1 { «nsw» := true }) (const? 32 6) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_7_proof.mul_add_to_mul_7_thm_1 (e : IntW 16) :
  add e (mul e (const? 16 32767) { «nsw» := true }) { «nsw» := true } ⊑ shl e (const? 16 15) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_8_proof.mul_add_to_mul_8_thm_1 (e : IntW 16) :
  add (mul e (const? 16 16383) { «nsw» := true }) (mul e (const? 16 16384) { «nsw» := true }) { «nsw» := true } ⊑
    mul e (const? 16 32767) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mul_add_to_mul_9_proof.mul_add_to_mul_9_thm_1 (e : IntW 16) :
  add (mul e (const? 16 16384) { «nsw» := true }) (mul e (const? 16 16384) { «nsw» := true }) { «nsw» := true } ⊑
    shl e (const? 16 15) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_and_proof.add_or_and_thm_1 (e e_1 : IntW 32) : add (LLVM.or e e_1) (LLVM.and e e_1) ⊑ add e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_or_and_commutative_proof.add_or_and_commutative_thm_1 (e e_1 : IntW 32) :
  add (LLVM.or e e_1) (LLVM.and e_1 e) ⊑ add e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_and_or_proof.add_and_or_thm_1 (e e_1 : IntW 32) : add (LLVM.and e e_1) (LLVM.or e e_1) ⊑ add e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_and_or_commutative_proof.add_and_or_commutative_thm_1 (e e_1 : IntW 32) :
  add (LLVM.and e_1 e) (LLVM.or e e_1) ⊑ add e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nsw_or_and_proof.add_nsw_or_and_thm_1 (e e_1 : IntW 32) :
  add (LLVM.or e e_1) (LLVM.and e e_1) { «nsw» := true } ⊑ add e e_1 { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nuw_or_and_proof.add_nuw_or_and_thm_1 (e e_1 : IntW 32) :
  add (LLVM.or e e_1) (LLVM.and e e_1) { «nuw» := true } ⊑ add e e_1 { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_nuw_nsw_or_and_proof.add_nuw_nsw_or_and_thm_1 (e e_1 : IntW 32) :
  add (LLVM.or e e_1) (LLVM.and e e_1) { «nsw» := true, «nuw» := true } ⊑
    add e e_1 { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_of_mul_proof.add_of_mul_thm_1 (e e_1 e_2 : IntW 8) :
  add (mul e e_1 { «nsw» := true }) (mul e e_2 { «nsw» := true }) { «nsw» := true } ⊑ mul e (add e_1 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_of_selects_proof.add_of_selects_thm_1 (e : IntW 1) (e_1 : IntW 32) :
  add (select e (const? 32 0) (const? 32 (-2))) (select e e_1 (const? 32 2)) ⊑ select e e_1 (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem add_undemanded_low_bits_proof.add_undemanded_low_bits_thm_1 (e : IntW 32) :
  lshr (add (LLVM.or e (const? 32 15)) (const? 32 1616)) (const? 32 4) ⊑
    lshr (add e (const? 32 1616)) (const? 32 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sub_undemanded_low_bits_proof.sub_undemanded_low_bits_thm_1 (e : IntW 32) :
  lshr (sub (LLVM.or e (const? 32 15)) (const? 32 1616)) (const? 32 4) ⊑
    lshr (add e (const? 32 (-1616))) (const? 32 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
