
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gsubhxorhcmp_proof
theorem sext_xor_sub_proof.sext_xor_sub_thm_1 (e : IntW 64) (e_1 : IntW 1) :
  sub (LLVM.xor e (sext 64 e_1)) (sext 64 e_1) ⊑ select e_1 (sub (const? 64 0) e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_xor_sub_1_proof.sext_xor_sub_1_thm_1 (e : IntW 64) (e_1 : IntW 1) :
  sub (LLVM.xor (sext 64 e_1) e) (sext 64 e_1) ⊑ select e_1 (sub (const? 64 0) e) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_xor_sub_2_proof.sext_xor_sub_2_thm_1 (e : IntW 64) (e_1 : IntW 1) :
  sub (sext 64 e_1) (LLVM.xor e (sext 64 e_1)) ⊑ select e_1 e (sub (const? 64 0) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_xor_sub_3_proof.sext_xor_sub_3_thm_1 (e : IntW 64) (e_1 : IntW 1) :
  sub (sext 64 e_1) (LLVM.xor (sext 64 e_1) e) ⊑ select e_1 e (sub (const? 64 0) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_non_bool_xor_sub_1_proof.sext_non_bool_xor_sub_1_thm_1 (e : IntW 64) (e_1 : IntW 8) :
  sub (LLVM.xor (sext 64 e_1) e) (sext 64 e_1) ⊑ sub (LLVM.xor e (sext 64 e_1)) (sext 64 e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_diff_i1_xor_sub_proof.sext_diff_i1_xor_sub_thm_1 (e_1 e_2 : IntW 1) :
  sub (sext 64 e_1) (sext 64 e_2) ⊑ add (zext 64 e_2) (sext 64 e_1) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_diff_i1_xor_sub_1_proof.sext_diff_i1_xor_sub_1_thm_1 (e_1 e_2 : IntW 1) :
  sub (sext 64 e_1) (sext 64 e_2) ⊑ add (zext 64 e_2) (sext 64 e_1) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem sext_multi_uses_proof.sext_multi_uses_thm_1 (e : IntW 64) (e_1 : IntW 1) (e_2 : IntW 64) :
  add (mul e_2 (sext 64 e_1)) (sub (LLVM.xor e (sext 64 e_1)) (sext 64 e_1)) ⊑
    select e_1 (sub (const? 64 0) (add e_2 e)) e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem absdiff_proof.absdiff_thm_1 (e e_1 : IntW 64) :
  sub (LLVM.xor (sext 64 (icmp IntPred.ult e e_1)) (sub e e_1)) (sext 64 (icmp IntPred.ult e e_1)) ⊑
    select (icmp IntPred.ult e e_1) (sub (const? 64 0) (sub e e_1)) (sub e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem absdiff1_proof.absdiff1_thm_1 (e e_1 : IntW 64) :
  sub (LLVM.xor (sub e e_1) (sext 64 (icmp IntPred.ult e e_1))) (sext 64 (icmp IntPred.ult e e_1)) ⊑
    select (icmp IntPred.ult e e_1) (sub (const? 64 0) (sub e e_1)) (sub e e_1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem absdiff2_proof.absdiff2_thm_1 (e e_1 : IntW 64) :
  sub (LLVM.xor (sub e_1 e) (sext 64 (icmp IntPred.ugt e e_1))) (sext 64 (icmp IntPred.ugt e e_1)) ⊑
    select (icmp IntPred.ugt e e_1) (sub (const? 64 0) (sub e_1 e)) (sub e_1 e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
