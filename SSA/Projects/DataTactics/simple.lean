import SSA.Projects.InstCombine.TacticAuto
import SSA.Projects.InstCombine.ForStd
import SSA.Projects.InstCombine.ForMathlib
import SSA.Projects.InstCombine.LLVM.Semantics

set_option linter.unreachableTactic false
set_option linter.unusedTactic false
set_option linter.longLine false
-- theorem bitvec_AndOrXor_2416 :
--     ∀ (e e_1 : LLVM.IntW w),
--       LLVM.xor (LLVM.and (LLVM.xor e_1 (LLVM.const? (-1))) e) (LLVM.const? (-1)) ⊑
--         LLVM.or e_1 (LLVM.xor e (LLVM.const? (-1))) := by
--   simp_alive_undef
--   simp_alive_ops
--   simp_alive_case_bash
--   ensure_only_goal
--   simp_alive_bitvec

variable {w : Nat}






theorem bitvec_AddSub_1164 :
    ∀ (e e_1 : LLVM.IntW w), LLVM.add (LLVM.sub (LLVM.const? 0) e_1) e ⊑ LLVM.sub e e_1 := by
  -- intros
  simp_alive_undef
  simp_alive_ops
  simp_alive_case_bash
  ensure_only_goal
  simp
  intros
