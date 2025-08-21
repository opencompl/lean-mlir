import SSA.Projects.SLLVM.Dialect.Base

/-!
# Refinement relation for SLLVM dialect
-/

namespace LeanMLIR.SLLVM

open InstCombine.LLVM.Ty (bitvec)

scoped instance : Refinement (BitVec w) := .ofEq
@[simp, simp_llvm_split] theorem bv_isRefinedBy_iff (x y : BitVec w) : x ⊑ y ↔ x = y := by rfl
-- ^^ declare that for pure bitvectors, refinement is just equality

-- open HRefinement in
-- @[simp, simp_denote]
-- theorem isRefinedBy_iff (x y : EffectM <| LLVM.IntW w) :
--     x ⊑ y ↔ @IsRefinedBy (StateT _ PoisonOr (PoisonOr _)) (StateT _ PoisonOr (PoisonOr _)) _ x y := by
--   rfl

instance : DialectHRefinement SLLVM SLLVM where
  MonadIsRefinedBy := inferInstanceAs <| HRefinement (EffectM _) (EffectM _)
  IsRefinedBy := @fun (.bitvec <| .concrete v) (.bitvec <| .concrete w) => ⟨
    fun (x y : LLVM.IntW _) => ∃ h : v = w, x ⊑ h ▸ y
  ⟩

@[simp, simp_denote]
instance instRefinement : DialectHRefinement SLLVM SLLVM where
  MonadIsRefinedBy := inferInstanceAs <| HRefinement (EffectM _) (EffectM _)
  IsRefinedBy := @fun (bitvec _) (bitvec _) =>
    inferInstanceAs <| HRefinement (LLVM.IntW _) (LLVM.IntW _)

-- @[simp, simp_denote]
-- theorem dialect_isRefinedBy_iff_of_width_eq (x y : SLLVM.m ⟦bitvec w⟧) :
--     x ⊑ y
--     ↔ HRefinement.IsRefinedBy (α := EffectM <| LLVM.IntW w) (β := EffectM <| LLVM.IntW w) x y := by
--   rfl
