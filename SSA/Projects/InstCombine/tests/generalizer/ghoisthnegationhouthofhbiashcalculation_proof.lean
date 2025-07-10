
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section ghoisthnegationhouthofhbiashcalculation_proof
theorem t0_proof.t0_thm_1 (e e_1 : IntW 8) :
  sub (LLVM.and (sub (const? 8 0) e_1) e) e ⊑ sub (const? 8 0) (LLVM.and e (add e_1 (const? 8 (-1)))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem n7_proof.n7_thm_1 (e e_1 : IntW 8) :
  sub e (LLVM.and (sub (const? 8 0) e_1) e) ⊑ LLVM.and e (add e_1 (const? 8 (-1))) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
