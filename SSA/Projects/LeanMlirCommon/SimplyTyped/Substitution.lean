import SSA.Projects.LeanMlirCommon.SimplyTyped.Basic
import SSA.Projects.LeanMlirCommon.UnTyped.Substitution

namespace MLIR.SimplyTyped

instance : UnTyped.SubstituteableTerminator VarName where
  substituteTerminator σ := σ

/-- The type of Type-preserving substitutions. That is, substitutions `σ` such that for each
variable `v` in the original context `Γ` we have that the result of applying `σ` to `v` is mapped to
the same type in the target context `Δ` -/
def Substitution (Γ Δ : Context Ty) : Type :=
  { σ : UnTyped.Substitution // ∀ v t, Γ.hasType v t → Δ.hasType (σ.apply v) t }


variable {Op Ty} [OpSignature Op Ty]

set_option warn.sorry false in
mutual

variable {Γ Δ} {σ : Substitution Γ Δ}

theorem Expr.WellTyped_of_substitute {e : UnTyped.Expr Op VarName}
    (h : Expr.WellTyped Γ e ty) : WellTyped Δ (e.substitute σ.val) ty := by
  rcases e with ⟨v, op, args, regions⟩
  simp [WellTyped, UnTyped.Expr.substitute] at h ⊢
  repeat' constructor
  · aesop
  · have h := h.right.left
    intro v ty h_mem
    -- simp at h_mem
    specialize h v ty
    sorry
  · sorry
  · sorry
  · aesop

end

end SimplyTyped

end MLIR
