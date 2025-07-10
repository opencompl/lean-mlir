
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthamounthreassociationhinhbittesthwithhtruncationhlshr_proof
theorem n0_proof.n0_thm_1 (e : IntW 32) (e_1 : IntW 64) (e_2 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 32) e_2)) (trunc 32 (lshr e_1 (zext 64 (add e_2 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 32) e_2))
        (trunc 32 (lshr e_1 (zext 64 (add e_2 (const? 32 (-16))) { «nneg» := true }))))
      (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_proof.t1_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl (const? 32 65535) (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 64 4294901760)) (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t1_single_bit_proof.t1_single_bit_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl (const? 32 32768) (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 64 2147483648)) (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n2_proof.n2_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl (const? 32 131071) (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne
      (LLVM.and (shl (const? 32 131071) (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16))) { «nneg» := true }))))
      (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_proof.t3_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 32) e_1))
        (trunc 32 (lshr (const? 64 131071) (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 1)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t3_singlebit_proof.t3_singlebit_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 32) e_1))
        (trunc 32 (lshr (const? 64 65536) (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 32 1)) (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n4_proof.n4_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 32) e_1))
        (trunc 32 (lshr (const? 64 262143) (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 32) e_1))
        (trunc 32 (lshr (const? 64 262143) (zext 64 (add e_1 (const? 32 (-16))) { «nneg» := true }))
          { «nsw» := true, «nuw» := true }))
      (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t9_highest_bit_proof.t9_highest_bit_thm_1 (e : IntW 32) (e_1 : IntW 64) (e_2 : IntW 32) :
  icmp IntPred.ne (LLVM.and (shl e (sub (const? 32 64) e_2)) (trunc 32 (lshr e_1 (zext 64 (add e_2 (const? 32 (-1)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and (lshr e_1 (const? 64 63)) (zext 64 e)) (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t10_almost_highest_bit_proof.t10_almost_highest_bit_thm_1 (e : IntW 32) (e_1 : IntW 64) (e_2 : IntW 32) :
  icmp IntPred.ne (LLVM.and (shl e (sub (const? 32 64) e_2)) (trunc 32 (lshr e_1 (zext 64 (add e_2 (const? 32 (-2)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 64) e_2))
        (trunc 32 (lshr e_1 (zext 64 (add e_2 (const? 32 (-2))) { «nneg» := true }))))
      (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t11_no_shift_proof.t11_no_shift_thm_1 (e : IntW 32) (e_1 : IntW 64) (e_2 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 64) e_2)) (trunc 32 (lshr e_1 (zext 64 (add e_2 (const? 32 (-64)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e_1 (zext 64 e)) (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t10_shift_by_one_proof.t10_shift_by_one_thm_1 (e : IntW 32) (e_1 : IntW 64) (e_2 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 64) e_2)) (trunc 32 (lshr e_1 (zext 64 (add e_2 (const? 32 (-63)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 64) e_2))
        (trunc 32 (lshr e_1 (zext 64 (add e_2 (const? 32 (-63))) { «nneg» := true }))))
      (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t13_x_is_one_proof.t13_x_is_one_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl (const? 32 1) (sub (const? 32 32) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPred.ne (LLVM.and e (const? 64 65536)) (const? 64 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem t14_x_is_one_proof.t14_x_is_one_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne
      (LLVM.and (shl e (sub (const? 32 32) e_1)) (trunc 32 (lshr (const? 64 1) (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem rawspeed_signbit_proof.rawspeed_signbit_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPred.eq
      (LLVM.and (shl (const? 32 1) (add e_1 (const? 32 (-1)) { «nsw» := true }))
        (trunc 32 (lshr e (zext 64 (sub (const? 32 64) e_1 { «nsw» := true })))))
      (const? 32 0) ⊑
    icmp IntPred.sgt e (const? 64 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
