
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section gselecthicmphand_proof
theorem test5_thm (e : IntW 41) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 41 32)) (const? 41 0)) (const? 41 32) (const? 41 0) ⊑
    LLVM.and e (const? 41 32) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 1023) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 1023 64)) (const? 1023 0)) (const? 1023 64) (const? 1023 0) ⊑
    LLVM.and e (const? 1023 64) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test35_thm (e : IntW 32) :
  select (icmp IntPredicate.sge e (const? 32 0)) (const? 32 60) (const? 32 100) ⊑
    select (icmp IntPredicate.sgt e (const? 32 (-1))) (const? 32 60) (const? 32 100) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test35_with_trunc_thm (e : IntW 64) :
  select (icmp IntPredicate.sge (trunc 32 e) (const? 32 0)) (const? 32 60) (const? 32 100) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 64 2147483648)) (const? 64 0)) (const? 32 60)
      (const? 32 100) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test65_thm (e : IntW 64) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 64 16)) (const? 64 0)) (const? 32 40) (const? 32 42) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 64 16)) (const? 64 0)) (const? 32 42) (const? 32 40) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test66_thm (e : IntW 64) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 64 4294967296)) (const? 64 0)) (const? 32 40) (const? 32 42) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 64 4294967296)) (const? 64 0)) (const? 32 42)
      (const? 32 40) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test67_thm (e : IntW 16) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 16 4)) (const? 16 0)) (const? 32 40) (const? 32 42) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 16 4)) (const? 16 0)) (const? 32 42) (const? 32 40) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test71_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 128)) (const? 32 0)) (const? 32 40) (const? 32 42) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 128)) (const? 32 0)) (const? 32 42) (const? 32 40) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test73_thm (e : IntW 32) :
  select (icmp IntPredicate.sgt (trunc 8 e) (const? 8 (-1))) (const? 32 40) (const? 32 42) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 128)) (const? 32 0)) (const? 32 40) (const? 32 42) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15a_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 16)) (const? 32 0)) (const? 32 0) (const? 32 16) ⊑
    LLVM.and e (const? 32 16) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15b_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 32)) (const? 32 0)) (const? 32 32) (const? 32 0) ⊑
    LLVM.xor (LLVM.and e (const? 32 32)) (const? 32 32) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15c_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 16)) (const? 32 16)) (const? 32 16) (const? 32 0) ⊑
    LLVM.and e (const? 32 16) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15d_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 16)) (const? 32 0)) (const? 32 16) (const? 32 0) ⊑
    LLVM.and e (const? 32 16) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15e_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 128)) (const? 32 0)) (const? 32 256) (const? 32 0) ⊑
    LLVM.and (shl e (const? 32 1)) (const? 32 256) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15f_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 128)) (const? 32 0)) (const? 32 0) (const? 32 256) ⊑
    LLVM.xor (LLVM.and (shl e (const? 32 1)) (const? 32 256)) (const? 32 256) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15g_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 8)) (const? 32 0)) (const? 32 (-1)) (const? 32 (-9)) ⊑
    LLVM.or e (const? 32 (-9)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15h_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 8)) (const? 32 0)) (const? 32 (-9)) (const? 32 (-1)) ⊑
    LLVM.xor (LLVM.and e (const? 32 8)) (const? 32 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15i_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 2)) (const? 32 0)) (const? 32 577) (const? 32 1089) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (const? 32 1089) (const? 32 577) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test15j_thm (e : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e (const? 32 2)) (const? 32 0)) (const? 32 1089) (const? 32 577) ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 2)) (const? 32 0)) (const? 32 577) (const? 32 1089) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem clear_to_set_decomposebittest_thm (e : IntW 8) :
  select (icmp IntPredicate.sgt e (const? 8 (-1))) (const? 8 (-125)) (const? 8 3) ⊑
    LLVM.xor (LLVM.and e (const? 8 (-128))) (const? 8 (-125)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem clear_to_clear_decomposebittest_thm (e : IntW 8) :
  select (icmp IntPredicate.sgt e (const? 8 (-1))) (const? 8 3) (const? 8 (-125)) ⊑
    LLVM.or (LLVM.and e (const? 8 (-128))) (const? 8 3) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_to_set_decomposebittest_thm (e : IntW 8) :
  select (icmp IntPredicate.slt e (const? 8 0)) (const? 8 (-125)) (const? 8 3) ⊑
    LLVM.or (LLVM.and e (const? 8 (-128))) (const? 8 3) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_to_clear_decomposebittest_thm (e : IntW 8) :
  select (icmp IntPredicate.slt e (const? 8 0)) (const? 8 3) (const? 8 (-125)) ⊑
    LLVM.xor (LLVM.and e (const? 8 (-128))) (const? 8 (-125)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_bittest_to_add_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 32 3) (const? 32 4) ⊑
    add (LLVM.and e (const? 32 1)) (const? 32 3) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_bittest_to_sub_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 32 4) (const? 32 3) ⊑
    sub (const? 32 4) (LLVM.and e (const? 32 1)) { «nsw» := true, «nuw» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_bittest_to_shl_negative_test_thm (e : IntW 32) :
  add (select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 32 2) (const? 32 4)) (const? 32 2)
      { «nsw» := true, «nuw» := true } ⊑
    select (icmp IntPredicate.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 32 4) (const? 32 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
