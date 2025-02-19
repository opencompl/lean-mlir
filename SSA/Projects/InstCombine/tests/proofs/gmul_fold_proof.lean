
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gmul_fold_proof
theorem mul8_low_A0_B0_thm (e e_1 : IntW 8) :
  add (shl (add (mul (lshr e_1 (const? 8 4)) e) (mul (lshr e (const? 8 4)) e_1)) (const? 8 4))
      (mul (LLVM.and e_1 (const? 8 15)) (LLVM.and e (const? 8 15))) ⊑
    mul e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul8_low_thm (e e_1 : IntW 8) :
  add
      (shl
        (add (mul (lshr e_1 (const? 8 4)) (LLVM.and e (const? 8 15)))
          (mul (LLVM.and e_1 (const? 8 15)) (lshr e (const? 8 4))))
        (const? 8 4))
      (mul (LLVM.and e_1 (const? 8 15)) (LLVM.and e (const? 8 15))) ⊑
    mul e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul16_low_thm (e e_1 : IntW 16) :
  add
      (shl
        (add (mul (lshr e_1 (const? 16 8)) (LLVM.and e (const? 16 255)))
          (mul (LLVM.and e_1 (const? 16 255)) (lshr e (const? 16 8))))
        (const? 16 8))
      (mul (LLVM.and e_1 (const? 16 255)) (LLVM.and e (const? 16 255))) ⊑
    mul e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul32_low_thm (e e_1 : IntW 32) :
  add
      (shl
        (add (mul (lshr e_1 (const? 32 16)) (LLVM.and e (const? 32 65535)))
          (mul (LLVM.and e_1 (const? 32 65535)) (lshr e (const? 32 16))))
        (const? 32 16))
      (mul (LLVM.and e_1 (const? 32 65535)) (LLVM.and e (const? 32 65535))) ⊑
    mul e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul64_low_thm (e e_1 : IntW 64) :
  add
      (shl
        (add (mul (lshr e_1 (const? 64 32)) (LLVM.and e (const? 64 4294967295)))
          (mul (LLVM.and e_1 (const? 64 4294967295)) (lshr e (const? 64 32))))
        (const? 64 32))
      (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295))) ⊑
    mul e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul128_low_thm (e e_1 : IntW 128) :
  add
      (shl
        (add (mul (lshr e_1 (const? 128 64)) (LLVM.and e (const? 128 18446744073709551615)))
          (mul (LLVM.and e_1 (const? 128 18446744073709551615)) (lshr e (const? 128 64))))
        (const? 128 64))
      (mul (LLVM.and e_1 (const? 128 18446744073709551615)) (LLVM.and e (const? 128 18446744073709551615))) ⊑
    mul e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul130_low_thm (e e_1 : IntW 130) :
  add
      (shl
        (add (mul (lshr e_1 (const? 130 65)) (LLVM.and e (const? 130 36893488147419103231)))
          (mul (LLVM.and e_1 (const? 130 36893488147419103231)) (lshr e (const? 130 65))))
        (const? 130 65))
      (mul (LLVM.and e_1 (const? 130 36893488147419103231)) (LLVM.and e (const? 130 36893488147419103231))) ⊑
    mul e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul9_low_thm (e e_1 : IntW 9) :
  add
      (shl
        (add (mul (lshr e_1 (const? 9 4)) (LLVM.and e (const? 9 15)))
          (mul (LLVM.and e_1 (const? 9 15)) (lshr e (const? 9 4))))
        (const? 9 4))
      (mul (LLVM.and e_1 (const? 9 15)) (LLVM.and e (const? 9 15))) ⊑
    add
      (shl
        (add (mul (lshr e_1 (const? 9 4)) (LLVM.and e (const? 9 15)) { «nsw» := false, «nuw» := true })
          (mul (LLVM.and e_1 (const? 9 15)) (lshr e (const? 9 4)) { «nsw» := false, «nuw» := true }))
        (const? 9 4))
      (mul (LLVM.and e_1 (const? 9 15)) (LLVM.and e (const? 9 15)) { «nsw» := true, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul16_low_miss_shift_amount_thm (e e_1 : IntW 16) :
  add
      (shl
        (add (mul (lshr e_1 (const? 16 8)) (LLVM.and e (const? 16 127)))
          (mul (LLVM.and e_1 (const? 16 127)) (lshr e (const? 16 8))))
        (const? 16 8))
      (mul (LLVM.and e_1 (const? 16 127)) (LLVM.and e (const? 16 127))) ⊑
    add
      (shl
        (add (mul (lshr e_1 (const? 16 8)) (LLVM.and e (const? 16 127)) { «nsw» := true, «nuw» := true })
          (mul (LLVM.and e_1 (const? 16 127)) (lshr e (const? 16 8)) { «nsw» := true, «nuw» := true })
          { «nsw» := false, «nuw» := true })
        (const? 16 8))
      (mul (LLVM.and e_1 (const? 16 127)) (LLVM.and e (const? 16 127)) { «nsw» := true, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mul8_low_miss_half_width_thm (e e_1 : IntW 8) :
  add
      (shl
        (add (mul (lshr e_1 (const? 8 3)) (LLVM.and e (const? 8 15)))
          (mul (LLVM.and e_1 (const? 8 15)) (lshr e (const? 8 3))))
        (const? 8 3))
      (mul (LLVM.and e_1 (const? 8 15)) (LLVM.and e (const? 8 15))) ⊑
    add
      (shl
        (add (mul (lshr e_1 (const? 8 3)) (LLVM.and e (const? 8 15)))
          (mul (LLVM.and e_1 (const? 8 15)) (lshr e (const? 8 3))))
        (const? 8 3))
      (mul (LLVM.and e_1 (const? 8 15)) (LLVM.and e (const? 8 15)) { «nsw» := false, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


