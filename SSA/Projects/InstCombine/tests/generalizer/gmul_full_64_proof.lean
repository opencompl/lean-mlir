
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
import SSA.Experimental.Bits.Fast.Generalize
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000

section gmul_full_64_proof
theorem mullo_proof.mullo_thm_1 (e e_1 : IntW 64) :
  LLVM.or
      (shl
        (add
          (LLVM.and
            (add
              (lshr (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295)) { «nuw» := true })
                (const? 64 32))
              (mul (LLVM.and e_1 (const? 64 4294967295)) (lshr e (const? 64 32)) { «nuw» := true }))
            (const? 64 4294967295))
          (mul (lshr e_1 (const? 64 32)) (LLVM.and e (const? 64 4294967295)) { «nuw» := true }))
        (const? 64 32))
      (LLVM.and (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295)) { «nuw» := true })
        (const? 64 4294967295)) ⊑
    LLVM.or
      (shl
        (add
          (add
            (lshr (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295)) { «nuw» := true })
              (const? 64 32))
            (mul e_1 (lshr e (const? 64 32))))
          (mul (lshr e_1 (const? 64 32)) e))
        (const? 64 32))
      (LLVM.and (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295)) { «nuw» := true })
        (const? 64 4294967295))
      { «disjoint» := true } := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
theorem mullo_variant3_proof.mullo_variant3_thm_1 (e e_1 : IntW 64) :
  add
      (shl
        (add (mul (lshr e_1 (const? 64 32)) (LLVM.and e (const? 64 4294967295)) { «nuw» := true })
          (mul (LLVM.and e_1 (const? 64 4294967295)) (lshr e (const? 64 32)) { «nuw» := true }))
        (const? 64 32))
      (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295)) { «nuw» := true }) ⊑
    mul e e_1 := by
        simp_alive_undef
        simp_alive_ops
        simp_alive_case_bash
        simp_alive_split
        bv_generalize
        simp_alive_benchmark
        all_goals sorry

    
