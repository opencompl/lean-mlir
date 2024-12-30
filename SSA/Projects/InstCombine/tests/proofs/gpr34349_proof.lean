
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000

section gpr34349_proof
theorem fast_div_201_thm (e : IntW 8) :
  lshr
      (add (trunc 8 (lshr (mul (zext 16 e) (const? 16 71)) (const? 16 8)))
        (lshr (sub e (trunc 8 (lshr (mul (zext 16 e) (const? 16 71)) (const? 16 8)))) (const? 8 1)))
      (const? 8 7) ⊑
    lshr
      (add
        (lshr
          (sub e
            (trunc 8 (lshr (mul (zext 16 e) (const? 16 71) { «nsw» := true, «nuw» := true }) (const? 16 8))
              { «nsw» := true, «nuw» := true }))
          (const? 8 1))
        (trunc 8 (lshr (mul (zext 16 e) (const? 16 71) { «nsw» := true, «nuw» := true }) (const? 16 8))
          { «nsw» := true, «nuw» := true })
        { «nsw» := false, «nuw» := true })
      (const? 8 7) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


