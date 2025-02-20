
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gpullhconditionalhbinophthroughhshift_proof
theorem and_signbit_select_shl_thm (e : IntW 32) (e_1 : IntW 1) :
  shl (select e_1 (LLVM.and e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.and (shl e (const? 32 8)) (const? 32 (-16777216))) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_nosignbit_select_shl_thm (e : IntW 32) (e_1 : IntW 1) :
  shl (select e_1 (LLVM.and e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.and (shl e (const? 32 8)) (const? 32 (-16777216))) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_signbit_select_shl_thm (e : IntW 32) (e_1 : IntW 1) :
  shl (select e_1 (LLVM.or e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.or (shl e (const? 32 8)) (const? 32 (-16777216))) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_nosignbit_select_shl_thm (e : IntW 32) (e_1 : IntW 1) :
  shl (select e_1 (LLVM.or e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.or (shl e (const? 32 8)) (const? 32 (-16777216))) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_signbit_select_shl_thm (e : IntW 32) (e_1 : IntW 1) :
  shl (select e_1 (LLVM.xor e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.xor (shl e (const? 32 8)) (const? 32 (-16777216))) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_nosignbit_select_shl_thm (e : IntW 32) (e_1 : IntW 1) :
  shl (select e_1 (LLVM.xor e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.xor (shl e (const? 32 8)) (const? 32 (-16777216))) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_signbit_select_shl_thm (e : IntW 32) (e_1 : IntW 1) :
  shl (select e_1 (add e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (add (shl e (const? 32 8)) (const? 32 (-16777216))) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem add_nosignbit_select_shl_thm (e : IntW 32) (e_1 : IntW 1) :
  shl (select e_1 (add e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (add (shl e (const? 32 8)) (const? 32 (-16777216))) (shl e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_signbit_select_lshr_thm (e : IntW 32) (e_1 : IntW 1) :
  lshr (select e_1 (LLVM.and e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.and (lshr e (const? 32 8)) (const? 32 16776960)) (lshr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_nosignbit_select_lshr_thm (e : IntW 32) (e_1 : IntW 1) :
  lshr (select e_1 (LLVM.and e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.and (lshr e (const? 32 8)) (const? 32 8388352)) (lshr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_signbit_select_lshr_thm (e : IntW 32) (e_1 : IntW 1) :
  lshr (select e_1 (LLVM.or e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.or (lshr e (const? 32 8)) (const? 32 16776960)) (lshr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_nosignbit_select_lshr_thm (e : IntW 32) (e_1 : IntW 1) :
  lshr (select e_1 (LLVM.or e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.or (lshr e (const? 32 8)) (const? 32 8388352)) (lshr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_signbit_select_lshr_thm (e : IntW 32) (e_1 : IntW 1) :
  lshr (select e_1 (LLVM.xor e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.xor (lshr e (const? 32 8)) (const? 32 16776960)) (lshr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_nosignbit_select_lshr_thm (e : IntW 32) (e_1 : IntW 1) :
  lshr (select e_1 (LLVM.xor e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.xor (lshr e (const? 32 8)) (const? 32 8388352)) (lshr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_signbit_select_ashr_thm (e : IntW 32) (e_1 : IntW 1) :
  ashr (select e_1 (LLVM.and e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.and (ashr e (const? 32 8)) (const? 32 (-256))) (ashr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem and_nosignbit_select_ashr_thm (e : IntW 32) (e_1 : IntW 1) :
  ashr (select e_1 (LLVM.and e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.and (ashr e (const? 32 8)) (const? 32 8388352)) (ashr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_signbit_select_ashr_thm (e : IntW 32) (e_1 : IntW 1) :
  ashr (select e_1 (LLVM.or e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.or (ashr e (const? 32 8)) (const? 32 (-256))) (ashr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem or_nosignbit_select_ashr_thm (e : IntW 32) (e_1 : IntW 1) :
  ashr (select e_1 (LLVM.or e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.or (ashr e (const? 32 8)) (const? 32 8388352)) (ashr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_signbit_select_ashr_thm (e : IntW 32) (e_1 : IntW 1) :
  ashr (select e_1 (LLVM.xor e (const? 32 (-65536))) e) (const? 32 8) ⊑
    select e_1 (LLVM.xor (ashr e (const? 32 8)) (const? 32 (-256))) (ashr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem xor_nosignbit_select_ashr_thm (e : IntW 32) (e_1 : IntW 1) :
  ashr (select e_1 (LLVM.xor e (const? 32 2147418112)) e) (const? 32 8) ⊑
    select e_1 (LLVM.xor (ashr e (const? 32 8)) (const? 32 8388352)) (ashr e (const? 32 8)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
