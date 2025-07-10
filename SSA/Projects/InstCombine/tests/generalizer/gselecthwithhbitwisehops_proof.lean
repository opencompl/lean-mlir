
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gselecthwithhbitwisehops_proof
theorem select_icmp_eq_and_1_0_or_2_proof.select_icmp_eq_and_1_0_or_2_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 2)) ⊑
    LLVM.or e_1 (LLVM.and (shl e (const? 32 1)) (const? 32 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_and_1_0_xor_2_proof.select_icmp_eq_and_1_0_xor_2_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 2)) ⊑
    LLVM.xor e_1 (LLVM.and (shl e (const? 32 1)) (const? 32 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_and_32_0_or_8_proof.select_icmp_eq_and_32_0_or_8_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 32)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 8)) ⊑
    LLVM.or e_1 (LLVM.and (lshr e (const? 32 2)) (const? 32 8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_and_32_0_xor_8_proof.select_icmp_eq_and_32_0_xor_8_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 32)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 8)) ⊑
    LLVM.xor e_1 (LLVM.and (lshr e (const? 32 2)) (const? 32 8)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_4096_or_4096_proof.select_icmp_ne_0_and_4096_or_4096_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.or e_1 (const? 32 4096)) ⊑
    LLVM.or e_1 (LLVM.xor (LLVM.and e (const? 32 4096)) (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_4096_xor_4096_proof.select_icmp_ne_0_and_4096_xor_4096_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.xor e_1 (const? 32 4096)) ⊑
    LLVM.xor (LLVM.xor (LLVM.and e (const? 32 4096)) e_1) (const? 32 4096) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_4096_and_not_4096_proof.select_icmp_ne_0_and_4096_and_not_4096_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.and e_1 (const? 32 (-4097))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.and e_1 (const? 32 (-4097))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_and_4096_0_or_4096_proof.select_icmp_eq_and_4096_0_or_4096_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 4096)) ⊑
    LLVM.or e_1 (LLVM.and e (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_and_4096_0_xor_4096_proof.select_icmp_eq_and_4096_0_xor_4096_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 4096)) ⊑
    LLVM.xor e_1 (LLVM.and e (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_0_and_1_or_1_proof.select_icmp_eq_0_and_1_or_1_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 64 1)) (const? 64 0)) e_1 (LLVM.or e_1 (const? 32 1)) ⊑
    LLVM.or e_1 (LLVM.and (trunc 32 e) (const? 32 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_0_and_1_xor_1_proof.select_icmp_eq_0_and_1_xor_1_thm_1 (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 64 1)) (const? 64 0)) e_1 (LLVM.xor e_1 (const? 32 1)) ⊑
    LLVM.xor e_1 (LLVM.and (trunc 32 e) (const? 32 1)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_4096_or_32_proof.select_icmp_ne_0_and_4096_or_32_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.or e_1 (const? 32 32)) ⊑
    LLVM.or e_1 (LLVM.xor (LLVM.and (lshr e (const? 32 7)) (const? 32 32)) (const? 32 32)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_4096_xor_32_proof.select_icmp_ne_0_and_4096_xor_32_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.xor e_1 (const? 32 32)) ⊑
    LLVM.xor (LLVM.xor (LLVM.and (lshr e (const? 32 7)) (const? 32 32)) e_1) (const? 32 32) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_4096_and_not_32_proof.select_icmp_ne_0_and_4096_and_not_32_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.and e_1 (const? 32 (-33))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.and e_1 (const? 32 (-33))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_32_or_4096_proof.select_icmp_ne_0_and_32_or_4096_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 32))) e_1 (LLVM.or e_1 (const? 32 4096)) ⊑
    LLVM.or e_1 (LLVM.xor (LLVM.and (shl e (const? 32 7)) (const? 32 4096)) (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_32_xor_4096_proof.select_icmp_ne_0_and_32_xor_4096_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 32))) e_1 (LLVM.xor e_1 (const? 32 4096)) ⊑
    LLVM.xor (LLVM.xor (LLVM.and (shl e (const? 32 7)) (const? 32 4096)) e_1) (const? 32 4096) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_32_and_not_4096_proof.select_icmp_ne_0_and_32_and_not_4096_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 32))) e_1 (LLVM.and e_1 (const? 32 (-4097))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32)) (const? 32 0)) (LLVM.and e_1 (const? 32 (-4097))) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_1073741824_or_8_proof.select_icmp_ne_0_and_1073741824_or_8_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 1073741824))) e_1 (LLVM.or e_1 (const? 8 8)) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 1073741824)) (const? 32 0)) (LLVM.or e_1 (const? 8 8)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_1073741824_xor_8_proof.select_icmp_ne_0_and_1073741824_xor_8_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 1073741824))) e_1 (LLVM.xor e_1 (const? 8 8)) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 1073741824)) (const? 32 0)) (LLVM.xor e_1 (const? 8 8)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_1073741824_and_not_8_proof.select_icmp_ne_0_and_1073741824_and_not_8_thm_1 (e : IntW 32) (e_1 : IntW 8) :
  select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 1073741824))) e_1 (LLVM.and e_1 (const? 8 (-9))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 1073741824)) (const? 32 0)) (LLVM.and e_1 (const? 8 (-9)))
      e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_8_or_1073741824_proof.select_icmp_ne_0_and_8_or_1073741824_thm_1 (e : IntW 8) (e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 8 0) (LLVM.and e (const? 8 8))) e_1 (LLVM.or e_1 (const? 32 1073741824)) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 8)) (const? 8 0)) (LLVM.or e_1 (const? 32 1073741824)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_8_xor_1073741824_proof.select_icmp_ne_0_and_8_xor_1073741824_thm_1 (e : IntW 8) (e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 8 0) (LLVM.and e (const? 8 8))) e_1 (LLVM.xor e_1 (const? 32 1073741824)) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 8)) (const? 8 0)) (LLVM.xor e_1 (const? 32 1073741824)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_ne_0_and_8_and_not_1073741824_proof.select_icmp_ne_0_and_8_and_not_1073741824_thm_1 (e : IntW 8) (e_1 : IntW 32) :
  select (icmp IntPred.ne (const? 8 0) (LLVM.and e (const? 8 8))) e_1 (LLVM.and e_1 (const? 32 (-1073741825))) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 8 8)) (const? 8 0)) (LLVM.and e_1 (const? 32 (-1073741825)))
      e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_and_8_ne_0_xor_8_proof.select_icmp_and_8_ne_0_xor_8_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 8)) (const? 32 0)) e (LLVM.xor e (const? 32 8)) ⊑
    LLVM.and e (const? 32 (-9)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_and_8_eq_0_xor_8_proof.select_icmp_and_8_eq_0_xor_8_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 8)) (const? 32 0)) (LLVM.xor e (const? 32 8)) e ⊑
    LLVM.or e (const? 32 8) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_x_and_8_eq_0_y_xor_8_proof.select_icmp_x_and_8_eq_0_y_xor_8_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 8)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 64 8)) ⊑
    LLVM.xor e_1 (zext 64 (LLVM.and e (const? 32 8)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_x_and_8_ne_0_y_xor_8_proof.select_icmp_x_and_8_ne_0_y_xor_8_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 8)) (const? 32 0)) (LLVM.xor e_1 (const? 64 8)) e_1 ⊑
    LLVM.xor e_1 (zext 64 (LLVM.xor (LLVM.and e (const? 32 8)) (const? 32 8)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_x_and_8_ne_0_y_or_8_proof.select_icmp_x_and_8_ne_0_y_or_8_thm_1 (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 8)) (const? 32 0)) (LLVM.or e_1 (const? 64 8)) e_1 ⊑
    LLVM.or e_1 (zext 64 (LLVM.xor (LLVM.and e (const? 32 8)) (const? 32 8)) { «nneg» := true }) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_and_2147483648_ne_0_xor_2147483648_proof.select_icmp_and_2147483648_ne_0_xor_2147483648_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 (-2147483648))) (const? 32 0)) e
      (LLVM.xor e (const? 32 (-2147483648))) ⊑
    LLVM.and e (const? 32 2147483647) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_and_2147483648_eq_0_xor_2147483648_proof.select_icmp_and_2147483648_eq_0_xor_2147483648_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 (-2147483648))) (const? 32 0)) (LLVM.xor e (const? 32 (-2147483648)))
      e ⊑
    LLVM.or e (const? 32 (-2147483648)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_x_and_2147483648_ne_0_or_2147483648_proof.select_icmp_x_and_2147483648_ne_0_or_2147483648_thm_1 (e : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 (-2147483648))) (const? 32 0)) (LLVM.or e (const? 32 (-2147483648)))
      e ⊑
    LLVM.or e (const? 32 (-2147483648)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test68_proof.test68_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 128)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 2)) ⊑
    LLVM.or e_1 (LLVM.and (lshr e (const? 32 6)) (const? 32 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test68_xor_proof.test68_xor_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.eq (LLVM.and e (const? 32 128)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 2)) ⊑
    LLVM.xor e_1 (LLVM.and (lshr e (const? 32 6)) (const? 32 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test69_proof.test69_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 128)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 2)) ⊑
    LLVM.or e_1 (LLVM.xor (LLVM.and (lshr e (const? 32 6)) (const? 32 2)) (const? 32 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test69_xor_proof.test69_xor_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 128)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 2)) ⊑
    LLVM.xor (LLVM.xor (LLVM.and (lshr e (const? 32 6)) (const? 32 2)) e_1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test69_and_proof.test69_and_thm_1 (e e_1 : IntW 32) :
  select (icmp IntPred.ne (LLVM.and e (const? 32 128)) (const? 32 0)) e_1 (LLVM.and e_1 (const? 32 2)) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 128)) (const? 32 0)) (LLVM.and e_1 (const? 32 2)) e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test70_proof.test70_thm_1 (e e_1 : IntW 8) :
  select (icmp IntPred.slt e (const? 8 0)) (LLVM.or e_1 (const? 8 2)) e_1 ⊑
    LLVM.or e_1 (LLVM.and (lshr e (const? 8 6)) (const? 8 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_no_xor_multiuse_or_proof.shift_no_xor_multiuse_or_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 2)))
      (LLVM.or e_1 (const? 32 2)) ⊑
    mul (LLVM.or e_1 (LLVM.and (shl e (const? 32 1)) (const? 32 2))) (LLVM.or e_1 (const? 32 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_no_xor_multiuse_xor_proof.shift_no_xor_multiuse_xor_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 2)))
      (LLVM.xor e_1 (const? 32 2)) ⊑
    mul (LLVM.xor e_1 (LLVM.and (shl e (const? 32 1)) (const? 32 2))) (LLVM.xor e_1 (const? 32 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_no_xor_multiuse_or_proof.no_shift_no_xor_multiuse_or_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 4096)))
      (LLVM.or e_1 (const? 32 4096)) ⊑
    mul (LLVM.or e_1 (LLVM.and e (const? 32 4096))) (LLVM.or e_1 (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_no_xor_multiuse_xor_proof.no_shift_no_xor_multiuse_xor_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 4096)))
      (LLVM.xor e_1 (const? 32 4096)) ⊑
    mul (LLVM.xor e_1 (LLVM.and e (const? 32 4096))) (LLVM.xor e_1 (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_or_proof.no_shift_xor_multiuse_or_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.or e_1 (const? 32 4096)))
      (LLVM.or e_1 (const? 32 4096)) ⊑
    mul (LLVM.or e_1 (LLVM.xor (LLVM.and e (const? 32 4096)) (const? 32 4096))) (LLVM.or e_1 (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_xor_proof.no_shift_xor_multiuse_xor_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.xor e_1 (const? 32 4096)))
      (LLVM.xor e_1 (const? 32 4096)) ⊑
    mul (LLVM.xor (LLVM.xor (LLVM.and e (const? 32 4096)) e_1) (const? 32 4096))
      (LLVM.xor e_1 (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_and_proof.no_shift_xor_multiuse_and_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.and e_1 (const? 32 (-4097))))
      (LLVM.and e_1 (const? 32 (-4097))) ⊑
    mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.and e_1 (const? 32 (-4097))) e_1)
      (LLVM.and e_1 (const? 32 (-4097))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_or_proof.shift_xor_multiuse_or_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.or e_1 (const? 32 2048)))
      (LLVM.or e_1 (const? 32 2048)) ⊑
    mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.or e_1 (const? 32 2048)) e_1)
      (LLVM.or e_1 (const? 32 2048)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_xor_proof.shift_xor_multiuse_xor_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.xor e_1 (const? 32 2048)))
      (LLVM.xor e_1 (const? 32 2048)) ⊑
    mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.xor e_1 (const? 32 2048)) e_1)
      (LLVM.xor e_1 (const? 32 2048)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_and_proof.shift_xor_multiuse_and_thm_1 (e e_1 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.and e_1 (const? 32 (-2049))))
      (LLVM.and e_1 (const? 32 (-2049))) ⊑
    mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.and e_1 (const? 32 (-2049))) e_1)
      (LLVM.and e_1 (const? 32 (-2049))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_no_xor_multiuse_cmp_proof.shift_no_xor_multiuse_cmp_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 2)))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_2 e_3) ⊑
    mul (LLVM.or e_1 (shl (LLVM.and e (const? 32 1)) (const? 32 1) { «nsw» := true, «nuw» := true }))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_2 e_3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_no_xor_multiuse_cmp_with_xor_proof.shift_no_xor_multiuse_cmp_with_xor_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 2)))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_2 e_3) ⊑
    mul (LLVM.xor e_1 (shl (LLVM.and e (const? 32 1)) (const? 32 1) { «nsw» := true, «nuw» := true }))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) e_2 e_3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_no_xor_multiuse_cmp_proof.no_shift_no_xor_multiuse_cmp_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 4096)))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_2 e_3) ⊑
    mul (LLVM.or e_1 (LLVM.and e (const? 32 4096)))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_2 e_3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_no_xor_multiuse_cmp_with_xor_proof.no_shift_no_xor_multiuse_cmp_with_xor_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 4096)))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_2 e_3) ⊑
    mul (LLVM.xor e_1 (LLVM.and e (const? 32 4096)))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_2 e_3) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_cmp_proof.no_shift_xor_multiuse_cmp_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.or e_1 (const? 32 4096)))
      (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3) ⊑
    mul (LLVM.or e_1 (LLVM.xor (LLVM.and e (const? 32 4096)) (const? 32 4096)))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_cmp_with_xor_proof.no_shift_xor_multiuse_cmp_with_xor_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.xor e_1 (const? 32 4096)))
      (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3) ⊑
    mul (LLVM.xor (LLVM.xor (LLVM.and e (const? 32 4096)) e_1) (const? 32 4096))
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_cmp_with_and_proof.no_shift_xor_multiuse_cmp_with_and_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.and e_1 (const? 32 (-4097))))
      (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3) ⊑
    mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.and e_1 (const? 32 (-4097))) e_1)
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_cmp_proof.shift_xor_multiuse_cmp_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.or e_1 (const? 32 2048)))
      (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3) ⊑
    mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.or e_1 (const? 32 2048)) e_1)
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_cmp_with_xor_proof.shift_xor_multiuse_cmp_with_xor_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.xor e_1 (const? 32 2048)))
      (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3) ⊑
    mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.xor e_1 (const? 32 2048)) e_1)
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_cmp_with_and_proof.shift_xor_multiuse_cmp_with_and_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.and e_1 (const? 32 (-2049))))
      (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3) ⊑
    mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.and e_1 (const? 32 (-2049))) e_1)
      (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_no_xor_multiuse_cmp_or_proof.no_shift_no_xor_multiuse_cmp_or_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_1 (LLVM.or e_1 (const? 32 4096)))
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_2 e_3))
      (LLVM.or e_1 (const? 32 4096)) ⊑
    mul
      (mul (LLVM.or e_1 (LLVM.and e (const? 32 4096)))
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_2 e_3))
      (LLVM.or e_1 (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_no_xor_multiuse_cmp_xor_proof.no_shift_no_xor_multiuse_cmp_xor_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_1 (LLVM.xor e_1 (const? 32 4096)))
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_2 e_3))
      (LLVM.xor e_1 (const? 32 4096)) ⊑
    mul
      (mul (LLVM.xor e_1 (LLVM.and e (const? 32 4096)))
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_2 e_3))
      (LLVM.xor e_1 (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_cmp_or_proof.no_shift_xor_multiuse_cmp_or_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.or e_1 (const? 32 4096)))
        (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3))
      (LLVM.or e_1 (const? 32 4096)) ⊑
    mul
      (mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.or e_1 (const? 32 4096)) e_1)
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2))
      (LLVM.or e_1 (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_cmp_xor_proof.no_shift_xor_multiuse_cmp_xor_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.xor e_1 (const? 32 4096)))
        (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3))
      (LLVM.xor e_1 (const? 32 4096)) ⊑
    mul
      (mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.xor e_1 (const? 32 4096)) e_1)
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2))
      (LLVM.xor e_1 (const? 32 4096)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_shift_xor_multiuse_cmp_and_proof.no_shift_xor_multiuse_cmp_and_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.and e_1 (const? 32 (-4097))))
        (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3))
      (LLVM.and e_1 (const? 32 (-4097))) ⊑
    mul
      (mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.and e_1 (const? 32 (-4097))) e_1)
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2))
      (LLVM.and e_1 (const? 32 (-4097))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_cmp_or_proof.shift_xor_multiuse_cmp_or_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.or e_1 (const? 32 2048)))
        (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3))
      (LLVM.or e_1 (const? 32 2048)) ⊑
    mul
      (mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.or e_1 (const? 32 2048)) e_1)
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2))
      (LLVM.or e_1 (const? 32 2048)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_cmp_xor_proof.shift_xor_multiuse_cmp_xor_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.xor e_1 (const? 32 2048)))
        (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3))
      (LLVM.xor e_1 (const? 32 2048)) ⊑
    mul
      (mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.xor e_1 (const? 32 2048)) e_1)
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2))
      (LLVM.xor e_1 (const? 32 2048)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem shift_xor_multiuse_cmp_and_proof.shift_xor_multiuse_cmp_and_thm_1 (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_1 (LLVM.and e_1 (const? 32 2048)))
        (select (icmp IntPred.ne (const? 32 0) (LLVM.and e (const? 32 4096))) e_2 e_3))
      (LLVM.and e_1 (const? 32 2048)) ⊑
    mul
      (mul (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) (LLVM.and e_1 (const? 32 2048)) e_1)
        (select (icmp IntPred.eq (LLVM.and e (const? 32 4096)) (const? 32 0)) e_3 e_2))
      (LLVM.and e_1 (const? 32 2048)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem set_bits_proof.set_bits_thm_1 (e : IntW 8) (e_1 : IntW 1) :
  select e_1 (LLVM.or e (const? 8 5)) (LLVM.and e (const? 8 (-6))) ⊑
    LLVM.or (LLVM.and e (const? 8 (-6))) (select e_1 (const? 8 5) (const? 8 0)) { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem xor_i8_to_i64_shl_save_and_ne_proof.xor_i8_to_i64_shl_save_and_ne_thm_1 (e : IntW 8) (e_1 : IntW 64) :
  select (icmp IntPred.ne (LLVM.and e (const? 8 1)) (const? 8 0)) (LLVM.xor e_1 (const? 64 (-9223372036854775808)))
      e_1 ⊑
    LLVM.xor e_1 (shl (zext 64 e) (const? 64 63)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_and_1_0_lshr_fv_proof.select_icmp_eq_and_1_0_lshr_fv_thm_1 (e e_1 : IntW 8) :
  select (icmp IntPred.eq (LLVM.and e (const? 8 1)) (const? 8 0)) e_1 (lshr e_1 (const? 8 2)) ⊑
    lshr e_1 (LLVM.and (shl e (const? 8 1)) (const? 8 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem select_icmp_eq_and_1_0_lshr_tv_proof.select_icmp_eq_and_1_0_lshr_tv_thm_1 (e e_1 : IntW 8) :
  select (icmp IntPred.ne (LLVM.and e (const? 8 1)) (const? 8 0)) (lshr e_1 (const? 8 2)) e_1 ⊑
    lshr e_1 (LLVM.and (shl e (const? 8 1)) (const? 8 2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
