import SSA.Projects.SLLVM.Dialect.Base

/-!
# Refinement relation for SLLVM dialect
-/

namespace LeanMLIR.SLLVM

open InstCombine.LLVM.Ty (bitvec)

instance : DialectHRefinement SLLVM SLLVM where
  IsRefinedBy := @fun
    | bitvec v, bitvec w, (x : PoisonOr (LLVM.IntW v)), (y : PoisonOr (LLVM.IntW w)) =>
        ∃ h : v = w, x ⊑ h ▸ y
