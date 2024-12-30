
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gmul_full_64_proof
theorem mullo_thm (e e_1 : IntW 64) :
  LLVM.or
      (shl
        (add
          (LLVM.and
            (add
              (lshr
                (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295))
                  { «nsw» := false, «nuw» := true })
                (const? 64 32))
              (mul (LLVM.and e_1 (const? 64 4294967295)) (lshr e (const? 64 32)) { «nsw» := false, «nuw» := true }))
            (const? 64 4294967295))
          (mul (lshr e_1 (const? 64 32)) (LLVM.and e (const? 64 4294967295)) { «nsw» := false, «nuw» := true }))
        (const? 64 32))
      (LLVM.and
        (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295))
          { «nsw» := false, «nuw» := true })
        (const? 64 4294967295)) ⊑
    LLVM.or
      (shl
        (add
          (add
            (lshr
              (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295))
                { «nsw» := false, «nuw» := true })
              (const? 64 32))
            (mul e_1 (lshr e (const? 64 32))))
          (mul (lshr e_1 (const? 64 32)) e))
        (const? 64 32))
      (LLVM.and
        (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295))
          { «nsw» := false, «nuw» := true })
        (const? 64 4294967295))
      { «disjoint» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem mullo_variant3_thm (e e_1 : IntW 64) :
  add
      (shl
        (add (mul (lshr e_1 (const? 64 32)) (LLVM.and e (const? 64 4294967295)) { «nsw» := false, «nuw» := true })
          (mul (LLVM.and e_1 (const? 64 4294967295)) (lshr e (const? 64 32)) { «nsw» := false, «nuw» := true }))
        (const? 64 32))
      (mul (LLVM.and e_1 (const? 64 4294967295)) (LLVM.and e (const? 64 4294967295))
        { «nsw» := false, «nuw» := true }) ⊑
    mul e e_1 := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


