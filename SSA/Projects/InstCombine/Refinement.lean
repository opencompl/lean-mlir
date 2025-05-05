/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.Base
import SSA.Core.Util.Poison

namespace InstCombine
open LLVM.Ty

@[simp_llvm]
instance : DialectHRefinement LLVM LLVM where
  IsRefinedBy := @fun
    | bitvec w, bitvec w', (x : LLVM.IntW _), (y : LLVM.IntW _) =>
        if h : w = w' then
          x ⊑ h ▸ y
        else
          false

-- abbrev Com.Refinement (src tgt : Com LLVM Γ .pure t)
--     (h : TyDenote.toType t = PoisonOr α := by rfl) : Prop :=
--   ∀ Γv, (h ▸ src.denote Γv) ⊑ (h ▸ tgt.denote Γv)

-- infixr:90 " ⊑ "  => Com.Refinement
