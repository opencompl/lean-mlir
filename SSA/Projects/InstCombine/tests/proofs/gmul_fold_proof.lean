
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gmul_fold_proof
theorem mul8_low_A0_B0_thm (e e_1 : IntW 8) :
  add (shl (add (mul (lshr e_1 (const? 4)) e) (mul (lshr e (const? 4)) e_1)) (const? 4))
      (mul (LLVM.and e_1 (const? 15)) (LLVM.and e (const? 15))) ⊑
    mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul8_low_thm (e e_1 : IntW 8) :
  add
      (shl
        (add (mul (lshr e_1 (const? 4)) (LLVM.and e (const? 15))) (mul (LLVM.and e_1 (const? 15)) (lshr e (const? 4))))
        (const? 4))
      (mul (LLVM.and e_1 (const? 15)) (LLVM.and e (const? 15))) ⊑
    mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul16_low_thm (e e_1 : IntW 16) :
  add
      (shl
        (add (mul (lshr e_1 (const? 8)) (LLVM.and e (const? 255)))
          (mul (LLVM.and e_1 (const? 255)) (lshr e (const? 8))))
        (const? 8))
      (mul (LLVM.and e_1 (const? 255)) (LLVM.and e (const? 255))) ⊑
    mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul32_low_thm (e e_1 : IntW 32) :
  add
      (shl
        (add (mul (lshr e_1 (const? 16)) (LLVM.and e (const? 65535)))
          (mul (LLVM.and e_1 (const? 65535)) (lshr e (const? 16))))
        (const? 16))
      (mul (LLVM.and e_1 (const? 65535)) (LLVM.and e (const? 65535))) ⊑
    mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul64_low_thm (e e_1 : IntW 64) :
  add
      (shl
        (add (mul (lshr e_1 (const? 32)) (LLVM.and e (const? 4294967295)))
          (mul (LLVM.and e_1 (const? 4294967295)) (lshr e (const? 32))))
        (const? 32))
      (mul (LLVM.and e_1 (const? 4294967295)) (LLVM.and e (const? 4294967295))) ⊑
    mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul128_low_thm (e e_1 : IntW 128) :
  add
      (shl
        (add (mul (lshr e_1 (const? 64)) (LLVM.and e (const? 18446744073709551615)))
          (mul (LLVM.and e_1 (const? 18446744073709551615)) (lshr e (const? 64))))
        (const? 64))
      (mul (LLVM.and e_1 (const? 18446744073709551615)) (LLVM.and e (const? 18446744073709551615))) ⊑
    mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul130_low_thm (e e_1 : IntW 130) :
  add
      (shl
        (add (mul (lshr e_1 (const? 65)) (LLVM.and e (const? 36893488147419103231)))
          (mul (LLVM.and e_1 (const? 36893488147419103231)) (lshr e (const? 65))))
        (const? 65))
      (mul (LLVM.and e_1 (const? 36893488147419103231)) (LLVM.and e (const? 36893488147419103231))) ⊑
    mul e e_1 := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul9_low_thm (e e_1 : IntW 9) :
  add
      (shl
        (add (mul (lshr e_1 (const? 4)) (LLVM.and e (const? 15))) (mul (LLVM.and e_1 (const? 15)) (lshr e (const? 4))))
        (const? 4))
      (mul (LLVM.and e_1 (const? 15)) (LLVM.and e (const? 15))) ⊑
    add
      (shl
        (add (mul (lshr e_1 (const? 4)) (LLVM.and e (const? 15)) { «nsw» := false, «nuw» := true })
          (mul (LLVM.and e_1 (const? 15)) (lshr e (const? 4)) { «nsw» := false, «nuw» := true }))
        (const? 4))
      (mul (LLVM.and e_1 (const? 15)) (LLVM.and e (const? 15)) { «nsw» := true, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul16_low_miss_shift_amount_thm (e e_1 : IntW 16) :
  add
      (shl
        (add (mul (lshr e_1 (const? 8)) (LLVM.and e (const? 127)))
          (mul (LLVM.and e_1 (const? 127)) (lshr e (const? 8))))
        (const? 8))
      (mul (LLVM.and e_1 (const? 127)) (LLVM.and e (const? 127))) ⊑
    add
      (shl
        (add (mul (lshr e_1 (const? 8)) (LLVM.and e (const? 127)) { «nsw» := true, «nuw» := true })
          (mul (LLVM.and e_1 (const? 127)) (lshr e (const? 8)) { «nsw» := true, «nuw» := true })
          { «nsw» := false, «nuw» := true })
        (const? 8))
      (mul (LLVM.and e_1 (const? 127)) (LLVM.and e (const? 127)) { «nsw» := true, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem mul8_low_miss_half_width_thm (e e_1 : IntW 8) :
  add
      (shl
        (add (mul (lshr e_1 (const? 3)) (LLVM.and e (const? 15))) (mul (LLVM.and e_1 (const? 15)) (lshr e (const? 3))))
        (const? 3))
      (mul (LLVM.and e_1 (const? 15)) (LLVM.and e (const? 15))) ⊑
    add
      (shl
        (add (mul (lshr e_1 (const? 3)) (LLVM.and e (const? 15))) (mul (LLVM.and e_1 (const? 15)) (lshr e (const? 3))))
        (const? 3))
      (mul (LLVM.and e_1 (const? 15)) (LLVM.and e (const? 15)) { «nsw» := false, «nuw» := true }) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


