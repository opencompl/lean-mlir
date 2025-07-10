
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gtrunc_proof
theorem test5_proof.test5_thm_1 (e : IntW 32) :
  trunc 32 (lshr (zext 128 e) (const? 128 16)) ⊑ lshr e (const? 32 16) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test6_proof.test6_thm_1 (e : IntW 64) :
  trunc 32 (lshr (zext 128 e) (const? 128 32)) ⊑ trunc 32 (lshr e (const? 64 32)) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_mul_sign_bits_proof.ashr_mul_sign_bits_thm_1 (e e_1 : IntW 8) :
  trunc 16 (ashr (mul (sext 32 e) (sext 32 e_1)) (const? 32 3)) ⊑
    ashr (mul (sext 16 e) (sext 16 e_1) { «nsw» := true }) (const? 16 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_mul_proof.ashr_mul_thm_1 (e e_1 : IntW 8) :
  trunc 16 (ashr (mul (sext 20 e) (sext 20 e_1)) (const? 20 8)) ⊑
    ashr (mul (sext 16 e) (sext 16 e_1) { «nsw» := true }) (const? 16 8) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_ashr_proof.trunc_ashr_thm_1 (e : IntW 32) :
  trunc 32 (ashr (LLVM.or (zext 36 e) (const? 36 (-2147483648))) (const? 36 8)) ⊑
    LLVM.or (lshr e (const? 32 8)) (const? 32 (-8388608)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 64) :
  trunc 92 (lshr (zext 128 e) (const? 128 32)) ⊑ zext 92 (lshr e (const? 64 32)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_proof.test8_thm_1 (e e_1 : IntW 32) :
  trunc 64 (LLVM.or (shl (zext 128 e_1) (const? 128 32)) (zext 128 e)) ⊑
    LLVM.or (shl (zext 64 e_1) (const? 64 32) { «nuw» := true }) (zext 64 e) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 32) :
  trunc 8 (LLVM.and e (const? 32 42)) ⊑ LLVM.and (trunc 8 e) (const? 8 42) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test11_proof.test11_thm_1 (e e_1 : IntW 32) :
  trunc 64 (shl (zext 128 e) (LLVM.and (zext 128 e_1) (const? 128 31))) ⊑
    shl (zext 64 e) (zext 64 (LLVM.and e_1 (const? 32 31)) { «nneg» := true }) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test12_proof.test12_thm_1 (e e_1 : IntW 32) :
  trunc 64 (lshr (zext 128 e) (LLVM.and (zext 128 e_1) (const? 128 31))) ⊑
    lshr (zext 64 e) (zext 64 (LLVM.and e_1 (const? 32 31)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test13_proof.test13_thm_1 (e e_1 : IntW 32) :
  trunc 64 (ashr (sext 128 e) (LLVM.and (zext 128 e_1) (const? 128 31))) ⊑
    ashr (sext 64 e) (zext 64 (LLVM.and e_1 (const? 32 31)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_31_i32_i64_proof.trunc_shl_31_i32_i64_thm_1 (e : IntW 64) :
  trunc 32 (shl e (const? 64 31)) ⊑ shl (trunc 32 e) (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_nsw_31_i32_i64_proof.trunc_shl_nsw_31_i32_i64_thm_1 (e : IntW 64) :
  trunc 32 (shl e (const? 64 31) { «nsw» := true }) ⊑ shl (trunc 32 e) (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_nuw_31_i32_i64_proof.trunc_shl_nuw_31_i32_i64_thm_1 (e : IntW 64) :
  trunc 32 (shl e (const? 64 31) { «nuw» := true }) ⊑ shl (trunc 32 e) (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_nsw_nuw_31_i32_i64_proof.trunc_shl_nsw_nuw_31_i32_i64_thm_1 (e : IntW 64) :
  trunc 32 (shl e (const? 64 31) { «nsw» := true, «nuw» := true }) ⊑ shl (trunc 32 e) (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_15_i16_i64_proof.trunc_shl_15_i16_i64_thm_1 (e : IntW 64) :
  trunc 16 (shl e (const? 64 15)) ⊑ shl (trunc 16 e) (const? 16 15) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_15_i16_i32_proof.trunc_shl_15_i16_i32_thm_1 (e : IntW 32) :
  trunc 16 (shl e (const? 32 15)) ⊑ shl (trunc 16 e) (const? 16 15) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_7_i8_i64_proof.trunc_shl_7_i8_i64_thm_1 (e : IntW 64) :
  trunc 8 (shl e (const? 64 7)) ⊑ shl (trunc 8 e) (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_1_i32_i64_proof.trunc_shl_1_i32_i64_thm_1 (e : IntW 64) :
  trunc 32 (shl e (const? 64 1)) ⊑ shl (trunc 32 e) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_16_i32_i64_proof.trunc_shl_16_i32_i64_thm_1 (e : IntW 64) :
  trunc 32 (shl e (const? 64 16)) ⊑ shl (trunc 32 e) (const? 32 16) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_33_i32_i64_proof.trunc_shl_33_i32_i64_thm_1 (e : IntW 64) : trunc 32 (shl e (const? 64 33)) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_32_i32_i64_proof.trunc_shl_32_i32_i64_thm_1 (e : IntW 64) : trunc 32 (shl e (const? 64 32)) ⊑ const? 32 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_lshr_infloop_proof.trunc_shl_lshr_infloop_thm_1 (e : IntW 64) :
  trunc 32 (shl (lshr e (const? 64 1)) (const? 64 2)) ⊑
    LLVM.and (shl (trunc 32 e) (const? 32 1)) (const? 32 (-4)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_ashr_infloop_proof.trunc_shl_ashr_infloop_thm_1 (e : IntW 64) :
  trunc 32 (shl (ashr e (const? 64 3)) (const? 64 2)) ⊑
    LLVM.and (trunc 32 (lshr e (const? 64 1))) (const? 32 (-4)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_shl_infloop_proof.trunc_shl_shl_infloop_thm_1 (e : IntW 64) :
  trunc 32 (shl (shl e (const? 64 1)) (const? 64 2)) ⊑ shl (trunc 32 e) (const? 32 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_lshr_var_proof.trunc_shl_lshr_var_thm_1 (e e_1 : IntW 64) :
  trunc 32 (shl (lshr e e_1) (const? 64 2)) ⊑ shl (trunc 32 (lshr e e_1)) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_ashr_var_proof.trunc_shl_ashr_var_thm_1 (e e_1 : IntW 64) :
  trunc 32 (shl (ashr e e_1) (const? 64 2)) ⊑ shl (trunc 32 (ashr e e_1)) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_shl_shl_var_proof.trunc_shl_shl_var_thm_1 (e e_1 : IntW 64) :
  trunc 32 (shl (shl e e_1) (const? 64 2)) ⊑ shl (trunc 32 (shl e e_1)) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR44545_proof.PR44545_thm_1 (e e_1 : IntW 32) :
  add
      (trunc 16
        (select (icmp IntPred.eq e_1 (const? 32 0)) (const? 32 0)
          (add e (const? 32 1) { «nsw» := true, «nuw» := true })))
      (const? 16 (-1)) { «nsw» := true } ⊑
    select (icmp IntPred.eq e_1 (const? 32 0)) (const? 16 (-1)) (trunc 16 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem drop_nsw_trunc_proof.drop_nsw_trunc_thm_1 (e e_1 : IntW 16) :
  trunc 8 (LLVM.and (LLVM.and e (const? 16 255)) e_1) { «nsw» := true } ⊑ trunc 8 (LLVM.and e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem drop_nuw_trunc_proof.drop_nuw_trunc_thm_1 (e e_1 : IntW 16) :
  trunc 8 (LLVM.and (LLVM.and e (const? 16 255)) e_1) { «nuw» := true } ⊑ trunc 8 (LLVM.and e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem drop_both_trunc_proof.drop_both_trunc_thm_1 (e e_1 : IntW 16) :
  trunc 8 (LLVM.and (LLVM.and e (const? 16 255)) e_1) { «nsw» := true, «nuw» := true } ⊑
    trunc 8 (LLVM.and e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_nuw_xor_proof.trunc_nuw_xor_thm_1 (e e_1 : IntW 8) :
  trunc 1 (LLVM.xor e e_1) { «nuw» := true } ⊑ icmp IntPred.ne e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_nsw_xor_proof.trunc_nsw_xor_thm_1 (e e_1 : IntW 8) :
  trunc 1 (LLVM.xor e e_1) { «nsw» := true } ⊑ icmp IntPred.ne e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
