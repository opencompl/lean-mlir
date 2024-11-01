
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section g2007h01h13hExtCompareMiscompile_proof
theorem test_thm (e e_1 : IntW 8) :
  icmp IntPredicate.sgt (zext 32 e_1) (zext 32 e) ⊑ icmp IntPredicate.ugt e_1 e := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


