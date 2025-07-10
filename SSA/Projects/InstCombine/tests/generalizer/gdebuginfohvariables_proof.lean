
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gdebuginfohvariables_proof
theorem test_sext_zext_proof.test_sext_zext_thm_1 (e : IntW 16) : sext 64 (zext 32 e) ⊑ zext 64 e := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test_cast_select_proof.test_cast_select_thm_1 (e : IntW 1) :
  zext 32 (select e (const? 16 3) (const? 16 5)) ⊑ select e (const? 32 3) (const? 32 5) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
