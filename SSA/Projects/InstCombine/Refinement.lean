/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Projects.InstCombine.Base
import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements

open MLIR AST

abbrev Com.Refinement (src tgt : Com (InstCombine.MOp 0) Γ t) (h : TyDenote.toType t = Option α := by rfl) : Prop :=
  ∀ Γv, (h ▸ src.denote Γv) ⊑ (h ▸ tgt.denote Γv)

infixr:90 " ⊑ "  => Com.Refinement
