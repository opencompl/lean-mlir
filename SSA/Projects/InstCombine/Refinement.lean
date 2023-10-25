import SSA.Projects.InstCombine.LLVM.EDSL
import SSA.Projects.InstCombine.AliveStatements

open MLIR AST

abbrev ICom.Refinement (src tgt : Com (φ:=0) Γ t) (h : Goedel.toType t = Option α := by rfl) : Prop :=
  ∀ Γv, (h ▸ src.denote Γv) ⊑ (h ▸ tgt.denote Γv)

infixr:90 " ⊑ "  => ICom.Refinement
