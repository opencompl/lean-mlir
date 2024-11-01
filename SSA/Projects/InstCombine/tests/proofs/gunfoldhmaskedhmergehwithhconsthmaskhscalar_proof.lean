
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gunfoldhmaskedhmergehwithhconsthmaskhscalar_proof
theorem scalar0_thm (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 e) (const? 1)) e ⊑
    LLVM.or (LLVM.and e_1 (const? 1)) (LLVM.and e (const? (-2))) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem scalar1_thm (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 e) (const? (-2))) e ⊑
    LLVM.or (LLVM.and e_1 (const? (-2))) (LLVM.and e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem in_constant_varx_mone_thm (e : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e (const? (-1))) (const? 1)) (const? (-1)) ⊑ LLVM.or e (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem in_constant_varx_14_thm (e : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e (const? (-2))) (const? 1)) (const? (-2)) ⊑ LLVM.or e (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem in_constant_mone_vary_thm (e : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e (const? (-1))) (const? 1)) e ⊑ LLVM.or e (const? 1) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem in_constant_14_vary_thm (e : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e (const? (-2))) (const? 1)) e ⊑ LLVM.and e (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem c_1_0_0_thm (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 e) (const? (-2))) e_1 ⊑
    LLVM.or (LLVM.and e (const? (-2))) (LLVM.and e_1 (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem c_0_1_0_thm (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 e) (const? (-2))) e_1 ⊑
    LLVM.or (LLVM.and e (const? (-2))) (LLVM.and e_1 (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem c_1_1_0_thm (e e_1 : IntW 4) :
  LLVM.xor (LLVM.and (LLVM.xor e_1 e) (const? (-2))) e ⊑
    LLVM.or (LLVM.and e_1 (const? (-2))) (LLVM.and e (const? 1)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


theorem commutativity_constant_14_vary_thm (e : IntW 4) :
  LLVM.xor e (LLVM.and (LLVM.xor e (const? (-2))) (const? 1)) ⊑ LLVM.and e (const? (-2)) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


