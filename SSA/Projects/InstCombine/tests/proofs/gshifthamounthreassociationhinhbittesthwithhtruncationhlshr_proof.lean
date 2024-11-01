
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gshifthamounthreassociationhinhbittesthwithhtruncationhlshr_proof
theorem t1_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl (const? 65535) (sub (const? 32) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? (-16)))))))
      (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 4294901760)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t1_single_bit_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl (const? 32768) (sub (const? 32) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? (-16)))))))
      (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 2147483648)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t3_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_1 (sub (const? 32) e)) (trunc 32 (lshr (const? 131071) (zext 64 (add e (const? (-16)))))))
      (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e_1 (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t3_singlebit_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_1 (sub (const? 32) e)) (trunc 32 (lshr (const? 65536) (zext 64 (add e (const? (-16)))))))
      (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e_1 (const? 1)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t9_highest_bit_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (shl e_2 (sub (const? 64) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? (-1)))))))
      (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and (lshr e (const? 63)) (zext 64 e_2)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t11_no_shift_thm (e : IntW 64) (e_1 e_2 : IntW 32) :
  icmp IntPredicate.ne (LLVM.and (shl e_2 (sub (const? 64) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? (-64)))))))
      (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (zext 64 e_2)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t13_x_is_one_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl (const? 1) (sub (const? 32) e_1)) (trunc 32 (lshr e (zext 64 (add e_1 (const? (-16)))))))
      (const? 0) ⊑
    icmp IntPredicate.ne (LLVM.and e (const? 65536)) (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem t14_x_is_one_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne
      (LLVM.and (shl e_1 (sub (const? 32) e)) (trunc 32 (lshr (const? 1) (zext 64 (add e (const? (-16)))))))
      (const? 0) ⊑
    const? 0 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem rawspeed_signbit_thm (e : IntW 64) (e_1 : IntW 32) :
  icmp IntPredicate.eq
      (LLVM.and (shl (const? 1) (add e_1 (const? (-1)) { «nsw» := true, «nuw» := false }))
        (trunc 32 (lshr e (zext 64 (sub (const? 64) e_1 { «nsw» := true, «nuw» := false })))))
      (const? 0) ⊑
    icmp IntPredicate.sgt e (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


