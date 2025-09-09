import SSA.Projects.SLLVM.Dialect.Base

/-!
# Refinement relation for SLLVM dialect
-/

namespace LeanMLIR.SLLVM


open SLLVM.Ty in
inductive Ty.IsRefinedBy : {t u : SLLVM.Ty} → ⟦t⟧ → ⟦u⟧ → Prop
  | bitvec {w v} (x : LLVM.IntW w) (y : LLVM.IntW v) : x ⊑ y → @IsRefinedBy (bitvec _) (bitvec _) x y
  | ptr (p q : SLLVM.Ptr) : p = q → @IsRefinedBy ptr ptr p q

@[simp, simp_denote]
instance instRefinement : DialectHRefinement SLLVM SLLVM where
  MonadIsRefinedBy := inferInstanceAs <| HRefinement (EffectM _) (EffectM _)
  IsRefinedBy := { IsRefinedBy := Ty.IsRefinedBy }

/-! ## Simp Lemmas-/
section Lemmas
open HRefinement (IsRefinedBy)
open Ty (bitvec ptr)

@[simp, simp_denote, simp_sllvm] theorem bitvec_isRefinedBy_bitvec :
    @Ty.IsRefinedBy (bitvec w) (bitvec v) x y ↔ @IsRefinedBy (LLVM.IntW w) (LLVM.IntW v) _ x y := by
  constructor
  · exact fun | (.bitvec _ _ h) => h
  · apply Ty.IsRefinedBy.bitvec

@[simp, simp_denote, simp_sllvm] theorem ptr_isRefinedBy_ptr :
    @Ty.IsRefinedBy ptr ptr x y ↔ x = y := by
  constructor
  · exact fun | (.ptr _ _ h) => h
  · apply Ty.IsRefinedBy.ptr

@[simp, simp_denote, simp_sllvm] theorem not_bitvec_isRefinedBy_ptr :
    ¬(@Ty.IsRefinedBy (bitvec w) ptr x y) := by
  rintro ⟨⟩
@[simp, simp_denote, simp_sllvm] theorem not_ptr_isRefinedBy_bitvec :
    ¬(@Ty.IsRefinedBy ptr (bitvec w) x y) := by
  rintro ⟨⟩


end Lemmas
