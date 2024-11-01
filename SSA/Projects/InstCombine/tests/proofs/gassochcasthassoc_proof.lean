
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gassochcasthassoc_proof
theorem XorZextXor_thm (e : IntW 3) :
  LLVM.xor (zext 5 (LLVM.xor e (const? 3))) (const? 12) ⊑ LLVM.xor (zext 5 e) (const? 15) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem OrZextOr_thm (e : IntW 3) :
  LLVM.or (zext 5 (LLVM.or e (const? 3))) (const? 8) ⊑ LLVM.or (zext 5 e) (const? 11) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem AndZextAnd_thm (e : IntW 3) :
  LLVM.and (zext 5 (LLVM.and e (const? 3))) (const? 14) ⊑ zext 5 (LLVM.and e (const? 2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem zext_nneg_thm (e : IntW 16) :
  LLVM.and (zext 24 (LLVM.and e (const? 32767))) (const? 8388607) ⊑ zext 24 (LLVM.and e (const? 32767)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


