
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gsignhbithtesthviahrighthshiftinghallhotherhbits_proof
theorem unsigned_sign_bit_extract_thm (e : IntW 32) :
  icmp IntPredicate.ne (lshr e (const? 31)) (const? 0) ⊑ icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem signed_sign_bit_extract_thm (e : IntW 32) :
  icmp IntPredicate.ne (ashr e (const? 31)) (const? 0) ⊑ icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem unsigned_sign_bit_extract_with_trunc_thm (e : IntW 64) :
  icmp IntPredicate.ne (trunc 32 (lshr e (const? 63))) (const? 0) ⊑ icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem signed_sign_bit_extract_trunc_thm (e : IntW 64) :
  icmp IntPredicate.ne (trunc 32 (ashr e (const? 63))) (const? 0) ⊑ icmp IntPredicate.slt e (const? 0) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


