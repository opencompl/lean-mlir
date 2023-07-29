-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Experimental.ErasedContext
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Basic

/-- A very simple intrinsically typed expression. -/
inductive IExpr : Ctxt → Ty → Type
  | add (a b : Γ.Var .nat) : IExpr Γ .nat
  /-- Nat literals. -/
  | cst (n : Nat) : IExpr Γ .nat

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

def IExpr.denote : IExpr Γ ty → (Γv : Γ.Valuation) → ty.toType
  | .cst n, _ => n
  | .add a b, Γv => Γv a + Γv b

def ICom.denote : ICom Γ ty → (Γv : Γ.Valuation) → ty.toType
  | .ret e, Γv => Γv e
  | .lete e body, Γv => body.denote (Γv.snoc (e.denote Γv))

def ExprRec.denote : ExprRec Γ ty → (Γv : Γ.Valuation) → ty.toType
  | .cst n, _ => n
  | .add a b, Γv => a.denote Γv + b.denote Γv
  | .var v, Γv => Γv v

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
  | .cst n => .cst n
  | .add a b => .add (varsMap a) (varsMap b)

@[simp]
theorem IExpr.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : Γ.hom Γ')
    (e : IExpr Γ ty)
    (Γ'v : Γ'.Valuation) : 
    (e.changeVars varsMap).denote Γ'v = 
    e.denote (fun t v => Γ'v (varsMap v)) := by
  induction e generalizing Γ'v <;> simp 
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
    (Γ'v : Γ'.Valuation) : 
    (c.changeVars varsMap).denote Γ'v = 
    c.denote (fun t v => Γ'v (varsMap v)) := by
  induction c generalizing Γ'v Γ' with
  | ret x => simp [ICom.denote, ICom.changeVars, *]
  | lete _ _ ih => 
    rw [changeVars, denote, ih]
    simp only [Ctxt.Valuation.snoc, Ctxt.Var.snocMap, IExpr.denote_changeVars, denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn <;> simp

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
    simp only [ICom.denote_changeVars, Ctxt.Valuation.snoc_toSnoc]
    congr
    funext t' v'
    by_cases h : ∃ h : t₁ = t', h ▸ v = v'
    . rcases h with ⟨rfl, h⟩
      dsimp at h
      simp only [h, exists_prop, dite_eq_ite, ite_true]
      congr
      funext t'' v''
      cases v'' using Ctxt.Var.casesOn <;>
        simp [Ctxt.Valuation.snoc, Ctxt.Var.snocMap]
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
    simp only [ICom.denote, Ctxt.Valuation.snoc, Function.comp_apply, Lets.denote, 
      eq_rec_constant]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn <;> simp

/-- `addProgramInMiddle v map lets rhs inputProg` appends the programs
`lets`, `rhs` and `inputProg`, while reassigning `v`, a free variable in
`inputProg`, to the output of `rhs`. It also assigns all free variables 
in `rhs` to variables available at the end of `lets` using `map`. -/
def addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt} (v : Γ₂.Var t₁)
    (map : Γ₃.hom Γ₂) 
    (lets : Lets Γ₁ Γ₂) (rhs : ICom Γ₃ t₁) 
    (inputProg : ICom Γ₂ t₂) : ICom Γ₁ t₂ :=
  addLetsAtTop lets (addProgramAtTop v map rhs inputProg)

theorem denote_addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt} 
    (v : Γ₂.Var t₁) (s : Γ₁.Valuation)
    (map : Γ₃.hom Γ₂) 
    (lets : Lets Γ₁ Γ₂) (rhs : ICom Γ₃ t₁)
    (inputProg : ICom Γ₂ t₂) :
    (addProgramInMiddle v map lets rhs inputProg).denote s =
      inputProg.denote (fun t' v' => 
        let s' := lets.denote s
        if h : ∃ h : t₁ = t', h ▸ v = v' 
        then h.fst ▸ rhs.denote (fun t' v' => s' (map v'))
        else s' v') := by
  rw [addProgramInMiddle, denote_addLetsAtTop, Function.comp_apply, 
    denote_addProgramAtTop]

/-- Substitute each free variable in an `ExprRec` for another `ExprRec` 
in a different context. -/
def ExprRec.bind {Γ₁ Γ₂ : Ctxt} 
    (f : (t : Ty) → Γ₁.Var t → ExprRec Γ₂ t) : 
    (e : ExprRec Γ₁ t) → ExprRec Γ₂ t
  | .var v => f _ v
  | .cst n => .cst n
  | .add e₁ e₂ => .add (bind f e₁) (bind f e₂)

