import SSA.Core.Framework.Refinement
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.Refinement
import SSA.Projects.InstCombine.Tactic

open InstCombine

set_option pp.explicit true
set_option pp.instances false

variable {w : Nat} (x y : LLVM.m ⟦LLVM.Ty.bitvec w⟧)

-- `simp_denote` simplifies refinement of LLVM dialect bitvectors to refinement
-- of their denotation `LLVM.IntW _`.
/-- warning: declaration uses 'sorry' -/
#guard_msgs in example : x ⊑ y := by
  simp only [simp_denote]
  guard_target =ₛ @HRefinement.IsRefinedBy (LLVM.IntW w) (LLVM.IntW w) _ x y
  sorry

-- `simp_llvm` further simplifies refinement `LLVM.IntW _` to refinement of
-- the generic `PoisonOr` helper.
/-- warning: declaration uses 'sorry' -/
#guard_msgs in example {w : Nat} (x y : LLVM.m ⟦LLVM.Ty.bitvec w⟧) : x ⊑ y := by
  simp only [simp_denote, simp_llvm]
  guard_target =ₛ @HRefinement.IsRefinedBy (PoisonOr _) (PoisonOr _) _ x y
  sorry

-- `simp_denote` should still simplify in the presence of *concrete* effects.
/--
warning: declaration uses 'sorry'
-/
#guard_msgs in example {w : Nat}
    (x : EffectKind.pure.toMonad LLVM.m ⟦LLVM.Ty.bitvec w⟧)
    (y : EffectKind.impure.toMonad LLVM.m ⟦LLVM.Ty.bitvec w⟧) :
    x ⊑ y := by
  simp only [simp_denote, simp_llvm]
  guard_target =ₛ @HRefinement.IsRefinedBy (PoisonOr _) (PoisonOr _) _ x y
  sorry
