
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gicmphshr_proof
theorem lshr_eq_msb_low_last_zero_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 127) e) (const? 8 0) ⊑ icmp IntPredicate.ugt e (const? 8 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_eq_msb_low_second_zero_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (const? 8 127) e) (const? 8 0) ⊑ icmp IntPredicate.ugt e (const? 8 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_ne_msb_low_last_zero_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 127) e) (const? 8 0) ⊑ icmp IntPredicate.ult e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ne_msb_low_second_zero_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (const? 8 127) e) (const? 8 0) ⊑ icmp IntPredicate.ult e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_eq_both_equal_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (const? 8 (-128)) e) (const? 8 (-128)) ⊑ icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ne_both_equal_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (const? 8 (-128)) e) (const? 8 (-128)) ⊑ icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_eq_both_equal_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 127) e) (const? 8 127) ⊑ icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_ne_both_equal_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 127) e) (const? 8 127) ⊑ icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_ashr_eq_both_equal_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-128)) ⊑
    icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_ashr_ne_both_equal_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-128)) ⊑
    icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_eq_both_equal_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 126) e { «exact» := true }) (const? 8 126) ⊑
    icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_ne_both_equal_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 126) e { «exact» := true }) (const? 8 126) ⊑
    icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_eq_opposite_msb_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 (-128)) e { «exact» := true }) (const? 8 1) ⊑
    icmp IntPredicate.eq e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_eq_opposite_msb_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 (-128)) e) (const? 8 1) ⊑ icmp IntPredicate.eq e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_ne_opposite_msb_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 (-128)) e { «exact» := true }) (const? 8 1) ⊑
    icmp IntPredicate.ne e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_ne_opposite_msb_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 (-128)) e) (const? 8 1) ⊑ icmp IntPredicate.ne e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_ashr_eq_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-1)) ⊑
    icmp IntPredicate.eq e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_ashr_ne_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-1)) ⊑
    icmp IntPredicate.ne e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_eq_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 4) e { «exact» := true }) (const? 8 1) ⊑
    icmp IntPredicate.eq e (const? 8 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_ne_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 4) e { «exact» := true }) (const? 8 1) ⊑
    icmp IntPredicate.ne e (const? 8 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_ashr_eq_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (const? 8 (-128)) e) (const? 8 (-1)) ⊑ icmp IntPredicate.eq e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_ashr_ne_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (const? 8 (-128)) e) (const? 8 (-1)) ⊑ icmp IntPredicate.ne e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_lshr_eq_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 4) e) (const? 8 1) ⊑ icmp IntPredicate.eq e (const? 8 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_lshr_ne_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 4) e) (const? 8 1) ⊑ icmp IntPredicate.ne e (const? 8 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_eq_exactdiv_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 80) e { «exact» := true }) (const? 8 5) ⊑
    icmp IntPredicate.eq e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_ne_exactdiv_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 80) e { «exact» := true }) (const? 8 5) ⊑
    icmp IntPredicate.ne e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_lshr_eq_exactdiv_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 80) e) (const? 8 5) ⊑ icmp IntPredicate.eq e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_lshr_ne_exactdiv_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 80) e) (const? 8 5) ⊑ icmp IntPredicate.ne e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_ashr_eq_exactdiv_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (const? 8 (-80)) e { «exact» := true }) (const? 8 (-5)) ⊑
    icmp IntPredicate.eq e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_ashr_ne_exactdiv_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (const? 8 (-80)) e { «exact» := true }) (const? 8 (-5)) ⊑
    icmp IntPredicate.ne e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_ashr_eq_exactdiv_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (const? 8 (-80)) e) (const? 8 (-5)) ⊑ icmp IntPredicate.eq e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_ashr_ne_exactdiv_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (const? 8 (-80)) e) (const? 8 (-5)) ⊑ icmp IntPredicate.ne e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_eq_noexactdiv_thm (e : IntW 8) :
  icmp IntPredicate.eq (lshr (const? 8 80) e { «exact» := true }) (const? 8 31) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_lshr_ne_noexactdiv_thm (e : IntW 8) :
  icmp IntPredicate.ne (lshr (const? 8 80) e { «exact» := true }) (const? 8 31) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_lshr_eq_noexactdiv_thm (e : IntW 8) : icmp IntPredicate.eq (lshr (const? 8 80) e) (const? 8 31) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_lshr_ne_noexactdiv_thm (e : IntW 8) : icmp IntPredicate.ne (lshr (const? 8 80) e) (const? 8 31) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_ashr_eq_noexactdiv_thm (e : IntW 8) :
  icmp IntPredicate.eq (ashr (const? 8 (-80)) e { «exact» := true }) (const? 8 (-31)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exact_ashr_ne_noexactdiv_thm (e : IntW 8) :
  icmp IntPredicate.ne (ashr (const? 8 (-80)) e { «exact» := true }) (const? 8 (-31)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_ashr_eq_noexactdiv_thm (e : IntW 8) : icmp IntPredicate.eq (ashr (const? 8 (-80)) e) (const? 8 (-31)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_ashr_ne_noexactdiv_thm (e : IntW 8) : icmp IntPredicate.ne (ashr (const? 8 (-80)) e) (const? 8 (-31)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_lshr_eq_noexactlog_thm (e : IntW 8) : icmp IntPredicate.eq (lshr (const? 8 90) e) (const? 8 30) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_lshr_ne_noexactlog_thm (e : IntW 8) : icmp IntPredicate.ne (lshr (const? 8 90) e) (const? 8 30) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_ashr_eq_noexactlog_thm (e : IntW 8) : icmp IntPredicate.eq (ashr (const? 8 (-90)) e) (const? 8 (-30)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem nonexact_ashr_ne_noexactlog_thm (e : IntW 8) : icmp IntPredicate.ne (ashr (const? 8 (-90)) e) (const? 8 (-30)) ⊑ const? 1 1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR20945_thm (e : IntW 32) :
  icmp IntPredicate.ne (ashr (const? 32 (-9)) e) (const? 32 (-5)) ⊑ icmp IntPredicate.ne e (const? 32 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR21222_thm (e : IntW 32) :
  icmp IntPredicate.eq (ashr (const? 32 (-93)) e) (const? 32 (-2)) ⊑ icmp IntPredicate.eq e (const? 32 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem PR24873_thm (e : IntW 64) :
  icmp IntPredicate.eq (ashr (const? 64 (-4611686018427387904)) e) (const? 64 (-1)) ⊑
    icmp IntPredicate.ugt e (const? 64 61) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_exact_eq_0_thm (e e_1 : IntW 32) :
  icmp IntPredicate.eq (ashr e_1 e { «exact» := true }) (const? 32 0) ⊑ icmp IntPredicate.eq e_1 (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_exact_ne_0_thm (e e_1 : IntW 32) :
  icmp IntPredicate.ne (lshr e_1 e { «exact» := true }) (const? 32 0) ⊑ icmp IntPredicate.ne e_1 (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_0_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 0) ⊑ icmp IntPredicate.ugt e (const? 4 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_1_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 1) ⊑ icmp IntPredicate.ugt e (const? 4 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_2_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 2) ⊑ icmp IntPredicate.ugt e (const? 4 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_3_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 3) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_4_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 4) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_5_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 5) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_6_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 6) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_7_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 7) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_8_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 (-8)) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_9_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 (-7)) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_10_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 (-6)) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_11_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 (-5)) ⊑ icmp IntPredicate.slt e (const? 4 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_12_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 (-4)) ⊑ icmp IntPredicate.ugt e (const? 4 (-7)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_13_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 (-3)) ⊑ icmp IntPredicate.ugt e (const? 4 (-5)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_14_thm (e : IntW 4) :
  icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 (-2)) ⊑ icmp IntPredicate.ugt e (const? 4 (-3)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ugt_15_thm (e : IntW 4) : icmp IntPredicate.ugt (ashr e (const? 4 1)) (const? 4 (-1)) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_0_thm (e : IntW 4) : icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 0) ⊑ const? 1 0 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_1_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 1) ⊑ icmp IntPredicate.ult e (const? 4 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_2_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 2) ⊑ icmp IntPredicate.ult e (const? 4 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_3_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 3) ⊑ icmp IntPredicate.ult e (const? 4 6) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_4_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 4) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_5_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 5) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_6_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 6) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_7_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 7) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_8_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 (-8)) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_9_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 (-7)) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_10_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 (-6)) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_11_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 (-5)) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_12_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 (-4)) ⊑ icmp IntPredicate.sgt e (const? 4 (-1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_13_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 (-3)) ⊑ icmp IntPredicate.ult e (const? 4 (-6)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_14_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 (-2)) ⊑ icmp IntPredicate.ult e (const? 4 (-4)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_ult_15_thm (e : IntW 4) :
  icmp IntPredicate.ult (ashr e (const? 4 1)) (const? 4 (-1)) ⊑ icmp IntPredicate.ult e (const? 4 (-2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_pow2_ugt_thm (e : IntW 8) :
  icmp IntPredicate.ugt (lshr (const? 8 2) e) (const? 8 1) ⊑ icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_pow2_ugt1_thm (e : IntW 8) :
  icmp IntPredicate.ugt (lshr (const? 8 (-128)) e) (const? 8 1) ⊑ icmp IntPredicate.ult e (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_pow2_ugt_thm (e : IntW 8) :
  icmp IntPredicate.ugt (ashr (const? 8 (-128)) e) (const? 8 (-96)) ⊑
    icmp IntPredicate.ugt (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-96)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_pow2_sgt_thm (e : IntW 8) :
  icmp IntPredicate.sgt (lshr (const? 8 (-128)) e) (const? 8 3) ⊑
    icmp IntPredicate.sgt (lshr (const? 8 (-128)) e { «exact» := true }) (const? 8 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_pow2_ult_thm (e : IntW 8) :
  icmp IntPredicate.ult (lshr (const? 8 4) e) (const? 8 2) ⊑ icmp IntPredicate.ugt e (const? 8 1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_pow2_ult_equal_constants_thm (e : IntW 32) :
  icmp IntPredicate.ult (lshr (const? 32 16) e) (const? 32 16) ⊑ icmp IntPredicate.ne e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_pow2_ult_smin_thm (e : IntW 8) :
  icmp IntPredicate.ult (lshr (const? 8 (-128)) e) (const? 8 (-128)) ⊑ icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_pow2_ult_thm (e : IntW 8) :
  icmp IntPredicate.ult (ashr (const? 8 (-128)) e) (const? 8 (-96)) ⊑
    icmp IntPredicate.ult (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-96)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_pow2_slt_thm (e : IntW 8) :
  icmp IntPredicate.slt (lshr (const? 8 (-128)) e) (const? 8 3) ⊑
    icmp IntPredicate.slt (lshr (const? 8 (-128)) e { «exact» := true }) (const? 8 3) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_neg_sgt_minus_1_thm (e : IntW 8) :
  icmp IntPredicate.sgt (lshr (const? 8 (-17)) e) (const? 8 (-1)) ⊑ icmp IntPredicate.ne e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem lshr_neg_slt_zero_thm (e : IntW 8) :
  icmp IntPredicate.slt (lshr (const? 8 (-17)) e) (const? 8 0) ⊑ icmp IntPredicate.eq e (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exactly_one_set_signbit_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (lshr e_1 (const? 8 7)) (zext 8 (icmp IntPredicate.sgt e (const? 8 (-1)))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem same_signbit_wrong_type_thm (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPredicate.ne (lshr e_1 (const? 8 7)) (zext 8 (icmp IntPredicate.sgt e (const? 32 (-1)))) ⊑
    LLVM.xor (icmp IntPredicate.slt e_1 (const? 8 0)) (icmp IntPredicate.sgt e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exactly_one_set_signbit_wrong_pred_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (lshr e_1 (const? 8 7)) (zext 8 (icmp IntPredicate.sgt e (const? 8 (-1)))) ⊑
    icmp IntPredicate.slt (LLVM.and e e_1) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem exactly_one_set_signbit_signed_thm (e e_1 : IntW 8) :
  icmp IntPredicate.eq (ashr e_1 (const? 8 7)) (sext 8 (icmp IntPredicate.sgt e (const? 8 (-1)))) ⊑
    icmp IntPredicate.slt (LLVM.xor e_1 e) (const? 8 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem same_signbit_wrong_type_signed_thm (e : IntW 32) (e_1 : IntW 8) :
  icmp IntPredicate.ne (ashr e_1 (const? 8 7)) (sext 8 (icmp IntPredicate.sgt e (const? 32 (-1)))) ⊑
    LLVM.xor (icmp IntPredicate.slt e_1 (const? 8 0)) (icmp IntPredicate.sgt e (const? 32 (-1))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_ult_i1_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.ult (zext 32 e_1) (lshr e (const? 32 31)) ⊑
    LLVM.and (icmp IntPredicate.slt e (const? 32 0)) (LLVM.xor e_1 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_ult_i1_fail1_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.ult (zext 32 e_1) (lshr e (const? 32 30)) ⊑
    icmp IntPredicate.ugt (lshr e (const? 32 30)) (zext 32 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_ult_i1_fail2_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.ult (zext 32 e_1) (ashr e (const? 32 31)) ⊑
    icmp IntPredicate.ugt (ashr e (const? 32 31)) (zext 32 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_slt_i1_fail_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.slt (zext 32 e_1) (lshr e (const? 32 31)) ⊑
    LLVM.and (icmp IntPredicate.slt e (const? 32 0)) (LLVM.xor e_1 (const? 1 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_i1_signed_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.eq (sext 32 e_1) (ashr e (const? 32 31)) ⊑
    LLVM.xor (icmp IntPredicate.sgt e (const? 32 (-1))) e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_zero_eq_i1_fail_signed_thm (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPredicate.eq (sext 32 e_1) (lshr e (const? 32 31)) ⊑
    icmp IntPredicate.eq (lshr e (const? 32 31)) (sext 32 e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