@[simp]
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
  | _, _, .cst n => .cst n
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

@[simp]
theorem IExpr.denote_toExprRec : {Γ : Ctxt} → {t : Ty} → 
    (s : Γ.Valuation) → (e : IExpr Γ t) → 
    e.toExprRec.denote s = e.denote s
  | _, _, _, .cst n => by simp [IExpr.toExprRec, IExpr.denote, ExprRec.denote]
  | _, _, s, .add e₁ e₂ => by
    simp only [IExpr.toExprRec, IExpr.denote, ExprRec.denote]

@[simp]
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
    cases v' using Ctxt.Var.casesOn <;>
      simp [ExprRec.denote, IExpr.denote_toExprRec]

/-- Get the `IExpr` that a var `v` is assigned to in a sequence of `Lets`.
The variables are adjusted so that they are variables in the output context of a lets,
not the local context where the variable appears. -/
def Lets.getIExpr : {Γ₁ Γ₂ : Ctxt} → (lets : Lets Γ₁ Γ₂) → {t : Ty} →
    (v : Γ₂.Var t) → Option (IExpr Γ₂ t) 
  | _, _, .nil, _, _ => none
  | _, _, .lete lets e, _, v => by
    cases v using Ctxt.Var.casesOn with
    | toSnoc v => 
      exact (Lets.getIExpr lets v).map
        (IExpr.changeVars (fun _ => Ctxt.Var.toSnoc))
    | last => exact some <| e.changeVars (fun _ => Ctxt.Var.toSnoc)

