
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gpr14365_proof
theorem test0_proof.test0_thm_1 (e : IntW 32) :
  add e (add (LLVM.xor (LLVM.and e (const? 32 1431655765)) (const? 32 (-1))) (const? 32 1) { «nsw» := true })
      { «nsw» := true } ⊑
    LLVM.and e (const? 32 (-1431655766)) := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem test1_proof.test1_thm_1 (e : IntW 32) :
  add e
      (add (LLVM.xor (LLVM.and (ashr e (const? 32 1)) (const? 32 1431655765)) (const? 32 (-1))) (const? 32 1)
        { «nsw» := true })
      { «nsw» := true } ⊑
    sub e (LLVM.and (lshr e (const? 32 1)) (const? 32 1431655765)) { «nsw» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
