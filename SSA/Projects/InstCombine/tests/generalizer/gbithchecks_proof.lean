
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gbithchecks_proof
theorem main1_proof.main1_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 1)) (const? 32 0))
        (icmp IntPred.ne (LLVM.and e (const? 32 2)) (const? 32 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 3)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main1_logical_proof.main1_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 1)) (const? 32 0))
        (icmp IntPred.ne (LLVM.and e (const? 32 2)) (const? 32 0)) (const? 1 0))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 3)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main2_proof.main2_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0))
        (icmp IntPred.eq (LLVM.and e (const? 32 2)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main2_logical_proof.main2_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 1)) (const? 32 0)) (const? 1 1)
        (icmp IntPred.eq (LLVM.and e (const? 32 2)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 3)) (const? 32 3)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3_proof.main3_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
        (icmp IntPred.eq (LLVM.and e (const? 32 48)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 55)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3_logical_proof.main3_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
        (icmp IntPred.eq (LLVM.and e (const? 32 48)) (const? 32 0)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 55)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3b_proof.main3b_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
        (icmp IntPred.ne (LLVM.and e (const? 32 16)) (const? 32 16)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 23)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3b_logical_proof.main3b_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 0))
        (icmp IntPred.ne (LLVM.and e (const? 32 16)) (const? 32 16)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 23)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3e_like_proof.main3e_like_thm_1 (e e_1 e_2 : IntW 32) :
  select (LLVM.and (icmp IntPred.eq (LLVM.and e e_1) (const? 32 0)) (icmp IntPred.eq (LLVM.and e e_2) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 e_2)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3e_like_logical_proof.main3e_like_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e e_1) (const? 32 0)) (icmp IntPred.eq (LLVM.and e e_2) (const? 32 0))
        (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (select (icmp IntPred.ne (LLVM.and e e_1) (const? 32 0)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e e_2) (const? 32 0))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3c_proof.main3c_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0))
        (icmp IntPred.ne (LLVM.and e (const? 32 48)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 55)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3c_logical_proof.main3c_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e (const? 32 48)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 55)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3d_proof.main3d_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0))
        (icmp IntPred.eq (LLVM.and e (const? 32 16)) (const? 32 16)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 23)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3d_logical_proof.main3d_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 0)) (const? 1 1)
        (icmp IntPred.eq (LLVM.and e (const? 32 16)) (const? 32 16)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 23)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3f_like_proof.main3f_like_thm_1 (e e_1 e_2 : IntW 32) :
  select (LLVM.or (icmp IntPred.ne (LLVM.and e e_1) (const? 32 0)) (icmp IntPred.ne (LLVM.and e e_2) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (LLVM.or e_1 e_2)) (const? 32 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main3f_like_logical_proof.main3f_like_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e e_1) (const? 32 0)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e e_2) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (select (icmp IntPred.eq (LLVM.and e e_1) (const? 32 0)) (icmp IntPred.eq (LLVM.and e e_2) (const? 32 0))
        (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4_proof.main4_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.eq (LLVM.and e (const? 32 48)) (const? 32 48)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 55)) (const? 32 55)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4_logical_proof.main4_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.eq (LLVM.and e (const? 32 48)) (const? 32 48)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 55)) (const? 32 55)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4b_proof.main4b_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.ne (LLVM.and e (const? 32 16)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 23)) (const? 32 23)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4b_logical_proof.main4b_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.ne (LLVM.and e (const? 32 16)) (const? 32 0)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 23)) (const? 32 23)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4e_like_proof.main4e_like_thm_1 (e e_1 e_2 : IntW 32) :
  select (LLVM.and (icmp IntPred.eq (LLVM.and e e_1) e_1) (icmp IntPred.eq (LLVM.and e e_2) e_2)) (const? 32 0)
      (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 e_2)) (LLVM.or e_1 e_2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4e_like_logical_proof.main4e_like_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (select (icmp IntPred.eq (LLVM.and e e_1) e_1) (icmp IntPred.eq (LLVM.and e e_2) e_2) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (select (icmp IntPred.ne (LLVM.and e e_1) e_1) (const? 1 1) (icmp IntPred.ne (LLVM.and e e_2) e_2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4c_proof.main4c_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.ne (LLVM.and e (const? 32 48)) (const? 32 48)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 55)) (const? 32 55)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4c_logical_proof.main4c_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e (const? 32 48)) (const? 32 48)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 55)) (const? 32 55)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4d_proof.main4d_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.eq (LLVM.and e (const? 32 16)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 23)) (const? 32 23)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4d_logical_proof.main4d_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7)) (const? 1 1)
        (icmp IntPred.eq (LLVM.and e (const? 32 16)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 23)) (const? 32 23)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4f_like_proof.main4f_like_thm_1 (e e_1 e_2 : IntW 32) :
  select (LLVM.or (icmp IntPred.ne (LLVM.and e e_1) e_1) (icmp IntPred.ne (LLVM.and e e_2) e_2)) (const? 32 0)
      (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (LLVM.or e_1 e_2)) (LLVM.or e_1 e_2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main4f_like_logical_proof.main4f_like_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (select (icmp IntPred.ne (LLVM.and e e_1) e_1) (const? 1 1) (icmp IntPred.ne (LLVM.and e e_2) e_2))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (select (icmp IntPred.eq (LLVM.and e e_1) e_1) (icmp IntPred.eq (LLVM.and e e_2) e_2) (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main5_like_proof.main5_like_thm_1 (e e_1 : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.eq (LLVM.and e_1 (const? 32 7)) (const? 32 7)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and (LLVM.and e e_1) (const? 32 7)) (const? 32 7)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main5_like_logical_proof.main5_like_logical_thm_1 (e e_1 : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.eq (LLVM.and e_1 (const? 32 7)) (const? 32 7)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e_1 (const? 32 7)) (const? 32 7))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main5e_like_proof.main5e_like_thm_1 (e e_1 e_2 : IntW 32) :
  select (LLVM.and (icmp IntPred.eq (LLVM.and e e_1) e) (icmp IntPred.eq (LLVM.and e e_2) e)) (const? 32 0)
      (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (LLVM.and e_1 e_2)) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main5e_like_logical_proof.main5e_like_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (select (icmp IntPred.eq (LLVM.and e e_1) e) (icmp IntPred.eq (LLVM.and e e_2) e) (const? 1 0)) (const? 32 0)
      (const? 32 1) ⊑
    zext 32 (select (icmp IntPred.ne (LLVM.and e e_1) e) (const? 1 1) (icmp IntPred.ne (LLVM.and e e_2) e)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main5c_like_proof.main5c_like_thm_1 (e e_1 : IntW 32) :
  select
      (LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.ne (LLVM.and e_1 (const? 32 7)) (const? 32 7)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and (LLVM.and e e_1) (const? 32 7)) (const? 32 7)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main5c_like_logical_proof.main5c_like_logical_thm_1 (e e_1 : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 7)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e_1 (const? 32 7)) (const? 32 7)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 7))
        (icmp IntPred.eq (LLVM.and e_1 (const? 32 7)) (const? 32 7)) (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main5f_like_proof.main5f_like_thm_1 (e e_1 e_2 : IntW 32) :
  select (LLVM.or (icmp IntPred.ne (LLVM.and e e_1) e) (icmp IntPred.ne (LLVM.and e e_2) e)) (const? 32 0)
      (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (LLVM.and e_1 e_2)) e) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main5f_like_logical_proof.main5f_like_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (select (icmp IntPred.ne (LLVM.and e e_1) e) (const? 1 1) (icmp IntPred.ne (LLVM.and e e_2) e)) (const? 32 0)
      (const? 32 1) ⊑
    zext 32 (select (icmp IntPred.eq (LLVM.and e e_1) e) (icmp IntPred.eq (LLVM.and e e_2) e) (const? 1 0)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main6_proof.main6_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 3))
        (icmp IntPred.eq (LLVM.and e (const? 32 48)) (const? 32 16)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 55)) (const? 32 19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main6_logical_proof.main6_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 3))
        (icmp IntPred.eq (LLVM.and e (const? 32 48)) (const? 32 16)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 55)) (const? 32 19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main6b_proof.main6b_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 3))
        (icmp IntPred.ne (LLVM.and e (const? 32 16)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 23)) (const? 32 19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main6b_logical_proof.main6b_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 7)) (const? 32 3))
        (icmp IntPred.ne (LLVM.and e (const? 32 16)) (const? 32 0)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (const? 32 23)) (const? 32 19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main6c_proof.main6c_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 3))
        (icmp IntPred.ne (LLVM.and e (const? 32 48)) (const? 32 16)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 55)) (const? 32 19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main6c_logical_proof.main6c_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 3)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e (const? 32 48)) (const? 32 16)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 55)) (const? 32 19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main6d_proof.main6d_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 3))
        (icmp IntPred.eq (LLVM.and e (const? 32 16)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 23)) (const? 32 19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main6d_logical_proof.main6d_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 7)) (const? 32 3)) (const? 1 1)
        (icmp IntPred.eq (LLVM.and e (const? 32 16)) (const? 32 0)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (icmp IntPred.eq (LLVM.and e (const? 32 23)) (const? 32 19)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7a_proof.main7a_thm_1 (e e_1 e_2 : IntW 32) :
  select (LLVM.and (icmp IntPred.eq (LLVM.and e_1 e) e_1) (icmp IntPred.eq (LLVM.and e_2 e) e_2)) (const? 32 0)
      (const? 32 1) ⊑
    zext 32 (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 e_2)) (LLVM.or e_1 e_2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7a_logical_proof.main7a_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (select (icmp IntPred.eq (LLVM.and e_1 e) e_1) (icmp IntPred.eq (LLVM.and e_2 e) e_2) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (select (icmp IntPred.ne (LLVM.and e_1 e) e_1) (const? 1 1) (icmp IntPred.ne (LLVM.and e_2 e) e_2)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7b_proof.main7b_thm_1 (e e_1 e_2 : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq e_1 (LLVM.and e e_1))
        (icmp IntPred.eq (mul e_2 (const? 32 42)) (LLVM.and e (mul e_2 (const? 32 42)))))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 (mul e_2 (const? 32 42))))
        (LLVM.or e_1 (mul e_2 (const? 32 42)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7b_logical_proof.main7b_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (select (icmp IntPred.eq e_1 (LLVM.and e e_1)) (icmp IntPred.eq e_2 (LLVM.and e e_2)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (select (icmp IntPred.ne e_1 (LLVM.and e e_1)) (const? 1 1) (icmp IntPred.ne e_2 (LLVM.and e e_2))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7c_proof.main7c_thm_1 (e e_1 e_2 : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq e_1 (LLVM.and e_1 e))
        (icmp IntPred.eq (mul e_2 (const? 32 42)) (LLVM.and (mul e_2 (const? 32 42)) e)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (icmp IntPred.ne (LLVM.and e (LLVM.or e_1 (mul e_2 (const? 32 42))))
        (LLVM.or e_1 (mul e_2 (const? 32 42)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7c_logical_proof.main7c_logical_thm_1 (e e_1 e_2 : IntW 32) :
  select (select (icmp IntPred.eq e_1 (LLVM.and e_1 e)) (icmp IntPred.eq e_2 (LLVM.and e_2 e)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32 (select (icmp IntPred.ne e_1 (LLVM.and e_1 e)) (const? 1 1) (icmp IntPred.ne e_2 (LLVM.and e_2 e))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7d_proof.main7d_thm_1 (e e_1 e_2 e_3 e_4 : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (LLVM.and e_1 e_3)) (LLVM.and e_1 e_3))
        (icmp IntPred.eq (LLVM.and e (LLVM.and e_2 e_4)) (LLVM.and e_2 e_4)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (icmp IntPred.ne (LLVM.and e (LLVM.or (LLVM.and e_1 e_3) (LLVM.and e_2 e_4)))
        (LLVM.or (LLVM.and e_1 e_3) (LLVM.and e_2 e_4))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7d_logical_proof.main7d_logical_thm_1 (e e_1 e_2 e_3 e_4 : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (LLVM.and e_1 e_3)) (LLVM.and e_1 e_3))
        (icmp IntPred.eq (LLVM.and e (LLVM.and e_2 e_4)) (LLVM.and e_2 e_4)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (select (icmp IntPred.ne (LLVM.and e (LLVM.and e_1 e_3)) (LLVM.and e_1 e_3)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e (LLVM.and e_2 e_4)) (LLVM.and e_2 e_4))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7e_proof.main7e_thm_1 (e e_1 e_2 e_3 e_4 : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and (LLVM.and e_1 e_3) e) (LLVM.and e_1 e_3))
        (icmp IntPred.eq (LLVM.and (LLVM.and e_2 e_4) e) (LLVM.and e_2 e_4)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (icmp IntPred.ne (LLVM.and e (LLVM.or (LLVM.and e_1 e_3) (LLVM.and e_2 e_4)))
        (LLVM.or (LLVM.and e_1 e_3) (LLVM.and e_2 e_4))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7e_logical_proof.main7e_logical_thm_1 (e e_1 e_2 e_3 e_4 : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and (LLVM.and e_1 e_3) e) (LLVM.and e_1 e_3))
        (icmp IntPred.eq (LLVM.and (LLVM.and e_2 e_4) e) (LLVM.and e_2 e_4)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (select (icmp IntPred.ne (LLVM.and (LLVM.and e_1 e_3) e) (LLVM.and e_1 e_3)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and (LLVM.and e_2 e_4) e) (LLVM.and e_2 e_4))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7f_proof.main7f_thm_1 (e e_1 e_2 e_3 e_4 : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e_1 e_3) (LLVM.and e (LLVM.and e_1 e_3)))
        (icmp IntPred.eq (LLVM.and e_2 e_4) (LLVM.and e (LLVM.and e_2 e_4))))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (icmp IntPred.ne (LLVM.and e (LLVM.or (LLVM.and e_1 e_3) (LLVM.and e_2 e_4)))
        (LLVM.or (LLVM.and e_1 e_3) (LLVM.and e_2 e_4))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7f_logical_proof.main7f_logical_thm_1 (e e_1 e_2 e_3 e_4 : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e_1 e_3) (LLVM.and e (LLVM.and e_1 e_3)))
        (icmp IntPred.eq (LLVM.and e_2 e_4) (LLVM.and e (LLVM.and e_2 e_4))) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (select (icmp IntPred.ne (LLVM.and e_1 e_3) (LLVM.and e (LLVM.and e_1 e_3))) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e_2 e_4) (LLVM.and e (LLVM.and e_2 e_4)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7g_proof.main7g_thm_1 (e e_1 e_2 e_3 e_4 : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e_1 e_3) (LLVM.and (LLVM.and e_1 e_3) e))
        (icmp IntPred.eq (LLVM.and e_2 e_4) (LLVM.and (LLVM.and e_2 e_4) e)))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (icmp IntPred.ne (LLVM.and e (LLVM.or (LLVM.and e_1 e_3) (LLVM.and e_2 e_4)))
        (LLVM.or (LLVM.and e_1 e_3) (LLVM.and e_2 e_4))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main7g_logical_proof.main7g_logical_thm_1 (e e_1 e_2 e_3 e_4 : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e_1 e_3) (LLVM.and (LLVM.and e_1 e_3) e))
        (icmp IntPred.eq (LLVM.and e_2 e_4) (LLVM.and (LLVM.and e_2 e_4) e)) (const? 1 0))
      (const? 32 0) (const? 32 1) ⊑
    zext 32
      (select (icmp IntPred.ne (LLVM.and e_1 e_3) (LLVM.and (LLVM.and e_1 e_3) e)) (const? 1 1)
        (icmp IntPred.ne (LLVM.and e_2 e_4) (LLVM.and (LLVM.and e_2 e_4) e))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main8_proof.main8_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.ne (LLVM.and e (const? 32 64)) (const? 32 0)) (icmp IntPred.slt (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 192)) (const? 32 0)) (const? 32 1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main8_logical_proof.main8_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 64)) (const? 32 0)) (const? 1 1)
        (icmp IntPred.slt (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 192)) (const? 32 0)) (const? 32 1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main9_proof.main9_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.ne (LLVM.and e (const? 32 64)) (const? 32 0)) (icmp IntPred.slt (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 192)) (const? 32 192)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main9_logical_proof.main9_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.ne (LLVM.and e (const? 32 64)) (const? 32 0)) (icmp IntPred.slt (trunc 8 e) (const? 8 0))
        (const? 1 0))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 192)) (const? 32 192)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main10_proof.main10_thm_1 (e : IntW 32) :
  select
      (LLVM.and (icmp IntPred.eq (LLVM.and e (const? 32 64)) (const? 32 0)) (icmp IntPred.sge (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 192)) (const? 32 0)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main10_logical_proof.main10_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 64)) (const? 32 0)) (icmp IntPred.sge (trunc 8 e) (const? 8 0))
        (const? 1 0))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 192)) (const? 32 0)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main11_proof.main11_thm_1 (e : IntW 32) :
  select
      (LLVM.or (icmp IntPred.eq (LLVM.and e (const? 32 64)) (const? 32 0)) (icmp IntPred.sge (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 192)) (const? 32 192)) (const? 32 1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main11_logical_proof.main11_logical_thm_1 (e : IntW 32) :
  select
      (select (icmp IntPred.eq (LLVM.and e (const? 32 64)) (const? 32 0)) (const? 1 1)
        (icmp IntPred.sge (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 192)) (const? 32 192)) (const? 32 1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main12_proof.main12_thm_1 (e : IntW 32) :
  select (LLVM.or (icmp IntPred.slt (trunc 16 e) (const? 16 0)) (icmp IntPred.slt (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32896)) (const? 32 0)) (const? 32 1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main12_logical_proof.main12_logical_thm_1 (e : IntW 32) :
  select (select (icmp IntPred.slt (trunc 16 e) (const? 16 0)) (const? 1 1) (icmp IntPred.slt (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32896)) (const? 32 0)) (const? 32 1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main13_proof.main13_thm_1 (e : IntW 32) :
  select (LLVM.and (icmp IntPred.slt (trunc 16 e) (const? 16 0)) (icmp IntPred.slt (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32896)) (const? 32 32896)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main13_logical_proof.main13_logical_thm_1 (e : IntW 32) :
  select (select (icmp IntPred.slt (trunc 16 e) (const? 16 0)) (icmp IntPred.slt (trunc 8 e) (const? 8 0)) (const? 1 0))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32896)) (const? 32 32896)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main14_proof.main14_thm_1 (e : IntW 32) :
  select (LLVM.and (icmp IntPred.sge (trunc 16 e) (const? 16 0)) (icmp IntPred.sge (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32896)) (const? 32 0)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main14_logical_proof.main14_logical_thm_1 (e : IntW 32) :
  select (select (icmp IntPred.sge (trunc 16 e) (const? 16 0)) (icmp IntPred.sge (trunc 8 e) (const? 8 0)) (const? 1 0))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32896)) (const? 32 0)) (const? 32 2) (const? 32 1) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main15_proof.main15_thm_1 (e : IntW 32) :
  select (LLVM.or (icmp IntPred.sge (trunc 16 e) (const? 16 0)) (icmp IntPred.sge (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32896)) (const? 32 32896)) (const? 32 1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem main15_logical_proof.main15_logical_thm_1 (e : IntW 32) :
  select (select (icmp IntPred.sge (trunc 16 e) (const? 16 0)) (const? 1 1) (icmp IntPred.sge (trunc 8 e) (const? 8 0)))
      (const? 32 2) (const? 32 1) ⊑
    select (icmp IntPred.eq (LLVM.and e (const? 32 32896)) (const? 32 32896)) (const? 32 1) (const? 32 2) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_masks_with_logical_or_proof.no_masks_with_logical_or_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (select (icmp IntPred.ne e (const? 32 0)) (const? 1 1) (icmp IntPred.ne e_1 (const? 32 63)))
      (icmp IntPred.ne e_2 (const? 32 0)) ⊑
    select (icmp IntPred.ne (LLVM.or e e_2) (const? 32 0)) (const? 1 1) (icmp IntPred.ne e_1 (const? 32 63)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem no_masks_with_logical_or2_proof.no_masks_with_logical_or2_thm_1 (e e_1 e_2 : IntW 32) :
  LLVM.or (select (icmp IntPred.ne e (const? 32 (-1))) (const? 1 1) (icmp IntPred.ne e_1 (const? 32 63)))
      (icmp IntPred.ne e_2 (const? 32 (-1))) ⊑
    select (icmp IntPred.ne (LLVM.and e e_2) (const? 32 (-1))) (const? 1 1)
      (icmp IntPred.ne e_1 (const? 32 63)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem only_one_masked_proof.only_one_masked_thm_1 (e : IntW 64) :
  LLVM.and (icmp IntPred.ne e (const? 64 0))
      (icmp IntPred.eq (LLVM.and e (const? 64 9223372036854775807)) (const? 64 0)) ⊑
    icmp IntPred.eq e (const? 64 (-9223372036854775808)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