theorem Lets.denote_getIExpr : {Γ₁ Γ₂ : Ctxt} → {lets : Lets Γ₁ Γ₂} → {t : Ty} → 
    {v : Γ₂.Var t} → {e : IExpr Γ₂ t} → (he : e ∈ lets.getIExpr v) → (s : Γ₁.Valuation) →
    e.denote (lets.denote s) = (lets.denote s) v 
  | _, _, .nil, t, v, e, he, s => by simp [Lets.getIExpr] at he
  | _, _, .lete lets e, _, v, e', he, s => by
    cases v using Ctxt.Var.casesOn with
    | toSnoc v => 
      simp only [getIExpr, eq_rec_constant, Ctxt.Var.casesOn_toSnoc, 
        Option.mem_def, Option.map_eq_some'] at he
      cases' he with a ha
      cases' ha with ha ha'
      subst ha'
      simp only [denote, eq_rec_constant, IExpr.denote_changeVars, 
        Ctxt.Var.casesOn_toSnoc]
      rw [denote_getIExpr ha s]
    | last => 
      simp only [getIExpr, eq_rec_constant, Ctxt.Var.casesOn_last, 
        Option.mem_def, Option.some.injEq] at he 
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
 
/-- `matchVar` attempts to assign variables in `matchExpr` to variables
in `lets`, and extends the input mapping `ma`, which is by default `∅`.  -/
def matchVar {Γ₁ Γ₂ Γ₃ : Ctxt} (lets : Lets Γ₁ Γ₂) 
    {t : Ty} (v : Γ₂.Var t) 
    (matchExpr : ExprRec Γ₃ t) 
    (ma : Mapping Γ₃ Γ₂ := ∅) : 
    Option (Mapping Γ₃ Γ₂) := do
  match matchExpr, lets.getIExpr v with
  | .var v', _ => 
    match ma.lookup ⟨_, v'⟩ with
    | some v₂ =>
      by
        exact if v = v₂
          then some ma
          else none
    | none => some (AList.insert ⟨_, v'⟩ v ma) 
  | .cst n, some (.cst m) =>
      if n = m then some ma
      else none
  | .add lhs rhs, some (.add v₁ v₂) => do
    let map₁ ← matchVar lets v₁ lhs ma
    let map₂ ← matchVar lets v₂ rhs map₁
    return map₂
  | _, _ => none

open AList

/-- For mathlib -/
theorem _root_.AList.keys_subset_keys_of_entries_subset_entries 
    {α : Type _} {β : α → Type _} 
    {s₁ s₂ : AList β} (h : s₁.entries ⊆ s₂.entries) : s₁.keys ⊆ s₂.keys := by
  intro k hk
  letI := Classical.decEq α 
  have := h (mem_lookup_iff.1 (Option.get_mem (lookup_isSome.2 hk)))
  rw [← mem_lookup_iff, Option.mem_def] at this
  rw [← mem_keys, ← lookup_isSome, this]
  exact Option.isSome_some

/-- The output mapping of `matchVar` extends the input mapping when it succeeds. -/
theorem subset_entries_matchVar : {Γ₁ Γ₂ Γ₃ : Ctxt} → 
    {lets : Lets Γ₁ Γ₂} →  
    {t : Ty} → {v : Γ₂.Var t} → 
    {matchExpr : ExprRec Γ₃ t} → 
    {varMap : Mapping Γ₃ Γ₂} → 
    {ma : Mapping Γ₃ Γ₂} → 
    (hvarMap : varMap ∈ matchVar lets v matchExpr ma) → 
    ma.entries ⊆ varMap.entries 
  | Γ₁, _, Γ₃, lets, t, v, .var v', varMap, ma => by
    simp only [matchVar, Option.mem_def]
    intros h x hx
    split at h
    . split_ifs at h
      . simp_all
    . simp only [Option.some.injEq] at h 
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
      . simp (config := {contextual := true})
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
      rename_i _ h _
      injection h with h₁ h₂
      subst h₁ h₂
      exact subset_entries_matchVar hm₂ (subset_entries_matchVar hm₁ hx)
    . simp_all

/-- All variables containing in `matchExpr` are assigned by `matchVar`. -/
theorem mem_matchVar : {Γ₁ Γ₂ Γ₃ : Ctxt} → {lets : Lets Γ₁ Γ₂} →  
    {t : Ty} → {v : Γ₂.Var t} → 
    {matchExpr : ExprRec Γ₃ t} → 
    {varMap : Mapping Γ₃ Γ₂} → 
    {ma : Mapping Γ₃ Γ₂} → 
    (hvarMap : varMap ∈ matchVar lets v matchExpr ma) → 
    ∀ {t' v'}, v' ∈ matchExpr.vars t' → ⟨t', v'⟩ ∈ varMap
  | Γ₁, _, Γ₃, lets, t, v, .var v', varMap, ma => by
    simp only [matchVar, Option.mem_def, ExprRec.vars]
    intros h t' v₂
    split at *
    . split_ifs at h
      . subst v
        injection h with h
        subst h
        split_ifs
        . subst t
          simp_all (config := {contextual := true}) 
            [Finset.mem_singleton, ← AList.lookup_isSome] 
        . simp
    . split_ifs
      . subst t
        simp only [Option.some.injEq] at h 
        subst h
        simp (config := {contextual := true})
      . simp
  | Γ₁, _, Γ₃, lets, _, v, .cst n, varMap, ma => by simp [ExprRec.vars]
  | Γ₁, _, Γ₃, lets, _, v, .add lhs rhs, varMap, ma => by
    unfold matchVar
    split
    . simp_all
    . simp_all
    . simp only [Option.bind_some, Option.mem_def, Option.bind_eq_some, 
        ExprRec.vars, Finset.mem_union, forall_exists_index, and_imp,
        pure, bind]
      rintro m₁ hm₁ hm₂ t' v' hv'
      rename_i _ h _
      injection h with h₁ h₂
      subst h₁ h₂
      rcases hv' with hv' | hv'
      . exact AList.keys_subset_keys_of_entries_subset_entries 
          (subset_entries_matchVar hm₂) (mem_matchVar hm₁ hv')
      . exact mem_matchVar hm₂ hv'
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
    simp only [matchVar, Option.mem_def] at h 
    split at h
    . split_ifs at h
      subst v
      simp only [ExprRec.denote]
      split
      . simp only [Option.some.injEq] at h 
        subst h
        simp_all
      . simp_all
    . simp at h
      subst h
      simp_all [ExprRec.denote]
  | Γ₁, _, Γ₃, lets, _, v, varMap, s₁, .cst n, ma, h => by  
    rw [ExprRec.denote]
    unfold matchVar at h
    cases hl : Lets.getIExpr lets v with
    | none => simp [hl] at h
    | some e => 
      cases e with
      | cst m => 
        simp [hl] at h
        rw [← Lets.denote_getIExpr hl]
        simp only [IExpr.denote]
        split_ifs at h; simp_all
      | add v₁ v₂ => simp [hl] at h
  | Γ₁, _, Γ₃, lets, _, v, varMap, s₁, .add lhs rhs, ma, h => by  
    rw [ExprRec.denote]
    unfold matchVar at h
    cases hl : Lets.getIExpr lets v with
    | none => simp [hl] at h
    | some e => 
      cases e with
      | cst m => simp [hl] at h
      | add v₁ v₂ => 
        simp only [hl, bind_pure, Option.mem_def] at h 
        rw [← Lets.denote_getIExpr hl]
        simp only [IExpr.denote]
        cases h₁ : matchVar lets v₁ lhs ma with
        | none =>  simp [h₁, bind] at h
        | some m₁ => 
          cases h₂ : matchVar lets v₂ rhs m₁ with
          | none => 
            simp [bind] at h
            rcases h with ⟨a, _, _⟩
            simp_all
          | some m₂ => 
            simp only [h₁, Option.some_bind, h₂, Option.some.injEq, pure, bind] at h 
            subst h
            have ih₁ := denote_matchVar lets v₁ m₁ s₁ lhs ma h₁ 
            have ih₂ := denote_matchVar lets v₂ m₂ s₁ rhs m₁ h₂
            rw [← ih₁, ← ih₂]
            congr 1
            apply ExprRec.denote_eq_of_eq_on_vars
            intro t' v' hv'
            have h₁ := mem_matchVar h₁ hv'
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

/-- A version of `matchVar` that returns a `hom` of `Ctxt`s instead of the `AList`,
provided every variable in the context appears as a free variable in `matchExpr`. -/
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
      have := AList.lookup_isSome.2 (mem_matchVar hm (hvars t v'))
      simp_all

theorem denote_matchVarMap {Γ₁ Γ₂ Γ₃ : Ctxt} {lets : Lets Γ₁ Γ₂}
    {t : Ty} {v : Γ₂.Var t} 
    {matchExpr : ExprRec Γ₃ t} 
    {hvars : ∀ t (v : Γ₃.Var t), v ∈ matchExpr.vars t} 
    {map : Γ₃.hom Γ₂}
    (hmap : map ∈ matchVarMap lets v matchExpr hvars) (s₁ : Γ₁.Valuation) :
    matchExpr.denote (fun t' v' => lets.denote s₁ (map v')) = 
      lets.denote s₁ v := by
  rw [matchVarMap] at hmap
  split at hmap
  . simp_all
  . rename_i hm
    rw [← denote_matchVar lets v _ s₁ matchExpr ∅ hm]
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
with the `pos`th variable in `prog`, and an `ICom` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAtAux : (pos : ℕ) → (lets : Lets Γ₁ Γ₂) → 
    (prog : ICom Γ₂ t) → 
    Option (Σ (Γ₃ : Ctxt), Lets Γ₁ Γ₃ × ICom Γ₃ t × (t' : Ty) × Γ₃.Var t')
  | 0, lets, .lete e body => some ⟨_, .lete lets e, body, _, Ctxt.Var.last _ _⟩ 
  | _, _, .ret _ => none
  | n+1, lets, .lete e body => 
    splitProgramAtAux n (lets.lete e) body

theorem denote_splitProgramAtAux : {pos : ℕ} → {lets : Lets Γ₁ Γ₂} →
    {prog : ICom Γ₂ t} →
    {res : Σ (Γ₃ : Ctxt), Lets Γ₁ Γ₃ × ICom Γ₃ t × (t' : Ty) × Γ₃.Var t'} →
    (hres : res ∈ splitProgramAtAux pos lets prog) →
    (s : Γ₁.Valuation) → 
    res.2.2.1.denote (res.2.1.denote s) = prog.denote (lets.denote s) 
  | 0, lets, .lete e body, res, hres, s => by
    simp only [splitProgramAtAux, Option.mem_def, Option.some.injEq] at hres 
    subst hres
    simp only [Lets.denote, eq_rec_constant, ICom.denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn <;> simp
  | _+1, _, .ret _, res, hres, s => by
    simp [splitProgramAtAux] at hres
  | n+1, lets, .lete e body, res, hres, s => by
    rw [splitProgramAtAux] at hres
    rw [ICom.denote, denote_splitProgramAtAux hres s]
    simp only [Lets.denote, eq_rec_constant, Ctxt.Valuation.snoc]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn <;> simp

/-- `splitProgramAt pos prog`, will return a `Lets` ending 
with the `pos`th variable in `prog`, and an `ICom` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAt (pos : ℕ) (prog : ICom Γ₁ t) :  
    Option (Σ (Γ₂ : Ctxt), Lets Γ₁ Γ₂ × ICom Γ₂ t × (t' : Ty) × Γ₂.Var t') :=
  splitProgramAtAux pos .nil prog

theorem denote_splitProgramAt {pos : ℕ} {prog : ICom Γ₁ t} 
    {res : Σ (Γ₂ : Ctxt), Lets Γ₁ Γ₂ × ICom Γ₂ t × (t' : Ty) × Γ₂.Var t'}
    (hres : res ∈ splitProgramAt pos prog) (s : Γ₁.Valuation) : 
    res.2.2.1.denote (res.2.1.denote s) = prog.denote s :=
  denote_splitProgramAtAux hres s

/-- `rewriteAt lhs rhs hlhs pos target`, searches for `lhs` at position `pos` of
`target`. If it can match the variables, it inserts `rhs` into the program
with the correct assignment of variables, and then replaces occurences
of the variable at position `pos` in `target` with the output of `rhs`.  -/
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
      simp only [ICom.denote_toExprRec] at this
      simp only [this, ← denote_splitProgramAt hs s]
      congr
      funext t' v'
      simp only [dite_eq_right_iff, forall_exists_index]
      rintro rfl rfl
      simp

attribute [local simp] Ctxt.snoc

def ex1 : ICom ∅ .nat :=
  ICom.lete (.cst 1) <|
  ICom.lete (.add ⟨0, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩ ) <|
  ICom.ret ⟨0, by simp [Ctxt.snoc]⟩ 

def ex2 : ICom ∅ .nat :=
  ICom.lete (.cst 1) <|
  ICom.lete (.add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  ICom.lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  ICom.lete (.add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
  ICom.lete (.add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
  ICom.ret ⟨0, by simp⟩

-- a + b => b + a
def m : ICom (Erased.mk [.nat, .nat]) .nat := 
  .lete (.add ⟨0, by simp⟩ ⟨1, by simp⟩) (.ret ⟨0, by simp⟩)
def r : ICom (Erased.mk [.nat, .nat]) .nat := 
  .lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) (.ret ⟨0, by simp⟩)

def hlhs: ∀ t v,  v ∈ ExprRec.vars (ICom.toExprRec m) t := by
  sorry

example : rewriteAt m r hlhs 1 ex1 = some (
  ICom.lete (IExpr.cst 1)  <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩)  <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩)  <|
     .ret ⟨0, by simp⟩) := by rfl

-- a + b => b + a
example : rewriteAt m r hlhs 0 ex1 = none := by rfl

example : rewriteAt m r hlhs 1 ex2 = some (
  ICom.lete (IExpr.cst 1)   <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨0, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩ ) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewriteAt m r hlhs 2 ex2 = some (
  ICom.lete (IExpr.cst 1)   <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨2, by simp⟩) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨2, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewriteAt m r hlhs 3 ex2 = some (
  ICom.lete (IExpr.cst 1)   <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewriteAt m r hlhs 4 ex2 = some (
  ICom.lete (IExpr.cst 1)   <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

def ex2' : ICom ∅ .nat :=
  ICom.lete (.cst 1) <|
  ICom.lete (.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
  ICom.lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
  ICom.lete (.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
  ICom.lete (.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
  ICom.ret ⟨0, by simp⟩  

-- a + b => b + (0 + a)
def r2 : ICom (Erased.mk [.nat, .nat]) .nat :=
  .lete (.cst 0) <|
  .lete (.add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨3, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩ 

example : rewriteAt m r2 hlhs 1 ex2' = Option.some (
     .lete (IExpr.cst 1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.cst 0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (IExpr.add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewriteAt m r2 hlhs 2 ex2 = some (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewriteAt m r2 hlhs 3 ex2 = some (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewriteAt m r2 hlhs 4 ex2 = some (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

-- a + b => (0 + a) + b
def r3 : ICom (Erased.mk [.nat, .nat]) .nat := 
  .lete (.cst 0) <|
  .lete (.add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨0, by simp⟩ ⟨3, by simp⟩) <|
  .ret ⟨0, by simp⟩

example : rewriteAt m r3 hlhs 1 ex2 = some (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewriteAt m r3 hlhs 2 ex2 = some (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewriteAt m r3 hlhs 3 ex2 = some (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewriteAt m r3 hlhs 4 ex2 = some (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

def ex3 : ICom ∅ .nat :=
  .lete (.cst 1) <|
  .lete (.cst 0) <|
  .lete (.cst 2) <|
  .lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete (.add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) <| --here
  .lete (.add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩

example : rewriteAt r3 m sorry 5 ex3 = some (
  .lete (.cst 1) <|
  .lete (.cst 0) <|
  .lete (.cst 2) <|
  .lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete (.add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete (.add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩) := rfl