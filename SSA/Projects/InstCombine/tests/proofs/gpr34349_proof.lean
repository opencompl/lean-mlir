
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

section gpr34349_proof
theorem fast_div_201_thm (e : IntW 8) :
  lshr
      (add (trunc 8 (lshr (mul (zext 16 e) (const? 71)) (const? 8)))
        (lshr (sub e (trunc 8 (lshr (mul (zext 16 e) (const? 71)) (const? 8)))) (const? 1)))
      (const? 7) ⊑
    lshr
      (add
        (lshr (sub e (trunc 8 (lshr (mul (zext 16 e) (const? 71) { «nsw» := true, «nuw» := true }) (const? 8))))
          (const? 1))
        (trunc 8 (lshr (mul (zext 16 e) (const? 71) { «nsw» := true, «nuw» := true }) (const? 8)))
        { «nsw» := false, «nuw» := true })
      (const? 7) := by 
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    try alive_auto
    all_goals sorry


