import SSA.Projects.SLLVM.Dialect.Base

/-!
# Refinement relation for SLLVM dialect
-/

namespace LeanMLIR.SLLVM

open InstCombine.LLVM.Ty (bitvec)

@[simp, simp_denote]
instance instRefinement : DialectHRefinement SLLVM SLLVM where
  MonadIsRefinedBy := inferInstanceAs <| HRefinement (EffectM _) (EffectM _)
  IsRefinedBy := @fun (bitvec _) (bitvec _) =>
    inferInstanceAs <| HRefinement (LLVM.IntW _) (LLVM.IntW _)
