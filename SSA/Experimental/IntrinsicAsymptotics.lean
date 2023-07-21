-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import Std.Data.Option.Lemmas
import Std.Data.Array.Lemmas
import Std.Data.Array.Init.Lemmas
-- import Mathlib
import Mathlib.Data.List.Indexes
import Mathlib.Data.Fin.Basic
import Mathlib.Data.List.AList

noncomputable section

/-- A very simple type universe. -/
inductive Ty
  | nat
  | bool
  deriving DecidableEq, Repr

@[reducible]
def Ty.toType
  | nat => Nat
  | bool => Bool

-- inductive Value where
--   | nat : Nat → Value
--   | bool : Bool → Value
--   deriving Repr, Inhabited, DecidableEq

-- /-- The `State` is a map from variables to values that uses relative de Bruijn
--     indices. The most recently introduced variable is at the head of the list.
-- -/
-- abbrev State := List Value

/-- A context is basicallty a list of `Ty`, but we make it a constant here to be
implemented later -/
axiom Ctxt : Type

/-- The empty context -/
axiom Ctxt.empty : Ctxt

instance : EmptyCollection Ctxt := ⟨Ctxt.empty⟩

/-- Add a `Ty` to a context -/
axiom Ctxt.snoc : Ctxt → Ty → Ctxt

/-- A `Γ.Var t` is a variable of Type `t` in a context `Γ`   -/
axiom Ctxt.Var (Γ : Ctxt) (t : Ty) : Type

@[instance]
axiom Ctxt.Var.decidableEq {Γ : Ctxt} {t : Ty} : DecidableEq (Ctxt.Var Γ t)

/-- The last variable in a context, i.e. the most recently added. -/
axiom Ctxt.Var.last (Γ : Ctxt) (t : Ty) : Ctxt.Var (Ctxt.snoc Γ t) t

/-- The empty Context has no variables, so we can add this eliminator. -/
axiom Ctxt.Var.emptyElim {α : Sort _} {t : Ty} : Ctxt.Var ∅ t → α  

