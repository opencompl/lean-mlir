import SSA.Core.Framework

open Ctxt (Valuation Var)

/-!
# Zipper
-/

variable (d : Dialect) [DialectSignature d]

/-- `Zipper d Γ_in eff Γ_mid ty` represents a particular position in a program, by storing the
`Lets` that come before this position separately from the `Com` that represents the rest.
Thus, `Γ_in` is the context of the program as a whole, while `Γ_mid` is the context at the
current position.

While technically the position is in between two let-bindings, by convention we say that the first
binding of `top : Lets ..` is the current binding of a particular zipper. -/
structure Zipper (Γ_in : Ctxt d.Ty) (eff : EffectKind) (Γ_mid : Ctxt d.Ty) (ty : d.Ty) where
  /-- The let-bindings at the top of the zipper -/
  top : Lets d Γ_in eff Γ_mid
  /-- The program at the bottom of the zipper -/
  bot : Com d Γ_mid eff ty


namespace Zipper
variable {d}

/-!
## Denotation
-/
section Denote
variable [TyDenote d.Ty] [DialectDenote d] [Monad d.m]

/-- The denotation of a zipper is a composition of the denotations of the constituent
`Lets` and `Com` -/
def denote (zip : Zipper d Γ_in eff Γ_out ty) (V_in : Valuation Γ_in) :
    eff.toMonad d.m ⟦ty⟧ :=
  (zip.top.denote V_in) >>= zip.bot.denote

@[simp] lemma denote_mk {lets : Lets d Γ_in eff Γ_out} {com : Com d Γ_out eff ty} :
    denote ⟨lets, com⟩ = fun V => (lets.denote V) >>= com.denote := rfl

/-- Casting the intermediate context is not relevant for the denotation -/
@[simp] lemma denoteLets_eqRec_Γ_mid {zip : Zipper d Γ_in eff Γ_mid ty}
    (h : Γ_mid = Γ_mid') :
    denote (h ▸ zip) = zip.denote := by
  subst h; rfl

end Denote

/-!
## Structural Manipulations
-/

/-! ### Com Reconstruction -/
section ToCom

/-- Recombine a zipper into a single program by adding the `lets` to the beginning of the `com` -/
def toCom (zip : Zipper d Γ_in eff Γ_mid ty) : Com d Γ_in eff ty :=
  go zip.top zip.bot
  where
    go : {Γ_mid : _} → Lets d Γ_in eff Γ_mid → Com d Γ_mid eff ty → Com d Γ_in eff ty
      | _, .nil, com          => com
      | _, .var body e, com  => go body (.var e com)

@[simp] lemma toCom_nil {com : Com d Γ eff ty} : toCom ⟨.nil, com⟩ = com := rfl
@[simp] lemma toCom_var {lets : Lets d Γ_in eff Γ_mid} :
    toCom ⟨Lets.var lets e, com⟩ = toCom ⟨lets, Com.var e com⟩ := rfl

variable [TyDenote d.Ty] [DialectDenote d] [Monad d.m]
@[simp] theorem denote_toCom [LawfulMonad d.m] (zip : Zipper d Γ_in eff Γ_mid ty) :
    zip.toCom.denote = zip.denote := by
  rcases zip with ⟨lets, com⟩
  funext Γv; induction lets <;> simp [Lets.denote, denote, *]

end ToCom

/-! ### Insertion -/
section InsertCom
variable [DecidableEq d.Ty]

/-- Add a `Com` directly before the current position of a zipper, while reassigning every
occurence of a given free variable (`v`) of `zip.com` to the output of the new `Com`  -/
def insertCom (zip : Zipper d Γ_in eff Γ_mid ty) (v : Var Γ_mid newTy)
    (newCom : Com d Γ_mid eff newTy) : Zipper d Γ_in eff newCom.outContext ty :=
  let newTop := zip.top.addComToEnd newCom
  --  ^^^^^^ The combination of the previous `top` with the `newCom` inserted
  let newBot := zip.bot.changeVars <| newCom.outContextHom.with v newCom.returnVar
  --  ^^^^^^ Adjust variables in `bot` to the intermediate context of the new zipper --- which is
  --         `newCom.outContext` --- while also reassigning `v`
  ⟨newTop, newBot⟩

/-- Add a pure `Com` directly before the current position of a possibly impure
zipper, while r eassigning every occurence of a given free variable (`v`) of
`zip.com` to the output of the new `Com`

This is a wrapper around `insertCom` (which expects `newCom` to have the same effect as `zip`)
and `castPureToEff` -/
def insertPureCom (zip : Zipper d Γ_in eff Γ_mid ty) (v : Var Γ_mid newTy)
    (newCom : Com d Γ_mid .pure newTy) : Zipper d Γ_in eff newCom.outContext ty :=
  (by simp : (newCom.castPureToEff eff).outContext = newCom.outContext)
    ▸ zip.insertCom v (newCom.castPureToEff eff)

/-! simp-lemmas -/
section Lemmas
variable [TyDenote d.Ty] [DialectDenote d] [Monad d.m]

theorem denote_insertCom {zip : Zipper d Γ_in eff Γ_mid ty₁}
    {newCom : Com d _ eff newTy} [LawfulMonad d.m] :
    (zip.insertCom v newCom).denote = (fun (V_in : Valuation Γ_in) => do
      let V_mid ← zip.top.denote V_in
      let V_newMid ← newCom.denoteLets V_mid
      zip.bot.denote
        (V_newMid.comap <| newCom.outContextHom.with v newCom.returnVar)
      ) := by
  funext V
  simp [insertCom, Com.denoteLets_eq]

theorem denote_insertPureCom {zip : Zipper d Γ_in eff Γ_mid ty₁}
    {newCom : Com d _ .pure newTy} [LawfulMonad d.m] :
    (zip.insertPureCom v newCom).denote = (fun (V_in : Valuation Γ_in) => do
      let V_mid ← zip.top.denote V_in
      zip.bot.denote
        ((Com.denoteLets newCom V_mid).comap <| newCom.outContextHom.with v newCom.returnVar)
      ) := by
  have (V_mid) (h : Com.outContext (Com.castPureToEff eff newCom) = Com.outContext newCom) :
      ((Com.denoteLets newCom V_mid).comap fun x v => v.castCtxt h).comap
        (newCom.castPureToEff eff).outContextHom
      = (Com.denoteLets newCom V_mid).comap newCom.outContextHom := by
    funext t' ⟨v', hv'⟩
    simp only [Com.outContextHom, Com.outContextDiff, Com.size_castPureToEff]
    rfl
  funext V; simp [insertPureCom, denote_insertCom, Valuation.comap, this]

end Lemmas
end InsertCom
