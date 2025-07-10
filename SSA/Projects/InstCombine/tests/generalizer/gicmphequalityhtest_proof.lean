
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gicmphequalityhtest_proof
theorem icmp_equality_test_proof.icmp_equality_test_thm_1 (e e_1 e_2 : IntW 64) :
  select (icmp IntPred.eq e e_2) (icmp IntPred.eq e_1 e_2)
      (select (LLVM.xor (icmp IntPred.eq e_1 e_2) (const? 1 1)) (icmp IntPred.eq e e_1) (const? 1 0)) ⊑
    icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_equality_test_constant_proof.icmp_equality_test_constant_thm_1 (e e_1 : IntW 42) :
  select (icmp IntPred.eq e (const? 42 (-42))) (icmp IntPred.eq e_1 (const? 42 (-42)))
      (select (LLVM.xor (icmp IntPred.eq e_1 (const? 42 (-42))) (const? 1 1)) (icmp IntPred.eq e e_1) (const? 1 0)) ⊑
    icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_equality_test_constant_samesign_proof.icmp_equality_test_constant_samesign_thm_1 (e e_1 : IntW 42) :
  select (icmp IntPred.eq e (const? 42 (-42))) (icmp IntPred.eq e_1 (const? 42 (-42)))
      (select (LLVM.xor (icmp IntPred.eq e_1 (const? 42 (-42))) (const? 1 1)) (icmp IntPred.eq e e_1) (const? 1 0)) ⊑
    icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_equality_test_swift_optional_pointers_proof.icmp_equality_test_swift_optional_pointers_thm_1 (e e_1 : IntW 64) :
  select (select (icmp IntPred.eq e (const? 64 0)) (const? 1 1) (icmp IntPred.eq e_1 (const? 64 0)))
      (select (icmp IntPred.eq e (const? 64 0)) (icmp IntPred.eq e_1 (const? 64 0)) (const? 1 0))
      (icmp IntPred.eq e e_1) ⊑
    icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_equality_test_commute_icmp1_proof.icmp_equality_test_commute_icmp1_thm_1 (e e_1 e_2 : IntW 64) :
  select (icmp IntPred.eq e_2 e) (icmp IntPred.eq e_2 e_1)
      (select (LLVM.xor (icmp IntPred.eq e_2 e_1) (const? 1 1)) (icmp IntPred.eq e_1 e) (const? 1 0)) ⊑
    icmp IntPred.eq e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_equality_test_commute_icmp2_proof.icmp_equality_test_commute_icmp2_thm_1 (e e_1 e_2 : IntW 64) :
  select (icmp IntPred.eq e_2 e) (icmp IntPred.eq e_1 e_2)
      (select (LLVM.xor (icmp IntPred.eq e_1 e_2) (const? 1 1)) (icmp IntPred.eq e_1 e) (const? 1 0)) ⊑
    icmp IntPred.eq e_1 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_equality_test_commute_select1_proof.icmp_equality_test_commute_select1_thm_1 (e e_1 e_2 : IntW 64) :
  select (icmp IntPred.eq e e_2) (icmp IntPred.eq e_1 e_2)
      (select (icmp IntPred.eq e_1 e_2) (const? 1 0) (icmp IntPred.eq e e_1)) ⊑
    icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_equality_test_commute_select2_proof.icmp_equality_test_commute_select2_thm_1 (e e_1 e_2 : IntW 64) :
  select (LLVM.xor (icmp IntPred.eq e e_2) (const? 1 1))
      (select (icmp IntPred.eq e_1 e_2) (const? 1 0) (icmp IntPred.eq e e_1)) (icmp IntPred.eq e_1 e_2) ⊑
    icmp IntPred.eq e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem icmp_equality_test_wrong_and_proof.icmp_equality_test_wrong_and_thm_1 (e e_1 e_2 : IntW 64) :
  select (icmp IntPred.eq e e_2) (icmp IntPred.eq e_1 e_2)
      (select (LLVM.xor (icmp IntPred.eq e_1 e_2) (const? 1 1)) (const? 1 0) (icmp IntPred.eq e e_1)) ⊑
    select (icmp IntPred.eq e e_2) (icmp IntPred.eq e_1 e_2)
      (select (icmp IntPred.eq e_1 e_2) (icmp IntPred.eq e e_1) (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
