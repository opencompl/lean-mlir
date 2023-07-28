-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Experimental.ErasedContext
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Basic

/-- A very simple intrinsically typed expression. -/
inductive IExpr : Ctxt → Ty → Type
  | add (a b : Γ.Var .nat) : IExpr Γ .nat
  /-- Nat literals. -/
  | nat (n : Nat) : IExpr Γ .nat

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive ICom : Ctxt → Ty → Type where
  | ret (v : Γ.Var t) : ICom Γ t
  | lete (e : IExpr Γ α) (body : ICom (Γ.snoc α) β) : ICom Γ β

inductive ExprRec (Γ : Ctxt) : Ty → Type where
  | cst (n : Nat) : ExprRec Γ .nat
  | add (a : ExprRec Γ .nat) (b : ExprRec Γ .nat) : ExprRec Γ .nat
  | var (v : Γ.Var t) : ExprRec Γ t

/-- `Lets Γ₁ Γ₂` is a sequence of lets which are well-formed under context `Γ₂` and result in 
    context `Γ₁`-/
inductive Lets : Ctxt → Ctxt → Type where
  | nil {Γ : Ctxt} : Lets Γ Γ
  | lete (body : Lets Γ₁ Γ₂) (e : IExpr Γ₂ t) : Lets Γ₁ (Γ₂.snoc t)

def IExpr.denote : IExpr Γ ty → (Γs : Γ.Valuation) → ty.toType
  | .nat n, _ => n
  | .add a b, ll => ll a + ll b

def ICom.denote : ICom Γ ty → (ll : Γ.Valuation) → ty.toType
  | .ret e, l => l e
  | .lete e body, l => body.denote (l.snoc (e.denote l))

def ExprRec.denote : ExprRec Γ ty → (ll : Γ.Valuation) → ty.toType
  | .cst n, _ => n
  | .add a b, ll => a.denote ll + b.denote ll
  | .var v, ll => ll v

def Lets.denote : Lets Γ₁ Γ₂ → Γ₁.Valuation → Γ₂.Valuation 
  | .nil => id
  | .lete e body => fun ll t v => by
    cases v using Ctxt.Var.casesOn with
    | last => 
      apply body.denote
      apply e.denote
      exact ll
    | toSnoc v =>
      exact e.denote ll v

