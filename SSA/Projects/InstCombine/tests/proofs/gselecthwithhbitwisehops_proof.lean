
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gselecthwithhbitwisehops_proof
theorem select_icmp_eq_and_1_0_or_2_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 1)) (const? 32 0)) e (LLVM.or e (const? 32 2)) ⊑
    LLVM.or e (LLVM.and (shl e_1 (const? 32 1)) (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_and_1_0_xor_2_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 1)) (const? 32 0)) e (LLVM.xor e (const? 32 2)) ⊑
    LLVM.xor e (LLVM.and (shl e_1 (const? 32 1)) (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_and_32_0_or_8_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 32)) (const? 32 0)) e (LLVM.or e (const? 32 8)) ⊑
    LLVM.or e (LLVM.and (lshr e_1 (const? 32 2)) (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_and_32_0_xor_8_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 32)) (const? 32 0)) e (LLVM.xor e (const? 32 8)) ⊑
    LLVM.xor e (LLVM.and (lshr e_1 (const? 32 2)) (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_4096_or_4096_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.or e (const? 32 4096)) ⊑
    LLVM.or e (LLVM.xor (LLVM.and e_1 (const? 32 4096)) (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_4096_xor_4096_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.xor e (const? 32 4096)) ⊑
    LLVM.xor (LLVM.xor (LLVM.and e_1 (const? 32 4096)) e) (const? 32 4096) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_4096_and_not_4096_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.and e (const? 32 (-4097))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) (LLVM.and e (const? 32 (-4097)))
      e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_and_4096_0_or_4096_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) e (LLVM.or e (const? 32 4096)) ⊑
    LLVM.or e (LLVM.and e_1 (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_and_4096_0_xor_4096_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) e (LLVM.xor e (const? 32 4096)) ⊑
    LLVM.xor e (LLVM.and e_1 (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_0_and_1_or_1_thm (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 64 1)) (const? 64 0)) e (LLVM.or e (const? 32 1)) ⊑
    LLVM.or e (LLVM.and (trunc 32 e_1) (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_0_and_1_xor_1_thm (e : IntW 32) (e_1 : IntW 64) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 64 1)) (const? 64 0)) e (LLVM.xor e (const? 32 1)) ⊑
    LLVM.xor e (LLVM.and (trunc 32 e_1) (const? 32 1)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_4096_or_32_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.or e (const? 32 32)) ⊑
    LLVM.or e (LLVM.xor (LLVM.and (lshr e_1 (const? 32 7)) (const? 32 32)) (const? 32 32)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_4096_xor_32_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.xor e (const? 32 32)) ⊑
    LLVM.xor (LLVM.xor (LLVM.and (lshr e_1 (const? 32 7)) (const? 32 32)) e) (const? 32 32) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_4096_and_not_32_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.and e (const? 32 (-33))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) (LLVM.and e (const? 32 (-33)))
      e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_32_or_4096_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 32))) e (LLVM.or e (const? 32 4096)) ⊑
    LLVM.or e (LLVM.xor (LLVM.and (shl e_1 (const? 32 7)) (const? 32 4096)) (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_32_xor_4096_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 32))) e (LLVM.xor e (const? 32 4096)) ⊑
    LLVM.xor (LLVM.xor (LLVM.and (shl e_1 (const? 32 7)) (const? 32 4096)) e) (const? 32 4096) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_32_and_not_4096_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 32))) e (LLVM.and e (const? 32 (-4097))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 32)) (const? 32 0)) (LLVM.and e (const? 32 (-4097)))
      e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_1073741824_or_8_thm (e : IntW 8) (e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 1073741824))) e (LLVM.or e (const? 8 8)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 1073741824)) (const? 32 0)) (LLVM.or e (const? 8 8))
      e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_1073741824_xor_8_thm (e : IntW 8) (e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 1073741824))) e (LLVM.xor e (const? 8 8)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 1073741824)) (const? 32 0)) (LLVM.xor e (const? 8 8))
      e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_1073741824_and_not_8_thm (e : IntW 8) (e_1 : IntW 32) :
  select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 1073741824))) e (LLVM.and e (const? 8 (-9))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 1073741824)) (const? 32 0)) (LLVM.and e (const? 8 (-9)))
      e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_8_or_1073741824_thm (e : IntW 32) (e_1 : IntW 8) :
  select (icmp IntPredicate.ne (const? 8 0) (LLVM.and e_1 (const? 8 8))) e (LLVM.or e (const? 32 1073741824)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 8)) (const? 8 0)) (LLVM.or e (const? 32 1073741824)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_8_xor_1073741824_thm (e : IntW 32) (e_1 : IntW 8) :
  select (icmp IntPredicate.ne (const? 8 0) (LLVM.and e_1 (const? 8 8))) e (LLVM.xor e (const? 32 1073741824)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 8)) (const? 8 0)) (LLVM.xor e (const? 32 1073741824))
      e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_ne_0_and_8_and_not_1073741824_thm (e : IntW 32) (e_1 : IntW 8) :
  select (icmp IntPredicate.ne (const? 8 0) (LLVM.and e_1 (const? 8 8))) e (LLVM.and e (const? 32 (-1073741825))) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 8)) (const? 8 0)) (LLVM.and e (const? 32 (-1073741825)))
      e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_and_8_ne_0_xor_8_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 8)) (const? 32 0)) e (LLVM.xor e (const? 32 8)) ⊑
    LLVM.and e (const? 32 (-9)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_and_8_eq_0_xor_8_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 8)) (const? 32 0)) (LLVM.xor e (const? 32 8)) e ⊑
    LLVM.or e (const? 32 8) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_x_and_8_eq_0_y_xor_8_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 8)) (const? 32 0)) e (LLVM.xor e (const? 64 8)) ⊑
    LLVM.xor e (zext 64 (LLVM.and e_1 (const? 32 8)) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_x_and_8_ne_0_y_xor_8_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 8)) (const? 32 0)) (LLVM.xor e (const? 64 8)) e ⊑
    LLVM.xor e (zext 64 (LLVM.xor (LLVM.and e_1 (const? 32 8)) (const? 32 8)) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_x_and_8_ne_0_y_or_8_thm (e : IntW 64) (e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 8)) (const? 32 0)) (LLVM.or e (const? 64 8)) e ⊑
    LLVM.or e (zext 64 (LLVM.xor (LLVM.and e_1 (const? 32 8)) (const? 32 8)) { «nneg» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_and_2147483648_ne_0_xor_2147483648_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 (-2147483648))) (const? 32 0)) e
      (LLVM.xor e (const? 32 (-2147483648))) ⊑
    LLVM.and e (const? 32 2147483647) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_and_2147483648_eq_0_xor_2147483648_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 (-2147483648))) (const? 32 0))
      (LLVM.xor e (const? 32 (-2147483648))) e ⊑
    LLVM.or e (const? 32 (-2147483648)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_x_and_2147483648_ne_0_or_2147483648_thm (e : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e (const? 32 (-2147483648))) (const? 32 0))
      (LLVM.or e (const? 32 (-2147483648))) e ⊑
    LLVM.or e (const? 32 (-2147483648)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test68_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 128)) (const? 32 0)) e (LLVM.or e (const? 32 2)) ⊑
    LLVM.or e (LLVM.and (lshr e_1 (const? 32 6)) (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test68_xor_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 128)) (const? 32 0)) e (LLVM.xor e (const? 32 2)) ⊑
    LLVM.xor e (LLVM.and (lshr e_1 (const? 32 6)) (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test69_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e_1 (const? 32 128)) (const? 32 0)) e (LLVM.or e (const? 32 2)) ⊑
    LLVM.or e (LLVM.xor (LLVM.and (lshr e_1 (const? 32 6)) (const? 32 2)) (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test69_xor_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e_1 (const? 32 128)) (const? 32 0)) e (LLVM.xor e (const? 32 2)) ⊑
    LLVM.xor (LLVM.xor (LLVM.and (lshr e_1 (const? 32 6)) (const? 32 2)) e) (const? 32 2) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test69_and_thm (e e_1 : IntW 32) :
  select (icmp IntPredicate.ne (LLVM.and e_1 (const? 32 128)) (const? 32 0)) e (LLVM.and e (const? 32 2)) ⊑
    select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 128)) (const? 32 0)) (LLVM.and e (const? 32 2)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test70_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.slt e_1 (const? 8 0)) (LLVM.or e (const? 8 2)) e ⊑
    LLVM.or e (LLVM.and (lshr e_1 (const? 8 6)) (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_no_xor_multiuse_or_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 1)) (const? 32 0)) e (LLVM.or e (const? 32 2)))
      (LLVM.or e (const? 32 2)) ⊑
    mul (LLVM.or e (LLVM.and (shl e_1 (const? 32 1)) (const? 32 2))) (LLVM.or e (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_no_xor_multiuse_xor_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 1)) (const? 32 0)) e (LLVM.xor e (const? 32 2)))
      (LLVM.xor e (const? 32 2)) ⊑
    mul (LLVM.xor e (LLVM.and (shl e_1 (const? 32 1)) (const? 32 2))) (LLVM.xor e (const? 32 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_no_xor_multiuse_or_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) e (LLVM.or e (const? 32 4096)))
      (LLVM.or e (const? 32 4096)) ⊑
    mul (LLVM.or e (LLVM.and e_1 (const? 32 4096))) (LLVM.or e (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_no_xor_multiuse_xor_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) e (LLVM.xor e (const? 32 4096)))
      (LLVM.xor e (const? 32 4096)) ⊑
    mul (LLVM.xor e (LLVM.and e_1 (const? 32 4096))) (LLVM.xor e (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_or_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.or e (const? 32 4096)))
      (LLVM.or e (const? 32 4096)) ⊑
    mul (LLVM.or e (LLVM.xor (LLVM.and e_1 (const? 32 4096)) (const? 32 4096))) (LLVM.or e (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_xor_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.xor e (const? 32 4096)))
      (LLVM.xor e (const? 32 4096)) ⊑
    mul (LLVM.xor (LLVM.xor (LLVM.and e_1 (const? 32 4096)) e) (const? 32 4096)) (LLVM.xor e (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_and_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.and e (const? 32 (-4097))))
      (LLVM.and e (const? 32 (-4097))) ⊑
    mul (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) (LLVM.and e (const? 32 (-4097))) e)
      (LLVM.and e (const? 32 (-4097))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_or_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.or e (const? 32 2048)))
      (LLVM.or e (const? 32 2048)) ⊑
    mul (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) (LLVM.or e (const? 32 2048)) e)
      (LLVM.or e (const? 32 2048)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_xor_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.xor e (const? 32 2048)))
      (LLVM.xor e (const? 32 2048)) ⊑
    mul (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) (LLVM.xor e (const? 32 2048)) e)
      (LLVM.xor e (const? 32 2048)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_and_thm (e e_1 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_1 (const? 32 4096))) e (LLVM.and e (const? 32 (-2049))))
      (LLVM.and e (const? 32 (-2049))) ⊑
    mul (select (icmp IntPredicate.eq (LLVM.and e_1 (const? 32 4096)) (const? 32 0)) (LLVM.and e (const? 32 (-2049))) e)
      (LLVM.and e (const? 32 (-2049))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_no_xor_multiuse_cmp_thm (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 1)) (const? 32 0)) e_2 (LLVM.or e_2 (const? 32 2)))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 1)) (const? 32 0)) e_1 e) ⊑
    mul (LLVM.or e_2 (shl (LLVM.and e_3 (const? 32 1)) (const? 32 1) { «nsw» := true, «nuw» := true }))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 1)) (const? 32 0)) e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_no_xor_multiuse_cmp_with_xor_thm (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 1)) (const? 32 0)) e_2 (LLVM.xor e_2 (const? 32 2)))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 1)) (const? 32 0)) e_1 e) ⊑
    mul (LLVM.xor e_2 (shl (LLVM.and e_3 (const? 32 1)) (const? 32 1) { «nsw» := true, «nuw» := true }))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 1)) (const? 32 0)) e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_no_xor_multiuse_cmp_thm (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_2 (LLVM.or e_2 (const? 32 4096)))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_1 e) ⊑
    mul (LLVM.or e_2 (LLVM.and e_3 (const? 32 4096)))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_no_xor_multiuse_cmp_with_xor_thm (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_2 (LLVM.xor e_2 (const? 32 4096)))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_1 e) ⊑
    mul (LLVM.xor e_2 (LLVM.and e_3 (const? 32 4096)))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_1 e) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_cmp_thm (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2 (LLVM.or e_2 (const? 32 4096)))
      (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e) ⊑
    mul (LLVM.or e_2 (LLVM.xor (LLVM.and e_3 (const? 32 4096)) (const? 32 4096)))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_cmp_with_xor_thm (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2 (LLVM.xor e_2 (const? 32 4096)))
      (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e) ⊑
    mul (LLVM.xor (LLVM.xor (LLVM.and e_3 (const? 32 4096)) e_2) (const? 32 4096))
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_cmp_with_and_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2
        (LLVM.and e_2 (const? 32 (-4097))))
      (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e) ⊑
    mul
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.and e_2 (const? 32 (-4097)))
        e_2)
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_cmp_thm (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2 (LLVM.or e_2 (const? 32 2048)))
      (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e) ⊑
    mul (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.or e_2 (const? 32 2048)) e_2)
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_cmp_with_xor_thm (e e_1 e_2 e_3 : IntW 32) :
  mul (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2 (LLVM.xor e_2 (const? 32 2048)))
      (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e) ⊑
    mul
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.xor e_2 (const? 32 2048)) e_2)
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_cmp_with_and_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2
        (LLVM.and e_2 (const? 32 (-2049))))
      (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e) ⊑
    mul
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.and e_2 (const? 32 (-2049)))
        e_2)
      (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_no_xor_multiuse_cmp_or_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_2 (LLVM.or e_2 (const? 32 4096)))
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_1 e))
      (LLVM.or e_2 (const? 32 4096)) ⊑
    mul
      (mul (LLVM.or e_2 (LLVM.and e_3 (const? 32 4096)))
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_1 e))
      (LLVM.or e_2 (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_no_xor_multiuse_cmp_xor_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_2
          (LLVM.xor e_2 (const? 32 4096)))
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_1 e))
      (LLVM.xor e_2 (const? 32 4096)) ⊑
    mul
      (mul (LLVM.xor e_2 (LLVM.and e_3 (const? 32 4096)))
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e_1 e))
      (LLVM.xor e_2 (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_cmp_or_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2 (LLVM.or e_2 (const? 32 4096)))
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e))
      (LLVM.or e_2 (const? 32 4096)) ⊑
    mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.or e_2 (const? 32 4096)) e_2)
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1))
      (LLVM.or e_2 (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_cmp_xor_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2
          (LLVM.xor e_2 (const? 32 4096)))
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e))
      (LLVM.xor e_2 (const? 32 4096)) ⊑
    mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.xor e_2 (const? 32 4096))
          e_2)
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1))
      (LLVM.xor e_2 (const? 32 4096)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem no_shift_xor_multiuse_cmp_and_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2
          (LLVM.and e_2 (const? 32 (-4097))))
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e))
      (LLVM.and e_2 (const? 32 (-4097))) ⊑
    mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.and e_2 (const? 32 (-4097)))
          e_2)
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1))
      (LLVM.and e_2 (const? 32 (-4097))) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_cmp_or_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2 (LLVM.or e_2 (const? 32 2048)))
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e))
      (LLVM.or e_2 (const? 32 2048)) ⊑
    mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.or e_2 (const? 32 2048)) e_2)
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1))
      (LLVM.or e_2 (const? 32 2048)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_cmp_xor_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2
          (LLVM.xor e_2 (const? 32 2048)))
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e))
      (LLVM.xor e_2 (const? 32 2048)) ⊑
    mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.xor e_2 (const? 32 2048))
          e_2)
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1))
      (LLVM.xor e_2 (const? 32 2048)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem shift_xor_multiuse_cmp_and_thm (e e_1 e_2 e_3 : IntW 32) :
  mul
      (mul
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_2
          (LLVM.and e_2 (const? 32 2048)))
        (select (icmp IntPredicate.ne (const? 32 0) (LLVM.and e_3 (const? 32 4096))) e_1 e))
      (LLVM.and e_2 (const? 32 2048)) ⊑
    mul
      (mul
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) (LLVM.and e_2 (const? 32 2048))
          e_2)
        (select (icmp IntPredicate.eq (LLVM.and e_3 (const? 32 4096)) (const? 32 0)) e e_1))
      (LLVM.and e_2 (const? 32 2048)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem set_bits_thm (e : IntW 8) (e_1 : IntW 1) :
  select e_1 (LLVM.or e (const? 8 5)) (LLVM.and e (const? 8 (-6))) ⊑
    LLVM.or (LLVM.and e (const? 8 (-6))) (select e_1 (const? 8 5) (const? 8 0)) { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_i8_to_i64_shl_save_and_ne_thm (e : IntW 64) (e_1 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_1 (const? 8 1)) (const? 8 0)) (LLVM.xor e (const? 64 (-9223372036854775808)))
      e ⊑
    LLVM.xor e (shl (zext 64 e_1) (const? 64 63)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_and_1_0_lshr_fv_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.eq (LLVM.and e_1 (const? 8 1)) (const? 8 0)) e (lshr e (const? 8 2)) ⊑
    lshr e (LLVM.and (shl e_1 (const? 8 1)) (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem select_icmp_eq_and_1_0_lshr_tv_thm (e e_1 : IntW 8) :
  select (icmp IntPredicate.ne (LLVM.and e_1 (const? 8 1)) (const? 8 0)) (lshr e (const? 8 2)) e ⊑
    lshr e (LLVM.and (shl e_1 (const? 8 1)) (const? 8 2)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


