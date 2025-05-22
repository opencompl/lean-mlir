import SSA.Projects.SLLVM.Dialect.Base

/-!
# Refinement relation for SLLVM dialect
-/

namespace LeanMLIR.SLLVM

open InstCombine.LLVM.Ty (bitvec)

scoped instance : Refinement (BitVec w) := .ofEq
@[simp, simp_llvm_split] theorem bv_isRefinedBy_iff (x y : BitVec w) : x ⊑ y ↔ x = y := by rfl
-- ^^ declare that for pure bitvectors, refinement is just equality

instance (w) : Refinement (UBOr <| LLVM.IntW w) where
  IsRefinedBy (x y : PoisonOr (PoisonOr _)) := x ⊑ y

open HRefinement in
@[simp, simp_denote]
theorem isRefinedBy_iff (x y : UBOr <| LLVM.IntW w) :
    x ⊑ y ↔ @IsRefinedBy (PoisonOr <| PoisonOr _) (PoisonOr <| PoisonOr _) _ x y := by
  rfl

instance : DialectHRefinement SLLVM SLLVM where
  IsRefinedBy := @fun
    | bitvec v, bitvec w, (x : PoisonOr (PoisonOr _)), (y : PoisonOr (PoisonOr _)) =>
        ∃ h : v = w, x ⊑ h ▸ y

@[simp, simp_denote]
theorem dialect_isRefinedBy_iff_of_width_eq (x y : SLLVM.m ⟦bitvec w⟧) :
    DialectHRefinement.IsRefinedBy x y
    ↔ HRefinement.IsRefinedBy (α := UBOr <| LLVM.IntW w) (β := UBOr <| LLVM.IntW w) x y := by
  simp [DialectHRefinement.IsRefinedBy]
