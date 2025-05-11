
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gaddhshlhsdivhtohsrem_proof
theorem addhshlhsdivhscalar0_thm (e : IntW 8) :
  add (shl (LLVM.sdiv e (const? 8 (-4))) (const? 8 2)) e ⊑ LLVM.srem e (const? 8 4) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem addhshlhsdivhscalar1_thm (e : IntW 8) :
  add (shl (LLVM.sdiv e (const? 8 (-64))) (const? 8 6)) e ⊑ LLVM.srem e (const? 8 64) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem addhshlhsdivhscalar2_thm (e : IntW 32) :
  add (shl (LLVM.sdiv e (const? 32 (-1073741824))) (const? 32 30)) e ⊑ LLVM.srem e (const? 32 1073741824) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem addhshlhsdivhnegative0_thm (e : IntW 8) :
  add (shl (LLVM.sdiv e (const? 8 4)) (const? 8 2)) e ⊑
    add (shl (LLVM.sdiv e (const? 8 4)) (const? 8 2) { «nsw» := true, «nuw» := false }) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem addhshlhsdivhnegative1_thm (e : IntW 32) :
  add (shl (LLVM.sdiv e (const? 32 (-1))) (const? 32 1)) e ⊑ sub (const? 32 0) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem addhshlhsdivhnegative2_thm (e : IntW 32) :
  add (shl (LLVM.sdiv e (const? 32 (-2147483648))) (const? 32 31)) e ⊑
    add (select (icmp IntPredicate.eq e (const? 32 (-2147483648))) (const? 32 (-2147483648)) (const? 32 0)) e := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
