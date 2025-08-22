import SSA.Projects.SLLVM.Dialect.Base

/-!
# Refinement relation for SLLVM dialect
-/

namespace LeanMLIR.SLLVM

open InstCombine.LLVM.Ty (bitvec)

scoped instance : Refinement (BitVec w) := .ofEq
@[simp, simp_llvm_split] theorem bv_isRefinedBy_iff (x y : BitVec w) : x ⊑ y ↔ x = y := by rfl
-- ^^ declare that for pure bitvectors, refinement is just equality

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
