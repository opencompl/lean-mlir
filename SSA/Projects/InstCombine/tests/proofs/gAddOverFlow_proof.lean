
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gAddOverFlow_proof
theorem oppositesign_thm (e e_1 : IntW 16) :
  add (LLVM.or e_1 (const? (-32768))) (LLVM.and e (const? 32767)) ⊑
    add (LLVM.or e_1 (const? (-32768))) (LLVM.and e (const? 32767)) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zero_sign_bit_thm (e : IntW 16) :
  add (LLVM.and e (const? 32767)) (const? 512) ⊑
    add (LLVM.and e (const? 32767)) (const? 512) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zero_sign_bit2_thm (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? 32767)) (LLVM.and e (const? 32767)) ⊑
    add (LLVM.and e_1 (const? 32767)) (LLVM.and e (const? 32767)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ripple_nsw1_thm (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? 1)) (LLVM.and e (const? (-16385))) ⊑
    add (LLVM.and e_1 (const? 1)) (LLVM.and e (const? (-16385))) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ripple_nsw2_thm (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? (-16385))) (LLVM.and e (const? 1)) ⊑
    add (LLVM.and e_1 (const? (-16385))) (LLVM.and e (const? 1)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ripple_nsw3_thm (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? (-21845))) (LLVM.and e (const? 21843)) ⊑
    add (LLVM.and e_1 (const? (-21845))) (LLVM.and e (const? 21843)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ripple_nsw4_thm (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? 21843)) (LLVM.and e (const? (-21845))) ⊑
    add (LLVM.and e_1 (const? 21843)) (LLVM.and e (const? (-21845))) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ripple_nsw5_thm (e e_1 : IntW 16) :
  add (LLVM.or e_1 (const? (-21845))) (LLVM.or e (const? (-10923))) ⊑
    add (LLVM.or e_1 (const? (-21845))) (LLVM.or e (const? (-10923))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ripple_nsw6_thm (e e_1 : IntW 16) :
  add (LLVM.or e_1 (const? (-10923))) (LLVM.or e (const? (-21845))) ⊑
    add (LLVM.or e_1 (const? (-10923))) (LLVM.or e (const? (-21845))) { «nsw» := true, «nuw» := false } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem ripple_no_nsw2_thm (e e_1 : IntW 16) :
  add (LLVM.and e_1 (const? 1)) (LLVM.and e (const? 32767)) ⊑
    add (LLVM.and e_1 (const? 1)) (LLVM.and e (const? 32767)) { «nsw» := false, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR38021_thm (e : IntW 8) :
  add (lshr e (const? 3)) (const? (-63)) ⊑
    add (lshr e (const? 3)) (const? (-63)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


