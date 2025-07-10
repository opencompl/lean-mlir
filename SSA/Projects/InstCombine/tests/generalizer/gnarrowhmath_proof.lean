
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gnarrowhmath_proof
theorem sext_sext_add_proof.sext_sext_add_thm_1 (e : IntW 32) :
  add (sext 64 (ashr e (const? 32 7))) (sext 64 (ashr e (const? 32 9))) ⊑
    sext 64 (add (ashr e (const? 32 7)) (ashr e (const? 32 9)) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_zext_add_mismatched_exts_proof.sext_zext_add_mismatched_exts_thm_1 (e : IntW 32) :
  add (sext 64 (ashr e (const? 32 7))) (zext 64 (lshr e (const? 32 9))) ⊑
    add (sext 64 (ashr e (const? 32 7))) (zext 64 (lshr e (const? 32 9)) { «nneg» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_sext_add_mismatched_types_proof.sext_sext_add_mismatched_types_thm_1 (e : IntW 16) (e_1 : IntW 32) :
  add (sext 64 (ashr e (const? 16 7))) (sext 64 (ashr e_1 (const? 32 9))) ⊑
    add (sext 64 (ashr e (const? 16 7))) (sext 64 (ashr e_1 (const? 32 9))) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e : IntW 32) :
  add (sext 64 (ashr e (const? 32 1))) (const? 64 1073741823) ⊑
    sext 64 (add (ashr e (const? 32 1)) (const? 32 1073741823) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test6_proof.test6_thm_1 (e : IntW 32) :
  add (sext 64 (ashr e (const? 32 1))) (const? 64 (-1073741824)) ⊑
    sext 64 (add (ashr e (const? 32 1)) (const? 32 (-1073741824)) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 32) :
  add (zext 64 (lshr e (const? 32 1))) (const? 64 2147483647) ⊑
    zext 64 (add (lshr e (const? 32 1)) (const? 32 2147483647) { «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test8_proof.test8_thm_1 (e : IntW 32) :
  mul (sext 64 (ashr e (const? 32 16))) (const? 64 32767) ⊑
    sext 64 (mul (ashr e (const? 32 16)) (const? 32 32767) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 32) :
  mul (sext 64 (ashr e (const? 32 16))) (const? 64 (-32767)) ⊑
    sext 64 (mul (ashr e (const? 32 16)) (const? 32 (-32767)) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e : IntW 32) :
  mul (zext 64 (lshr e (const? 32 16))) (const? 64 65535) ⊑
    zext 64 (mul (lshr e (const? 32 16)) (const? 32 65535) { «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test15_proof.test15_thm_1 (e : IntW 32) :
  sub (const? 64 8) (sext 64 (ashr e (const? 32 1))) ⊑
    sext 64 (sub (const? 32 8) (ashr e (const? 32 1)) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test16_proof.test16_thm_1 (e : IntW 32) :
  sub (const? 64 4294967294) (zext 64 (lshr e (const? 32 1))) ⊑
    zext 64 (sub (const? 32 (-2)) (lshr e (const? 32 1)) { «nuw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
