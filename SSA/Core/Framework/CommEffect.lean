import SSA.Core.Framework

import SSA.Projects.SLLVM.Dialect
import SSA.Projects.SLLVM.Tactic

section Prelim
variable {d : Dialect} [TyDenote d.Ty]

@[simp]
theorem Ctxt.Valuation.snoc_comap_id_unSnoc {Γ : Ctxt d.Ty} {t : d.Ty}
    (V : Γ.Valuation) (v : ⟦t⟧) :
    (V.snoc v).comap (.id |> .unSnoc) = V :=
  rfl

variable [DialectSignature d]

def Com.swapLastTwoVars {Γ : Ctxt _}
    (com : Com d (Γ.snoc t |>.snoc u) eff v) :
    Com d (Γ.snoc u |>.snoc t) eff v :=
  com.changeVars fun v =>
    sorry

end Prelim


namespace LeanMLIR

section CommEffect

variable {d : Dialect} [DialectSignature d] [TyDenote d.Ty] [DialectDenote d] [Monad d.m] [LawfulMonad d.m]

-- #check

#check Expr.mk
#check EffectKind.le_refl

-- #find (Lets ?d ?Γ ?eff ?t → Lets .. )

#check Com.toLets

def OpCommutativeEffect (op : d.Op) : Prop :=
  ∀ {Γ} {α} (args) (regArgs) (V) (x : d.m α),
    let e := Expr.mk (Γ := Γ) op rfl (EffectKind.le_impure _) args regArgs;
    (e.denote V) <* x = x *> (e.denote V)

def Expr.CommutativeEffect : Expr d Γ eff ty → Prop :=
  OpCommutativeEffect ∘ Expr.op

instance : Coe (Expr d Γ eff t) (Expr d (Γ.snoc u) eff t) where
  coe := Expr.changeVars (Ctxt.Hom.unSnoc .id)


end CommEffect



section SLLVM


example : CommutativeEffect (d:=LeanMLIR.SLLVM) (InstCombine.LLVM.Op.udiv w) := by
  intro Γ α args regArgs V x
  match args with
  | v₀ ::ₕ (v₁ ::ₕ .nil) =>
    simp_peephole
    simp_sllvm
    split
    · rw [seqLeft_eq_bind, seqRight_eq_bind]
      simp only [EffectM.bind_ub, EffectM.ub_bind]
    · rfl
