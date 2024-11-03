
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gadd4_proof
theorem match_unsigned_thm (e : IntW 64) :
  add (urem e (const? 64 299)) (mul (urem (LLVM.udiv e (const? 64 299)) (const? 64 64)) (const? 64 299)) ⊑
    urem e (const? 64 19136) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem match_andAsRem_lshrAsDiv_shlAsMul_thm (e : IntW 64) :
  add (LLVM.and e (const? 64 63)) (shl (urem (lshr e (const? 64 6)) (const? 64 9)) (const? 64 6)) ⊑
    urem e (const? 64 576) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem match_signed_thm (e : IntW 64) :
  add (add (LLVM.srem e (const? 64 299)) (mul (LLVM.srem (LLVM.sdiv e (const? 64 299)) (const? 64 64)) (const? 64 299)))
      (mul (LLVM.srem (LLVM.sdiv e (const? 64 19136)) (const? 64 9)) (const? 64 19136)) ⊑
    LLVM.srem e (const? 64 172224) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_match_inconsistent_signs_thm (e : IntW 64) :
  add (urem e (const? 64 299)) (mul (urem (LLVM.sdiv e (const? 64 299)) (const? 64 64)) (const? 64 299)) ⊑
    add (urem e (const? 64 299))
      (mul (LLVM.and (LLVM.sdiv e (const? 64 299)) (const? 64 63)) (const? 64 299) { «nsw» := true, «nuw» := true })
      { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem not_match_inconsistent_values_thm (e : IntW 64) :
  add (urem e (const? 64 299)) (mul (urem (LLVM.udiv e (const? 64 29)) (const? 64 64)) (const? 64 299)) ⊑
    add (urem e (const? 64 299))
      (mul (LLVM.and (LLVM.udiv e (const? 64 29)) (const? 64 63)) (const? 64 299) { «nsw» := true, «nuw» := true })
      { «nsw» := true, «nuw» := true } := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_add_udiv_urem_thm (e : IntW 32) :
  add (shl (LLVM.udiv e (const? 32 10)) (const? 32 4)) (urem e (const? 32 10)) ⊑
    add (mul (LLVM.udiv e (const? 32 10)) (const? 32 6) { «nsw» := false, «nuw» := true }) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_add_sdiv_srem_thm (e : IntW 32) :
  add (shl (LLVM.sdiv e (const? 32 10)) (const? 32 4)) (LLVM.srem e (const? 32 10)) ⊑
    add (mul (LLVM.sdiv e (const? 32 10)) (const? 32 6) { «nsw» := true, «nuw» := false }) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_add_udiv_urem_to_mul_thm (e : IntW 32) :
  add (mul (LLVM.udiv e (const? 32 7)) (const? 32 21)) (mul (urem e (const? 32 7)) (const? 32 3)) ⊑
    mul e (const? 32 3) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_add_udiv_urem_commuted_thm (e : IntW 32) :
  add (urem e (const? 32 10)) (shl (LLVM.udiv e (const? 32 10)) (const? 32 4)) ⊑
    add (mul (LLVM.udiv e (const? 32 10)) (const? 32 6) { «nsw» := false, «nuw» := true }) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_add_udiv_urem_or_disjoint_thm (e : IntW 32) :
  LLVM.or (shl (LLVM.udiv e (const? 32 10)) (const? 32 4)) (urem e (const? 32 10)) ⊑
    add (mul (LLVM.udiv e (const? 32 10)) (const? 32 6) { «nsw» := false, «nuw» := true }) e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem fold_add_udiv_urem_without_noundef_thm (e : IntW 32) :
  add (shl (LLVM.udiv e (const? 32 10)) (const? 32 4)) (urem e (const? 32 10)) ⊑
    LLVM.or (shl (LLVM.udiv e (const? 32 10)) (const? 32 4)) (urem e (const? 32 10)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


