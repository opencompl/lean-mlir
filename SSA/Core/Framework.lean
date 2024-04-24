/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Core.ErasedContext
import SSA.Core.HVector
import SSA.Core.Framework.Dialect
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Piecewise

open Ctxt (Var VarSet Valuation)
open TyDenote (toType)

/-
  # Classes
-/

abbrev RegionSignature Ty := List (Ctxt Ty × Ty)

structure Signature (Ty : Type) where
  sig     : List Ty
  regSig  : RegionSignature Ty
  outTy   : Ty

class DialectSignature (d : Dialect) where
  signature : d.Op → Signature d.Ty
export DialectSignature (signature)

section
variable {d} [s : DialectSignature d]

def DialectSignature.sig     := Signature.sig ∘ s.signature
def DialectSignature.regSig  := Signature.regSig ∘ s.signature
def DialectSignature.outTy   := Signature.outTy ∘ s.signature

end


class DialectDenote (d : Dialect) [TyDenote d.Ty] [DialectSignature d] where
  denote : (op : d.Op) → HVector toType (DialectSignature.sig op) →
    HVector (fun t : Ctxt d.Ty × d.Ty => t.1.Valuation → toType t.2) (DialectSignature.regSig op) →
    (toType <| DialectSignature.outTy op)

/-
  # Datastructures
-/

variable (d : Dialect) [DialectSignature d]

mutual

