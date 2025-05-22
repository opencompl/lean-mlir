import SSA.Projects.SLLVM.Dialect.Base

/-!
# Refinement relation for SLLVM dialect
-/

namespace LeanMLIR.SLLVM

open InstCombine.LLVM.Ty (bitvec)

scoped instance : Refinement (BitVec w) := .ofEq
@[simp, simp_llvm_split] theorem bv_isRefinedBy_iff (x y : BitVec w) : x ⊑ y ↔ x = y := by rfl
-- ^^ declare that for pure bitvectors, refinement is just equality

open HRefinement in
@[simp, simp_denote]
theorem isRefinedBy_iff (x y : EffectM <| LLVM.IntW w) :
    x ⊑ y ↔ @IsRefinedBy (StateT _ PoisonOr (PoisonOr _)) (StateT _ PoisonOr (PoisonOr _)) _ x y := by
  rfl

instance : DialectHRefinement SLLVM SLLVM where
  IsRefinedBy := @fun
    | bitvec v, bitvec w, (x : EffectM <| LLVM.IntW v), (y : EffectM <| LLVM.IntW w) =>
        ∃ h : v = w, x ⊑ h ▸ y

@[simp, simp_denote]
theorem dialect_isRefinedBy_iff_of_width_eq (x y : SLLVM.m ⟦bitvec w⟧) :
    DialectHRefinement.IsRefinedBy x y
    ↔ HRefinement.IsRefinedBy (α := EffectM <| LLVM.IntW w) (β := EffectM <| LLVM.IntW w) x y := by
  simp [DialectHRefinement.IsRefinedBy]
