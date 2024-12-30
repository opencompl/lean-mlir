
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphtopbitssame_proof
theorem testi16i8_thm (e : IntW 16) :
  icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 16 8))) ⊑
    icmp IntPredicate.ult (add e (const? 16 128)) (const? 16 256) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi16i8_com_thm (e : IntW 16) :
  icmp IntPredicate.eq (trunc 8 (lshr e (const? 16 8))) (ashr (trunc 8 e) (const? 8 7)) ⊑
    icmp IntPredicate.ult (add e (const? 16 128)) (const? 16 256) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi16i8_ne_thm (e : IntW 16) :
  icmp IntPredicate.ne (ashr (trunc 8 e) (const? 8 7)) (trunc 8 (lshr e (const? 16 8))) ⊑
    icmp IntPredicate.ult (add e (const? 16 (-128))) (const? 16 (-256)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi16i8_ne_com_thm (e : IntW 16) :
  icmp IntPredicate.ne (trunc 8 (lshr e (const? 16 8))) (ashr (trunc 8 e) (const? 8 7)) ⊑
    icmp IntPredicate.ult (add e (const? 16 (-128))) (const? 16 (-256)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi64i32_thm (e : IntW 64) :
  icmp IntPredicate.eq (ashr (trunc 32 e) (const? 32 31)) (trunc 32 (lshr e (const? 64 32))) ⊑
    icmp IntPredicate.ult (add e (const? 64 2147483648)) (const? 64 4294967296) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem testi64i32_ne_thm (e : IntW 64) :
  icmp IntPredicate.ne (ashr (trunc 32 e) (const? 32 31)) (trunc 32 (lshr e (const? 64 32))) ⊑
    icmp IntPredicate.ult (add e (const? 64 (-2147483648))) (const? 64 (-4294967296)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem wrongimm2_thm (e : IntW 16) :
  icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 6)) (trunc 8 (lshr e (const? 16 8))) ⊑
    icmp IntPredicate.eq (ashr (trunc 8 e) (const? 8 6))
      (trunc 8 (lshr e (const? 16 8)) { «nsw» := false, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem slt_thm (e : IntW 64) :
  icmp IntPredicate.slt (ashr (trunc 32 e) (const? 32 31)) (trunc 32 (lshr e (const? 64 32))) ⊑
    icmp IntPredicate.slt (ashr (trunc 32 e) (const? 32 31))
      (trunc 32 (lshr e (const? 64 32)) { «nsw» := false, «nuw» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


