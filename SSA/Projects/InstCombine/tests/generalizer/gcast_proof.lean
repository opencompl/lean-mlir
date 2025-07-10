
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gcast_proof
theorem test2_proof.test2_thm_1 (e : IntW 8) : zext 64 (zext 32 (zext 16 e)) ⊑ zext 64 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test3_proof.test3_thm_1 (e : IntW 64) : zext 64 (trunc 8 e) ⊑ LLVM.and e (const? 64 255) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test4_proof.test4_thm_1 (e e_1 : IntW 32) :
  zext 32 (zext 8 (icmp IntPred.slt e e_1)) ⊑ zext 32 (icmp IntPred.slt e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e : IntW 1) : zext 32 (zext 8 e) ⊑ zext 32 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test7_proof.test7_thm_1 (e : IntW 1) : sext 64 (zext 32 e) ⊑ zext 64 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test9_proof.test9_thm_1 (e : IntW 16) : trunc 16 (sext 32 e) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test10_proof.test10_thm_1 (e : IntW 16) : trunc 16 (sext 32 e) ⊑ e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test17_proof.test17_thm_1 (e : IntW 1) : trunc 16 (zext 32 e) ⊑ zext 16 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test18_proof.test18_thm_1 (e : IntW 8) : trunc 16 (sext 32 e) ⊑ sext 16 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test19_proof.test19_thm_1 (e : IntW 32) :
  icmp IntPred.slt (sext 64 e) (const? 64 12345) ⊑ icmp IntPred.slt e (const? 32 12345) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test20_proof.test20_thm_1 (e : IntW 1) : icmp IntPred.slt (zext 32 e) (const? 32 (-1)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test21_proof.test21_thm_1 (e : IntW 32) :
  LLVM.and (sext 32 (trunc 8 e)) (const? 32 255) ⊑ LLVM.and e (const? 32 255) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test22_proof.test22_thm_1 (e : IntW 32) :
  shl (sext 32 (trunc 8 e)) (const? 32 24) ⊑ shl e (const? 32 24) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test23_proof.test23_thm_1 (e : IntW 32) : zext 32 (trunc 16 e) ⊑ LLVM.and e (const? 32 65535) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test24_proof.test24_thm_1 (e : IntW 1) :
  icmp IntPred.ne (select e (const? 32 14) (const? 32 1234)) (const? 32 0) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test29_proof.test29_thm_1 (e e_1 : IntW 32) :
  zext 32 (LLVM.or (trunc 8 e_1) (trunc 8 e)) ⊑ LLVM.and (LLVM.or e_1 e) (const? 32 255) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test31_proof.test31_thm_1 (e : IntW 64) :
  icmp IntPred.eq (LLVM.and (trunc 32 e) (const? 32 42)) (const? 32 10) ⊑
    icmp IntPred.eq (LLVM.and e (const? 64 42)) (const? 64 10) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test34_proof.test34_thm_1 (e : IntW 16) :
  trunc 16 (lshr (zext 32 e) (const? 32 8)) ⊑ lshr e (const? 16 8) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test36_proof.test36_thm_1 (e : IntW 32) :
  icmp IntPred.eq (trunc 8 (lshr e (const? 32 31))) (const? 8 0) ⊑ icmp IntPred.sgt e (const? 32 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test37_proof.test37_thm_1 (e : IntW 32) :
  icmp IntPred.eq (trunc 8 (LLVM.or (lshr e (const? 32 31)) (const? 32 512))) (const? 8 11) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test38_proof.test38_thm_1 (e : IntW 32) :
  zext 64 (LLVM.xor (zext 8 (icmp IntPred.eq e (const? 32 (-2)))) (const? 8 1)) ⊑
    zext 64 (icmp IntPred.ne e (const? 32 (-2))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test40_proof.test40_thm_1 (e : IntW 16) :
  trunc 16 (LLVM.or (lshr (zext 32 e) (const? 32 9)) (shl (zext 32 e) (const? 32 8))) ⊑
    LLVM.or (lshr e (const? 16 9)) (shl e (const? 16 8)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test42_proof.test42_thm_1 (e : IntW 32) : zext 32 (trunc 8 e) ⊑ LLVM.and e (const? 32 255) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test43_proof.test43_thm_1 (e : IntW 8) :
  sext 64 (add (zext 32 e) (const? 32 (-1))) ⊑ sext 64 (add (zext 32 e) (const? 32 (-1)) { «nsw» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test44_proof.test44_thm_1 (e : IntW 8) :
  zext 64 (LLVM.or (zext 16 e) (const? 16 1234)) ⊑
    zext 64 (LLVM.or (zext 16 e) (const? 16 1234)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test46_proof.test46_thm_1 (e : IntW 64) :
  zext 64 (shl (LLVM.and (trunc 32 e) (const? 32 42)) (const? 32 8)) ⊑
    zext 64 (LLVM.and (shl (trunc 32 e) (const? 32 8)) (const? 32 10752)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test47_proof.test47_thm_1 (e : IntW 8) :
  zext 64 (LLVM.or (sext 32 e) (const? 32 42)) ⊑ zext 64 (sext 32 (LLVM.or e (const? 8 42))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test48_proof.test48_thm_1 (e : IntW 8) :
  zext 64 (LLVM.or (shl (zext 32 e) (const? 32 8)) (zext 32 e)) ⊑
    zext 64
      (LLVM.or (shl (zext 32 e) (const? 32 8) { «nsw» := true, «nuw» := true }) (zext 32 e) { «disjoint» := true })
      { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test51_proof.test51_thm_1 (e : IntW 64) (e_1 : IntW 1) :
  sext 64 (select e_1 (LLVM.and (trunc 32 e) (const? 32 (-2))) (LLVM.or (trunc 32 e) (const? 32 1))) ⊑
    sext 64
      (LLVM.or (LLVM.and (trunc 32 e) (const? 32 (-2))) (zext 32 (LLVM.xor e_1 (const? 1 1)))
        { «disjoint» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test52_proof.test52_thm_1 (e : IntW 64) :
  zext 32 (LLVM.and (LLVM.or (trunc 16 e) (const? 16 (-32574))) (const? 16 (-25350))) ⊑
    zext 32 (LLVM.or (LLVM.and (trunc 16 e) (const? 16 7224)) (const? 16 (-32574)) { «disjoint» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test53_proof.test53_thm_1 (e : IntW 32) :
  zext 64 (LLVM.and (LLVM.or (trunc 16 e) (const? 16 (-32574))) (const? 16 (-25350))) ⊑
    zext 64 (LLVM.or (LLVM.and (trunc 16 e) (const? 16 7224)) (const? 16 (-32574)) { «disjoint» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test54_proof.test54_thm_1 (e : IntW 64) :
  sext 32 (LLVM.and (LLVM.or (trunc 16 e) (const? 16 (-32574))) (const? 16 (-25350))) ⊑
    sext 32 (LLVM.or (LLVM.and (trunc 16 e) (const? 16 7224)) (const? 16 (-32574)) { «disjoint» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test55_proof.test55_thm_1 (e : IntW 32) :
  sext 64 (LLVM.and (LLVM.or (trunc 16 e) (const? 16 (-32574))) (const? 16 (-25350))) ⊑
    sext 64 (LLVM.or (LLVM.and (trunc 16 e) (const? 16 7224)) (const? 16 (-32574)) { «disjoint» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test56_proof.test56_thm_1 (e : IntW 16) :
  zext 64 (lshr (sext 32 e) (const? 32 5)) ⊑ zext 64 (lshr (sext 32 e) (const? 32 5)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test57_proof.test57_thm_1 (e : IntW 64) :
  zext 64 (lshr (trunc 32 e) (const? 32 8)) ⊑ zext 64 (lshr (trunc 32 e) (const? 32 8)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test58_proof.test58_thm_1 (e : IntW 64) :
  zext 64 (LLVM.or (lshr (trunc 32 e) (const? 32 8)) (const? 32 128)) ⊑
    zext 64 (LLVM.or (lshr (trunc 32 e) (const? 32 8)) (const? 32 128)) { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test59_proof.test59_thm_1 (e e_1 : IntW 8) :
  zext 64 (LLVM.or (lshr (zext 32 e_1) (const? 32 4)) (LLVM.and (shl (zext 32 e) (const? 32 4)) (const? 32 48))) ⊑
    zext 64
      (LLVM.or (LLVM.and (shl (zext 32 e) (const? 32 4) { «nsw» := true, «nuw» := true }) (const? 32 48))
        (zext 32 (lshr e_1 (const? 8 4)) { «nneg» := true }) { «disjoint» := true })
      { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test67_proof.test67_thm_1 (e : IntW 1) (e_1 : IntW 32) :
  icmp IntPred.eq
      (trunc 8
        (ashr
          (LLVM.xor
            (shl (LLVM.and e_1 (LLVM.xor (zext 32 e) (const? 32 1))) (const? 32 24) { «nsw» := true, «nuw» := true })
            (const? 32 (-16777216)))
          (const? 32 24) { «exact» := true }))
      (const? 8 0) ⊑
    const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test82_proof.test82_thm_1 (e : IntW 64) :
  zext 64 (shl (lshr (trunc 32 e) (const? 32 8)) (const? 32 9)) ⊑
    zext 64 (LLVM.and (shl (trunc 32 e) (const? 32 1)) (const? 32 (-512))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test83_proof.test83_thm_1 (e : IntW 16) (e_1 : IntW 64) :
  zext 64 (shl (sext 32 e) (trunc 32 (add e_1 (const? 64 (-1)) { «nsw» := true }))) ⊑
    zext 64 (shl (sext 32 e) (add (trunc 32 e_1) (const? 32 (-1)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test84_proof.test84_thm_1 (e : IntW 32) :
  trunc 8 (lshr (add e (const? 32 (-16777216)) { «nsw» := true }) (const? 32 23) { «exact» := true }) ⊑
    trunc 8 (lshr (add e (const? 32 2130706432)) (const? 32 23)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test85_proof.test85_thm_1 (e : IntW 32) :
  trunc 8 (lshr (add e (const? 32 (-16777216)) { «nuw» := true }) (const? 32 23) { «exact» := true }) ⊑
    trunc 8 (lshr (add e (const? 32 2130706432)) (const? 32 23)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test86_proof.test86_thm_1 (e : IntW 16) :
  trunc 16 (ashr (sext 32 e) (const? 32 4)) ⊑ ashr e (const? 16 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test87_proof.test87_thm_1 (e : IntW 16) :
  trunc 16 (ashr (mul (sext 32 e) (const? 32 16) { «nsw» := true }) (const? 32 16)) ⊑ ashr e (const? 16 12) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test88_proof.test88_thm_1 (e : IntW 16) :
  trunc 16 (ashr (sext 32 e) (const? 32 18)) ⊑ ashr e (const? 16 15) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR23309_proof.PR23309_thm_1 (e e_1 : IntW 32) :
  trunc 1 (sub (add e (const? 32 (-4))) e_1 { «nsw» := true }) ⊑ trunc 1 (sub e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR23309v2_proof.PR23309v2_thm_1 (e e_1 : IntW 32) :
  trunc 1 (add (add e (const? 32 (-4))) e_1 { «nuw» := true }) ⊑ trunc 1 (add e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR24763_proof.PR24763_thm_1 (e : IntW 8) :
  trunc 16 (lshr (sext 32 e) (const? 32 1)) ⊑ sext 16 (ashr e (const? 8 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test91_proof.test91_thm_1 (e : IntW 64) :
  trunc 64 (lshr (sext 96 e) (const? 96 48)) ⊑
    trunc 64 (lshr (sext 96 e) (const? 96 48)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test92_proof.test92_thm_1 (e : IntW 64) :
  trunc 64 (lshr (sext 96 e) (const? 96 32)) ⊑ ashr e (const? 64 32) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test93_proof.test93_thm_1 (e : IntW 32) :
  trunc 32 (lshr (sext 96 e) (const? 96 64)) ⊑ ashr e (const? 32 31) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_lshr_sext_proof.trunc_lshr_sext_thm_1 (e : IntW 8) :
  trunc 8 (lshr (sext 32 e) (const? 32 6)) ⊑ ashr e (const? 8 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_lshr_sext_exact_proof.trunc_lshr_sext_exact_thm_1 (e : IntW 8) :
  trunc 8 (lshr (sext 32 e) (const? 32 6) { «exact» := true }) ⊑ ashr e (const? 8 6) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_lshr_sext_wide_input_proof.trunc_lshr_sext_wide_input_thm_1 (e : IntW 16) :
  trunc 8 (lshr (sext 32 e) (const? 32 9)) ⊑ trunc 8 (ashr e (const? 16 9)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_lshr_sext_wide_input_exact_proof.trunc_lshr_sext_wide_input_exact_thm_1 (e : IntW 16) :
  trunc 8 (lshr (sext 32 e) (const? 32 9) { «exact» := true }) ⊑
    trunc 8 (ashr e (const? 16 9) { «exact» := true }) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_lshr_sext_narrow_input_proof.trunc_lshr_sext_narrow_input_thm_1 (e : IntW 8) :
  trunc 16 (lshr (sext 32 e) (const? 32 6)) ⊑ sext 16 (ashr e (const? 8 6)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_lshr_zext_proof.trunc_lshr_zext_thm_1 (e : IntW 8) :
  trunc 8 (lshr (zext 32 e) (const? 32 6)) ⊑ lshr e (const? 8 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem trunc_lshr_zext_exact_proof.trunc_lshr_zext_exact_thm_1 (e : IntW 8) :
  trunc 8 (lshr (zext 32 e) (const? 32 6) { «exact» := true }) ⊑ lshr e (const? 8 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem pr33078_1_proof.pr33078_1_thm_1 (e : IntW 8) :
  trunc 8 (lshr (sext 16 e) (const? 16 8)) ⊑ ashr e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem pr33078_2_proof.pr33078_2_thm_1 (e : IntW 8) :
  trunc 12 (lshr (sext 16 e) (const? 16 4)) ⊑ sext 12 (ashr e (const? 8 4)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem pr33078_3_proof.pr33078_3_thm_1 (e : IntW 8) :
  trunc 4 (lshr (sext 16 e) (const? 16 12)) ⊑ trunc 4 (lshr (sext 16 e) (const? 16 12)) { «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem pr33078_4_proof.pr33078_4_thm_1 (e : IntW 3) :
  trunc 8 (lshr (sext 16 e) (const? 16 13)) ⊑
    trunc 8 (lshr (sext 16 e) (const? 16 13)) { «nsw» := true, «nuw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test94_proof.test94_thm_1 (e : IntW 32) :
  sext 64 (LLVM.xor (sext 8 (icmp IntPred.eq e (const? 32 (-2)))) (const? 8 (-1))) ⊑
    sext 64 (icmp IntPred.ne e (const? 32 (-2))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test95_proof.test95_thm_1 (e : IntW 32) :
  zext 32 (LLVM.or (LLVM.and (lshr (trunc 8 e) (const? 8 6)) (const? 8 2)) (const? 8 40)) ⊑
    zext 32 (LLVM.or (LLVM.and (lshr (trunc 8 e) (const? 8 6)) (const? 8 2)) (const? 8 40) { «disjoint» := true })
      { «nneg» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
