/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.Base

open InstCombine (LLVM)

abbrev Com.Refinement (src tgt : Com LLVM Γ .pure t) (h : TyDenote.toType t = Option α := by rfl) : Prop :=
  ∀ Γv, (h ▸ src.denote Γv) ⊑ (h ▸ tgt.denote Γv)

infixr:90 " ⊑ "  => Com.Refinement
