
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphshr_proof
theorem lshr_eq_msb_low_last_zero_proof.lshr_eq_msb_low_last_zero_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 127) e) (const? 8 0) ⊑ icmp IntPred.ugt e (const? 8 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_eq_msb_low_second_zero_proof.ashr_eq_msb_low_second_zero_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 127) e) (const? 8 0) ⊑ icmp IntPred.ugt e (const? 8 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_ne_msb_low_last_zero_proof.lshr_ne_msb_low_last_zero_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 127) e) (const? 8 0) ⊑ icmp IntPred.ult e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ne_msb_low_second_zero_proof.ashr_ne_msb_low_second_zero_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 127) e) (const? 8 0) ⊑ icmp IntPred.ult e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_eq_both_equal_proof.ashr_eq_both_equal_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-128)) e) (const? 8 (-128)) ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ne_both_equal_proof.ashr_ne_both_equal_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-128)) e) (const? 8 (-128)) ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_eq_both_equal_proof.lshr_eq_both_equal_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 127) e) (const? 8 127) ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_ne_both_equal_proof.lshr_ne_both_equal_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 127) e) (const? 8 127) ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_ashr_eq_both_equal_proof.exact_ashr_eq_both_equal_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-128)) ⊑
    icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_ashr_ne_both_equal_proof.exact_ashr_ne_both_equal_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-128)) ⊑
    icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_eq_both_equal_proof.exact_lshr_eq_both_equal_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 126) e { «exact» := true }) (const? 8 126) ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_ne_both_equal_proof.exact_lshr_ne_both_equal_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 126) e { «exact» := true }) (const? 8 126) ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_eq_opposite_msb_proof.exact_lshr_eq_opposite_msb_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 (-128)) e { «exact» := true }) (const? 8 1) ⊑ icmp IntPred.eq e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_eq_opposite_msb_proof.lshr_eq_opposite_msb_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 (-128)) e) (const? 8 1) ⊑ icmp IntPred.eq e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_ne_opposite_msb_proof.exact_lshr_ne_opposite_msb_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 (-128)) e { «exact» := true }) (const? 8 1) ⊑ icmp IntPred.ne e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_ne_opposite_msb_proof.lshr_ne_opposite_msb_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 (-128)) e) (const? 8 1) ⊑ icmp IntPred.ne e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_ashr_eq_proof.exact_ashr_eq_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-1)) ⊑
    icmp IntPred.eq e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_ashr_ne_proof.exact_ashr_ne_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-1)) ⊑
    icmp IntPred.ne e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_eq_proof.exact_lshr_eq_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 4) e { «exact» := true }) (const? 8 1) ⊑ icmp IntPred.eq e (const? 8 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_ne_proof.exact_lshr_ne_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 4) e { «exact» := true }) (const? 8 1) ⊑ icmp IntPred.ne e (const? 8 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_ashr_eq_proof.nonexact_ashr_eq_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-128)) e) (const? 8 (-1)) ⊑ icmp IntPred.eq e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_ashr_ne_proof.nonexact_ashr_ne_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-128)) e) (const? 8 (-1)) ⊑ icmp IntPred.ne e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_lshr_eq_proof.nonexact_lshr_eq_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 4) e) (const? 8 1) ⊑ icmp IntPred.eq e (const? 8 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_lshr_ne_proof.nonexact_lshr_ne_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 4) e) (const? 8 1) ⊑ icmp IntPred.ne e (const? 8 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_eq_exactdiv_proof.exact_lshr_eq_exactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 80) e { «exact» := true }) (const? 8 5) ⊑ icmp IntPred.eq e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_ne_exactdiv_proof.exact_lshr_ne_exactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 80) e { «exact» := true }) (const? 8 5) ⊑ icmp IntPred.ne e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_lshr_eq_exactdiv_proof.nonexact_lshr_eq_exactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 80) e) (const? 8 5) ⊑ icmp IntPred.eq e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_lshr_ne_exactdiv_proof.nonexact_lshr_ne_exactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 80) e) (const? 8 5) ⊑ icmp IntPred.ne e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_ashr_eq_exactdiv_proof.exact_ashr_eq_exactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-80)) e { «exact» := true }) (const? 8 (-5)) ⊑
    icmp IntPred.eq e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_ashr_ne_exactdiv_proof.exact_ashr_ne_exactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-80)) e { «exact» := true }) (const? 8 (-5)) ⊑
    icmp IntPred.ne e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_ashr_eq_exactdiv_proof.nonexact_ashr_eq_exactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-80)) e) (const? 8 (-5)) ⊑ icmp IntPred.eq e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_ashr_ne_exactdiv_proof.nonexact_ashr_ne_exactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-80)) e) (const? 8 (-5)) ⊑ icmp IntPred.ne e (const? 8 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_eq_noexactdiv_proof.exact_lshr_eq_noexactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 80) e { «exact» := true }) (const? 8 31) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_lshr_ne_noexactdiv_proof.exact_lshr_ne_noexactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 80) e { «exact» := true }) (const? 8 31) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_lshr_eq_noexactdiv_proof.nonexact_lshr_eq_noexactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 80) e) (const? 8 31) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_lshr_ne_noexactdiv_proof.nonexact_lshr_ne_noexactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 80) e) (const? 8 31) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_ashr_eq_noexactdiv_proof.exact_ashr_eq_noexactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-80)) e { «exact» := true }) (const? 8 (-31)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exact_ashr_ne_noexactdiv_proof.exact_ashr_ne_noexactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-80)) e { «exact» := true }) (const? 8 (-31)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_ashr_eq_noexactdiv_proof.nonexact_ashr_eq_noexactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-80)) e) (const? 8 (-31)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_ashr_ne_noexactdiv_proof.nonexact_ashr_ne_noexactdiv_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-80)) e) (const? 8 (-31)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_lshr_eq_noexactlog_proof.nonexact_lshr_eq_noexactlog_thm_1 (e : IntW 8) :
  icmp IntPred.eq (lshr (const? 8 90) e) (const? 8 30) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_lshr_ne_noexactlog_proof.nonexact_lshr_ne_noexactlog_thm_1 (e : IntW 8) :
  icmp IntPred.ne (lshr (const? 8 90) e) (const? 8 30) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_ashr_eq_noexactlog_proof.nonexact_ashr_eq_noexactlog_thm_1 (e : IntW 8) :
  icmp IntPred.eq (ashr (const? 8 (-90)) e) (const? 8 (-30)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem nonexact_ashr_ne_noexactlog_proof.nonexact_ashr_ne_noexactlog_thm_1 (e : IntW 8) :
  icmp IntPred.ne (ashr (const? 8 (-90)) e) (const? 8 (-30)) ⊑ const? 1 1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR20945_proof.PR20945_thm_1 (e : IntW 32) :
  icmp IntPred.ne (ashr (const? 32 (-9)) e) (const? 32 (-5)) ⊑ icmp IntPred.ne e (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR21222_proof.PR21222_thm_1 (e : IntW 32) :
  icmp IntPred.eq (ashr (const? 32 (-93)) e) (const? 32 (-2)) ⊑ icmp IntPred.eq e (const? 32 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem PR24873_proof.PR24873_thm_1 (e : IntW 64) :
  icmp IntPred.eq (ashr (const? 64 (-4611686018427387904)) e) (const? 64 (-1)) ⊑
    icmp IntPred.ugt e (const? 64 61) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_exact_eq_0_proof.ashr_exact_eq_0_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.eq (ashr e e_1 { «exact» := true }) (const? 32 0) ⊑ icmp IntPred.eq e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_exact_ne_0_proof.lshr_exact_ne_0_thm_1 (e e_1 : IntW 32) :
  icmp IntPred.ne (lshr e e_1 { «exact» := true }) (const? 32 0) ⊑ icmp IntPred.ne e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_0_proof.ashr_ugt_0_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 0) ⊑ icmp IntPred.ugt e (const? 4 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_1_proof.ashr_ugt_1_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 1) ⊑ icmp IntPred.ugt e (const? 4 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_2_proof.ashr_ugt_2_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 2) ⊑ icmp IntPred.ugt e (const? 4 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_3_proof.ashr_ugt_3_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 3) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_4_proof.ashr_ugt_4_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 4) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_5_proof.ashr_ugt_5_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 5) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_6_proof.ashr_ugt_6_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 6) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_7_proof.ashr_ugt_7_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 7) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_8_proof.ashr_ugt_8_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 (-8)) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_9_proof.ashr_ugt_9_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 (-7)) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_10_proof.ashr_ugt_10_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 (-6)) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_11_proof.ashr_ugt_11_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 (-5)) ⊑ icmp IntPred.slt e (const? 4 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_12_proof.ashr_ugt_12_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 (-4)) ⊑ icmp IntPred.ugt e (const? 4 (-7)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_13_proof.ashr_ugt_13_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 (-3)) ⊑ icmp IntPred.ugt e (const? 4 (-5)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_14_proof.ashr_ugt_14_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 (-2)) ⊑ icmp IntPred.ugt e (const? 4 (-3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ugt_15_proof.ashr_ugt_15_thm_1 (e : IntW 4) :
  icmp IntPred.ugt (ashr e (const? 4 1)) (const? 4 (-1)) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_0_proof.ashr_ult_0_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 0) ⊑ const? 1 0 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_1_proof.ashr_ult_1_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 1) ⊑ icmp IntPred.ult e (const? 4 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_2_proof.ashr_ult_2_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 2) ⊑ icmp IntPred.ult e (const? 4 4) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_3_proof.ashr_ult_3_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 3) ⊑ icmp IntPred.ult e (const? 4 6) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_4_proof.ashr_ult_4_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 4) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_5_proof.ashr_ult_5_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 5) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_6_proof.ashr_ult_6_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 6) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_7_proof.ashr_ult_7_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 7) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_8_proof.ashr_ult_8_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 (-8)) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_9_proof.ashr_ult_9_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 (-7)) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_10_proof.ashr_ult_10_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 (-6)) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_11_proof.ashr_ult_11_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 (-5)) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_12_proof.ashr_ult_12_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 (-4)) ⊑ icmp IntPred.sgt e (const? 4 (-1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_13_proof.ashr_ult_13_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 (-3)) ⊑ icmp IntPred.ult e (const? 4 (-6)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_14_proof.ashr_ult_14_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 (-2)) ⊑ icmp IntPred.ult e (const? 4 (-4)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_ult_15_proof.ashr_ult_15_thm_1 (e : IntW 4) :
  icmp IntPred.ult (ashr e (const? 4 1)) (const? 4 (-1)) ⊑ icmp IntPred.ult e (const? 4 (-2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_pow2_ugt_proof.lshr_pow2_ugt_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (lshr (const? 8 2) e) (const? 8 1) ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_pow2_ugt1_proof.lshr_pow2_ugt1_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (lshr (const? 8 (-128)) e) (const? 8 1) ⊑ icmp IntPred.ult e (const? 8 7) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_pow2_ugt_proof.ashr_pow2_ugt_thm_1 (e : IntW 8) :
  icmp IntPred.ugt (ashr (const? 8 (-128)) e) (const? 8 (-96)) ⊑
    icmp IntPred.ugt (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-96)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_pow2_sgt_proof.lshr_pow2_sgt_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (lshr (const? 8 (-128)) e) (const? 8 3) ⊑
    icmp IntPred.sgt (lshr (const? 8 (-128)) e { «exact» := true }) (const? 8 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_pow2_ult_proof.lshr_pow2_ult_thm_1 (e : IntW 8) :
  icmp IntPred.ult (lshr (const? 8 4) e) (const? 8 2) ⊑ icmp IntPred.ugt e (const? 8 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_pow2_ult_equal_constants_proof.lshr_pow2_ult_equal_constants_thm_1 (e : IntW 32) :
  icmp IntPred.ult (lshr (const? 32 16) e) (const? 32 16) ⊑ icmp IntPred.ne e (const? 32 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_pow2_ult_smin_proof.lshr_pow2_ult_smin_thm_1 (e : IntW 8) :
  icmp IntPred.ult (lshr (const? 8 (-128)) e) (const? 8 (-128)) ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_pow2_ult_proof.ashr_pow2_ult_thm_1 (e : IntW 8) :
  icmp IntPred.ult (ashr (const? 8 (-128)) e) (const? 8 (-96)) ⊑
    icmp IntPred.ult (ashr (const? 8 (-128)) e { «exact» := true }) (const? 8 (-96)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_pow2_slt_proof.lshr_pow2_slt_thm_1 (e : IntW 8) :
  icmp IntPred.slt (lshr (const? 8 (-128)) e) (const? 8 3) ⊑
    icmp IntPred.slt (lshr (const? 8 (-128)) e { «exact» := true }) (const? 8 3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_neg_sgt_minus_1_proof.lshr_neg_sgt_minus_1_thm_1 (e : IntW 8) :
  icmp IntPred.sgt (lshr (const? 8 (-17)) e) (const? 8 (-1)) ⊑ icmp IntPred.ne e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem lshr_neg_slt_zero_proof.lshr_neg_slt_zero_thm_1 (e : IntW 8) :
  icmp IntPred.slt (lshr (const? 8 (-17)) e) (const? 8 0) ⊑ icmp IntPred.eq e (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exactly_one_set_signbit_proof.exactly_one_set_signbit_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (lshr e (const? 8 7)) (zext 8 (icmp IntPred.sgt e_1 (const? 8 (-1)))) ⊑
    icmp IntPred.slt (LLVM.xor e e_1) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem same_signbit_wrong_type_proof.same_signbit_wrong_type_thm_1 (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPred.ne (lshr e (const? 8 7)) (zext 8 (icmp IntPred.sgt e_1 (const? 32 (-1)))) ⊑
    LLVM.xor (icmp IntPred.slt e (const? 8 0)) (icmp IntPred.sgt e_1 (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exactly_one_set_signbit_wrong_pred_proof.exactly_one_set_signbit_wrong_pred_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.sgt (lshr e (const? 8 7)) (zext 8 (icmp IntPred.sgt e_1 (const? 8 (-1)))) ⊑
    icmp IntPred.slt (LLVM.and e_1 e) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem exactly_one_set_signbit_signed_proof.exactly_one_set_signbit_signed_thm_1 (e e_1 : IntW 8) :
  icmp IntPred.eq (ashr e (const? 8 7)) (sext 8 (icmp IntPred.sgt e_1 (const? 8 (-1)))) ⊑
    icmp IntPred.slt (LLVM.xor e e_1) (const? 8 0) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem same_signbit_wrong_type_signed_proof.same_signbit_wrong_type_signed_thm_1 (e : IntW 8) (e_1 : IntW 32) :
  icmp IntPred.ne (ashr e (const? 8 7)) (sext 8 (icmp IntPred.sgt e_1 (const? 32 (-1)))) ⊑
    LLVM.xor (icmp IntPred.slt e (const? 8 0)) (icmp IntPred.sgt e_1 (const? 32 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem slt_zero_ult_i1_proof.slt_zero_ult_i1_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.ult (zext 32 e_1) (lshr e (const? 32 31)) ⊑
    LLVM.and (icmp IntPred.slt e (const? 32 0)) (LLVM.xor e_1 (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem slt_zero_ult_i1_fail1_proof.slt_zero_ult_i1_fail1_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.ult (zext 32 e_1) (lshr e (const? 32 30)) ⊑
    icmp IntPred.ugt (lshr e (const? 32 30)) (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem slt_zero_ult_i1_fail2_proof.slt_zero_ult_i1_fail2_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.ult (zext 32 e_1) (ashr e (const? 32 31)) ⊑
    icmp IntPred.ugt (ashr e (const? 32 31)) (zext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem slt_zero_slt_i1_fail_proof.slt_zero_slt_i1_fail_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.slt (zext 32 e_1) (lshr e (const? 32 31)) ⊑
    LLVM.and (icmp IntPred.slt e (const? 32 0)) (LLVM.xor e_1 (const? 1 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem slt_zero_eq_i1_signed_proof.slt_zero_eq_i1_signed_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.eq (sext 32 e_1) (ashr e (const? 32 31)) ⊑ LLVM.xor (icmp IntPred.sgt e (const? 32 (-1))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem slt_zero_eq_i1_fail_signed_proof.slt_zero_eq_i1_fail_signed_thm_1 (e : IntW 32) (e_1 : IntW 1) :
  icmp IntPred.eq (sext 32 e_1) (lshr e (const? 32 31)) ⊑ icmp IntPred.eq (lshr e (const? 32 31)) (sext 32 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
