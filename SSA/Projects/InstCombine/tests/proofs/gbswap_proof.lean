
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gbswap_proof
theorem PR39793_bswap_u64_as_u16_trunc_thm (e : IntW 64) :
  trunc 8
      (LLVM.or (LLVM.and (lshr e (const? 64 8)) (const? 64 255)) (LLVM.and (shl e (const? 64 8)) (const? 64 65280))) ⊑
    trunc 8 (lshr e (const? 64 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem PR39793_bswap_u32_as_u16_trunc_thm (e : IntW 32) :
  trunc 8
      (LLVM.or (LLVM.and (lshr e (const? 32 8)) (const? 32 255)) (LLVM.and (shl e (const? 32 8)) (const? 32 65280))) ⊑
    trunc 8 (lshr e (const? 32 8)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


