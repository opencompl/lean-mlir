
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gdemorgan_proof
theorem demorgan_or_apint1_thm (e e_1 : IntW 43) :
  LLVM.or (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1))) ⊑ LLVM.xor (LLVM.and e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_or_apint2_thm (e e_1 : IntW 129) :
  LLVM.or (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1))) ⊑ LLVM.xor (LLVM.and e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_and_apint1_thm (e e_1 : IntW 477) :
  LLVM.and (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1))) ⊑ LLVM.xor (LLVM.or e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_and_apint2_thm (e e_1 : IntW 129) :
  LLVM.and (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1))) ⊑ LLVM.xor (LLVM.or e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_and_apint3_thm (e e_1 : IntW 65) :
  LLVM.and (LLVM.xor e_1 (const? (-1))) (LLVM.xor (const? (-1)) e) ⊑ LLVM.xor (LLVM.or e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_and_apint4_thm (e e_1 : IntW 66) :
  LLVM.and (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1))) ⊑ LLVM.xor (LLVM.or e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_and_apint5_thm (e e_1 : IntW 47) :
  LLVM.and (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1))) ⊑ LLVM.xor (LLVM.or e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1)))) (const? (-1)) ⊑ LLVM.or e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_thm (e : IntW 32) :
  LLVM.xor (LLVM.and (LLVM.xor e (const? (-1))) (const? 5)) (const? (-1)) ⊑ LLVM.or e (const? (-6)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1)))) (const? (-1)) ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test3_apint_thm (e e_1 : IntW 47) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1)))) (const? (-1)) ⊑ LLVM.or e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test4_apint_thm (e : IntW 61) :
  LLVM.and (LLVM.xor e (const? (-1))) (const? 5) ⊑ LLVM.xor (LLVM.and e (const? 5)) (const? 5) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem test5_apint_thm (e e_1 : IntW 71) :
  LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) (LLVM.xor e (const? (-1)))) (const? (-1)) ⊑ LLVM.and e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nand_thm (e e_1 : IntW 8) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? (-1))) e) (const? (-1)) ⊑ LLVM.or e_1 (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nand_apint1_thm (e e_1 : IntW 7) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? (-1))) e) (const? (-1)) ⊑ LLVM.or e_1 (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nand_apint2_thm (e e_1 : IntW 117) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 (const? (-1))) e) (const? (-1)) ⊑ LLVM.or e_1 (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nor_thm (e e_1 : IntW 8) :
  LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? (-1)) ⊑ LLVM.and e_1 (LLVM.xor e (const? (-1))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nor_use2a_thm (e e_1 : IntW 8) :
  LLVM.sdiv (LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? (-1)))
      (mul (LLVM.xor e_1 (const? (-1))) (const? 23)) ⊑
    LLVM.sdiv (LLVM.and e_1 (LLVM.xor e (const? (-1)))) (mul (LLVM.xor e_1 (const? (-1))) (const? 23)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nor_use2b_thm (e e_1 : IntW 8) :
  LLVM.sdiv (LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? (-1))) (mul e (const? 23)) ⊑
    LLVM.sdiv (LLVM.and e_1 (LLVM.xor e (const? (-1)))) (mul e (const? 23)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nor_use2c_thm (e e_1 : IntW 8) :
  LLVM.sdiv (LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? (-1)))
      (mul (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? 23)) ⊑
    LLVM.sdiv (LLVM.xor (LLVM.or e (LLVM.xor e_1 (const? (-1)))) (const? (-1)))
      (mul (LLVM.or e (LLVM.xor e_1 (const? (-1)))) (const? 23)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nor_use2ab_thm (e e_1 : IntW 8) :
  LLVM.sdiv (LLVM.sdiv (LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? (-1))) (mul e (const? 23)))
      (mul (LLVM.xor e_1 (const? (-1))) (const? 17)) ⊑
    LLVM.sdiv (LLVM.sdiv (LLVM.and e_1 (LLVM.xor e (const? (-1)))) (mul e (const? 23)))
      (mul (LLVM.xor e_1 (const? (-1))) (const? 17)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nor_use2ac_thm (e e_1 : IntW 8) :
  LLVM.sdiv
      (LLVM.sdiv (LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? (-1)))
        (mul (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? 23)))
      (mul (LLVM.xor e_1 (const? (-1))) (const? 17)) ⊑
    LLVM.sdiv
      (LLVM.sdiv (LLVM.xor (LLVM.or e (LLVM.xor e_1 (const? (-1)))) (const? (-1)))
        (mul (LLVM.or e (LLVM.xor e_1 (const? (-1)))) (const? 23)))
      (mul (LLVM.xor e_1 (const? (-1))) (const? 17)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_nor_use2bc_thm (e e_1 : IntW 8) :
  LLVM.sdiv
      (LLVM.sdiv (LLVM.xor (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? (-1)))
        (mul (LLVM.or (LLVM.xor e_1 (const? (-1))) e) (const? 23)))
      (mul e (const? 23)) ⊑
    LLVM.sdiv
      (LLVM.sdiv (LLVM.xor (LLVM.or e (LLVM.xor e_1 (const? (-1)))) (const? (-1)))
        (mul (LLVM.or e (LLVM.xor e_1 (const? (-1)))) (const? 23)))
      (mul e (const? 23)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorganize_constant2_thm (e : IntW 32) :
  LLVM.xor (LLVM.or e (const? 15)) (const? (-1)) ⊑ LLVM.xor (LLVM.and e (const? (-16))) (const? (-16)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_or_zext_thm (e e_1 : IntW 1) :
  LLVM.or (LLVM.xor (zext 32 e_1) (const? 1)) (LLVM.xor (zext 32 e) (const? 1)) ⊑
    zext 32 (LLVM.xor (LLVM.and e_1 e) (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_and_zext_thm (e e_1 : IntW 1) :
  LLVM.and (LLVM.xor (zext 32 e_1) (const? 1)) (LLVM.xor (zext 32 e) (const? 1)) ⊑
    zext 32 (LLVM.xor (LLVM.or e_1 e) (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR28476_thm (e e_1 : IntW 32) :
  LLVM.xor (zext 32 (LLVM.and (icmp IntPredicate.ne e_1 (const? 0)) (icmp IntPredicate.ne e (const? 0)))) (const? 1) ⊑
    zext 32 (LLVM.or (icmp IntPredicate.eq e_1 (const? 0)) (icmp IntPredicate.eq e (const? 0))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR28476_logical_thm (e e_1 : IntW 32) :
  LLVM.xor (zext 32 (select (icmp IntPredicate.ne e_1 (const? 0)) (icmp IntPredicate.ne e (const? 0)) (const? 0)))
      (const? 1) ⊑
    zext 32 (select (icmp IntPredicate.eq e_1 (const? 0)) (const? 1) (icmp IntPredicate.eq e (const? 0))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem demorgan_plus_and_to_xor_thm (e e_1 : IntW 32) :
  LLVM.xor (LLVM.or (LLVM.and e_1 e) (LLVM.xor (LLVM.or e_1 e) (const? (-1)))) (const? (-1)) ⊑ LLVM.xor e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR45984_thm (e e_1 : IntW 32) :
  LLVM.or (LLVM.xor e_1 e) (LLVM.xor (LLVM.or e_1 e) (const? (-1))) ⊑ LLVM.xor (LLVM.and e_1 e) (const? (-1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


