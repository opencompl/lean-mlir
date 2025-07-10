
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsignext_proof
theorem sextinreg_proof.sextinreg_thm_1 (e : IntW 32) :
  add (LLVM.xor (LLVM.and e (const? 32 65535)) (const? 32 (-32768))) (const? 32 32768) ⊑
    ashr (shl e (const? 32 16)) (const? 32 16) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sextinreg_alt_proof.sextinreg_alt_thm_1 (e : IntW 32) :
  add (LLVM.xor (LLVM.and e (const? 32 65535)) (const? 32 32768)) (const? 32 (-32768)) ⊑
    ashr (shl e (const? 32 16)) (const? 32 16) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_proof.sext_thm_1 (e : IntW 16) :
  add (LLVM.xor (zext 32 e) (const? 32 32768)) (const? 32 (-32768)) ⊑ sext 32 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sextinreg2_proof.sextinreg2_thm_1 (e : IntW 32) :
  add (LLVM.xor (LLVM.and e (const? 32 255)) (const? 32 128)) (const? 32 (-128)) ⊑
    ashr (shl e (const? 32 24)) (const? 32 24) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test5_proof.test5_thm_1 (e : IntW 32) :
  ashr (shl e (const? 32 16)) (const? 32 16) ⊑ ashr (shl e (const? 32 16)) (const? 32 16) { «exact» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test6_proof.test6_thm_1 (e : IntW 16) :
  ashr (shl (zext 32 e) (const? 32 16)) (const? 32 16) ⊑ sext 32 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem ashr_proof.ashr_thm_1 (e : IntW 32) :
  add (LLVM.xor (lshr e (const? 32 5)) (const? 32 67108864)) (const? 32 (-67108864)) ⊑ ashr e (const? 32 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
