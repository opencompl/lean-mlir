
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false

section gdemand_shrink_nsw_proof
theorem foo_thm (e : IntW 32) :
  LLVM.xor
      (LLVM.or
        (add
          (sub
            (add (LLVM.xor (LLVM.and e (const? 32 223)) (const? 32 29)) (const? 32 (-784568073))
              { «nsw» := false, «nuw» := true })
            (shl
              (LLVM.xor (LLVM.or (LLVM.xor (LLVM.and e (const? 32 223)) (const? 32 29)) (const? 32 1874836915))
                (LLVM.xor (LLVM.and (LLVM.xor (LLVM.and e (const? 32 223)) (const? 32 29)) (const? 32 221))
                  (const? 32 1874836915)))
              (const? 32 1) { «nsw» := true, «nuw» := true }))
          (const? 32 1533579450) { «nsw» := true, «nuw» := false })
        (const? 32 (-2147483648)))
      (const? 32 749011377) ⊑
    LLVM.xor
      (add
        (sub
          (add (LLVM.xor (LLVM.and e (const? 32 223)) (const? 32 29)) (const? 32 1362915575)
            { «nsw» := true, «nuw» := true })
          (LLVM.and
            (shl (LLVM.xor (LLVM.and e (const? 32 223)) (const? 32 29)) (const? 32 1) { «nsw» := true, «nuw» := true })
            (const? 32 290))
          { «nsw» := true, «nuw» := true })
        (const? 32 1533579450) { «nsw» := false, «nuw» := true })
      (const? 32 749011377) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