def IExpr.changeVars (varsMap : Γ.hom Γ') : 
    (e : IExpr Γ ty) → IExpr Γ' ty
  | .nat n => .nat n
  | .add a b => .add (varsMap a) (varsMap b)

@[simp]
theorem IExpr.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : Γ.hom Γ')
    (e : IExpr Γ ty)
    (ll : Γ'.Valuation) : 
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
    (ll : Γ'.Valuation) : 
    (c.changeVars varsMap).denote ll = 
    c.denote (fun t v => ll (varsMap v)) := by
  induction c generalizing ll Γ' with
  | ret x => simp [ICom.denote, ICom.changeVars, *]
  | lete _ _ ih => 
    rw [changeVars, denote, ih]
    simp only [Ctxt.Valuation.snoc, Ctxt.Var.snocMap, IExpr.denote_changeVars, denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn
    . simp
    . simp
 
-- Find a let somewhere in the program. Replace that let with
-- a sequence of lets each of which might refer to higher up variables.

/-- Append two programs, while substituting a free variable in the second for 
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
        (fun _ v => Ctxt.Var.snocMap map v)
        body 
        (inputProg.changeVars (fun _ v => v.toSnoc))
      .lete (e.changeVars map) newBody
      
theorem denote_addProgramAtTop {Γ Γ' : Ctxt} (v : Γ'.Var t₁)
    (map : Γ.hom Γ') (s : Γ'.Valuation) :
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
    simp [ICom.denote_changeVars, Ctxt.Valuation.snoc_toSnoc]
    congr
    funext t' v'
    by_cases h : ∃ h : t₁ = t', h ▸ v = v'
    . rcases h with ⟨rfl, h⟩
      dsimp at h
      simp [h]
      congr
      funext t'' v''
      cases v'' using Ctxt.Var.casesOn
      . simp [Ctxt.Valuation.snoc, Ctxt.Var.snocMap]
      . simp [Ctxt.Valuation.snoc, Ctxt.Var.snocMap]
    . rw [dif_neg h, dif_neg]
      rintro ⟨rfl, h'⟩ 
      simp only [Ctxt.toSnoc_injective.eq_iff] at h'
      exact h ⟨rfl, h'⟩  

/-- Add some `Lets` to the beginning of a program -/
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
      Ctxt.Valuation.snoc]
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
    (v : Γ₂.Var t₁) (s : Γ₁.Valuation)
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

theorem ExprRec.denote_bind {Γ₁ Γ₂ : Ctxt} (s : Γ₂.Valuation) 
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
    (s : Γ.Valuation) → (e : IExpr Γ t) → 
    e.toExprRec.denote s = e.denote s
  | _, _, _, .nat n => by simp [IExpr.toExprRec, IExpr.denote, ExprRec.denote]
  | _, _, s, .add e₁ e₂ => by
    simp only [IExpr.toExprRec, IExpr.denote, ExprRec.denote]

theorem ICom.denote_toExprRec : {Γ : Ctxt} → {t : Ty} → 
    (s : Γ.Valuation) → (c : ICom Γ t) → 
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

-- def Lets.getVar : {Γ₁ Γ₂ : Ctxt} → (lets : Lets Γ₁ Γ₂) → {t : Ty} →
--     (v : Γ₂.Var t) → Option ((Γ₃ : Ctxt) × Lets Γ₁ (Γ₃.snoc t) × 
--       (Γ₃.snoc t).hom Γ₂)
--   | _, _, .nil, _, _ => none
--   | _, _, lets@(.lete body _), _, v => by
--     cases v using Ctxt.Var.casesOn with
--     | last => exact some ⟨_, lets, fun t v => v⟩ 
--     | toSnoc v => exact do
--       let g ← getVar body v
--       some ⟨g.1, g.2.1, fun t v => g.2.2 v⟩

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
    (v : Γ₂.Var t) → (e : IExpr Γ₂ t) → (he : e ∈ lets.getExpr v) → (s : Γ₁.Valuation) →
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

def ExprRec.vars : ExprRec Γ t → (t' : Ty) → Finset (Γ.Var t')
  | .var v, t' => if ht : t = t' then ht ▸ {v} else ∅ 
  | .cst _, _ => ∅ 
  | .add e₁ e₂, t' => e₁.vars t' ∪ e₂.vars t'

theorem ExprRec.denote_eq_of_eq_on_vars : (e : ExprRec Γ t) → {s₁ s₂ : Γ.Valuation} → 
    (h : ∀ t v, v ∈ e.vars t → s₁ v = s₂ v) → 
    e.denote s₁ = e.denote s₂
  | .var v, _, _, h => h _ _ (by simp [ExprRec.vars])
  | .cst n, s₁, _, h => rfl
  | .add e₁ e₂, s₁, s₂, h => by
    simp only [ExprRec.denote, ExprRec.denote_eq_of_eq_on_vars]
    congr 1
    . exact ExprRec.denote_eq_of_eq_on_vars e₁ (fun t v hv => h t v 
        (by simp [hv, ExprRec.vars]))
    . exact ExprRec.denote_eq_of_eq_on_vars e₂ (fun t v hv => h t v 
        (by simp [hv, ExprRec.vars]))

def matchVar {Γ₁ Γ₂ Γ₃ : Ctxt} (lets : Lets Γ₁ Γ₂) 
    {t : Ty} (v : Γ₂.Var t) 
    (matchExpr : ExprRec Γ₃ t) 
    (ma : Mapping Γ₃ Γ₂ := ∅) : 
    Option (Mapping Γ₃ Γ₂) := do
  match matchExpr, lets.getExpr v with
  | .var v', _ => 
    match ma.lookup ⟨_, v'⟩ with
    | some v₂ =>
      by
        exact if v = v₂
          then some ma
          else none
    | none => some (AList.insert ⟨_, v'⟩ v ma) 
  | .cst n, some (.nat m) =>
      if n = m then some ma
      else none
  | .add lhs rhs, some (.add v₁ v₂) => do
    let map₁ ← matchVar lets v₁ lhs ma
    let map₂ ← matchVar lets v₂ rhs map₁
    return map₂
  | _, _ => none

open AList

theorem _root_.AList.keys_subset_keys_of_entries_subset_entries 
    {α : Type _} {β : α → Type _} [DecidableEq α]
    {s₁ s₂ : AList β} (h : s₁.entries ⊆ s₂.entries) : s₁.keys ⊆ s₂.keys := by
  intro k hk
  have := h (mem_lookup_iff.1 (Option.get_mem (lookup_isSome.2 hk)))
  rw [← mem_lookup_iff, Option.mem_def] at this
  rw [← mem_keys, ← lookup_isSome, this]
  exact Option.isSome_some

theorem subset_entries_matchVar : {Γ₁ Γ₂ Γ₃ : Ctxt} → 
    {lets : Lets Γ₁ Γ₂} →  
    {t : Ty} → {v : Γ₂.Var t} → 
    {matchExpr : ExprRec Γ₃ t} → 
    {varMap : Mapping Γ₃ Γ₂} → 
    {ma : Mapping Γ₃ Γ₂} → 
    (hvarMap : varMap ∈ matchVar lets v matchExpr ma) → 
    ma.entries ⊆ varMap.entries 
  | Γ₁, _, Γ₃, lets, t, v, .var v', varMap, ma => by
    simp [matchVar, ExprRec.vars]
    intros h x hx
    split at *
    . split_ifs at h
      . subst v
        injection h with h
        subst h
        assumption
    . simp at h
      subst h
      rcases x with ⟨x, y⟩
      simp only [← AList.mem_lookup_iff] at *
      by_cases hx : x = ⟨t, v'⟩
      . subst x; simp_all
      . rwa [AList.lookup_insert_ne hx]
  | Γ₁, _, Γ₃, lets, _, v, .cst n, varMap, ma => by
    unfold matchVar
    split
    . simp_all
    . split_ifs
      . simp
        rintro rfl
        simp
      . simp
    . simp_all
    . simp_all
  | Γ₁, _, Γ₃, lets, _, v, .add lhs rhs, varMap, ma => by
    unfold matchVar
    split
    . simp_all
    . simp_all
    . simp [bind, pure, ExprRec.vars]
      rintro m₁ hm₁ hm₂ x hx
      --YUCK
      have h : ExprRec.add lhs rhs = ExprRec.add _ _ :=
        by assumption
      injection h with h₁ h₂
      subst h₁ h₂
      have := subset_entries_matchVar hm₁ hx
      exact subset_entries_matchVar hm₂ this
    . simp_all

theorem mem_matchVar : {Γ₁ Γ₂ Γ₃ : Ctxt} → (lets : Lets Γ₁ Γ₂) →  
    {t : Ty} → (v : Γ₂.Var t) → 
    (matchExpr : ExprRec Γ₃ t) → 
    (varMap : Mapping Γ₃ Γ₂) → 
    (ma : Mapping Γ₃ Γ₂) → 
    (hvarMap : varMap ∈ matchVar lets v matchExpr ma) → 
    ∀ t' v', v' ∈ matchExpr.vars t' → ⟨t', v'⟩ ∈ varMap
  | Γ₁, _, Γ₃, lets, t, v, .var v', varMap, ma => by
    simp [matchVar, ExprRec.vars]
    intros h t' v₂
    split at *
    . split_ifs at h
      . subst v
        injection h with h
        subst h
        split_ifs
        . subst t
          simp
          rintro rfl
          rename_i _ _ h
          rw [← AList.lookup_isSome, h]
          simp
        . simp
    . split_ifs
      . subst t
        simp at h
        subst h
        simp
        rintro rfl
        simp
      . simp
  | Γ₁, _, Γ₃, lets, _, v, .cst n, varMap, ma => by simp [ExprRec.vars]
  | Γ₁, _, Γ₃, lets, _, v, .add lhs rhs, varMap, ma => by
    unfold matchVar
    split
    . simp_all
    . simp_all
    . simp [bind, pure, ExprRec.vars]
      rintro m₁ hm₁ hm₂ t' v' hv'
      --YUCK
      have h : ExprRec.add lhs rhs = ExprRec.add _ _ :=
        by assumption
      injection h with h₁ h₂
      subst h₁ h₂
      rcases hv' with hv' | hv'
      . have := mem_matchVar _ _ _ _ _ hm₁ _ _ hv'
        exact AList.keys_subset_keys_of_entries_subset_entries 
          (subset_entries_matchVar hm₂) this
      . exact mem_matchVar _ _ _ _ _ hm₂ _ _ hv'
    . simp_all
      
instance (t : Ty) : Inhabited t.toType := by
  cases t <;> dsimp [Ty.toType] <;> infer_instance

theorem denote_matchVar : {Γ₁ Γ₂ Γ₃ : Ctxt} → (lets : Lets Γ₁ Γ₂) → 
    {t : Ty} → (v : Γ₂.Var t) → 
    (varMap : Mapping Γ₃ Γ₂) → (s₁ : Γ₁.Valuation) → 
    (matchExpr : ExprRec Γ₃ t) → 
    (ma : Mapping Γ₃ Γ₂ := ∅) →
    (h : varMap ∈ matchVar lets v matchExpr ma) →
    matchExpr.denote (fun t' v' => by
        match varMap.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default 
        ) = 
      lets.denote s₁ v
  | Γ₁, _, Γ₃, lets, t, v, varMap, s₁, .var v', ma, h => by
    simp [matchVar] at h
    split at h
    . split_ifs at h
      subst v
      simp [ExprRec.denote]
      split
      . simp at h
        subst h
        simp_all
      . simp_all
    . simp_all [ExprRec.denote]
      subst h
      simp
  | Γ₁, _, Γ₃, lets, _, v, varMap, s₁, .cst n, ma, h => by  
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
        split_ifs at h; simp_all
      | add v₁ v₂ => simp [hl] at h
  | Γ₁, _, Γ₃, lets, _, v, varMap, s₁, .add lhs rhs, ma, h => by  
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
        cases h₁ : matchVar lets v₁ lhs ma with
        | none =>  simp [h₁, bind] at h
        | some m₁ => 
          cases h₂ : matchVar lets v₂ rhs m₁ with
          | none => 
            simp [bind] at h
            rcases h with ⟨a, _, _⟩
            simp_all
          | some m₂ => 
            simp [h₁, h₂, bind] at h
            subst h
            have ih₁ := denote_matchVar lets v₁ m₁ s₁ lhs ma h₁ 
            have ih₂ := denote_matchVar lets v₂ m₂ s₁ rhs m₁ h₂
            rw [← ih₁, ← ih₂]
            congr 1
            apply ExprRec.denote_eq_of_eq_on_vars
            intro t' v' hv'
            have h₁ := mem_matchVar _ _ _ _ _ h₁ _ _ hv'
            have h₃ := subset_entries_matchVar h₂  
            have h₂ := keys_subset_keys_of_entries_subset_entries
              h₃ h₁
            simp only [← lookup_isSome, ← mem_keys] at h₁ h₂
            simp only [List.subset_def, Sigma.forall, 
              ← mem_lookup_iff, Option.mem_def] at h₃ 
            split
            . rename_i h1
              split
              . rename_i h2
                have := h₃ _ _ _ h2
                simp_all
              . simp_all
            . simp_all
            
def matchVarMap {Γ₁ Γ₂ Γ₃ : Ctxt} (lets : Lets Γ₁ Γ₂) 
    {t : Ty} (v : Γ₂.Var t) 
    (matchExpr : ExprRec Γ₃ t) 
    (hvars : ∀ t (v : Γ₃.Var t), v ∈ matchExpr.vars t) : 
    Option (Γ₃.hom Γ₂) := do
  match hm : matchVar lets v matchExpr with
  | none => none
  | some m => 
    return fun t v' =>
    match h : m.lookup ⟨t, v'⟩ with
    | some v' => by exact v'
    | none => by
      have := AList.lookup_isSome.2 (mem_matchVar lets v matchExpr _ _ hm _ v' 
        (hvars _ _))
      simp_all

theorem denote_matchVarMap {Γ₁ Γ₂ Γ₃ : Ctxt} (lets : Lets Γ₁ Γ₂) 
    {t : Ty} (v : Γ₂.Var t) 
    (matchExpr : ExprRec Γ₃ t) (s₁ : Γ₁.Valuation)
    (hvars : ∀ t (v : Γ₃.Var t), v ∈ matchExpr.vars t) 
    (map : Γ₃.hom Γ₂) 
    (hmap : map ∈ matchVarMap lets v matchExpr hvars) :
    matchExpr.denote (fun t' v' => lets.denote s₁ (map v')) = 
      lets.denote s₁ v := by
  rw [matchVarMap] at hmap
  split at hmap
  . simp_all
  . rename_i hm
    rw [← denote_matchVar lets v _ s₁ matchExpr ∅ hm]
    simp [pure] at hmap 
    subst hmap
    congr
    funext t' v;
    split
    . congr
      simp_all
      split <;> simp_all
    . have := AList.lookup_isSome.2 (mem_matchVar lets _ matchExpr _ _ hm _ v 
        (hvars _ _))
      simp_all

def splitProgramAtAux : (pos : ℕ) → (lets : Lets Γ₁ Γ₂) → 
    (prog : ICom Γ₂ t) → 
    Option (Σ (Γ₃ : Ctxt), Lets Γ₁ Γ₃ × ICom Γ₃ t × (t' : Ty) × Γ₃.Var t')
  | 0, lets, .lete e body => some ⟨_, .lete lets e, body, _, Ctxt.Var.last _ _⟩ 
  | _, _, .ret _ => none
  | n+1, lets, .lete e body => 
    splitProgramAtAux n (lets.lete e) body

theorem denote_splitProgramAtAux : (pos : ℕ) → (lets : Lets Γ₁ Γ₂) →
    (prog : ICom Γ₂ t) →
    (res : Σ (Γ₃ : Ctxt), Lets Γ₁ Γ₃ × ICom Γ₃ t × (t' : Ty) × Γ₃.Var t') →
    (hres : res ∈ splitProgramAtAux pos lets prog) →
    (s : Γ₁.Valuation) → 
    res.2.2.1.denote (res.2.1.denote s) = prog.denote (lets.denote s) 
  | 0, lets, .lete e body, res, hres, s => by
    simp [splitProgramAtAux] at hres
    subst hres
    simp [Lets.denote, ICom.denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn
    . simp
    . simp
  | _+1, _, .ret _, res, hres, s => by
    simp [splitProgramAtAux] at hres
  | n+1, lets, .lete e body, res, hres, s => by
    rw [splitProgramAtAux] at hres
    rw [ICom.denote, denote_splitProgramAtAux n _ _ _ hres s]
    simp [Ctxt.Valuation.snoc, Lets.denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn
    . simp
    . simp

def splitProgramAt (pos : ℕ) (prog : ICom Γ₁ t) :  
    Option (Σ (Γ₂ : Ctxt), Lets Γ₁ Γ₂ × ICom Γ₂ t × (t' : Ty) × Γ₂.Var t') :=
  splitProgramAtAux pos .nil prog

theorem denote_splitProgramAt (pos : ℕ) (prog : ICom Γ₁ t) 
    (res : Σ (Γ₂ : Ctxt), Lets Γ₁ Γ₂ × ICom Γ₂ t × (t' : Ty) × Γ₂.Var t')
    (hres : res ∈ splitProgramAt pos prog) (s : Γ₁.Valuation) : 
    res.2.2.1.denote (res.2.1.denote s) = prog.denote s :=
  denote_splitProgramAtAux pos _ _ _ hres s

def rewriteAt (lhs rhs : ICom Γ₁ t₁) 
    (hlhs : ∀ t (v : Γ₁.Var t), v ∈ lhs.toExprRec.vars t)
    (pos : ℕ) (target : ICom Γ₂ t₂) :
    Option (ICom Γ₂ t₂) := do
  let ⟨Γ₃, lets, target', t', vm⟩ ← splitProgramAt pos target
  if h : t₁ = t'
  then 
    let m ← matchVarMap lets vm (h ▸ lhs.toExprRec) 
      (by subst h; exact hlhs)
    return addProgramInMiddle vm m lets (h ▸ rhs) target'
  else none

theorem denote_rewriteAt (lhs rhs : ICom Γ₁ t₁)
    (hlhs : ∀ t (v : Γ₁.Var t), v ∈ lhs.toExprRec.vars t)
    (pos : ℕ) (target : ICom Γ₂ t₂)
    (hl : lhs.denote = rhs.denote)
    (rew : ICom Γ₂ t₂)
    (hrew : rew ∈ rewriteAt lhs rhs hlhs pos target) :
    rew.denote = target.denote := by
  ext s 
  rw [rewriteAt] at hrew
  simp only [bind, pure, Option.bind] at hrew
  split at hrew
  . simp at hrew
  . rename_i hs
    simp at hrew
    split_ifs at hrew
    subst t₁
    simp at hrew
    split at hrew
    . simp at hrew
    . simp at hrew
      subst hrew
      rw [denote_addProgramInMiddle]
      simp
      simp only [← hl]
      have : matchVarMap _ _ _ _ = _ := by
        assumption
      have := denote_matchVarMap _ _ _ s _ _ this
      simp only [ICom.denote_toExprRec] at this
      simp only [this]
      rw [← denote_splitProgramAt _ _ _ hs s]
      congr
      funext t' v'
      simp
      rintro rfl rfl
      simp
