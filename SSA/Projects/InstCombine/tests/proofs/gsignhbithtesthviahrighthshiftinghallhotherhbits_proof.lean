
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option Elab.async false

section gsignhbithtesthviahrighthshiftinghallhotherhbits_proof
theorem unsigned_sign_bit_extract_thm (e : IntW 32) :
  icmp IntPredicate.ne (lshr e (const? 32 31)) (const? 32 0) ⊑ icmp IntPredicate.slt e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_sign_bit_extract_thm (e : IntW 32) :
  icmp IntPredicate.ne (ashr e (const? 32 31)) (const? 32 0) ⊑ icmp IntPredicate.slt e (const? 32 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem unsigned_sign_bit_extract_with_trunc_thm (e : IntW 64) :
  icmp IntPredicate.ne (trunc 32 (lshr e (const? 64 63))) (const? 32 0) ⊑ icmp IntPredicate.slt e (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem signed_sign_bit_extract_trunc_thm (e : IntW 64) :
  icmp IntPredicate.ne (trunc 32 (ashr e (const? 64 63))) (const? 32 0) ⊑ icmp IntPredicate.slt e (const? 64 0) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
