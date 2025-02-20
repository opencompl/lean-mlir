
import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.LLVM.Semantics
open BitVec
open LLVM

set_option linter.unusedTactic false
set_option linter.unreachableTactic false
set_option maxHeartbeats 5000000
set_option maxRecDepth 1000000
set_option exponentiation.threshold 500

section g2010h11h01hlshrhmask_proof
theorem main_thm (e : IntW 32) :
  zext 32
      (mul
        (lshr
          (LLVM.xor (LLVM.or (trunc 8 e) (const? 8 (-17)))
            (LLVM.xor (shl (LLVM.xor (LLVM.and (trunc 8 e) (const? 8 122)) (const? 8 (-17))) (const? 8 6))
              (LLVM.xor (LLVM.and (trunc 8 e) (const? 8 122)) (const? 8 (-17)))))
          (const? 8 7))
        (const? 8 64)) ⊑
    zext 32 (LLVM.and (shl (LLVM.xor (trunc 8 e) (const? 8 (-1))) (const? 8 5)) (const? 8 64))
      { «nneg» := true } := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry


theorem foo_thm (e e_1 : IntW 8) :
  LLVM.xor (shl (lshr (LLVM.xor (shl e_1 (const? 8 7)) (LLVM.and e (const? 8 (-118)))) (const? 8 7)) (const? 8 5))
      (LLVM.or
        (LLVM.or (LLVM.and e (const? 8 33)) (LLVM.and (sub (const? 8 (-88)) (LLVM.and e (const? 8 84))) (const? 8 84)))
        (LLVM.xor (shl e_1 (const? 8 7)) (LLVM.and e (const? 8 (-118))))) ⊑
    LLVM.xor
      (LLVM.and (lshr (LLVM.xor (shl e_1 (const? 8 7)) (LLVM.and e (const? 8 (-118)))) (const? 8 2)) (const? 8 32))
      (LLVM.or
        (LLVM.or (LLVM.and e (const? 8 33))
          (LLVM.and (sub (const? 8 40) (LLVM.and e (const? 8 84)) { «nsw» := true, «nuw» := false }) (const? 8 84))
          { «disjoint» := true })
        (LLVM.xor (shl e_1 (const? 8 7)) (LLVM.and e (const? 8 (-118)))) { «disjoint» := true }) := by
    simp_alive_undef
    simp_alive_ops
    simp_alive_case_bash
    simp_alive_split
    simp_alive_benchmark
    all_goals sorry
