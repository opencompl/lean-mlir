
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 1500

section gbitreverse_proof
theorem rev8_mul_and_lshr_thm (e : IntW 8) :
  trunc 8
      (lshr
        (mul
          (LLVM.or (LLVM.and (mul (zext 64 e) (const? 64 2050) { «nsw» := true, «nuw» := true }) (const? 64 139536))
            (LLVM.and (mul (zext 64 e) (const? 64 32800) { «nsw» := true, «nuw» := true }) (const? 64 558144)))
          (const? 64 65793) { «nsw» := true, «nuw» := true })
        (const? 64 16)) ⊑
    trunc 8
      (lshr
        (mul
          (LLVM.or (LLVM.and (mul (zext 64 e) (const? 64 2050) { «nsw» := true, «nuw» := true }) (const? 64 139536))
            (LLVM.and (mul (zext 64 e) (const? 64 32800) { «nsw» := true, «nuw» := true }) (const? 64 558144))
            { «disjoint» := true })
          (const? 64 65793) { «nsw» := true, «nuw» := true })
        (const? 64 16)) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
