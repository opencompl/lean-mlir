
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gshifthamounthreassociationhinhbittesthwithhtruncationhlshr_proof
theorem n0_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_2 (sub (const? 32 32) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne
      (LLVM.and (shl e_2 (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16))) { «nneg» := true }))))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl (const? 32 65535) (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 64 4294901760)) (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t1_single_bit_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl (const? 32 32768) (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 64 2147483648)) (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n2_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl (const? 32 131071) (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne
      (LLVM.and (shl (const? 32 131071) (sub (const? 32 32) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16))) { «nneg» := true }))))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_1 (sub (const? 32 32) e))
        (trunc 32 (lshr (const? 64 131071) (zext 64 (add e (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e_1 (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t3_singlebit_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_1 (sub (const? 32 32) e))
        (trunc 32 (lshr (const? 64 65536) (zext 64 (add e (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e_1 (const? 32 1)) (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem n4_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_1 (sub (const? 32 32) e))
        (trunc 32 (lshr (const? 64 262143) (zext 64 (add e (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne
      (LLVM.and (shl e_1 (sub (const? 32 32) e))
        (trunc 32 (lshr (const? 64 262143) (zext 64 (add e (const? 32 (-16))) { «nneg» := true }))
          { «nsw» := true, «nuw» := true }))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t9_highest_bit_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_2 (sub (const? 32 64) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-1)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e (const? 64 63)) (zext 64 e_2)) (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t10_almost_highest_bit_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_2 (sub (const? 32 64) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-2)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne
      (LLVM.and (shl e_2 (sub (const? 32 64) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-2))) { «nneg» := true }))))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t11_no_shift_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_2 (sub (const? 32 64) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-64)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (zext 64 e_2)) (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t10_shift_by_one_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_2 (sub (const? 32 64) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-63)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne
      (LLVM.and (shl e_2 (sub (const? 32 64) e_1))
        (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-63))) { «nneg» := true }))))
      (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t13_x_is_one_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl (const? 32 1) (sub (const? 32 32) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? 32 (-16)))))))
      (const? 32 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 64 65536)) (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem t14_x_is_one_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_1 (sub (const? 32 32) e)) (trunc 32 (lshr (const? 64 1) (zext 64 (add e (const? 32 (-16)))))))
      (const? 32 0) ⊑
    const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem rawspeed_signbit_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.eq
      (LLVM.and (shl (const? 32 1) (add e_1 (const? 32 (-1)) { «nsw» := true, «nuw» := false }))
        (trunc 32 (lshr e (zext 64 (sub (const? 32 64) e_1 { «nsw» := true, «nuw» := false })))))
      (const? 32 0) ⊑
    icmp IntPredicate.sgt e (const? 64 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