/-- A very simple intrinsically typed expression. -/
inductive Expr : (Γ : Ctxt d.Ty) → (ty : d.Ty) → Type :=
  | mk {Γ} {ty} (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    (regArgs : HVector (fun t : Ctxt d.Ty × d.Ty => Com t.1 t.2)
      (DialectSignature.regSig op)) : Expr Γ ty

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive Com : Ctxt d.Ty → d.Ty → Type where
  | ret (v : Var Γ t) : Com Γ t
  | lete (e : Expr Γ α) (body : Com (Γ.snoc α) β) : Com Γ β

end

section
open Std (Format)
variable {d} [DialectSignature d] [Repr d.Op] [Repr d.Ty]

mutual
  def Expr.repr (prec : Nat) : Expr d Γ t → Format
    | ⟨op, _, args, _regArgs⟩ => f!"{repr op}{repr args}"

  def Com.repr (prec : Nat) : Com d Γ t → Format
    | .ret v => .align false ++ f!"return {reprPrec v prec}"
    | .lete e body => (.align false ++ f!"{e.repr prec}") ++ body.repr prec
end

instance : Repr (Expr d Γ t) := ⟨flip Expr.repr⟩
instance : Repr (Com d Γ t) := ⟨flip Com.repr⟩

end

--TODO: this should be derived later on when a derive handler is implemented
mutual

variable {d} [DialectSignature d]

protected instance HVector.decidableEqReg [DecidableEq d.Op] [DecidableEq d.Ty] :
    ∀ {l : List (Ctxt d.Ty × d.Ty)}, DecidableEq (HVector (fun t => Com d t.1 t.2) l)
  | _, .nil, .nil => isTrue rfl
  | _, .cons x₁ v₁, .cons x₂ v₂ =>
    letI := HVector.decidableEqReg v₁ v₂
    letI := Com.decidableEq x₁ x₂
    decidable_of_iff (x₁ = x₂ ∧ v₁ = v₂) (by simp)

protected instance Expr.decidableEq [DecidableEq d.Op] [DecidableEq d.Ty] :
    {Γ : Ctxt d.Ty} → {ty : d.Ty} → DecidableEq (Expr d Γ ty)
  | _, _, .mk op₁ rfl arg₁ regArgs₁, .mk op₂ eq arg₂ regArgs₂ =>
    if ho : op₁ = op₂
    then by
      subst ho
      letI := HVector.decidableEq arg₁ arg₂
      letI := HVector.decidableEqReg regArgs₁ regArgs₂
      exact decidable_of_iff (arg₁ = arg₂ ∧ regArgs₁ = regArgs₂) (by simp)
    else isFalse (by simp_all)

protected instance Com.decidableEq [DecidableEq d.Op] [DecidableEq d.Ty] :
    {Γ : Ctxt d.Ty} → {ty : d.Ty} → DecidableEq (Com d Γ ty)
  | _, _, .ret v₁, .ret v₂ => decidable_of_iff (v₁ = v₂) (by simp)
  | _, _, .lete (α := α₁) e₁ body₁, .lete (α := α₂) e₂ body₂ =>
    if hα : α₁ = α₂
    then by
      subst hα
      letI := Expr.decidableEq e₁ e₂
      letI := Com.decidableEq body₁ body₂
      exact decidable_of_iff (e₁ = e₂ ∧ body₁ = body₂) (by simp)
    else isFalse (by simp_all)
  | _, _, .ret _, .lete _ _ => isFalse (fun h => Com.noConfusion h)
  | _, _, .lete _ _, .ret _ => isFalse (fun h => Com.noConfusion h)

end

/-- `Lets d Γ₁ Γ₂` is a sequence of lets which are well-formed under context `Γ₂` and result in
    context `Γ₁`-/
inductive Lets : Ctxt d.Ty → Ctxt d.Ty → Type where
  | nil {Γ : Ctxt d.Ty} : Lets Γ Γ
  | lete (body : Lets Γ₁ Γ₂) (e : Expr d Γ₂ t) : Lets Γ₁ (Γ₂.snoc t)

open Std (Format) in
variable {d} [Repr d.Op] [Repr d.Ty] in
def Lets.repr (prec : Nat) : Lets d Γ_in Γ_out → Format
  | .nil => .align false ++ f!"nil"
  | .lete body e => (.align false ++ f!"{e.repr prec}") ++ body.repr prec
instance [Repr d.Op] [Repr d.Ty] : Repr (Lets d Γ_in Γ_out) := ⟨flip Lets.repr⟩

/-
  # Definitions
-/

variable {d : Dialect} [DialectSignature d]

@[elab_as_elim]
def Com.rec' {motive : (a : Ctxt d.Ty) → (a_1 : d.Ty) → Com d a a_1 → Sort u} :
    (ret : {Γ : Ctxt d.Ty} → {t : d.Ty} → (v : Var Γ t) → motive Γ t (Com.ret v)) →
    (lete : {Γ : Ctxt d.Ty} →
        {α β : d.Ty} →
          (e : Expr d Γ α) →
            (body : Com d (Ctxt.snoc Γ α) β) →
              motive (Ctxt.snoc Γ α) β body → motive Γ β (Com.lete e body)) →
      {a : Ctxt d.Ty} → {a_1 : d.Ty} → (t : Com d a a_1) → motive a a_1 t
  | hret, _, _, _, Com.ret v => hret v
  | hret, hlete, _, _, Com.lete e body => hlete e body (Com.rec' hret hlete body)

def Expr.op {Γ : Ctxt d.Ty} {ty : d.Ty} (e : Expr d Γ ty) : d.Op :=
  Expr.casesOn e (fun op _ _ _ => op)

theorem Expr.ty_eq {Γ : Ctxt d.Ty} {ty : d.Ty} (e : Expr d Γ ty) :
    ty = DialectSignature.outTy e.op :=
  Expr.casesOn e (fun _ ty_eq _ _ => ty_eq)

def Expr.args {Γ : Ctxt d.Ty} {ty : d.Ty} (e : Expr d Γ ty) :
    HVector (Var Γ) (DialectSignature.sig e.op) :=
  Expr.casesOn e (fun _ _ args _ => args)

def Expr.regArgs {Γ : Ctxt d.Ty} {ty : d.Ty} (e : Expr d Γ ty) :
    HVector (fun t : Ctxt d.Ty × d.Ty => Com d t.1 t.2) (DialectSignature.regSig e.op) :=
  Expr.casesOn e (fun _ _ _ regArgs => regArgs)

/-! Projection equations for `Expr` -/
@[simp]
theorem Expr.op_mk {Γ : Ctxt d.Ty} {ty : d.Ty} (op : d.Op) (ty_eq : ty = DialectSignature.outTy op)
    (args : HVector (Var Γ) (DialectSignature.sig op)) (regArgs):
    (Expr.mk op ty_eq args regArgs).op = op := rfl

@[simp]
theorem Expr.args_mk {Γ : Ctxt d.Ty} {ty : d.Ty} (op : d.Op) (ty_eq : ty = DialectSignature.outTy op)
    (args : HVector (Var Γ) (DialectSignature.sig op)) (regArgs) :
    (Expr.mk op ty_eq args regArgs).args = args := rfl

@[simp]
theorem Expr.regArgs_mk {Γ : Ctxt d.Ty} {ty : d.Ty} (op : d.Op) (ty_eq : ty = DialectSignature.outTy op)
    (args : HVector (Var Γ) (DialectSignature.sig op)) (regArgs) :
    (Expr.mk op ty_eq args regArgs).regArgs = regArgs := rfl

-- TODO: the following `variable` probably means we include these assumptions also in definitions
-- that might not strictly need them, we can look into making this more fine-grained
variable [TyDenote d.Ty] [DialectDenote d] [DecidableEq d.Ty]

mutual

def HVector.denote : {l : List (Ctxt d.Ty × d.Ty)} → (T : HVector (fun t => Com d t.1 t.2) l) →
    HVector (fun t => t.1.Valuation → toType t.2) l
  | _, .nil => HVector.nil
  | _, .cons v vs => HVector.cons (v.denote) (HVector.denote vs)

def Expr.denote : {ty : d.Ty} → (e : Expr d Γ ty) → (Γv : Valuation Γ) → (toType ty)
  | _, ⟨op, Eq.refl _, args, regArgs⟩, Γv =>
    DialectDenote.denote op (args.map (fun _ v => Γv v)) regArgs.denote

def Com.denote : Com d Γ ty → (Γv : Valuation Γ) → (toType ty)
  | .ret e, Γv => Γv e
  | .lete e body, Γv => body.denote (Γv.snoc (e.denote Γv))

end

@[simp] lemma HVector.denote_nil {d : Dialect} [DialectSignature d] [TyDenote d.Ty] [DialectDenote d]
    (T : HVector (fun (t : Ctxt d.Ty × d.Ty) => Com d t.1 t.2) []) :
    HVector.denote T = HVector.nil := by
  cases T; simp [HVector.denote]

@[simp] lemma HVector.denote_cons {d : Dialect} [DialectSignature d] [TyDenote d.Ty] [DialectDenote d]
    (t : Ctxt d.Ty × d.Ty) (ts : List (Ctxt d.Ty × d.Ty))
    (a : Com d t.1 t.2) (as : HVector (fun t => Com d t.1 t.2) ts) :
    HVector.denote (.cons a as) = .cons (a.denote) (as.denote) := by
  simp [HVector.denote]

@[simp] lemma Com.denote_lete (e : Expr d Γ α) (body : Com d (Γ.snoc α) β) :
  Com.denote (Com.lete e body) = fun Γv => body.denote (Γv.snoc (e.denote Γv)) := by
    funext Γv; simp[Com.denote]

@[simp] lemma Com.denote_ret (v : Var Γ α)  :
  Com.denote (d:=d) (Com.ret v) = fun Γv => Γv v := by
    funext Γv; simp[Com.denote]

/-
https://leanprover.zulipchat.com/#narrow/stream/270676-lean4/topic/Equational.20Lemmas
Recall that `simp` lazily generates equation lemmas.
Moreover, recall that `simp only` **does not** generate equation lemmas.
*but* if equation lemmas are present, then `simp only` *uses* the equation lemmas.

Hence, we build the equation lemmas by invoking the correct Lean meta magic,
so that `simp only` (which we use in `simp_peephole` can find them!)

This allows `simp only [HVector.denote]` to correctly simplify `HVector.denote`
args, since there now are equation lemmas for it.
-/
#eval Lean.Meta.getEqnsFor? ``HVector.denote
#eval Lean.Meta.getEqnsFor? ``Expr.denote
#eval Lean.Meta.getEqnsFor? ``Com.denote

def Lets.denote : Lets d Γ₁ Γ₂ → Valuation Γ₁ → Valuation Γ₂
  | .nil => id
  | .lete e body => fun ll t v => by
    cases v using Var.casesOn with
    | last =>
      apply body.denote
      apply e.denote
      exact ll
    | toSnoc v =>
      exact e.denote ll v

def Expr.changeVars (varsMap : Γ.Hom Γ') :
    {ty : d.Ty} → (e : Expr d Γ ty) → Expr d Γ' ty
  | _, ⟨op, Eq.refl _, args, regArgs⟩ => ⟨op, rfl, args.map varsMap, regArgs⟩

@[simp]
theorem Expr.denote_changeVars {Γ Γ' : Ctxt d.Ty}
    (varsMap : Γ.Hom Γ')
    (e : Expr d Γ ty)
    (Γ'v : Valuation Γ') :
    (e.changeVars varsMap).denote Γ'v =
    e.denote (fun t v => Γ'v (varsMap v)) := by
  rcases e with ⟨_, rfl, _⟩
  simp [Expr.denote, Expr.changeVars, HVector.map_map]

def Com.changeVars
    (varsMap : Γ.Hom Γ') :
    Com d Γ ty → Com d Γ' ty
  | .ret e => .ret (varsMap e)
  | .lete e body => .lete (e.changeVars varsMap)
      (body.changeVars (fun t v => varsMap.snocMap v))

@[simp]
theorem Com.denote_changeVars
    (varsMap : Γ.Hom Γ') (c : Com d Γ ty)
    (Γ'v : Valuation Γ') :
    (c.changeVars varsMap).denote Γ'v =
    c.denote (fun t v => Γ'v (varsMap v)) := by
  induction c using Com.rec' generalizing Γ'v Γ' with
  | ret x => simp [Com.denote, Com.changeVars, *]
  | lete _ _ ih =>
    rw [changeVars, denote, ih]
    simp only [Ctxt.Valuation.snoc, Ctxt.Hom.snocMap, Expr.denote_changeVars, denote]
    congr
    funext t v
    cases v using Var.casesOn <;> simp


variable (d : Dialect) [DialectSignature d] in
/-- The result returned by `addProgramToLets` -/
structure addProgramToLets.Result (Γ_in Γ_out : Ctxt d.Ty) (ty : d.Ty) where
  /-- The new out context -/
  {Γ_out_new : Ctxt d.Ty}
  /-- The new `lets`, with the program added to it -/
  lets : Lets d Γ_in Γ_out_new
  /-- The difference between the old out context and the new out context
      This induces a context mapping from `Γ_out` to `Γ_out_new` -/
  diff : Ctxt.Diff Γ_out Γ_out_new
  /-- The variable in the new `lets` that represent the return value of the added program -/
  var : Var Γ_out_new ty

/--
  Add a program to a list of `Lets`, returning
  * the new lets
  * a map from variables of the out context of the old lets to the out context of the new lets
  * a variable in the new out context, which is semantically equivalent to the return variable of
    the added program
-/
def addProgramToLets (lets : Lets d Γ_in Γ_out) (varsMap : Δ.Hom Γ_out) : Com d Δ ty →
    addProgramToLets.Result d Γ_in Γ_out ty
  | .ret v => ⟨lets, .zero _, varsMap v⟩
  | .lete (α:=α) e body =>
      let lets := Lets.lete lets (e.changeVars varsMap)
      let ⟨lets', diff, v'⟩ := addProgramToLets lets (varsMap.snocMap) body
      ⟨lets', diff.unSnoc, v'⟩

theorem denote_addProgramToLets_lets (lets : Lets d Γ_in Γ_out) {map} {com : Com d Δ t}
    (ll : Valuation Γ_in) ⦃t⦄ (var : Var Γ_out t) :
    (addProgramToLets lets map com).lets.denote ll ((addProgramToLets lets map com).diff.toHom var)
    = lets.denote ll var := by
  induction com using Com.rec' generalizing lets Γ_out
  next =>
    rfl
  next e body ih =>
    -- Was just `simp [addProgramToLets, ih, Lets.denote]
    rw [addProgramToLets]
    simp [ih, Lets.denote]

theorem denote_addProgramToLets_var {lets : Lets d Γ_in Γ_out} {map} {com : Com d Δ t} :
    ∀ (ll : Valuation Γ_in),
      (addProgramToLets lets map com).lets.denote ll (addProgramToLets lets map com).var
      = com.denote (fun _ v => lets.denote ll <| map v) := by
  intro ll
  induction com using Com.rec' generalizing lets Γ_out
  next =>
    rfl
  next e body ih =>
    -- Was just `simp only [addProgramToLets, ih, Com.denote]`
    rw [addProgramToLets]
    simp only [ih, Com.denote]
    congr
    funext t v
    cases v using Var.casesOn
    . rfl
    . simp [Lets.denote]; rfl

/-- Add some `Lets` to the beginning of a program -/
def addLetsAtTop : (lets : Lets d Γ₁ Γ₂) → (inputProg : Com d Γ₂ t₂) → Com d Γ₁ t₂
  | Lets.nil, inputProg => inputProg
  | Lets.lete body e, inputProg =>
    addLetsAtTop body (.lete e inputProg)

theorem denote_addLetsAtTop :
    (lets : Lets d Γ₁ Γ₂) → (inputProg : Com d Γ₂ t₂) →
    (addLetsAtTop lets inputProg).denote =
      inputProg.denote ∘ lets.denote
  | Lets.nil, inputProg => rfl
  | Lets.lete body e, inputProg => by
    rw [addLetsAtTop, denote_addLetsAtTop body]
    funext
    simp only [Com.denote, Ctxt.Valuation.snoc, Function.comp_apply, Lets.denote,
      eq_rec_constant]
    congr
    funext t v
    cases v using Var.casesOn <;> simp

/-- `addProgramInMiddle v map lets rhs inputProg` appends the programs
`lets`, `rhs` and `inputProg`, while reassigning `v`, a free variable in
`inputProg`, to the output of `rhs`. It also assigns all free variables
in `rhs` to variables available at the end of `lets` using `map`. -/
def addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt d.Ty} (v : Var Γ₂ t₁)
    (map : Γ₃.Hom Γ₂)
    (lets : Lets d Γ₁ Γ₂) (rhs : Com d Γ₃ t₁)
    (inputProg : Com d Γ₂ t₂) : Com d Γ₁ t₂ :=
  let r := addProgramToLets lets map rhs
  addLetsAtTop r.lets <| inputProg.changeVars (r.diff.toHom.with v r.var)

theorem denote_addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt d.Ty}
    (v : Var Γ₂ t₁) (s : Valuation Γ₁)
    (map : Γ₃.Hom Γ₂)
    (lets : Lets d Γ₁ Γ₂) (rhs : Com d Γ₃ t₁)
    (inputProg : Com d Γ₂ t₂) :
    (addProgramInMiddle v map lets rhs inputProg).denote s =
      inputProg.denote (fun t' v' =>
        let s' := lets.denote s
        if h : ∃ h : t₁ = t', h ▸ v = v'
        then h.fst ▸ rhs.denote (fun t' v' => s' (map v'))
        else s' v') := by
  simp only [addProgramInMiddle, Ctxt.Hom.with, denote_addLetsAtTop, Function.comp_apply,
              Com.denote_changeVars]
  congr
  funext t' v'
  split_ifs
  next h =>
    rcases h with ⟨⟨⟩, ⟨⟩⟩
    simp [denote_addProgramToLets_var]
  next h₁ h₂ =>
    rcases h₁ with ⟨⟨⟩, ⟨⟩⟩
    simp at h₂
  next h₁ h₂ =>
    rcases h₂ with ⟨⟨⟩, ⟨⟩⟩
    simp at h₁
  next =>
    apply denote_addProgramToLets_lets

structure FlatCom (d : Dialect) [DialectSignature d] (Γ : Ctxt d.Ty) (t : d.Ty) where
  {Γ_out : Ctxt d.Ty}
  /-- The let bindings of the original program -/
  lets : Lets d Γ Γ_out
  /-- The return variable -/
  ret : Var Γ_out t

def Com.toLets {t : d.Ty} : Com d Γ t → FlatCom d Γ t :=
  go .nil
where
  go {Γ_out} (lets : Lets d Γ Γ_out) : Com d Γ_out t → FlatCom d Γ t
    | .ret v => ⟨lets, v⟩
    | .lete e body => go (lets.lete e) body

@[simp]
theorem Com.denote_toLets_go (lets : Lets d Γ_in Γ_out) (com : Com d Γ_out t) (s : Valuation Γ_in) :
    (toLets.go lets com).lets.denote s (toLets.go lets com).ret = com.denote (lets.denote s) := by
  induction com using Com.rec'
  . rfl
  next ih =>
    -- Was just `simp [toLets.go, denote, ih]`
    rw [toLets.go]
    simp [denote, ih]
    congr
    funext _ v
    cases v using Var.casesOn <;> simp[Lets.denote]

@[simp]
theorem Com.denote_toLets (com : Com d Γ t) (s : Valuation Γ) :
    com.toLets.lets.denote s com.toLets.ret = com.denote s :=
  denote_toLets_go ..

/-- Get the `Expr` that a var `v` is assigned to in a sequence of `Lets`,
    without adjusting variables
-/
def Lets.getExprAux {Γ₁ Γ₂ : Ctxt d.Ty} {t : d.Ty} : Lets d Γ₁ Γ₂ → Var Γ₂ t →
    Option ((Δ : Ctxt d.Ty) × Expr d Δ t)
  | .nil, _ => none
  | .lete lets e, v => by
    cases v using Var.casesOn with
      | toSnoc v => exact (Lets.getExprAux lets v)
      | last => exact some ⟨_, e⟩

/-- If `getExprAux` succeeds,
    then the orignal context `Γ₁` is a prefix of the local context `Δ`, and
    their difference is exactly the value of the requested variable index plus 1
-/
def Lets.getExprAuxDiff {lets : Lets d Γ₁ Γ₂} {v : Var Γ₂ t}
    (h : getExprAux lets v = some ⟨Δ, e⟩) :
    Δ.Diff Γ₂ :=
  ⟨v.val + 1, by
    intro i t
    induction lets
    next =>
      simp only [getExprAux] at h
    next lets e ih =>
      simp only [getExprAux, eq_rec_constant] at h
      cases v using Var.casesOn <;> simp at h
      . intro h'
        simp [Ctxt.get?]
        simp[←ih h h', Ctxt.snoc, Var.toSnoc, List.get?]
      . rcases h with ⟨⟨⟩, ⟨⟩⟩
        intro a
        simp_all only [Ctxt.get?, Var.val_last, zero_add, forall_true_left, implies_true]
        exact a
  ⟩

theorem Lets.denote_getExprAux {Γ₁ Γ₂ Δ : Ctxt d.Ty} {t : d.Ty}
    {lets : Lets d Γ₁ Γ₂} {v : Var Γ₂ t} {e : Expr d Δ t}
    (he : lets.getExprAux v = some ⟨Δ, e⟩)
    (s : Valuation Γ₁) :
    (e.changeVars (getExprAuxDiff he).toHom).denote (lets.denote s) = (lets.denote s) v := by
  rw [getExprAuxDiff]
  induction lets
  next => simp [getExprAux] at he
  next ih =>
    simp [Ctxt.Diff.toHom_succ <| getExprAuxDiff.proof_1 he]
    cases v using Var.casesOn with
    | toSnoc v =>
      simp only [getExprAux, eq_rec_constant, Var.casesOn_toSnoc, Option.mem_def,
        Option.map_eq_some'] at he
      simp [denote, ←ih he]
    | last =>
      simp only [getExprAux, eq_rec_constant, Var.casesOn_last,
        Option.mem_def, Option.some.injEq] at he
      rcases he with ⟨⟨⟩, ⟨⟩⟩
      simp [denote]


/-- Get the `Expr` that a var `v` is assigned to in a sequence of `Lets`.
The variables are adjusted so that they are variables in the output context of a lets,
not the local context where the variable appears. -/
def Lets.getExpr {Γ₁ Γ₂ : Ctxt d.Ty} (lets : Lets d Γ₁ Γ₂) {t : d.Ty} (v : Var Γ₂ t) :
    Option (Expr d Γ₂ t) :=
  match h : getExprAux lets v with
  | none => none
  | some r => r.snd.changeVars (getExprAuxDiff h).toHom

theorem Lets.denote_getExpr {Γ₁ Γ₂ : Ctxt d.Ty} : {lets : Lets d Γ₁ Γ₂} → {t : d.Ty} →
    {v : Var Γ₂ t} → {e : Expr d Γ₂ t} → (he : lets.getExpr v = some e) → (s : Valuation Γ₁) →
    e.denote (lets.denote s) = (lets.denote s) v := by
  intros lets _ v e he s
  simp [getExpr] at he
  split at he
  . contradiction
  . rw[←Option.some_inj.mp he, denote_getExprAux]


/-
  ## Mapping
  We can map between different dialects
-/

section Map

instance : Functor RegionSignature where
  map f := List.map fun (tys, ty) => (f <$> tys, f ty)

instance : Functor Signature where
  map := fun f ⟨sig, regSig, outTy⟩ =>
    ⟨f <$> sig, f <$> regSig, f outTy⟩

/-- A dialect morphism consists of a map between operations and a map between types,
  such that the signature of operations is respected
-/
structure DialectMorphism (d d' : Dialect) [DialectSignature d] [DialectSignature d'] where
  mapOp : d.Op → d'.Op
  mapTy : d.Ty → d'.Ty
  preserves_signature : ∀ op, signature (mapOp op) = mapTy <$> (signature op)

variable {d d'} [DialectSignature d] [DialectSignature d'] (f : DialectMorphism d d')

def DialectMorphism.preserves_sig (op : d.Op) :
    DialectSignature.sig (f.mapOp op) = f.mapTy <$> (DialectSignature.sig op) := by
  simp only [DialectSignature.sig, Function.comp_apply, f.preserves_signature, List.map_eq_map]; rfl

def DialectMorphism.preserves_regSig (op : d.Op) :
    DialectSignature.regSig (f.mapOp op) = (DialectSignature.regSig op).map (
      fun ⟨a, b⟩ => ⟨f.mapTy <$> a, f.mapTy b⟩
    ) := by
  simp only [DialectSignature.regSig, Function.comp_apply, f.preserves_signature, List.map_eq_map]; rfl

def DialectMorphism.preserves_outTy (op : d.Op) :
    DialectSignature.outTy (f.mapOp op) = f.mapTy (DialectSignature.outTy op) := by
  simp only [DialectSignature.outTy, Function.comp_apply, f.preserves_signature]; rfl

mutual
  def Com.map : Com d Γ ty → Com d' (f.mapTy <$> Γ) (f.mapTy ty)
    | .ret v          => .ret v.toMap
    | .lete body rest => .lete body.map rest.map

  def Expr.map : Expr d Γ ty → Expr d' (Γ.map f.mapTy) (f.mapTy ty)
    | ⟨op, Eq.refl _, args, regs⟩ => ⟨
        f.mapOp op,
        (f.preserves_outTy _).symm,
        f.preserves_sig _ ▸ args.map' f.mapTy fun _ => Var.toMap (f:=f.mapTy),
        f.preserves_regSig _ ▸
          HVector.mapDialectMorphism regs
      ⟩

  /-- Inline of `HVector.map'` for the termination checker -/
  def HVector.mapDialectMorphism : ∀ {regSig : RegionSignature d.Ty},
      HVector (fun t => Com d t.fst t.snd) regSig
      → HVector (fun t => Com d' t.fst t.snd) (f.mapTy <$> regSig : RegionSignature _)
    | _, .nil        => .nil
    | t::_, .cons a as  => .cons a.map (HVector.mapDialectMorphism as)
end

end Map

/-
  ## Matching
-/

abbrev Mapping (Γ Δ : Ctxt d.Ty) : Type :=
  @AList (Σ t, Var Γ t) (fun x => Var Δ x.1)

def HVector.toVarSet : {l : List d.Ty} → (T : HVector (Var Γ) l) → VarSet Γ
  | [], .nil => ∅
  | _::_, .cons v vs => insert ⟨_, v⟩ vs.toVarSet

def HVector.vars {l : List d.Ty}
    (T : HVector (Var Γ) l) : VarSet Γ :=
  T.foldl (fun _ s a => insert ⟨_, a⟩ s) ∅

@[simp]
theorem HVector.vars_nil :
    (HVector.nil : HVector (Var Γ) ([] : List d.Ty)).vars = ∅ := by
  simp [HVector.vars, HVector.foldl]

@[simp]
theorem HVector.vars_cons {t  : d.Ty} {l : List d.Ty}
    (v : Var Γ t) (T : HVector (Var Γ) l) :
    (HVector.cons v T).vars = insert ⟨_, v⟩ T.vars := by
  rw [HVector.vars, HVector.vars]
  generalize hs : (∅ : VarSet Γ) = s
  clear hs
  induction T generalizing s t v with
  | nil => simp [foldl]
  | cons v' T ih =>
    rename_i t2 _
    conv_rhs => rw [foldl]
    rw [← ih]
    rw [foldl,foldl, foldl]
    congr 1
    simp [Finset.ext_iff, or_comm, or_assoc]

/-- The free variables of `lets` that are (transitively) referred to by some variable `v` -/
def Lets.vars : Lets d Γ_in Γ_out → Var Γ_out t → VarSet Γ_in
  | .nil, v => VarSet.ofVar v
  | .lete lets e, v => by
      cases v using Var.casesOn with
      | toSnoc v => exact lets.vars v
      -- this is wrong
      | last => exact (e.args.vars).biUnion (fun v => lets.vars v.2)

theorem HVector.map_eq_of_eq_on_vars {A : d.Ty → Type*}
    {T : HVector (Var Γ) l}
    {s₁ s₂ : ∀ (t), Var Γ t → A t}
    (h : ∀ v, v ∈ T.vars → s₁ _ v.2 = s₂ _ v.2) :
    T.map s₁ = T.map s₂ := by
  induction T with
  | nil => simp [HVector.map]
  | cons v T ih =>
    rw [HVector.map, HVector.map, ih]
    · congr
      apply h ⟨_, v⟩
      simp
    · intro v hv
      apply h
      simp_all

theorem Lets.denote_eq_of_eq_on_vars (lets : Lets d Γ_in Γ_out)
    (v : Var Γ_out t)
    {s₁ s₂ : Valuation Γ_in}
    (h : ∀ w, w ∈ lets.vars v → s₁ w.2 = s₂ w.2) :
    lets.denote s₁ v = lets.denote s₂ v := by
  induction lets generalizing t
  next =>
    simp [vars] at h
    simp [denote, h]
  next lets e ih =>
    cases v using Var.casesOn
    . simp [vars] at h
      simp [denote]
      apply ih
      simpa
    . rcases e with ⟨op, rfl, args⟩
      simp [denote, Expr.denote]
      congr 1
      apply HVector.map_eq_of_eq_on_vars
      intro v h'
      apply ih
      intro v' hv'
      apply h
      rw [vars, Var.casesOn_last]
      simp
      use v.1, v.2

def Com.vars : Com d Γ t → VarSet Γ :=
  fun com => com.toLets.lets.vars com.toLets.ret

/--
  Given two sequences of lets, `lets` and `matchExpr`,
  and variables that indicate an expression, of the same type, in each sequence,
  attempt to assign free variables in `matchExpr` to variables (free or bound) in `lets`, such that
  the original two variables are semantically equivalent.
  If this succeeds, return the mapping.
-/

def matchVar {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in Γ_out) (v : Var Γ_out t) :
    (matchLets : Lets d Δ_in Δ_out) →
    (w : Var Δ_out t) →
    (ma : Mapping Δ_in Γ_out := ∅) →
    Option (Mapping Δ_in Γ_out)
  | .lete matchLets _, ⟨w+1, h⟩, ma => -- w† = Var.toSnoc w
      let w := ⟨w, by simp_all[Ctxt.snoc]⟩
      matchVar lets v matchLets w ma
  | @Lets.lete _ _ _ Δ_out _ matchLets matchExpr, ⟨0, _⟩, ma => do -- w† = Var.last
      let ie ← lets.getExpr v
      if hs : ∃ h : ie.op = matchExpr.op, ie.regArgs = (h ▸ matchExpr.regArgs)
      then
        -- hack to make a termination proof work
        let matchVar' := fun t vₗ vᵣ ma =>
            matchVar (t := t) lets vₗ matchLets vᵣ ma
        let rec matchArg : ∀ {l : List d.Ty}
            (_Tₗ : HVector (Var Γ_out) l) (_Tᵣ :  HVector (Var Δ_out) l),
            Mapping Δ_in Γ_out → Option (Mapping Δ_in Γ_out)
          | _, .nil, .nil, ma => some ma
          | t::l, .cons vₗ vsₗ, .cons vᵣ vsᵣ, ma => do
              let ma ← matchVar' _ vₗ vᵣ ma
              matchArg vsₗ vsᵣ ma
        matchArg ie.args (hs.1 ▸ matchExpr.args) ma
      else none
  | .nil, w, ma => -- The match expression is just a free (meta) variable
      match ma.lookup ⟨_, w⟩ with
      | some v₂ =>
        by
          exact if v = v₂
            then some ma
            else none
      | none => some (AList.insert ⟨_, w⟩ v ma)

open AList

theorem subset_entries_matchVar_matchArg_aux
    {Γ_out Δ_in Δ_out  : Ctxt d.Ty}
    {matchVar' : (t : d.Ty) → Var Γ_out t → Var Δ_out t →
      Mapping Δ_in Γ_out → Option (Mapping Δ_in Γ_out)} :
    {l : List d.Ty} → {argsₗ : HVector (Var Γ_out) l} →
    {argsᵣ : HVector (Var Δ_out) l} → {ma : Mapping Δ_in Γ_out} →
    {varMap : Mapping Δ_in Γ_out} →
    (hmatchVar : ∀ vMap (t : d.Ty) (vₗ vᵣ) ma,
        vMap ∈ matchVar' t vₗ vᵣ ma → ma.entries ⊆ vMap.entries) →
    (hvarMap : varMap ∈ matchVar.matchArg Δ_out matchVar' argsₗ argsᵣ ma) →
    ma.entries ⊆ varMap.entries
  | _, .nil, .nil, ma, varMap, _, h => by
    simp only [matchVar.matchArg, Option.mem_def, Option.some.injEq] at h
    subst h
    exact Set.Subset.refl _
  | _, .cons vₗ argsₗ, .cons vᵣ argsᵣ, ma, varMap, hmatchVar, h => by
    simp [matchVar.matchArg, bind, pure] at h
    rcases h with ⟨ma', h₁, h₂⟩
    refine List.Subset.trans ?_
      (subset_entries_matchVar_matchArg_aux hmatchVar h₂)
    exact hmatchVar _ _ _ _ _ h₁

/-- The output mapping of `matchVar` extends the input mapping when it succeeds. -/
theorem subset_entries_matchVar [DecidableEq d.Op]
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets d Γ_in Γ_out} {v : Var Γ_out t} :
    {matchLets : Lets d Δ_in Δ_out} → {w : Var Δ_out t} →
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma) →
    ma.entries ⊆ varMap.entries
  | .nil, w => by
    simp [matchVar]
    intros h x hx
    split at h
    . split_ifs at h
      . simp_all
    . simp only [Option.some.injEq] at h
      subst h
      rcases x with ⟨x, y⟩
      simp only [← AList.mem_lookup_iff] at *
      by_cases hx : x = ⟨t, w⟩
      . subst x; simp_all
      . rwa [AList.lookup_insert_ne hx]

  | .lete matchLets _, ⟨w+1, h⟩ => by
    simp [matchVar]
    apply subset_entries_matchVar

  | .lete matchLets matchExpr, ⟨0, _⟩ => by
    simp [matchVar, Bind.bind, Option.bind]
    intro h
    split at h
    · simp at h
    · rename_i e he
      rcases e with ⟨op, rfl, args⟩
      dsimp at h
      split_ifs at h with hop
      · rcases hop with ⟨rfl, hop⟩
        dsimp at h
        exact subset_entries_matchVar_matchArg_aux
          (fun vMap t vₗ vᵣ ma hvMap => subset_entries_matchVar hvMap) h

theorem subset_entries_matchVar_matchArg [DecidableEq d.Op]
    {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {lets : Lets d Γ_in Γ_out}
    {matchLets : Lets d Δ_in Δ_out} :
    {l : List d.Ty} → {argsₗ : HVector (Var Γ_out) l} →
    {argsᵣ : HVector (Var Δ_out) l} → {ma : Mapping Δ_in Γ_out} →
    {varMap : Mapping Δ_in Γ_out} →
    (hvarMap : varMap ∈ matchVar.matchArg Δ_out
        (fun t vₗ vᵣ ma =>
            matchVar (t := t) lets vₗ matchLets vᵣ ma) argsₗ argsᵣ ma) →
    ma.entries ⊆ varMap.entries :=
  subset_entries_matchVar_matchArg_aux (fun _ _ _ _ _ => subset_entries_matchVar)

-- TODO: this assumption is too strong, we also want to be able to model non-inhabited types
variable [∀ (t : d.Ty), Inhabited (toType t)] [DecidableEq d.Op]

theorem denote_matchVar_matchArg [DecidableEq d.Op]
    {Γ_out Δ_in Δ_out : Ctxt d.Ty} {lets : Lets d Γ_in Γ_out}
    {matchLets : Lets d Δ_in Δ_out} :
    {l : List d.Ty} →
    {args₁ : HVector (Var Γ_out) l} →
    {args₂ : HVector (Var Δ_out) l} →
    {ma varMap₁ varMap₂ : Mapping Δ_in Γ_out} →
    (h_sub : varMap₁.entries ⊆ varMap₂.entries) →
    (f₁ : (t : d.Ty) → Var Γ_out t → toType t) →
    (f₂ : (t : d.Ty) → Var Δ_out t → toType t) →
    (hf : ∀ t v₁ v₂ (ma : Mapping Δ_in Γ_out) (ma'),
      (ma ∈ matchVar lets v₁ matchLets v₂ ma') →
      ma.entries ⊆ varMap₂.entries → f₂ t v₂ = f₁ t v₁) →
    (hmatchVar : ∀ vMap (t : d.Ty) (vₗ vᵣ) ma,
      vMap ∈ matchVar (t := t) lets vₗ matchLets vᵣ ma →
      ma.entries ⊆ vMap.entries) →
    (hvarMap : varMap₁ ∈ matchVar.matchArg Δ_out
      (fun t vₗ vᵣ ma =>
        matchVar (t := t) lets vₗ matchLets vᵣ ma) args₁ args₂ ma) →
      HVector.map f₂ args₂ = HVector.map f₁ args₁
  | _, .nil, .nil, _, _ => by simp [HVector.map]
  | _, .cons v₁ T₁, .cons v₂ T₂, ma, varMap₁ => by
    intro h_sub f₁ f₂ hf hmatchVar hvarMap
    simp [HVector.map]
    simp [matchVar.matchArg, pure, bind] at hvarMap
    rcases hvarMap with ⟨ma', h₁, h₂⟩
    refine ⟨hf _ _ _ _ _ h₁ (List.Subset.trans ?_ h_sub), ?_⟩
    · refine List.Subset.trans ?_
        (subset_entries_matchVar_matchArg h₂)
      · exact Set.Subset.refl _
    apply denote_matchVar_matchArg (hvarMap := h₂) (hf := hf)
    · exact h_sub
    · exact hmatchVar

theorem denote_matchVar_of_subset
    {lets : Lets d Γ_in Γ_out} {v : Var Γ_out t}
    {varMap₁ varMap₂ : Mapping Δ_in Γ_out}
    {s₁ : Valuation Γ_in}
    {ma : Mapping Δ_in Γ_out} :
    {matchLets : Lets d Δ_in Δ_out} → {w : Var Δ_out t} →
    (h_sub : varMap₁.entries ⊆ varMap₂.entries) →
    (h_matchVar : varMap₁ ∈ matchVar lets v matchLets w ma) →
      matchLets.denote (fun t' v' => by
        match varMap₂.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default
        ) w =
      lets.denote s₁ v
  | .nil, w => by
    simp[Lets.denote, matchVar]
    intro h_sub h_mv
    split at h_mv
    next x v₂ heq =>
      split_ifs at h_mv
      next v_eq_v₂ =>
        subst v_eq_v₂
        injection h_mv with h_mv
        subst h_mv
        rw[mem_lookup_iff.mpr ?_]
        apply h_sub
        apply mem_lookup_iff.mp
        exact heq
    next =>
      rw [mem_lookup_iff.mpr]
      injection h_mv with h_mv
      apply h_sub
      subst h_mv
      simp
  | .lete matchLets _, ⟨w+1, h⟩ => by
    simp [matchVar]
    apply denote_matchVar_of_subset
  | .lete matchLets matchExpr, ⟨0, h_w⟩ => by
    rename_i t'
    have : t = t' := by simp[List.get?] at h_w; apply h_w.symm
    subst this
    simp [matchVar, Bind.bind, Option.bind]
    intro h_sub h_mv
    split at h_mv
    · simp_all
    · rename_i e he
      rcases e with ⟨op₁, rfl, args₁, regArgs₁⟩
      rcases matchExpr with ⟨op₂, h, args₂, regArgs₂⟩
      dsimp at h_mv
      split_ifs at h_mv with hop
      · rcases hop with ⟨rfl, hop⟩
        simp [Lets.denote, Expr.denote]
        rw [← Lets.denote_getExpr he]
        clear he
        simp only [Expr.denote]
        congr 1
        · apply denote_matchVar_matchArg (hvarMap := h_mv) h_sub
          · intro t v₁ v₂ ma ma' hmem hma
            apply denote_matchVar_of_subset hma
            apply hmem
          · exact (fun _ _ _ _ _ h => subset_entries_matchVar h)
        · dsimp at hop
          subst hop
          rfl

theorem denote_matchVar {lets : Lets d Γ_in Γ_out} {v : Var Γ_out t} {varMap : Mapping Δ_in Γ_out}
    {s₁ : Valuation Γ_in}
    {ma : Mapping Δ_in Γ_out}
    {matchLets : Lets d Δ_in Δ_out}
    {w : Var Δ_out t} :
    varMap ∈ matchVar lets v matchLets w ma →
    matchLets.denote (fun t' v' => by
        match varMap.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default
        ) w =
      lets.denote s₁ v :=
  denote_matchVar_of_subset (List.Subset.refl _)

theorem lt_one_add_add (a b : ℕ) : b < 1 + a + b := by
  simp (config := { arith := true })

@[simp]
theorem zero_eq_zero : (Zero.zero : ℕ) = 0 := rfl

attribute [simp] lt_one_add_add

macro_rules | `(tactic| decreasing_trivial) => `(tactic| simp (config := {arith := true}))

mutual

theorem mem_matchVar_matchArg
    {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {lets : Lets d Γ_in Γ_out}
    {matchLets : Lets d Δ_in Δ_out} :
    {l : List d.Ty} → {argsₗ : HVector (Var Γ_out) l} →
    {argsᵣ : HVector (Var Δ_out) l} → {ma : Mapping Δ_in Γ_out} →
    {varMap : Mapping Δ_in Γ_out} →
    (hvarMap : varMap ∈ matchVar.matchArg Δ_out
        (fun t vₗ vᵣ ma =>
            matchVar (t := t) lets vₗ matchLets vᵣ ma) argsₗ argsᵣ ma) →
    ∀ {t' v'}, ⟨t', v'⟩ ∈ (argsᵣ.vars).biUnion (fun v => matchLets.vars v.2) →
      ⟨t', v'⟩ ∈ varMap
  | _, .nil, .nil, _, varMap, _ => by simp
  | _, .cons vₗ argsₗ, .cons vᵣ argsᵣ, ma, varMap, h => by
    simp [matchVar.matchArg, bind, pure] at h
    rcases h with ⟨ma', h₁, h₂⟩
    simp only [HVector.vars_cons, Finset.biUnion_insert, Finset.mem_union,
      Finset.mem_biUnion, Sigma.exists]
    rintro (h | ⟨a, b, hab⟩)
    · exact AList.keys_subset_keys_of_entries_subset_entries
        (subset_entries_matchVar_matchArg h₂)
        (mem_matchVar h₁ h)
    · exact mem_matchVar_matchArg h₂
        (Finset.mem_biUnion.2 ⟨⟨_, _⟩, hab.1, hab.2⟩)

/-- All variables containing in `matchExpr` are assigned by `matchVar`. -/
theorem mem_matchVar
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets d Γ_in Γ_out} {v : Var Γ_out t} :
    {matchLets : Lets d Δ_in Δ_out} → {w : Var Δ_out t} →
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma) →
    ∀ {t' v'}, ⟨t', v'⟩ ∈ matchLets.vars w → ⟨t', v'⟩ ∈ varMap
  | .nil, w, h, t', v' => by
    simp [Lets.vars]
    simp [matchVar] at h
    intro h_mem
    subst h_mem
    intro h; cases h
    split at h
    · split_ifs at h
      · simp at h
        subst h
        subst v
        exact AList.lookup_isSome.1 (by simp_all)
    · simp at h
      subst h
      simp

  | .lete matchLets matchE, w, h, t', v' => by
    cases w using Var.casesOn
    next w =>
      simp [matchVar] at h
      apply mem_matchVar h
    next =>
      simp [Lets.vars]
      intro _ _ hl h_v'
      simp [matchVar, pure, bind] at h
      rcases h with ⟨⟨ope, h, args⟩, he₁, he₂⟩
      subst t
      split_ifs at he₂ with h
      · dsimp at h
        dsimp
        apply @mem_matchVar_matchArg (hvarMap := he₂)
        simp
        refine ⟨_, _, ?_, h_v'⟩
        rcases matchE  with ⟨_, _, _⟩
        dsimp at h
        rcases h with ⟨rfl, _⟩
        exact hl

end
--termination_by
--  mem_matchVar_matchArg _ _ _ _ _ matchLets args _ _ _ _ _ _ _ => (sizeOf matchLets, sizeOf args)
--  mem_matchVar _ _ _ _ matchLets _ _ _ _ => (sizeOf matchLets, 0)

/-- A version of `matchVar` that returns a `Hom` of `Ctxt`s instead of the `AList`,
provided every variable in the context appears as a free variable in `matchExpr`. -/
def matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty}
    (lets : Lets d Γ_in Γ_out) (v : Var Γ_out t) (matchLets : Lets d Δ_in Δ_out) (w : Var Δ_out t)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w) :
    Option (Δ_in.Hom Γ_out) := do
  match hm : matchVar lets v matchLets w with
  | none => none
  | some m =>
    return fun t v' =>
    match h : m.lookup ⟨t, v'⟩ with
    | some v' => by exact v'
    | none => by
      have := AList.lookup_isSome.2 (mem_matchVar hm (hvars t v'))
      simp_all

theorem denote_matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in Γ_out}
    {t : d.Ty} {v : Var Γ_out t}
    {matchLets : Lets d Δ_in Δ_out}
    {w : Var Δ_out t}
    {hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w}
    {map : Δ_in.Hom Γ_out}
    (hmap : map ∈ matchVarMap lets v matchLets w hvars) (s₁ : Valuation Γ_in) :
    matchLets.denote (fun t' v' => lets.denote s₁ (map v')) w =
      lets.denote s₁ v := by
  rw [matchVarMap] at hmap
  split at hmap
  next => simp_all
  next hm =>
    rw [← denote_matchVar hm]
    simp only [Option.mem_def, Option.some.injEq, pure] at hmap
    subst hmap
    congr
    funext t' v;
    split
    . congr
      dsimp
      split <;> simp_all
    . have := AList.lookup_isSome.2 (mem_matchVar hm (hvars _ v))
      simp_all

/-- `splitProgramAtAux pos lets prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAtAux : (pos : ℕ) → (lets : Lets d Γ₁ Γ₂) →
    (prog : Com d Γ₂ t) →
    Option (Σ (Γ₃ : Ctxt d.Ty), Lets d Γ₁ Γ₃ × Com d Γ₃ t × (t' : d.Ty) × Var Γ₃ t')
  | 0, lets, .lete e body => some ⟨_, .lete lets e, body, _, Var.last _ _⟩
  | _, _, .ret _ => none
  | n+1, lets, .lete e body =>
    splitProgramAtAux n (lets.lete e) body

theorem denote_splitProgramAtAux : {pos : ℕ} → {lets : Lets d Γ₁ Γ₂} →
    {prog : Com d Γ₂ t} →
    {res : Σ (Γ₃ : Ctxt d.Ty), Lets d Γ₁ Γ₃ × Com d Γ₃ t × (t' : d.Ty) × Var Γ₃ t'} →
    (hres : res ∈ splitProgramAtAux pos lets prog) →
    (s : Valuation Γ₁) →
    res.2.2.1.denote (res.2.1.denote s) = prog.denote (lets.denote s)
  | 0, lets, .lete e body, res, hres, s => by
    simp only [splitProgramAtAux, Option.mem_def, Option.some.injEq] at hres
    subst hres
    simp only [Lets.denote, eq_rec_constant, Com.denote]
    congr
    funext t v
    cases v using Var.casesOn <;> simp
  | _+1, _, .ret _, res, hres, s => by
    simp [splitProgramAtAux] at hres
  | n+1, lets, .lete e body, res, hres, s => by
    rw [splitProgramAtAux] at hres
    rw [Com.denote, denote_splitProgramAtAux hres s]
    simp only [Lets.denote, eq_rec_constant, Ctxt.Valuation.snoc]
    congr
    funext t v
    cases v using Var.casesOn <;> simp

/-- `splitProgramAt pos prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAt (pos : ℕ) (prog : Com d Γ₁ t) :
    Option (Σ (Γ₂ : Ctxt d.Ty), Lets d Γ₁ Γ₂ × Com d Γ₂ t × (t' : d.Ty) × Var Γ₂ t') :=
  splitProgramAtAux pos .nil prog

theorem denote_splitProgramAt {pos : ℕ} {prog : Com d Γ₁ t}
    {res : Σ (Γ₂ : Ctxt d.Ty), Lets d Γ₁ Γ₂ × Com d Γ₂ t × (t' : d.Ty) × Var Γ₂ t'}
    (hres : res ∈ splitProgramAt pos prog) (s : Valuation Γ₁) :
    res.2.2.1.denote (res.2.1.denote s) = prog.denote s :=
  denote_splitProgramAtAux hres s



/-
  ## Rewriting
-/

/-- `rewriteAt lhs rhs hlhs pos target`, searches for `lhs` at position `pos` of
`target`. If it can match the variables, it inserts `rhs` into the program
with the correct assignment of variables, and then replaces occurences
of the variable at position `pos` in `target` with the output of `rhs`.  -/
def rewriteAt (lhs rhs : Com d Γ₁ t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com d Γ₂ t₂) :
    Option (Com d Γ₂ t₂) := do
  let ⟨Γ₃, lets, target', t', vm⟩ ← splitProgramAt pos target
  if h : t₁ = t'
  then
    let flatLhs := lhs.toLets
    let m ← matchVarMap lets vm flatLhs.lets (h ▸ flatLhs.ret)
      (by subst h; exact hlhs)
    return addProgramInMiddle vm m lets (h ▸ rhs) target'
  else none

theorem denote_rewriteAt (lhs rhs : Com d Γ₁ t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com d Γ₂ t₂)
    (hl : lhs.denote = rhs.denote)
    (rew : Com d Γ₂ t₂)
    (hrew : rew ∈ rewriteAt lhs rhs hlhs pos target) :
    rew.denote = target.denote := by
  ext s
  rw [rewriteAt] at hrew
  simp only [bind, pure, Option.bind] at hrew
  split at hrew
  . simp at hrew
  . rename_i hs
    simp only [Option.mem_def] at hrew
    split_ifs at hrew
    subst t₁
    split at hrew
    . simp at hrew
    . simp only [Option.some.injEq] at hrew
      subst hrew
      rw [denote_addProgramInMiddle, ← hl]
      rename_i _ _ h
      have := denote_matchVarMap h
      simp only [Com.denote_toLets] at this
      simp only [this, ← denote_splitProgramAt hs s]
      congr
      funext t' v'
      simp only [dite_eq_right_iff, forall_exists_index]
      rintro rfl rfl
      simp

variable (d : Dialect) [DialectSignature d] [TyDenote d.Ty] [DialectDenote d] in
/--
  Rewrites are indexed with a concrete list of types, rather than an (erased) context, so that
  the required variable checks become decidable
-/
structure PeepholeRewrite (Γ : List d.Ty) (t : d.Ty) where
  lhs : Com d (.ofList Γ) t
  rhs : Com d (.ofList Γ) t
  correct : lhs.denote = rhs.denote

instance {Γ : List d.Ty} {t' : d.Ty} {lhs : Com d (.ofList Γ) t'} :
    Decidable (∀ (t : d.Ty) (v : Var (.ofList Γ) t), ⟨t, v⟩ ∈ lhs.vars) :=
  decidable_of_iff
    (∀ (i : Fin Γ.length),
      let v : Var (.ofList Γ) (Γ.get i) := ⟨i, by simp [List.get?_eq_get, Ctxt.ofList]⟩
      ⟨_, v⟩ ∈ lhs.vars) <|  by
  constructor
  . intro h t v
    rcases v with ⟨i, hi⟩
    try simp only [Erased.out_mk] at hi
    rcases List.get?_eq_some.1 hi with ⟨h', rfl⟩
    simp at h'
    convert h ⟨i, h'⟩
  . intro h i
    apply h

def rewritePeepholeAt (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ t₂) :
    (Com d Γ₂ t₂) := if hlhs : ∀ t (v : Var (.ofList Γ) t), ⟨_, v⟩ ∈ pr.lhs.vars then
      match rewriteAt pr.lhs pr.rhs hlhs pos target
      with
        | some res => res
        | none => target
      else target


theorem denote_rewritePeepholeAt (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ t₂) :
    (rewritePeepholeAt pr pos target).denote = target.denote := by
    simp only [rewritePeepholeAt]
    split_ifs
    case pos h =>
      generalize hrew : rewriteAt pr.lhs pr.rhs h pos target = rew
      cases rew with
        | some res =>
          apply denote_rewriteAt pr.lhs pr.rhs h pos target pr.correct _ hrew
        | none => simp
    case neg h => simp

/- repeatedly apply peephole on program. -/
section SimpPeepholeApplier

/-- rewrite with `pr` to `target` program, at location `ix` and later, running at most `fuel` steps. -/
def rewritePeephole_go (fuel : ℕ) (pr : PeepholeRewrite d Γ t)
    (ix : ℕ) (target : Com d Γ₂ t₂) : (Com d Γ₂ t₂) :=
  match fuel with
  | 0 => target
  | fuel' + 1 =>
     let target' := rewritePeepholeAt pr ix target
     rewritePeephole_go fuel' pr (ix + 1) target'

/-- rewrite with `pr` to `target` program, running at most `fuel` steps. -/
def rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ t₂) : (Com d Γ₂ t₂) :=
  rewritePeephole_go fuel pr 0 target

/-- `rewritePeephole_go` preserve semantics -/
theorem denote_rewritePeephole_go (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ t₂) :
    (rewritePeephole_go fuel pr pos target).denote = target.denote := by
  induction fuel generalizing pr pos target
  case zero =>
    simp[rewritePeephole_go, denote_rewritePeepholeAt]
  case succ fuel' hfuel =>
    simp[rewritePeephole_go, denote_rewritePeepholeAt, hfuel]

/-- `rewritePeephole` preserves semantics. -/
theorem denote_rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ t₂) :
    (rewritePeephole fuel pr target).denote = target.denote := by
  simp[rewritePeephole, denote_rewritePeephole_go]
end SimpPeepholeApplier

section Unfoldings

/-- Equation lemma to unfold `denote`, which does not unfold correctly due to the presence
  of the coercion `ty_eq` and the mutual definition. -/
theorem Expr.denote_unfold  [OP_SIG : DialectSignature d] [OP_DENOTE: DialectDenote d]
    (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    (regArgs : HVector (fun (t : Ctxt d.Ty × d.Ty) => Com d t.1 t.2)
      (OP_SIG.regSig op))
  : ∀(Γv : Γ.Valuation),
    Expr.denote (Expr.mk op ty_eq args regArgs) Γv =  ty_eq ▸ OP_DENOTE.denote op (args.map (fun _ v => Γv v)) regArgs.denote := by
      subst ty_eq
      simp[denote]

/-- Equation lemma to unfold `denote`, which does not unfold correctly due to the presence
  of the coercion `ty_eq` and the mutual definition. -/
theorem Com.denote_unfold  [OP_SIG : DialectSignature d] [OP_DENOTE: DialectDenote d]
    (op : d.Op)
    (ty_eq : ty = DialectSignature.outTy op)
    (args : HVector (Var Γ) <| DialectSignature.sig op)
    (regArgs : HVector (fun (t : Ctxt d.Ty × d.Ty) => Com d t.1 t.2)
      (OP_SIG.regSig op))
  : ∀(Γv : Γ.Valuation),
    Expr.denote (Expr.mk op ty_eq args regArgs) Γv =  ty_eq ▸ OP_DENOTE.denote op (args.map (fun _ v => Γv v)) regArgs.denote := by
      subst ty_eq
      simp[denote]
      simp[Expr.denote]


end Unfoldings

section TypeProjections

variable {d} [DialectSignature d] {Γ : Ctxt d.Ty} {t : d.Ty}

def Com.getTy : Com d Γ t → Type      := fun _ => d.Ty
def Com.ty    : Com d Γ t → d.Ty      := fun _ => t
def Com.ctxt  : Com d Γ t → Ctxt d.Ty := fun _ => Γ

def Expr.getTy  : Expr d Γ t → Type       := fun _ => d.Ty
def Expr.ty     : Expr d Γ t → d.Ty       := fun _ => t
def Expr.ctxt   : Expr d Γ t → Ctxt d.Ty  := fun _ => Γ

end TypeProjections