/-- Take a variable in a context `Γ` and get the corresponding variable
in context `Γ.snoc t`. This is marked as a coercion. -/
@[coe]
axiom Ctxt.Var.toSnoc {Γ : Ctxt} {t t' : Ty} : 
    Ctxt.Var Γ t → Ctxt.Var (Ctxt.snoc Γ t') t 

-- axiom Ctxt.append : Ctxt → Ctxt → Ctxt

-- axiom Ctxt.append_empty (Γ : Ctxt) : Ctxt.append Γ ∅ = Γ

-- axiom Ctxt.append_snoc (Γ Γ' : Ctxt) (t : Ty) : 
--   Ctxt.append Γ (Ctxt.snoc Γ' t) = (Γ.append Γ').snoc t

-- axiom Ctxt.Var.inl {Γ Γ' : Ctxt} {t : Ty} (v : Var Γ t) : 
--   Var (Ctxt.append Γ Γ') t

-- axiom Ctxt.Var.inr {Γ Γ' : Ctxt} {t : Ty} (v : Var Γ' t) :
--   Var (Ctxt.append Γ Γ') t

/-- This is an induction principle that case splits on whether or not a variable 
is the last variable in a context. -/
@[elab_as_elim]
axiom Ctxt.Var.casesOn 
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t t' : Ty} (v : (Γ.snoc t').Var t)
    (toSnoc : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      motive Γ t t' v

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to the last variable -/
@[simp]
axiom Ctxt.Var.casesOn_last
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t : Ty}
    (toSnoc : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
    Ctxt.Var.casesOn (motive := motive)
        (Ctxt.Var.last Γ t) toSnoc last = last

/-- `Ctxt.Var.casesOn` behaves in the expected way when applied to a previous variable,
that is not the last one. -/
@[simp]
axiom Ctxt.Var.casesOn_toSnoc 
    {motive : (Γ : Ctxt) → (t t' : Ty) → Ctxt.Var (Γ.snoc t') t → Sort _}
    {Γ : Ctxt} {t t' : Ty} (v : Γ.Var t)
    (toSnoc : {t t' : Ty} → 
        {Γ : Ctxt} → (v : Γ.Var t) → motive Γ t t' v.toSnoc)
    (last : {Γ : Ctxt} → {t : Ty} → motive Γ t t (Ctxt.Var.last _ _)) :
      Ctxt.Var.casesOn (motive := motive) (Ctxt.Var.toSnoc (t' := t') v) toSnoc last = toSnoc v

theorem toSnoc_injective {Γ : Ctxt} {t t' : Ty} : 
    Function.Injective (@Ctxt.Var.toSnoc Γ t t') := by
  let ofSnoc : (Γ.snoc t').Var t → Option (Γ.Var t) :=
    fun v => Ctxt.Var.casesOn v some none
  intro x y h
  simpa using congr_arg ofSnoc h
  

-- axiom Ctxt.Var.appendCasesOn 
--     {motive : (Γ Γ' : Ctxt) → (t : Ty) → (Γ.append Γ').Var t → Sort _}
--     {Γ Γ' : Ctxt} {t : Ty} (v : (Γ.append Γ').Var t)
--     (inl : {Γ Γ' : Ctxt} → (v : Γ.Var t) → motive Γ Γ' t v.inl)
--     (inr : {Γ Γ' : Ctxt} → (v : Γ'.Var t) → motive Γ Γ' t v.inr) :
--       motive Γ Γ' t v

-- @[simp]
-- axiom Ctxt.Var.appendCasesOn_inl
--     {motive : (Γ Γ' : Ctxt) → (t : Ty) → (Γ.append Γ').Var t → Sort _}
--     {Γ Γ' : Ctxt} {t : Ty} (v : Γ.Var t)
--     (inl : {Γ Γ' : Ctxt} → (v : Γ.Var t) → motive Γ Γ' t v.inl)
--     (inr : {Γ Γ' : Ctxt} → (v : Γ'.Var t) → motive Γ Γ' t v.inr) :
--     Ctxt.Var.appendCasesOn (motive := motive)
--        (v.inl : (Γ.append Γ').Var t) inl inr = inl v

-- @[simp]
-- axiom Ctxt.Var.appendCasesOn_inr
--     {motive : (Γ Γ' : Ctxt) → (t : Ty) → (Γ.append Γ').Var t → Sort _}
--     {Γ Γ' : Ctxt} {t : Ty} (v : Γ'.Var t)
--     (inl : {Γ Γ' : Ctxt} → (v : Γ.Var t) → motive Γ Γ' t v.inl)
--     (inr : {Γ Γ' : Ctxt} → (v : Γ'.Var t) → motive Γ Γ' t v.inr) :
--     Ctxt.Var.appendCasesOn (motive := motive)
--        (v.inr : (Γ.append Γ').Var t) inl inr = inr v

instance {Γ : Ctxt} : Coe (Γ.Var t) ((Γ.snoc t').Var t) := ⟨Ctxt.Var.toSnoc⟩

/-- A semantics for a context. Provide a way to evaluate every variable in a context. -/
def Ctxt.Sem (Γ : Ctxt) : Type :=
  ⦃t : Ty⦄ → Γ.Var t → t.toType    

instance : Inhabited (Ctxt.Sem ∅) := ⟨fun _ v => v.emptyElim⟩ 

/-- Make a semantics for `Γ.snoc t` from a semantics for `Γ` and an element of `t.toType`. -/
def Ctxt.Sem.snoc {Γ : Ctxt} {t : Ty} (s : Γ.Sem) (x : t.toType) : 
    (Γ.snoc t).Sem := by
  intro t' v
  revert s x
  refine Ctxt.Var.casesOn v ?_ ?_
  . intro _ _ _ v s _; exact s v
  . intro _ _ _ x; exact x

@[simp]
theorem Ctxt.Sem.snoc_last {Γ : Ctxt} {t : Ty} (s : Γ.Sem) (x : t.toType) : 
    (s.snoc x) (Ctxt.Var.last _ _) = x := by 
  simp [Ctxt.Sem.snoc]

@[simp]
theorem Ctxt.Sem.snoc_toSnoc {Γ : Ctxt} {t t' : Ty} (s : Γ.Sem) (x : t.toType) 
    (v : Γ.Var t') : (s.snoc x) v.toSnoc = s v := by
  simp [Ctxt.Sem.snoc]

/-- Given a change of variables map from `Γ` to `Γ'`, extend it to 
a map `Γ.snoc t` to `Γ'.snoc t` -/
@[simp] 
def Ctxt.Var.snocMap {Γ Γ' : Ctxt} {t : Ty}
    (f : (t : Ty) → Γ.Var t → Γ'.Var t) :
    (t' : Ty) → (Γ.snoc t).Var t' → (Γ'.snoc t).Var t' :=
  fun _ v => Ctxt.Var.casesOn v (fun v f => (f _ v).toSnoc) 
    (fun _ => Ctxt.Var.last _ _) f

abbrev Ctxt.hom (Γ Γ' : Ctxt) := ⦃t : Ty⦄ → Γ.Var t → Γ'.Var t

/-- A very simple intrinsically typed expression. -/
inductive IExpr : Ctxt → Ty → Type
  | add (a b : Γ.Var .nat) : IExpr Γ .nat
  /-- Nat literals. -/
  | nat (n : Nat) : IExpr Γ .nat

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive ICom : Ctxt →  Ty → Type where
  | ret {Γ : Ctxt} : Γ.Var t → ICom Γ t
  | lete (e : IExpr Γ α) (body : ICom (Γ.snoc α) β) : ICom Γ β

inductive ExprRec (Γ : Ctxt) : Ty → Type where
  | cst (n : Nat) : ExprRec Γ .nat
  | add (a : ExprRec Γ .nat) (b : ExprRec Γ .nat) : ExprRec Γ .nat
  | var (v : Γ.Var t) : ExprRec Γ t
  deriving DecidableEq

/-- `Lets Γ₁ Γ₂` is a sequence of lets which are well-formed under context `Γ₂` and result in 
    context `Γ₁`-/
inductive Lets : Ctxt → Ctxt → Type where
  | nil {Γ : Ctxt} : Lets Γ Γ
  | lete (body : Lets Γ₁ Γ₂) (e : IExpr Γ₂ t) : Lets Γ₁ (Γ₂.snoc t)

-- A simple first program
-- Observation: without the type annotation, we accumulate an exponentially large tree of nested contexts and `List.get`s.
-- By repeatedly referring to the last variable in the context, we force proof (time)s to grow linearly, resulting in
-- overall quadratic elaboration times.
-- def ex : ICom Array.empty .nat :=
--   ICom.let (.nat 0) <|
--   ICom.let (α := .nat) (.add ⟨⟨0, by decide⟩, by decide⟩ ⟨⟨0, by decide⟩, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨1, by decide⟩ ⟨1, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨2, by decide⟩ ⟨2, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨3, by decide⟩ ⟨3, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨4, by decide⟩ ⟨4, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨5, by decide⟩ ⟨5, by decide⟩) <|
--   ICom.ret (.add ⟨0, by decide⟩ ⟨0, by decide⟩)

def IExpr.denote : IExpr Γ ty → (Γs : Γ.Sem) → ty.toType
  | .nat n, _ => n
  | .add a b, ll => ll a + ll b

def ICom.denote : ICom Γ ty → (ll : Γ.Sem) → ty.toType
  | .ret e, l => l e
  | .lete e body, l => body.denote (l.snoc (e.denote l))

def ExprRec.denote : ExprRec Γ ty → (ll : Γ.Sem) → ty.toType
  | .cst n, _ => n
  | .add a b, ll => a.denote ll + b.denote ll
  | .var v, ll => ll v

def Lets.denote : Lets Γ₁ Γ₂ → Γ₁.Sem → Γ₂.Sem 
  | .nil => id
  | .lete e body => fun ll t v => by
    cases v using Ctxt.Var.casesOn with
    | last => 
      apply body.denote
      apply e.denote
      exact ll
    | toSnoc v =>
      exact e.denote ll v

def IExpr.changeVars (varsMap : (t : Ty) → Γ.Var t → Γ'.Var t) : 
    (e : IExpr Γ ty) → IExpr Γ' ty
  | .nat n => .nat n
  | .add a b => .add (varsMap _ a) (varsMap _ b)

@[simp]
theorem IExpr.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : Γ.hom Γ')
    (e : IExpr Γ ty)
    (ll : Γ'.Sem) : 
    (e.changeVars varsMap).denote ll = 
    e.denote (fun t v => ll (varsMap v)) := by
  induction e generalizing ll <;> simp 
    [IExpr.denote, IExpr.changeVars, *]

def ICom.changeVars 
    (varsMap : Γ.hom Γ') : 
    ICom Γ ty → ICom Γ' ty
  | .ret e => .ret (varsMap e)
  | .lete e body => .lete (e.changeVars varsMap) 
      (body.changeVars (fun t v => v.snocMap varsMap))

@[simp]
theorem ICom.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : Γ.hom Γ') (c : ICom Γ ty)
    (ll : Γ'.Sem) : 
    (c.changeVars varsMap).denote ll = 
    c.denote (fun t v => ll (varsMap v)) := by
  induction c generalizing ll Γ' with
  | ret x => simp [ICom.denote, ICom.changeVars, *]
  | lete _ _ ih => 
    rw [changeVars, denote, ih]
    simp only [Ctxt.Sem.snoc, Ctxt.Var.snocMap, IExpr.denote_changeVars, denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn
    . simp
    . simp
 
-- Find a let somewhere in the program. Replace that let with
-- a sequence of lets each of which might refer to higher up variables.

/-- Append two programs, while substituiting a free variable in the ssecond for 
the output of the first -/
def addProgramAtTop {Γ Γ' : Ctxt} (v : Γ'.Var t₁)
    (map : Γ.hom Γ') :
    (rhs : ICom Γ t₁) → (inputProg : ICom Γ' t₂) → ICom Γ' t₂
  | .ret e, inputProg => inputProg.changeVars 
      (fun t' v' => 
        if h : ∃ h : t₁ = t', h ▸ v = v' 
        then h.fst ▸ map e
        else v')
  | .lete e body, inputProg => 
      let newBody := addProgramAtTop v.toSnoc
        (fun _ v => Ctxt.Var.snocMap map _ v)
        body 
        -- This is the identity function if vars are debruijn indices
        (inputProg.changeVars (fun _ v => v.toSnoc))
      .lete (e.changeVars map) newBody
      
theorem denote_addProgramAtTop {Γ Γ' : Ctxt} (v : Γ'.Var t₁)
    (map : Γ.hom Γ') (s : Γ'.Sem) :
    (rhs : ICom Γ t₁) → (inputProg : ICom Γ' t₂) → 
    (addProgramAtTop v map rhs inputProg).denote s =
      inputProg.denote (fun t' v' => 
        if h : ∃ h : t₁ = t', h ▸ v = v' 
        then h.fst ▸ rhs.denote (fun t' v' => s (map v'))
        else s v')
  | .ret e, inputProg => by
    simp only [addProgramAtTop, ICom.denote_changeVars, ICom.denote]
    congr
    funext t' v'
    split_ifs with h
    . rcases h with ⟨rfl, _⟩
      simp
    . rfl   
  | .lete e body, inputProg => by
    simp only [ICom.denote, IExpr.denote_changeVars]
    rw [denote_addProgramAtTop _ _ _ body]
    simp [ICom.denote_changeVars, Ctxt.Sem.snoc_toSnoc]
    congr
    funext t' v'
    by_cases h : ∃ h : t₁ = t', h ▸ v = v'
    . rcases h with ⟨rfl, h⟩
      dsimp at h
      simp [h]
      congr
      funext t'' v''
      cases v'' using Ctxt.Var.casesOn
      . simp [Ctxt.Sem.snoc, Ctxt.Var.snocMap]
      . simp [Ctxt.Sem.snoc, Ctxt.Var.snocMap]
    . rw [dif_neg h, dif_neg]
      rintro ⟨rfl, h'⟩ 
      simp only [toSnoc_injective.eq_iff] at h'
      exact h ⟨rfl, h'⟩  

def addLetsAtTop {Γ₁ Γ₂ : Ctxt} :
    (lets : Lets Γ₁ Γ₂) → (inputProg : ICom Γ₂ t₂) → ICom Γ₁ t₂
  | Lets.nil, inputProg => inputProg
  | Lets.lete body e, inputProg => 
    addLetsAtTop body (.lete e inputProg)

theorem denote_addLetsAtTop {Γ₁ Γ₂ : Ctxt} :
    (lets : Lets Γ₁ Γ₂) → (inputProg : ICom Γ₂ t₂) →
    (addLetsAtTop lets inputProg).denote = 
      inputProg.denote ∘ lets.denote
  | Lets.nil, inputProg => rfl
  | Lets.lete body e, inputProg => by
    rw [addLetsAtTop, denote_addLetsAtTop body]
    funext
    simp [ICom.denote, Function.comp_apply, Lets.denote,
      Ctxt.Sem.snoc]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn
    . simp
    . simp

def addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt} (v : Γ₂.Var t₁)
    (map : Γ₃.hom Γ₂) 
    (l : Lets Γ₁ Γ₂) (rhs : ICom Γ₃ t₁) 
    (inputProg : ICom Γ₂ t₂) : ICom Γ₁ t₂ :=
  addLetsAtTop l (addProgramAtTop v map rhs inputProg)

theorem denote_addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt} 
    (v : Γ₂.Var t₁) (s : Γ₁.Sem)
    (map : Γ₃.hom Γ₂) 
    (l : Lets Γ₁ Γ₂) (rhs : ICom Γ₃ t₁)
    (inputProg : ICom Γ₂ t₂) :
    (addProgramInMiddle v map l rhs inputProg).denote s =
      inputProg.denote (fun t' v' => 
        let s' := l.denote s
        if h : ∃ h : t₁ = t', h ▸ v = v' 
        then h.fst ▸ rhs.denote (fun t' v' => s' (map v'))
        else s' v') := by
  rw [addProgramInMiddle, denote_addLetsAtTop, Function.comp_apply, 
    denote_addProgramAtTop]

def ExprRec.bind {Γ₁ Γ₂ : Ctxt} 
    (f : (t : Ty) → Γ₁.Var t → ExprRec Γ₂ t) : 
    (e : ExprRec Γ₁ t) → ExprRec Γ₂ t
  | .var v => f _ v
  | .cst n => .cst n
  | .add e₁ e₂ => .add (bind f e₁) (bind f e₂)

theorem ExprRec.denote_bind {Γ₁ Γ₂ : Ctxt} (s : Γ₂.Sem) 
    (f : (t : Ty) → Γ₁.Var t → ExprRec Γ₂ t) :
    (e : ExprRec Γ₁ t) → (e.bind f).denote s = 
      e.denote (fun t' v' => (f t' v').denote s)
  | .var v => by simp [bind, denote]
  | .cst n => by simp [bind, denote]
  | .add e₁ e₂ => by
    simp only [ExprRec.denote, bind]
    rw [denote_bind _ _ e₁, denote_bind _ _ e₂]

def IExpr.toExprRec : {Γ : Ctxt} → {t : Ty} → IExpr Γ t → ExprRec Γ t
  | _, _, .nat n => .cst n
  | _, _, .add e₁ e₂ => .add (.var e₁) (.var e₂)

def ICom.toExprRec : {Γ : Ctxt} → {t : Ty} → ICom Γ t → ExprRec Γ t
  | _, _, .ret e => .var e
  | _, _, .lete e body => 
    let e' := e.toExprRec
    body.toExprRec.bind 
    (fun t v => by
      cases v using Ctxt.Var.casesOn with
      | toSnoc v => exact .var v
      | last => exact e')

theorem IExpr.denote_toExprRec : {Γ : Ctxt} → {t : Ty} → 
    (s : Γ.Sem) → (e : IExpr Γ t) → 
    e.toExprRec.denote s = e.denote s
  | _, _, _, .nat n => by simp [IExpr.toExprRec, IExpr.denote, ExprRec.denote]
  | _, _, s, .add e₁ e₂ => by
    simp only [IExpr.toExprRec, IExpr.denote, ExprRec.denote]

theorem ICom.denote_toExprRec : {Γ : Ctxt} → {t : Ty} → 
    (s : Γ.Sem) → (c : ICom Γ t) → 
    c.toExprRec.denote s = c.denote s
  | _, _, _, .ret e => by simp [ICom.toExprRec, ICom.denote, ExprRec.denote]
  | _, _, s, .lete e body => by
    simp only [ICom.toExprRec, ICom.denote, ExprRec.denote,
      IExpr.denote_toExprRec, ExprRec.denote_bind]
    rw [ICom.denote_toExprRec _ body]
    congr
    funext t' v'
    cases v' using Ctxt.Var.casesOn
    . simp [ExprRec.denote]
    . simp [IExpr.denote_toExprRec]

-- def matchVar (lets : Lets) (varPos: Nat) (matchExpr: ExprRec) (mapping: Mapping := []): Option Mapping :=
--   match matchExpr with
--   | .var x => match mapping.lookup x with
--     | some varPos' => if varPos = varPos' then (x, varPos)::mapping else none
--     | none => (x, varPos)::mapping
--   | .cst n => match lets[varPos]! with
--     | .cst n' => if n = n' then some mapping else none
--     | _ => none
--   | .add a' b' =>
--     match lets[varPos]! with
--     | .add a b => do
--         let mapping ← matchVar lets (getPos a varPos) a' mapping
--         matchVar lets (getPos b varPos) b' mapping
--     | _ => none

def Lets.getVar : {Γ₁ Γ₂ : Ctxt} → (lets : Lets Γ₁ Γ₂) → {t : Ty} →
    (v : Γ₂.Var t) → Option ((Γ₃ : Ctxt) × Lets Γ₁ (Γ₃.snoc t) × 
      ((t' : Ty) → (Γ₃.snoc t).Var t' → Γ₂.Var t'))
  | _, _, .nil, _, _ => none
  | _, _, lets@(.lete body _), _, v => by
    cases v using Ctxt.Var.casesOn with
    | last => exact some ⟨_, lets, fun t v => v⟩ 
    | toSnoc v => exact do
      let g ← getVar body v
      some ⟨g.1, g.2.1, fun t v => g.2.2 t v⟩

def Lets.getExpr : {Γ₁ Γ₂ : Ctxt} → (lets : Lets Γ₁ Γ₂) → {t : Ty} →
    (v : Γ₂.Var t) → Option (IExpr Γ₂ t) 
  | _, _, .nil, _, _ => none
  | _, _, .lete lets e, _, v => by
    cases v using Ctxt.Var.casesOn with
    | toSnoc v => 
      exact (Lets.getExpr lets v).map 
        (IExpr.changeVars (fun _ => Ctxt.Var.toSnoc))
    | last => exact some <| e.changeVars (fun _ => Ctxt.Var.toSnoc)

theorem Lets.denote_getExpr : {Γ₁ Γ₂ : Ctxt} → (lets : Lets Γ₁ Γ₂) → {t : Ty} → 
    (v : Γ₂.Var t) → (e : IExpr Γ₂ t) → (he : e ∈ lets.getExpr v) → (s : Γ₁.Sem) →
    e.denote (lets.denote s) = (lets.denote s) v 
  | _, _, .nil, t, v, e, he, s => by simp [Lets.getExpr] at he
  | _, _, .lete lets e, _, v, e', he, s => by
    cases v using Ctxt.Var.casesOn with
    | toSnoc v => 
      simp only [getExpr, eq_rec_constant, Ctxt.Var.casesOn_toSnoc, 
        Option.mem_def, Option.map_eq_some'] at he
      cases' he with a ha
      cases' ha with ha ha'
      subst ha'
      simp only [denote, eq_rec_constant, IExpr.denote_changeVars, 
        Ctxt.Var.casesOn_toSnoc]
      rw [denote_getExpr lets _ _ ha s]
    | last => 
      simp [getExpr] at he
      subst he
      simp [Lets.denote]

abbrev Mapping (Γ Δ : Ctxt) : Type :=
  @AList (Σ t, Γ.Var t) (fun x => Δ.Var x.1)

def Mapping.hNew {Γ Δ : Ctxt} (v₁ : Γ.Var t₁) (v₂ : Δ.Var t₂) : 
    Option (Mapping Γ Δ) := 
  if h₁ : t₁ = t₂
  then some <| AList.singleton ⟨_, h₁ ▸ v₁⟩ v₂   
  else none

def Mapping.merge {Γ Δ : Ctxt} (m₁ m₂ : Mapping Γ Δ) : Option (Mapping Γ Δ) := 
  m₁.foldl (fun m t v => do
    let m ← m 
    match m.lookup t with
    | some v' => if v = v' then some m else none
    | none => some <| m.insert t v
    ) m₂

def Mapping.changeVarsRight {Γ Δ₁ Δ₂ : Ctxt}
    (m : Mapping Γ Δ₁) (f : Δ₁.hom Δ₂) : Mapping Γ Δ₂ :=
  ⟨m.1.map (fun x => ⟨x.1, f x.2⟩), by
    rw [List.NodupKeys, List.keys, List.map_map]
    exact m.2⟩       

-- def matchVar' : {Γ₁ Γ₂ Γ₃ Γ₄ : Ctxt} → (lets : Lets Γ₁ Γ₂) → 
--     (map : Γ₂.hom Γ₄)  →
--     (matchExpr : ExprRec Γ₃ t) → Option (Mapping Γ₃ Γ₄)
--   | _, _, _, _, .nil, _, _ => none
--   | Γ₁, _, Γ₃, Γ₄, .lete lets e, map, matchExpr => 
--     match matchExpr, e with
--     | .var v, _ => 
--         Mapping.hNew v (map (Ctxt.Var.last _ _))
--     | .cst n, .nat m =>
--         if n = m then some ∅ 
--         else none
--     | .add lhs rhs, .add v₁ v₂ => do
--         /-
--           Sketch: to match `lhs`, we drop just enough variables from `lets` so that the 
--           declaration corresponding to `v₁` is at the head. Then, we recursively call 
--           `matchVar'` again.
--         -/
--         let ⟨_, lets₁, embed₁⟩ ← lets.getVar v₁
--         let map₁ ← matchVar' lets₁ (fun t v => map (embed₁ t v)) lhs

--         let ⟨_, lets₂, embed₂⟩ ← lets.getVar v₂
--         let map₂ ← matchVar' lets₂ (fun t v => map (embed₂ t v)) rhs

--         map₁.merge map₂
--     | _, _ => none

def matchVar {Γ₁ Γ₂ Γ₃ : Ctxt} (lets : Lets Γ₁ Γ₂) 
    {t : Ty} (v : Γ₂.Var t) 
    (matchExpr : ExprRec Γ₃ t) : Option (Mapping Γ₃ Γ₂) := do
  match matchExpr, lets.getExpr v with
  | .var v', _ => Mapping.hNew v' v
  | .cst n, some (.nat m) =>
      if n = m then some ∅ 
      else none
  | .add lhs rhs, some (.add v₁ v₂) => 
      /-
        Sketch: to match `lhs`, we drop just enough variables from `lets` so that the 
        declaration corresponding to `v₁` is at the head. Then, we recursively call 
        `matchVar'` again.
      -/
      --let ⟨_, lets₁, embed₁⟩ ← lets.getVar v₁
      let map₁ ← matchVar lets v₁ lhs
      let map₂ ← matchVar lets v₂ rhs

      map₁.merge map₂
  | _, _ => none

instance (t : Ty) : Inhabited t.toType := by
  cases t <;> dsimp [Ty.toType] <;> infer_instance

theorem denote_matchVar : {Γ₁ Γ₂ Γ₃ : Ctxt} → (lets : Lets Γ₁ Γ₂) → 
    {t : Ty} → (v : Γ₂.Var t) → 
    (varMap : Mapping Γ₃ Γ₂) → (s₁ : Γ₁.Sem) → 
    (matchExpr : ExprRec Γ₃ t) → 
    (h : varMap ∈ matchVar lets v matchExpr) →
    matchExpr.denote (fun t' v' => by
        match varMap.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default 
        ) = 
      lets.denote s₁ v
  | Γ₁, _, Γ₃, lets, t, v, varMap, s₁, matchExpr, h => by
    cases matchExpr with
    | var v' => 
      simp [matchVar, Mapping.hNew] at h
      subst h
      simp [ExprRec.denote, AList.lookup]
    | cst n => 
      rw [ExprRec.denote]
      unfold matchVar at h
      cases hl : Lets.getExpr lets v with
      | none => simp [hl] at h
      | some e => 
        cases e with
        | nat m => 
          simp [hl] at h
          rw [← Lets.denote_getExpr _ _ _ hl]
          simp [IExpr.denote]
          split_ifs at h <;> simp_all
        | add v₁ v₂ => simp [hl] at h
    | add lhs rhs =>
      rw [ExprRec.denote]
      unfold matchVar at h
      cases hl : Lets.getExpr lets v with
      | none => simp [hl] at h
      | some e => 
        cases e with
        | nat m => simp [hl] at h
        | add v₁ v₂ => 
          simp [hl] at h
          rw [← Lets.denote_getExpr _ _ _ hl]
          simp [IExpr.denote]
          cases h₁ : matchVar lets v₁ lhs with
          | none => simp [h₁, bind] at h
          | some m₁ => 
            cases h₂ : matchVar lets v₂ rhs with
            | none => simp [h₂, bind] at h
            | some m₂ => 
              simp [h₁, h₂, bind] at h
              have ih₁ := denote_matchVar lets v₁ m₁ s₁ lhs h₁
              have ih₂ := denote_matchVar lets v₂ m₂ s₁ rhs h₂
              rw [← ih₁, ← ih₂]
              congr
              
 



#exit

-- let's automate
macro "mk_lets" n:num init:term : term =>
  n.getNat.foldRevM (fun n stx => `(ICom.let (α := .nat) (.nat ⟨$(Lean.quote n), by decide⟩) $stx)) init

macro "mk_com" n:num : term =>
`(show ICom [] .nat from
  ICom.let (.nat 0) <|
  mk_lets $n
  ICom.ret (.var ⟨0, by decide⟩))

macro "mk_ex" n:num : command =>
`(theorem t : ICom [] .nat :=
  mk_com $n)


-- type checking took 146ms
-- elaboration took 327ms
-- mk_ex 50
-- type checking took 574ms
-- elaboration took 1.41s
-- mk_ex 100
-- type checking took 911ms
-- elaboration took 2.26s
-- mk_ex 120

-- Clearly not linear!

-- Apart from proving transformations of specific (sub)programs, we are also interested in applying such
-- verified transformations to larger programs parsed at run time.

-- /-- An untyped expression as an intermediate step of input processing. -/

-- structure Absolute where
--   v : Nat
--   deriving Repr, Inhabited, DecidableEq

-- def Absolute.ofNat (n: Nat) : Absolute :=
--   {v := n}

-- instance : OfNat Absolute n where
--   ofNat := Absolute.ofNat n

-- abbrev VarRel := Nat

-- def formatVarRel : VarRel → Nat → Std.Format
--   | x, _ => repr x

-- instance : Repr VarRel where
--   reprPrec :=  formatVarRel

-- def VarRel.ofNat (n: Nat) : VarRel :=
--   n

-- instance : OfNat VarRel n where
-- --   ofNat := VarRel.ofNat n

-- inductive Expr : Type
--   | cst (n : Nat)
--   | add (a : VarRel) (b : VarRel)
--   deriving Repr, Inhabited, DecidableEq

-- abbrev LeafVar := Nat

-- inductive ExprRec : Type
--   | cst (n : Nat)
--   | add (a : ExprRec) (b : ExprRec)
--   | var (idx : LeafVar)
--   deriving Repr, Inhabited, DecidableEq

-- inductive RegTmp : Type
--   | concreteRegion (c : Com)
--   | regionVar (n : Nat)

-- /-- An untyped command; types are always given as in MLIR. -/
-- inductive Com : Type where
--   | let (ty : Ty) (e : Expr) (body : Com): Com
--   | ret (e : VarRel) : Com
--   deriving Repr, Inhabited, DecidableEq

-- def ex' : Com :=
--   Com.let .nat (.cst 0) <|
--   Com.let .nat (.add 0 0) <|
--   Com.let .nat (.add 1 0) <|
--   Com.let .nat (.add 2 0) <|
--   Com.let .nat (.add 3 3) <|
--   Com.let .nat (.add 4 4) <|
--   Com.let .nat (.add 5 5) <|
--   Com.ret 0

-- open Lean in

-- def formatCom : Com → Nat → Std.Format
--   | .ret v, _=> "  .ret " ++ (repr v)
--   | .let ty e body, n=> "  .let " ++ (repr ty) ++ " " ++ (repr e) ++ " <|\n" ++ (formatCom body n)

-- instance : Repr Com where
--   reprPrec :=  formatCom

-- abbrev Mapping := List (LeafVar × Nat)
-- abbrev Lets := List Expr

-- def ex0 : Com :=
--   Com.let .nat (.cst 0) <|
--   Com.let .nat (.add 0 0) <|
--   Com.let .nat (.add 1 0) <|
--   Com.let .nat (.add 2 0) <|
--   Com.let .nat (.add 3 0) <|
--   Com.ret 0

-- def getPos (v : VarRel) (currentPos: Nat) : Nat :=
--   v + currentPos + 1

/-- Apply `matchExpr` on a sequence of `lets` and return a `mapping` from
free variables to their absolute position in the lets array.
-/
-- def matchVar (lets : Lets) (varPos: Nat) (matchExpr: ExprRec) (mapping: Mapping := []): Option Mapping :=
--   match matchExpr with
--   | .var x => match mapping.lookup x with
--     | some varPos' => if varPos = varPos' then (x, varPos)::mapping else none
--     | none => (x, varPos)::mapping
--   | .cst n => match lets[varPos]! with
--     | .cst n' => if n = n' then some mapping else none
--     | _ => none
--   | .add a' b' =>
--     match lets[varPos]! with
--     | .add a b => do
--         let mapping ← matchVar lets (getPos a varPos) a' mapping
--         matchVar lets (getPos b varPos) b' mapping
--     | _ => none

-- example: matchVar [.add 2 0, .add 1 0, .add 0 0, .cst 1] 0
--          (.add (.var 0) (.add (.var 1) (.var 2))) =
--   some [(2, 2), (1, 3), (0, 3)]:= rfl

def getVarAfterMapping (var : LeafVar) (lets : Lets) (m : Mapping) (inputLets : Nat) : Nat :=
 match m with
 | x :: xs => if var = x.1 then
                 x.2 + (lets.length - inputLets)
              else
                 getVarAfterMapping var lets xs inputLets
 | _ => panic! "var should be in mapping"

def getRel (v : Nat) (array: List Expr): VarRel :=
  VarRel.ofNat (array.length - v - 1)

def applyMapping  (pattern : ExprRec) (m : Mapping) (lets : Lets) (inputLets : Nat := lets.length): (Lets × Nat) :=
match pattern with
    | .var v =>
      (lets, getVarAfterMapping v lets m inputLets)
    | .add a b =>
      let res := applyMapping a m lets inputLets
      let res2 := applyMapping b m (res.1) inputLets
      let l := VarRel.ofNat (res.2 + (res2.1.length - res.1.length))
      let r := VarRel.ofNat res2.2
      ((Expr.add l r) :: res2.1, 0)
    | .cst n => ((.cst n) :: lets, 0)

/-- shift variables after `pos` by `delta` -/
def shiftVarBy (v : VarRel) (delta : ℕ) (pos : ℕ) : VarRel :=
    if v >= pos then
      VarRel.ofNat (v + delta)
    else
      v

def Expr.changeVars (f : VarRel → VarRel) (e : Expr) : Expr :=
  match e with
  | .add a b => .add (f a) (f b)
  | .cst x => (.cst x)

/-- shift variables after `pos` by `delta` in expr -/
def shiftExprBy (e : Expr) (delta : ℕ) (pos : ℕ) : Expr :=
 match e with
    | .add a b => .add (shiftVarBy a delta pos) (shiftVarBy b delta pos)
    | .cst x => (.cst x)

def Com.changeVars (f : VarRel → VarRel) (c : Com) : Com :=
  match c with
  | .ret x => .ret (f x)
  | .let ty e body => .let ty (e.changeVars f) (body.changeVars f)

/-- shift variables after `pos` by `delta` in com -/
def shiftComBy (inputProg : Com) (delta : ℕ) (pos : ℕ := 0): Com :=
  match inputProg with
  | .ret x => .ret (shiftVarBy x delta (pos+1))
  | .let ty e body => .let ty (shiftExprBy e delta pos) (shiftComBy body delta (pos+1))

def VarRel.inc (v : VarRel) : VarRel :=
  v + 1

def replaceUsesOfVar (inputProg : Com) (old: VarRel) (new : VarRel) : Com :=
  let replace (v : VarRel) : VarRel :=
     if old = v then new else v
  match inputProg with
  | .ret x => .ret (replace x)
  | .let ty e body => match e with
    | .add a b =>
      .let ty (Expr.add (replace a) (replace b)) (replaceUsesOfVar body (old.inc) (new.inc))
    | .cst x => .let ty (.cst x) (replaceUsesOfVar body (old.inc) (new.inc))

def addLetsToProgram (newLets : Lets) (oldProgram : Com) : Com :=
  newLets.foldl (λ acc e => Com.let .nat e acc) oldProgram

/-- unfolding lemma for `addLetsToProgram` -/
theorem addLetsToProgram_cons (e : Expr) (ls : Lets) (c : Com) :
  addLetsToProgram (e :: ls) c = addLetsToProgram ls (Com.let .nat e c) := by {
    simp[addLetsToProgram]
}

/-- unfolding lemma for `addLetsToProgram` -/
theorem addLetsToProgram_snoc (e : Expr) (ls : Lets) (c : Com) :
  addLetsToProgram (List.concat ls e) c =
  Com.let .nat e (addLetsToProgram ls c) := by {
    simp[addLetsToProgram]
}

def applyRewrite (lets : Lets) (inputProg : Com) (rewrite: ExprRec × ExprRec) : Option Com := do
  let varPos := 0
  let mapping ← matchVar lets varPos rewrite.1
  let (newLets, newVar) := applyMapping (rewrite.2) mapping lets
  let newProgram := inputProg
  let newProgram := shiftComBy newProgram (newLets.length - lets.length)
  let newProgram := replaceUsesOfVar newProgram (VarRel.ofNat (newLets.length - lets.length)) (VarRel.ofNat (newVar))
  let newProgram := addLetsToProgram newLets newProgram

  some newProgram

def rewriteAt' (inputProg : Com) (depth : Nat) (lets: Lets) (rewrite: ExprRec × ExprRec) : Option Com :=
  match inputProg with
    | .ret _ => none
    | .let _ expr body =>
        let lets := expr :: lets
        if depth = 0 then
           applyRewrite lets body rewrite
        else
           rewriteAt' body (depth - 1) lets rewrite

def rewriteAt (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Option Com :=
    rewriteAt' inputProg depth [] rewrite

def rewrite (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Com :=
    let x := rewriteAt inputProg depth rewrite
    match x with
      | none => inputProg
      | some y => y

def getVal (s : State) (v : VarRel) : Nat :=
  get_nat (s.get! v)

def Expr.denote (e : Expr) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .add a b => .nat ((getVal s a) + (getVal s b))

def Com.denote (c : Com) (s : State) : Value :=
  match c with
    | .ret v => .nat (getVal s v)
    | .let _ e body => denote body (e.denote s :: s) -- introduce binder.

def denote (p: Com) : Value :=
  p.denote []

def Lets.denote (lets : Lets) (s : State := []): State :=
  List.foldr (λ v s => (v.denote s) :: s) s lets

structure ComFlat where
  lets : Lets -- sequence of let bindings.
  ret : VarRel -- return value.

def ComFlat.denote (prog: ComFlat) : Value :=
  let s := prog.lets.denote
  .nat (getVal s prog.ret)

def flatToTree (prog: ComFlat) : Com :=
  addLetsToProgram prog.lets (Com.ret prog.ret)

def ExprRec.denote (e : ExprRec) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .add a b => let a_val := get_nat (a.denote s)
                     let b_val := get_nat (b.denote s)
                     Value.nat (a_val + b_val)
    | .var v => s.get! v

theorem key_lemma :
    (addLetsToProgram lets xs).denote s = xs.denote (lets.denote s) := by
  induction lets generalizing xs <;> simp_all [addLetsToProgram, Com.denote, Lets.denote]

theorem denoteFlatDenoteTree : denote (flatToTree flat) = flat.denote := by
  unfold flatToTree denote; simp [key_lemma]; rfl



theorem denoteVar_shift_zero: (shiftVarBy v 0 pos) = v := by
  simp[shiftVarBy]
  intros _H
  simp[VarRel.ofNat]


theorem denoteExpr_shift_zero: Expr.denote (shiftExprBy e 0 pos) s = Expr.denote e s := by  {
  induction e
  case cst => {
    simp[Expr.denote, shiftExprBy]
  }
  case add => {
    simp[Expr.denote, shiftExprBy, denoteVar_shift_zero]
  }
}

theorem denoteCom_shift_zero: Com.denote (shiftComBy com 0 pos) s = Com.denote com s := by {
 revert pos s
 induction com;
 case ret => {
   simp[Com.denote, denoteVar_shift_zero]
 }
 case _ ty e body IH => {
   simp[Com.denote]
   simp[IH]
   simp[denoteExpr_shift_zero]
 }
}

/-
theorem denoteCom_shift_snoc :
  Com.denote (addLetsToProgram (List.concat ls e) c) σ =
  Com.denote (addLetsToProgram ls c) () := by {
}
-/

/-
theorem denoteCom_shift_cons :
  Com.denote (addLetsToProgram (List.concat ls e) c) σ =
  Com.denote (addLetsToProgram ls c) () := by {
}
-/

/-- @sid: this theorem statement is wrong. I need to think properly about what shift is saying.
Anyway, proof outline: prove a theorem that tells us how the index changes when we add a single let
binding. Push the `denote` through and then rewrite across the single index change. -/
theorem shifting :
    Com.denote (addLetsToProgram lets (shiftComBy p (lets.length))) s =
      Com.denote p s := by
  rw [addLetsToProgram]
  induction lets using List.reverseRecOn
  case H0 =>
    cases p <;> simp [shiftComBy, shiftExprBy, Com.denote]

  
      
#exit

theorem letsTheorem
 (matchExpr : ExprRec) (lets : Lets)
 (h1: matchVar lets pos matchExpr m₀ = some m)
 (hlets: lets.length > 0)
 (hm₀: denote (addLetsToProgram lets (Com.ret (VarRel.ofNat (lets.length - pos - 1) ))) =
       denote (addLetsToProgram (applyMapping matchExpr m₀ lets).1
              (Com.ret 0))):

   denote (addLetsToProgram (lets) (Com.ret (VarRel.ofNat (lets.length - pos - 1)))) =
   denote (addLetsToProgram (applyMapping matchExpr m lets).1 (Com.ret 0)) := by
      induction matchExpr generalizing m₀ m pos
      unfold applyMapping
      case cst n =>
        simp [applyMapping, hm₀]

      case add a b a_ih b_ih =>
        simp [matchVar] at h1
        split at h1
        case h_1 x avar bvar heq =>
          erw [Option.bind_eq_some] at h1; rcases h1 with ⟨m_intermediate, ⟨h1, h2⟩⟩
          have a_fold := a_ih h1
          have b_fold := b_ih h2
          rw [hm₀]
          dsimp [VarRel.ofNat]

          unfold applyMapping
          sorry

        case h_2 x x' =>
          contradiction

      case var idx =>
        simp [applyMapping, hm₀]


-- We probably need to know 'Com.denote body env' is well formed. We want to say that if
-- body succeeds at env, then it succeeds in a larger env.
-- Actually this is not even true, we need to shift body.
-- @grosser: since this theorem cannot be true, we see that denoteAddLetsToProgram
-- also cannot possibly be true.
theorem Com_denote_invariant_under_extension_false_theorem :
   Com.denote body s = Com.denote  body (v :: s) := by {
   revert s
   induction body;
   case ret => {
    intros env; simp[Com.denote];
    simp[getVal];
    sorry
   }
   case _ => sorry
}

theorem denoteAddLetsToProgram:
  denote (addLetsToProgram lets body) = denote (addLetsToProgram lets (Com.let ty e body)) := by
  simp[denote]
  simp[key_lemma (lets := lets) (xs := body)]
  simp[key_lemma]
  simp[Com.denote]
  generalize H : (Lets.denote lets) = env'
  -- we know that this theorem must be false, because it asserts that
  -- ⊢ Com.denote body env' = Com.denote body (Expr.denote e env' :: env')
  -- but this is absurd, because if body were a variable, we need to at least shift the
  -- variables in the RHS.
  sorry -- The statement is likely not complete enough to be proven.


theorem rewriteAtApplyRewriteCorrect
 (hpos: pos = 0) :
 rewriteAt' body pos lets rwExpr = applyRewrite (lets ++ [e]) body rwExpr := by
  sorry

theorem rewriteAtAppend:
  rewriteAt' body pos lets rwExpr = rewriteAt' body (pos - 1) (lets ++ [e]) rwExpr := sorry

theorem rewriteAtCorrect'
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt' p pos lets rwExpr = some p'):
  denote p' = denote (addLetsToProgram lets p) := by
  induction pos
  case zero =>
    unfold rewriteAt' at successful
    split at successful
    · contradiction
    · simp at successful
      rename_i inputProg ty e body
      sorry
  sorry



theorem rewriteAtCorrect
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt' p pos lets rwExpr = some p'):
  denote p' = denote (addLetsToProgram lets p) := by
  induction p
  case «let» ty e body body_ih =>
    unfold rewriteAt' at successful
    split at successful
    case inl hpos =>
      rw [body_ih]
      · rw [denoteAddLetsToProgram] --weak
      · rw [←successful]
        dsimp
        sorry
        -- rw [rewriteAtApplyRewriteCorrect] -- weak

    case inr hpos =>
      dsimp
      rw [body_ih]
      · rw [denoteAddLetsToProgram] -- weak
      · rw [←successful]
        dsimp
        simp at successful
        simp at body_ih
        simp_all
        unfold rewriteAt'
        simp
        cases body
        simp_all
        · simp_all
          sorry


        · simp_all
          contradiction
  case ret v =>
    unfold rewriteAt' at successful
    contradiction

theorem preservesSemantics
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s):
  denote (rewrite p pos rwExpr) = denote p := by
  unfold rewrite
  unfold rewriteAt
  simp
  split
  · rfl
  · rw [rewriteAtCorrect (successful := by assumption)]
    simp [addLetsToProgram]
    apply rewriteCorrect

def ex1 : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.ret 0

def ex2 : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 1 1) <|
  Com.let .nat (.add 1 1) <|
  Com.ret 0

/-
def ex22 : ComFlat :=
  { lets := #[
     (.cst 1),
     (.add 0 0),
     (.add 1 0),
     (.add 1 1),
     (.add 1 1)]
   , ret := 0 }

#eval ex22.denote = denote ex2
-/


/-
def prog_map_before : Com :=
  %0 := cst [0, 1, 2] : !list
  %1 := map %0 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      yield %l2
  })

  %2 := map %1 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      yield %l2
  })

def prog_map_after : Com :=
  %0 := cst [0, 1, 2] : !list
  %2 := map %0 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      %l3 = addi %l2, 1
      yield %l3
  })

def match_strip_mining := ExprRec.map (.map (.var 0) (.rgn 0)) (.rgn 1))

-/

theorem addLets: addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 0) = (
  Com.let .nat (Expr.cst 1) <|
  Com.let .nat (Expr.add 0 0) <|
  Com.ret 0) := rfl

theorem letsDenoteZero: Lets.denote [] = [] := rfl
theorem letsComDenoteZero: (addLetsToProgram [] (Com.ret 0)).denote [] = Value.nat 0 := rfl

theorem letsDenoteOne: Lets.denote [Expr.cst 0] [] = [Value.nat 0] := rfl
theorem letsComDenoteOne: (addLetsToProgram [Expr.cst 0] (Com.ret 0)).denote [] = Value.nat 0 := rfl

theorem letsDenoteTwo:
  Lets.denote [Expr.add 0 0, Expr.cst 1] [] = [Value.nat 2, Value.nat 1] := rfl

theorem letsComDenoteTwo:
  (addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 0)).denote [] = Value.nat 2 := by
  rfl
theorem letsComDenoteTwo':
  (addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 1)).denote [] = Value.nat 1 := by
  rfl

theorem letsDenoteThree:
  Lets.denote [Expr.cst 0, Expr.cst 1, Expr.cst 2] [] =
  [Value.nat 0, Value.nat 1, Value.nat 2] := rfl
theorem letsComDenoteThree:
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 0)).denote [] = Value.nat 0 := by
  rfl
theorem letsComDenoteThree':
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 1)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteThree'':
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 2)).denote [] = Value.nat 2 := by
  rfl

theorem letsDenoteFour:
  Lets.denote [Expr.add 0 1, Expr.cst 3, Expr.cst 5, Expr.cst 7] [] =
  [Value.nat 8, Value.nat 3, Value.nat 5, Value.nat 7] := rfl
theorem letsComDenoteFour:
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 0)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteFour':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 1)).denote [] = Value.nat 0 := by
  rfl
theorem letsComDenoteFour'':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 2)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteFour''':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 3)).denote [] = Value.nat 2 := by
  rfl

def lets1 : Lets := [Expr.cst 1]
theorem letsDenote1: (addLetsToProgram lets1 xs).denote [] = xs.denote (lets1.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets2 : Lets := [Expr.cst 1, Expr.cst 2]
theorem letsDenote2: (addLetsToProgram lets2 xs).denote [] = xs.denote (lets2.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets3 : Lets := [Expr.cst 1, Expr.cst 2, Expr.cst 3]
theorem letsDenote3: (addLetsToProgram lets3 xs).denote [] = xs.denote (lets3.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets4 : Lets := [Expr.cst 1, Expr.cst 2, Expr.cst 3, Expr.add 0 1]
theorem letsDenote4: (addLetsToProgram lets4 xs).denote [] = xs.denote (lets4.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

-- a + b => b + a
def m := ExprRec.add (.var 0) (.var 1)
def r := ExprRec.add (.var 1) (.var 0)

def lets := [Expr.add 2 0, .add 1 0 , .add 0 0, .cst 1]
def m2 := ExprRec.add (.var 0) (.add (.var 1) (.var 2))

theorem mv3:
  matchVar lets 3 m = none := rfl

theorem mv2:
  matchVar lets 2 m = some [(1, 3), (0, 3)]:= rfl

theorem mv1:
  matchVar lets 1 m = some [(1, 2), (0, 3)]:= rfl

theorem mv0:
  matchVar lets 0 m = some [(1, 1), (0, 3)]:= rfl

theorem mv23:
  matchVar lets 3 m2 = none := rfl

theorem mv22:
  matchVar lets 2 m2 = none := rfl

theorem mv21:
  matchVar lets 1 m2 =
  some [(2, 3), (1, 3), (0, 3)] := rfl

theorem mv20:
  matchVar lets 0 m2 =
  some [(2, 2), (1, 3), (0, 3)]:= rfl

def testRewrite (p : Com) (r : ExprRec) (pos : Nat) : Com :=
  let new := rewriteAt p pos (m, r)
  dbg_trace "# Before"
  dbg_trace repr p
  match new with
    | none => (Com.ret 0) -- Failure
    | some y =>
      dbg_trace ""
      dbg_trace "# After"
      dbg_trace repr y
      dbg_trace ""
      y

example : rewriteAt ex1 1 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)    <|
     .let Ty.nat (Expr.add 0 0)  <|
     .let Ty.nat (Expr.add 1 1)  <|
     .ret 0) := by rfl
example : denote ex1 = denote (testRewrite ex1 r 1) := by rfl

-- a + b => b + a

example : rewriteAt ex2 0 (m, r) = none := by rfl
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

example : rewriteAt ex2 1 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

example : rewriteAt ex2 2 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 2) <|
     .let Ty.nat (Expr.add 2 2) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 2) := by rfl

example : rewriteAt ex2 3 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 2) <|
     .let Ty.nat (Expr.add 2 2) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 3) := by rfl

example : rewriteAt ex2 4 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 2) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 4) := by rfl

def ex2' : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 1 1) <|
  Com.let .nat (.add 1 1) <|
  Com.ret 0

-- a + b => b + (0 + a)
def r2 := ExprRec.add (.var 1) (.add (.cst 0) (.var 0))

example : rewriteAt ex2 1 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 2) <|
     .let Ty.nat (Expr.add 3 0) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 1) := by rfl

example : rewriteAt ex2 2 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 3 0) <|
     .let Ty.nat (Expr.add 4 4) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 2) := by rfl

example : rewriteAt ex2 3 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 4 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 3) := by rfl

example : rewriteAt ex2 4 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 4) := by rfl

-- a + b => (0 + a) + b
def r3 := ExprRec.add (.add (.cst 0 ) (.var 0)) (.var 1)

example : rewriteAt ex2 1 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 2) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 1) := by rfl

example : rewriteAt ex2 2 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 4) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 2) := by rfl

example : rewriteAt ex2 3 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 4) <|
     .let Ty.nat (Expr.add 4 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 3) := by rfl

example : rewriteAt ex2 4 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 4) := by rfl
 