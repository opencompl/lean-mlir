
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gsignext_proof
theorem sextinreg_thm (e : IntW 32) :
  add (LLVM.xor (LLVM.and e (const? 32 65535)) (const? 32 (-32768))) (const? 32 32768) ⊑
    ashr (shl e (const? 32 16)) (const? 32 16) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sextinreg_alt_thm (e : IntW 32) :
  add (LLVM.xor (LLVM.and e (const? 32 65535)) (const? 32 32768)) (const? 32 (-32768)) ⊑
    ashr (shl e (const? 32 16)) (const? 32 16) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sext_thm (e : IntW 16) :
  add (LLVM.xor (zext 32 e) (const? 32 32768)) (const? 32 (-32768)) ⊑ sext 32 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem sextinreg2_thm (e : IntW 32) :
  add (LLVM.xor (LLVM.and e (const? 32 255)) (const? 32 128)) (const? 32 (-128)) ⊑
    ashr (shl e (const? 32 24)) (const? 32 24) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test5_thm (e : IntW 32) :
  ashr (shl e (const? 32 16)) (const? 32 16) ⊑ ashr (shl e (const? 32 16)) (const? 32 16) { «exact» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem test6_thm (e : IntW 16) : ashr (shl (zext 32 e) (const? 32 16)) (const? 32 16) ⊑ sext 32 e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem ashr_thm (e : IntW 32) :
  add (LLVM.xor (lshr e (const? 32 5)) (const? 32 67108864)) (const? 32 (-67108864)) ⊑ ashr e (const? 32 5) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


