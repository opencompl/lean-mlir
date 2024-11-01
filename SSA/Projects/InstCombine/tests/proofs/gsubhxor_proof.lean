
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsubhxor_proof
theorem low_mask_nsw_nuw_thm (e : IntW 32) :
  sub (const? 32 63) (LLVM.and e (const? 32 31)) ⊑ LLVM.xor (LLVM.and e (const? 32 31)) (const? 32 63) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem arbitrary_mask_sub_i8_thm (e : IntW 8) :
  sub (const? 8 11) (LLVM.and e (const? 8 10)) ⊑
    sub (const? 8 11) (LLVM.and e (const? 8 10)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem not_masked_sub_i8_thm (e : IntW 8) :
  sub (const? 8 11) (LLVM.and e (const? 8 7)) ⊑
    sub (const? 8 11) (LLVM.and e (const? 8 7)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem xor_add_thm (e : IntW 32) :
  add (LLVM.xor (LLVM.and e (const? 32 31)) (const? 32 31)) (const? 32 42) ⊑
    sub (const? 32 73) (LLVM.and e (const? 32 31)) { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


