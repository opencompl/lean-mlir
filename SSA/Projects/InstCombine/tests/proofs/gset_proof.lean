
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gset_proof
theorem test3_thm (e : IntW 32) : icmp IntPred.slt e e ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test4_thm (e : IntW 32) : icmp IntPred.sgt e e ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 32) : icmp IntPred.sle e e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 32) : icmp IntPred.sge e e ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test7_thm (e : IntW 32) : icmp IntPred.uge e (const? 32 0) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test8_thm (e : IntW 32) : icmp IntPred.ult e (const? 32 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test9_thm (e : IntW 1) : icmp IntPred.ult e (const? 1 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test10_thm (e : IntW 1) : icmp IntPred.ugt e (const? 1 1) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test11_thm (e : IntW 1) : icmp IntPred.ule e (const? 1 1) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test12_thm (e : IntW 1) : icmp IntPred.uge e (const? 1 0) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test13_thm (e e_1 : IntW 1) : icmp IntPred.uge e_1 e ⊑ LLVM.or e_1 (LLVM.xor e (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test14_thm (e e_1 : IntW 1) : icmp IntPred.eq e_1 e ⊑ LLVM.xor (LLVM.xor e_1 e) (const? 1 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bool_eq0_thm (e : IntW 64) :
  LLVM.and (icmp IntPred.sgt e (const? 64 0))
      (icmp IntPred.eq (icmp IntPred.eq e (const? 64 1)) (const? 1 0)) ⊑
    icmp IntPred.sgt e (const? 64 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem bool_eq0_logical_thm (e : IntW 64) :
  select (icmp IntPred.sgt e (const? 64 0))
      (icmp IntPred.eq (icmp IntPred.eq e (const? 64 1)) (const? 1 0)) (const? 1 0) ⊑
    icmp IntPred.sgt e (const? 64 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_of_icmps_thm (e : IntW 64) :
  LLVM.xor (icmp IntPred.eq e (const? 64 1)) (icmp IntPred.sgt e (const? 64 0)) ⊑
    icmp IntPred.sgt e (const? 64 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_of_icmps_commute_thm (e : IntW 64) :
  LLVM.xor (icmp IntPred.sgt e (const? 64 0)) (icmp IntPred.eq e (const? 64 1)) ⊑
    icmp IntPred.sgt e (const? 64 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_of_icmps_to_ne_thm (e : IntW 64) :
  LLVM.xor (icmp IntPred.sgt e (const? 64 4)) (icmp IntPred.slt e (const? 64 6)) ⊑
    icmp IntPred.ne e (const? 64 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_of_icmps_to_ne_commute_thm (e : IntW 64) :
  LLVM.xor (icmp IntPred.slt e (const? 64 6)) (icmp IntPred.sgt e (const? 64 4)) ⊑
    icmp IntPred.ne e (const? 64 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_of_icmps_neg_to_ne_thm (e : IntW 64) :
  LLVM.xor (icmp IntPred.sgt e (const? 64 (-6))) (icmp IntPred.slt e (const? 64 (-4))) ⊑
    icmp IntPred.ne e (const? 64 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_of_icmps_to_eq_thm (e : IntW 8) :
  LLVM.xor (icmp IntPred.slt e (const? 8 (-128))) (icmp IntPred.sgt e (const? 8 126)) ⊑
    icmp IntPred.eq e (const? 8 127) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR2844_thm (e : IntW 32) :
  select (LLVM.or (icmp IntPred.eq e (const? 32 0)) (icmp IntPred.slt e (const? 32 (-638208501))))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (LLVM.and (icmp IntPred.ne e (const? 32 0)) (icmp IntPred.sgt e (const? 32 (-638208502)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR2844_logical_thm (e : IntW 32) :
  select (select (icmp IntPred.eq e (const? 32 0)) (const? 1 1) (icmp IntPred.slt e (const? 32 (-638208501))))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (LLVM.and (icmp IntPred.ne e (const? 32 0)) (icmp IntPred.sgt e (const? 32 (-638208502)))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test16_thm (e : IntW 32) : icmp IntPred.eq (LLVM.and e (const? 32 5)) (const? 32 8) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test17_thm (e : IntW 8) : icmp IntPred.eq (LLVM.or e (const? 8 1)) (const? 8 2) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test19_thm (e e_1 : IntW 1) :
  icmp IntPred.eq (zext 32 e_1) (zext 32 e) ⊑ LLVM.xor (LLVM.xor e_1 e) (const? 1 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test20_thm (e : IntW 32) :
  zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 1)) (const? 32 0)) ⊑ LLVM.and e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test21_thm (e : IntW 32) :
  zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 4)) (const? 32 0)) ⊑
    LLVM.and (lshr e (const? 32 2)) (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test22_thm (e e_1 : IntW 32) :
  LLVM.or (icmp IntPred.ult (LLVM.and e_1 (const? 32 100663295)) (const? 32 268435456))
      (icmp IntPred.sgt (LLVM.and e (const? 32 7)) (const? 32 (-1))) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test22_logical_thm (e e_1 : IntW 32) :
  select (icmp IntPred.ult (LLVM.and e_1 (const? 32 100663295)) (const? 32 268435456)) (const? 1 1)
      (icmp IntPred.sgt (LLVM.and e (const? 32 7)) (const? 32 (-1))) ⊑
    const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test23_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) ⊑
    LLVM.xor (LLVM.and e (const? 32 1)) (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test24_thm (e : IntW 32) :
  zext 32 (icmp IntPred.eq (lshr (LLVM.and e (const? 32 4)) (const? 32 2)) (const? 32 0)) ⊑
    LLVM.xor (LLVM.and (lshr e (const? 32 2)) (const? 32 1)) (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test25_thm (e : IntW 32) : icmp IntPred.ugt (LLVM.and e (const? 32 2)) (const? 32 2) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
