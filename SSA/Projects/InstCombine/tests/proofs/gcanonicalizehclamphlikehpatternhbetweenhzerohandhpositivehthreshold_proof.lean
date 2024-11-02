
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gcanonicalizehclamphlikehpatternhbetweenhzerohandhpositivehthreshold_proof
theorem t0_ult_slt_65536_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult e_2 (const? 32 65536)) e_2
      (select (icmp IntPredicate.slt e_2 (const? 32 65536)) e_1 e) ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e_1 e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem t1_ult_slt_0_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult e_2 (const? 32 65536)) e_2 (select (icmp IntPredicate.slt e_2 (const? 32 0)) e_1 e) ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e_1 e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem t2_ult_sgt_65536_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult e_2 (const? 32 65536)) e_2
      (select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e_1 e) ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e_1
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem t3_ult_sgt_neg1_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ult e_2 (const? 32 65536)) e_2 (select (icmp IntPredicate.sgt e_2 (const? 32 (-1))) e_1 e) ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e_1
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem t4_ugt_slt_65536_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt e_2 (const? 32 65535)) (select (icmp IntPredicate.slt e_2 (const? 32 65536)) e_1 e)
      e_2 ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e_1 e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem t5_ugt_slt_0_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt e_2 (const? 32 65535)) (select (icmp IntPredicate.slt e_2 (const? 32 0)) e_1 e) e_2 ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e_1 e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem t6_ugt_sgt_65536_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt e_2 (const? 32 65535)) (select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e_1 e)
      e_2 ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e_1
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


theorem t7_ugt_sgt_neg1_thm (e e_1 e_2 : IntW 32) :
  select (icmp IntPredicate.ugt e_2 (const? 32 65535)) (select (icmp IntPredicate.sgt e_2 (const? 32 (-1))) e_1 e) e_2 ⊑
    select (icmp IntPredicate.sgt e_2 (const? 32 65535)) e_1
      (select (icmp IntPredicate.slt e_2 (const? 32 0)) e e_2) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    sorry
    


