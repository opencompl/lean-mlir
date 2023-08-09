-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Experimental.ErasedContext
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open Ctxt (Var VarSet)


/-- A very simple intrinsically typed expression. -/
inductive IExpr : Ctxt → Ty → Type
  | add (a b : Γ.Var .nat) : IExpr Γ .nat
  /-- Nat literals. -/
  | cst (n : Nat) : IExpr Γ .nat

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive ICom : Ctxt → Ty → Type where
  | ret (v : Γ.Var t) : ICom Γ t
  | lete (e : IExpr Γ α) (body : ICom (Γ.snoc α) β) : ICom Γ β

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

def IExpr.changeVars (varsMap : Γ.Hom Γ') : 
    (e : IExpr Γ ty) → IExpr Γ' ty
  | .cst n => .cst n
  | .add a b => .add (varsMap a) (varsMap b)

@[simp]
theorem IExpr.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : Γ.Hom Γ')
    (e : IExpr Γ ty)
    (Γ'v : Γ'.Valuation) : 
    (e.changeVars varsMap).denote Γ'v = 
    e.denote (fun t v => Γ'v (varsMap v)) := by
  induction e generalizing Γ'v <;> simp 
    [IExpr.denote, IExpr.changeVars, *]

def ICom.changeVars 
    (varsMap : Γ.Hom Γ') : 
    ICom Γ ty → ICom Γ' ty
  | .ret e => .ret (varsMap e)
  | .lete e body => .lete (e.changeVars varsMap) 
      (body.changeVars (fun t v => varsMap.snocMap v))

@[simp]
theorem ICom.denote_changeVars {Γ Γ' : Ctxt}
    (varsMap : Γ.Hom Γ') (c : ICom Γ ty)
    (Γ'v : Γ'.Valuation) : 
    (c.changeVars varsMap).denote Γ'v = 
    c.denote (fun t v => Γ'v (varsMap v)) := by
  induction c generalizing Γ'v Γ' with
  | ret x => simp [ICom.denote, ICom.changeVars, *]
  | lete _ _ ih => 
    rw [changeVars, denote, ih]
    simp only [Ctxt.Valuation.snoc, Ctxt.Hom.snocMap, IExpr.denote_changeVars, denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn <;> simp


/-- The result returned by `addProgramToLets` -/
structure addProgramToLets.Result (Γ_in Γ_out : Ctxt) (ty : Ty) where
  /-- The new out context -/
  {Γ_out_new : Ctxt}
  /-- The new `lets`, with the program added to it -/
  lets : Lets Γ_in Γ_out_new
  /-- The difference between the old out context and the new out context
      This induces a context mapping from `Γ_out` to `Γ_out_new` -/
  diff : Ctxt.Diff Γ_out Γ_out_new
  /-- The variable in the new `lets` that represent the return value of the added program -/
  var : Γ_out_new.Var ty

/--
  Add a program to a list of `Lets`, returning
  * the new lets
  * a map from variables of the out context of the old lets to the out context of the new lets
  * a variable in the new out context, which is semantically equivalent to the return variable of 
    the added program
-/
def addProgramToLets (lets : Lets Γ_in Γ_out) (varsMap : Δ.Hom Γ_out) : ICom Δ ty → 
    addProgramToLets.Result Γ_in Γ_out ty
  | .ret v => ⟨lets, .zero _, varsMap v⟩
  | .lete (α:=α) e body => 
      let lets := Lets.lete lets (e.changeVars varsMap)
      let ⟨lets', diff, v'⟩ := addProgramToLets lets (varsMap.snocMap) body
      ⟨lets', diff.unSnoc, v'⟩

theorem denote_addProgramToLets_lets (lets : Lets Γ_in Γ_out) {map} {com : ICom Δ t} 
    (ll : Γ_in.Valuation) ⦃t⦄ (var : Γ_out.Var t) :
    (addProgramToLets lets map com).lets.denote ll ((addProgramToLets lets map com).diff.toHom var)
    = lets.denote ll var := by
  induction com generalizing lets Γ_out
  next =>
    rfl
  next e body ih =>
    simp[addProgramToLets, ih, Lets.denote]

theorem denote_addProgramToLets_var {lets : Lets Γ_in Γ_out} {map} {com : ICom Δ t} :
    ∀ (ll : Γ_in.Valuation), 
      (addProgramToLets lets map com).lets.denote ll (addProgramToLets lets map com).var
      = com.denote (fun _ v => lets.denote ll <| map v) := by
  intro ll
  induction com generalizing lets Γ_out
  next =>
    rfl
  next e body ih =>
    simp only [addProgramToLets, ih, ICom.denote]
    congr
    funext t v
    cases v using Ctxt.Var.casesOn
    . rfl
    . simp [Lets.denote]; rfl
    


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
    (map : Γ₃.Hom Γ₂) 
    (lets : Lets Γ₁ Γ₂) (rhs : ICom Γ₃ t₁) 
    (inputProg : ICom Γ₂ t₂) : ICom Γ₁ t₂ :=
  let r := addProgramToLets lets map rhs
  addLetsAtTop r.lets <| inputProg.changeVars (r.diff.toHom.with v r.var)

theorem denote_addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt} 
    (v : Γ₂.Var t₁) (s : Γ₁.Valuation)
    (map : Γ₃.Hom Γ₂) 
    (lets : Lets Γ₁ Γ₂) (rhs : ICom Γ₃ t₁)
    (inputProg : ICom Γ₂ t₂) :
    (addProgramInMiddle v map lets rhs inputProg).denote s =
      inputProg.denote (fun t' v' => 
        let s' := lets.denote s
        if h : ∃ h : t₁ = t', h ▸ v = v' 
        then h.fst ▸ rhs.denote (fun t' v' => s' (map v'))
        else s' v') := by
  simp only [addProgramInMiddle, Ctxt.Hom.with, denote_addLetsAtTop, Function.comp_apply, 
              ICom.denote_changeVars]
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

structure FlatICom (Γ : Ctxt) (t : Ty) where
  {Γ_out : Ctxt}
  /-- The let bindings of the original program -/
  lets : Lets Γ Γ_out
  /-- The return variable -/
  ret : Γ_out.Var t

def ICom.toLets {Γ : Ctxt} {t : Ty} : ICom Γ t → FlatICom Γ t :=
  go .nil
where
  go {Γ_out} (lets : Lets Γ Γ_out) : ICom Γ_out t → FlatICom Γ t   
    | .ret v => ⟨lets, v⟩
    | .lete e body => go (lets.lete e) body

@[simp]
theorem ICom.denote_toLets_go (lets : Lets Γ_in Γ_out) (com : ICom Γ_out t) (s : Γ_in.Valuation) :
    (toLets.go lets com).lets.denote s (toLets.go lets com).ret = com.denote (lets.denote s) := by
  induction com
  . rfl
  next ih =>
    simp [toLets.go, denote, ih]
    congr
    funext _ v
    cases v using Ctxt.Var.casesOn <;> simp[Lets.denote]

@[simp]
theorem ICom.denote_toLets (com : ICom Γ t) (s : Γ.Valuation) :
    com.toLets.lets.denote s com.toLets.ret = com.denote s :=
  denote_toLets_go ..

/-- Get the `IExpr` that a var `v` is assigned to in a sequence of `Lets`, 
    without adjusting variables
-/
def Lets.getIExprAux {Γ₁ Γ₂ : Ctxt} {t : Ty} : Lets Γ₁ Γ₂ → Γ₂.Var t → 
    Option ((Δ : Ctxt) × IExpr Δ t)
  | .nil, _ => none
  | .lete lets e, v => by
    cases v using Ctxt.Var.casesOn with
      | toSnoc v => exact (Lets.getIExprAux lets v)
      | last => exact some ⟨_, e⟩

/-- If `getIExprAux` succeeds, 
    then the orignal context `Γ₁` is a prefix of the local context `Δ`, and 
    their difference is exactly the value of the requested variable index plus 1
-/
def Lets.getIExprAuxDiff {lets : Lets Γ₁ Γ₂} {v : Γ₂.Var t} 
    (h : getIExprAux lets v = some ⟨Δ, e⟩) :
    Δ.Diff Γ₂ :=
  ⟨v.val + 1, by
    intro i t
    induction lets
    next =>
      simp only [getIExprAux] at h 
    next lets e ih => 
      simp only [getIExprAux, eq_rec_constant] at h  
      cases v using Ctxt.Var.casesOn <;> simp at h
      . intro h'
        simp [Ctxt.get?]
        simp[←ih h h', Ctxt.snoc, Ctxt.Var.toSnoc, List.get?]
      . rcases h with ⟨⟨⟩, ⟨⟩⟩
        simp[Ctxt.snoc, List.get?, Ctxt.Var.last]
  ⟩

theorem Lets.denote_getIExprAux {Γ₁ Γ₂ Δ : Ctxt} {t : Ty}
    {lets : Lets Γ₁ Γ₂} {v : Γ₂.Var t} {e : IExpr Δ t}
    (he : lets.getIExprAux v = some ⟨Δ, e⟩)
    (s : Γ₁.Valuation) :
    (e.changeVars (getIExprAuxDiff he).toHom).denote (lets.denote s) = (lets.denote s) v := by  
  rw [getIExprAuxDiff]
  induction lets
  next => simp [getIExprAux] at he
  next ih =>
    simp [Ctxt.Diff.toHom_succ <| getIExprAuxDiff.proof_1 he]
    cases v using Ctxt.Var.casesOn with
    | toSnoc v => 
      simp only [getIExprAux, eq_rec_constant, Ctxt.Var.casesOn_toSnoc, Option.mem_def, 
        Option.map_eq_some'] at he
      simp [denote, ←ih he]
    | last =>
      simp only [getIExprAux, eq_rec_constant, Ctxt.Var.casesOn_last, 
        Option.mem_def, Option.some.injEq] at he 
      rcases he with ⟨⟨⟩, ⟨⟩⟩
      simp [denote]
      

/-- Get the `IExpr` that a var `v` is assigned to in a sequence of `Lets`.
The variables are adjusted so that they are variables in the output context of a lets,
not the local context where the variable appears. -/
def Lets.getIExpr {Γ₁ Γ₂ : Ctxt} (lets : Lets Γ₁ Γ₂) {t : Ty} (v : Γ₂.Var t) : 
    Option (IExpr Γ₂ t) :=
  match h : getIExprAux lets v with
  | none => none
  | some r => r.snd.changeVars (getIExprAuxDiff h).toHom

theorem Lets.denote_getIExpr {Γ₁ Γ₂ : Ctxt} : {lets : Lets Γ₁ Γ₂} → {t : Ty} → 
    {v : Γ₂.Var t} → {e : IExpr Γ₂ t} → (he : lets.getIExpr v = some e) → (s : Γ₁.Valuation) →
    e.denote (lets.denote s) = (lets.denote s) v := by
  intros lets _ v e he s
  simp [getIExpr] at he  
  split at he
  . contradiction
  . rw[←Option.some_inj.mp he, denote_getIExprAux]

  

abbrev Mapping (Γ Δ : Ctxt) : Type :=
  @AList (Σ t, Γ.Var t) (fun x => Δ.Var x.1)

/-- The free variables of `lets` that are (transitively) referred to by some variable `v` -/
def Lets.vars : Lets Γ_in Γ_out → Γ_out.Var t → Γ_in.VarSet
  | .nil, v => VarSet.ofVar v
  | .lete lets e, v => by
      cases v using Ctxt.Var.casesOn with
      | toSnoc v => exact lets.vars v
      | last => exact match e with 
        | .cst _    => ∅ 
        | .add x y  => lets.vars x ∪ lets.vars y

-- theorem Lets.denote_eq_of_eq_on_vars (lets : Lets Γ_in Γ_out) (v : Γ_out.Var t)
--     {s₁ s₂ : Γ_in.Valuation} 
--     (h : ∀ t w, w ∈ lets.vars v t → s₁ w = s₂ w) :
--     lets.denote s₁ v = lets.denote s₂ v := by
--   induction lets
--   next => 
--     simp [vars] at h
--     simp [denote, h _ v]
--   next lets e ih =>
--     cases v using Ctxt.Var.casesOn
--     . simp [vars] at h
--       simp[denote]
--       apply ih _ h
--     . simp [denote, IExpr.denote]
--       cases e
--       . simp [vars] at h
--         simp
--         congr 1
--         <;> apply ih
--         <;> intro _ _ hw
--         <;> apply h
--         . apply Or.inl hw
--         . apply Or.inr hw
--       . simp

def ICom.vars : ICom Γ t → Γ.VarSet :=
  fun com => com.toLets.lets.vars com.toLets.ret



/-- 
  Given two sequences of lets, `lets` and `matchExpr`, 
  and variables that indicate an expression, of the same type, in each sequence, 
  attempt to assign free variables in `matchExpr` to variables (free or bound) in `lets`, such that
  the original two variables are semantically equivalent.
  If this succeeds, return the mapping. 
-/
def matchVar {Γ_in Γ_out Δ_in Δ_out : Ctxt} {t : Ty} 
    (lets : Lets Γ_in Γ_out) (v : Γ_out.Var t) (matchLets : Lets Δ_in Δ_out) (w : Δ_out.Var t) 
    (ma : Mapping Δ_in Γ_out := ∅) : 
    Option (Mapping Δ_in Γ_out) := 
  match matchLets, w with
    | .lete matchLets _, ⟨w+1, h⟩ => -- w† = Var.toSnoc w
        let w := ⟨w, by simp_all[Ctxt.snoc]⟩
        matchVar lets v matchLets w ma
    | .lete matchLets matchExpr, ⟨0, _⟩ => do -- w† = Var.last
        let e ← lets.getIExpr v
        match matchExpr, e with 
          | .cst n, .cst m =>
              if n = m then some ma
              else none
          | .add lhs rhs, .add v₁ v₂ => do
              let map₁ ← matchVar lets v₁ matchLets lhs ma
              let map₂ ← matchVar lets v₂ matchLets rhs map₁
              return map₂
          | _, _ =>
              none
    | .nil, w => -- The match expression is just a free (meta) variable
        match ma.lookup ⟨_, w⟩ with
        | some v₂ =>
          by
            exact if v = v₂
              then some ma
              else none
        | none => some (AList.insert ⟨_, w⟩ v ma) 

open AList

/-- For mathlib -/
theorem _root_.AList.mem_of_mem_entries {α : Type _} {β : α → Type _} {s : AList β} 
    {k : α} {v : β k} :
    ⟨k, v⟩ ∈ s.entries → k ∈ s := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp [(· ∈ ·), keys] at h |-
  clear nd;
  induction h
  next    => apply List.Mem.head
  next ih => apply List.Mem.tail _ ih

theorem _root_.AList.mem_entries_of_mem {α : Type _} {β : α → Type _} {s : AList β} {k : α} :
    k ∈ s → ∃ v, ⟨k, v⟩ ∈ s.entries := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp [(· ∈ ·), keys, List.keys] at h |-
  clear nd;
  induction entries
  next    => contradiction
  next hd tl ih => 
    cases h
    next =>
      use hd.snd
      apply List.Mem.head
    next h =>
      rcases ih h with ⟨v, ih⟩
      exact ⟨v, .tail _ ih⟩

theorem _root_.AList.keys_subset_keys_of_entries_subset_entries 
    {α : Type _} {β : α → Type _} 
    {s₁ s₂ : AList β} (h : s₁.entries ⊆ s₂.entries) : s₁.keys ⊆ s₂.keys := by
  intro k hk
  rcases mem_entries_of_mem hk with ⟨v, he⟩
  apply mem_of_mem_entries <| h he


/-- The output mapping of `matchVar` extends the input mapping when it succeeds. -/
theorem subset_entries_matchVar {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets Γ_in Γ_out} {v : Γ_out.Var t} :
    {matchLets : Lets Δ_in Δ_out} → {w : Δ_out.Var t} →
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
    . contradiction
    . simp at h
      split at h
      . split_ifs at h
        rw[Option.some_inj.mp h]
        intro x hx
        apply hx
      . split at h
        . contradiction
        next map₂ h_map₂ =>
          simp at h
          split at h
          . contradiction
          next map₁ h_map₁ =>
            simp [Pure.pure] at h
            subst h
            intro x hx
            apply subset_entries_matchVar h_map₁
            apply subset_entries_matchVar h_map₂
            apply hx
      . contradiction


instance (t : Ty) : Inhabited t.toType := by
  cases t <;> dsimp [Ty.toType] <;> infer_instance

theorem denote_matchVar_sub {lets : Lets Γ_in Γ_out} {v : Γ_out.Var t} 
    {varMap₁ varMap₂ : Mapping Δ_in Γ_out}
    {s₁ : Γ_in.Valuation} 
    {ma : Mapping Δ_in Γ_out} :
    {matchLets : Lets Δ_in Δ_out} → {w : Δ_out.Var t} → 
    (h_matchVar : varMap₁ ∈ matchVar lets v matchLets w ma) →
    (h_sub : varMap₁.entries ⊆ varMap₂.entries)  → 
    matchLets.denote (fun t' v' => by
        match varMap₂.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default 
        ) w = 
      lets.denote s₁ v
  | .nil, w => by
    simp[Lets.denote, matchVar]
    intro h_mv h_sub
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
        apply heq
    next =>
      rw [mem_lookup_iff.mpr]
      apply h_sub
      injection h_mv with h_mv
      rw[←h_mv]
      simp only [insert_entries, List.find?, List.mem_cons, true_or]
  | .lete matchLets _, ⟨w+1, h⟩ => by
    simp [matchVar]
    apply denote_matchVar_sub
  | .lete matchLets matchExpr, ⟨0, h_w⟩ => by
    rename_i t'
    have : t = t' := by simp[List.get?] at h_w; apply h_w.symm
    subst this
    simp [matchVar, Bind.bind, Option.bind]
    intro h_mv h_sub
    split at h_mv <;> try contradiction
    next e h_getIExpr =>
      simp only [h_getIExpr, bind_pure, Option.mem_def] at h_mv
      rw [←Lets.denote_getIExpr h_getIExpr]
      simp only [IExpr.denote, Lets.denote, Ctxt.Var.casesOn_last, eq_rec_constant]
      split at h_mv <;> try contradiction
      next =>
        split_ifs at h_mv
        injection h_mv with h_mv
      next =>
        split at h_mv
        next => contradiction
        next map₁ h_matchVar₁ =>
          simp at h_mv
          split at h_mv
          next => contradiction
          next map₂ h_matchVar₂ =>
            simp at h_mv
            injection h_mv with h_mv
            subst h_mv
            simp [Lets.denote, Ctxt.Var.casesOn, IExpr.denote]
            rw [denote_matchVar_sub h_matchVar₂ h_sub, denote_matchVar_sub h_matchVar₁]
            . intro x hx
              apply h_sub
              apply subset_entries_matchVar h_matchVar₂
              apply hx

theorem denote_matchVar {lets : Lets Γ_in Γ_out} {v : Γ_out.Var t} {varMap : Mapping Δ_in Γ_out}
    {s₁ : Γ_in.Valuation} 
    {ma : Mapping Δ_in Γ_out}
    {matchLets : Lets Δ_in Δ_out}
    {w : Δ_out.Var t} :
    varMap ∈ matchVar lets v matchLets w ma → 
    matchLets.denote (fun t' v' => by
        match varMap.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default 
        ) w = 
      lets.denote s₁ v :=
  fun h => denote_matchVar_sub h (fun _ => id)

/-- All variables containing in `matchExpr` are assigned by `matchVar`. -/
theorem mem_matchVar 
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets Γ_in Γ_out} {v : Γ_out.Var t} :
    {matchLets : Lets Δ_in Δ_out} → {w : Δ_out.Var t} →
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma) → 
    ∀ {t' v'}, v' ∈ matchLets.vars w t' → ⟨t', v'⟩ ∈ varMap
  | .nil, w, h, t', v' => by
    simp [Lets.vars]
    simp [matchVar] at h
    intro h_mem
    split_ifs at h_mem with t_eq <;> try contradiction
    subst t_eq
    simp at h_mem
    subst h_mem
    split at h
    next h_lookup =>
      split_ifs at h with v_eq
      subst v_eq
      injection h with h
      subst h
      apply mem_of_mem_entries
      apply mem_lookup_iff.mp h_lookup
    next =>
      injection h with h
      subst h
      apply (mem_insert _).mpr (.inl rfl)
    
  | .lete matchLets matchE, w, h, t', v' => by
    cases w using Ctxt.Var.casesOn
    next w =>
      simp [matchVar] at h
      apply mem_matchVar h
    next =>
      simp [Lets.vars]
      intro h_v'
      split at h_v' <;> try contradiction
      simp [Finset.mem_union.mp] at h_v'
      simp [matchVar, Bind.bind, Option.bind] at h
      split at h <;> try contradiction
      next e' h_getIExpr =>
        simp at h
        repeat
          split at h <;> try contradiction
          simp at h
        rename_i h_IExpr_eq _ _ map₁ h_map₁ _ _ map₂ h_map₂
        injection h with h
        injection h_IExpr_eq with h₁ h₂
        subst h h₁ h₂
        rcases h_v' with hv' | hv'
        . exact AList.keys_subset_keys_of_entries_subset_entries 
            (subset_entries_matchVar h_map₂) (mem_matchVar h_map₁ hv')
        . exact mem_matchVar h_map₂ hv'
        
      

/-- A version of `matchVar` that returns a `Hom` of `Ctxt`s instead of the `AList`,
provided every variable in the context appears as a free variable in `matchExpr`. -/
def matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt} {t : Ty} 
    (lets : Lets Γ_in Γ_out) (v : Γ_out.Var t) (matchLets : Lets Δ_in Δ_out) (w : Δ_out.Var t)
    (hvars : ∀ t (v : Δ_in.Var t), v ∈ matchLets.vars w t) : 
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

theorem denote_matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt}
    {lets : Lets Γ_in Γ_out}
    {t : Ty} {v : Γ_out.Var t} 
    {matchLets : Lets Δ_in Δ_out} 
    {w : Δ_out.Var t}
    {hvars : ∀ t (v : Δ_in.Var t), v ∈ matchLets.vars w t} 
    {map : Δ_in.Hom Γ_out}
    (hmap : map ∈ matchVarMap lets v matchLets w hvars) (s₁ : Γ_in.Valuation) :
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
    (hlhs : ∀ t (v : Γ₁.Var t), v ∈ lhs.vars t)
    (pos : ℕ) (target : ICom Γ₂ t₂) :
    Option (ICom Γ₂ t₂) := do
  let ⟨Γ₃, lets, target', t', vm⟩ ← splitProgramAt pos target
  if h : t₁ = t'
  then 
    let flatLhs := lhs.toLets
    let m ← matchVarMap lets vm flatLhs.lets (h ▸ flatLhs.ret) 
      (by subst h; exact hlhs)
    return addProgramInMiddle vm m lets (h ▸ rhs) target'
  else none

theorem denote_rewriteAt (lhs rhs : ICom Γ₁ t₁)
    (hlhs : ∀ t (v : Γ₁.Var t), v ∈ lhs.vars t)
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
      simp only [ICom.denote_toLets] at this
      simp only [this, ← denote_splitProgramAt hs s]
      congr
      funext t' v'
      simp only [dite_eq_right_iff, forall_exists_index]
      rintro rfl rfl
      simp
 
/--
  Rewrites are indexed with a concrete list of types, rather than an (erased) context, so that
  the required variable checks become decidable
-/
structure PeepholeRewrite (Γ : List Ty) (t : Ty) where
  lhs : ICom (.ofList Γ) t
  rhs : ICom (.ofList Γ) t
  correct : lhs.denote = rhs.denote

#synth Decidable (?v ∈ ICom.vars ?com ?t)

instance {Γ : List Ty} {t' : Ty} {lhs : ICom (.ofList Γ) t'} :
    Decidable (∀ (t : Ty) (v : Ctxt.Var (.ofList Γ) t), v ∈ lhs.vars t) :=   
  decidable_of_iff 
    (∀ (i : Fin Γ.length), 
      let v : Ctxt.Var (.ofList Γ) (Γ.get i) := ⟨i, by simp [List.get?_eq_get, Ctxt.ofList]⟩
      v ∈ lhs.vars (Γ.get i)) <|  by
  constructor
  . intro h t v
    rcases v with ⟨i, hi⟩
    simp only [Erased.out_mk] at hi  
    rcases List.get?_eq_some.1 hi with ⟨h', rfl⟩
    simp at h'
    convert h ⟨i, h'⟩
  . intro h i
    apply h

def rewritePeepholeAt (pr : PeepholeRewrite Γ t) 
    (pos : ℕ) (target : ICom Γ₂ t₂) :
    (ICom Γ₂ t₂) := if hlhs : ∀ t (v : Ctxt.Var (.ofList Γ) t), v ∈ pr.lhs.vars t then
      match rewriteAt pr.lhs pr.rhs hlhs pos target
      with 
        | some res => res
        | none => target
      else target

theorem denote_rewritePeepholeAt (pr : PeepholeRewrite Γ t)
    (pos : ℕ) (target : ICom Γ₂ t₂) :
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

macro "simp_peephole": tactic =>
  `(tactic|
      (
      funext ll
      simp only [ICom.denote, IExpr.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.snoc, Ctxt.Valuation.snoc_last, Ctxt.Valuation.snoc_toSnoc]
      generalize ll { val := 0, property := _ } = a;
      generalize ll { val := 1, property := _ } = b;
      generalize ll { val := 2, property := _ } = c;
      generalize ll { val := 3, property := _ } = d;
      generalize ll { val := 4, property := _ } = e;
      generalize ll { val := 5, property := _ } = f;
      unfold Ty.toType at a b c d e f;
      simp at a b c d e f;
      try clear f;
      try clear e;
      try clear d;
      try clear c;
      try clear b;
      try clear a;
      try revert f;
      try revert e;
      try revert d;
      try revert c;
      try revert b;
      try revert a;
      clear ll;
      )
   )

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
def m : ICom (.ofList [.nat, .nat]) .nat := 
  .lete (.add ⟨0, by simp⟩ ⟨1, by simp⟩) (.ret ⟨0, by simp⟩)
def r : ICom (.ofList [.nat, .nat]) .nat := 
  .lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) (.ret ⟨0, by simp⟩)

def p1 : PeepholeRewrite [.nat, .nat] .nat:=
  { lhs := m, rhs := r, correct :=
    by
      simp_peephole
      intros a b
      rw [Nat.add_comm]
    }

example : rewritePeepholeAt p1 1 ex1 = (
  ICom.lete (IExpr.cst 1)  <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩)  <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩)  <|
     .ret ⟨0, by simp⟩) := by rfl

-- a + b => b + a
example : rewritePeepholeAt p1 0 ex1 = ex1 := by rfl

example : rewritePeepholeAt p1 1 ex2 = (
  ICom.lete (IExpr.cst 1)   <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨0, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩ ) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewritePeepholeAt p1 2 ex2 = (
  ICom.lete (IExpr.cst 1)   <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨2, by simp⟩) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨2, by simp⟩) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewritePeepholeAt p1 3 ex2 = (
  ICom.lete (IExpr.cst 1)   <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (IExpr.add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p1 4 ex2 = (
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
def r2 : ICom (.ofList [.nat, .nat]) .nat :=
  .lete (.cst 0) <|
  .lete (.add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨3, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩ 

def p2 : PeepholeRewrite [.nat, .nat] .nat:=
  { lhs := m, rhs := r2, correct :=
    by
      simp_peephole
      intros a b
      rw [Nat.zero_add]
      rw [Nat.add_comm]
    }

example : rewritePeepholeAt p2 1 ex2' = (
     .lete (IExpr.cst 1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.cst 0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (IExpr.add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 2 ex2 = (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 3 ex2 = (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 4 ex2 = (
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
def r3 : ICom (.ofList [.nat, .nat]) .nat := 
  .lete (.cst 0) <|
  .lete (.add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨0, by simp⟩ ⟨3, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p3 : PeepholeRewrite [.nat, .nat] .nat:=
  { lhs := m, rhs := r3, correct :=
    by
      simp_peephole
      intros a b
      rw [Nat.zero_add]
    }

example : rewritePeepholeAt p3 1 ex2 = (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 2 ex2 = (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 3 ex2 = (
  ICom.lete (IExpr.cst  1) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (IExpr.add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (IExpr.cst  0) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (IExpr.add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (IExpr.add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 4 ex2 = (
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

def p4 : PeepholeRewrite [.nat, .nat] .nat:=
  { lhs := r3, rhs := m, correct :=
    by
      simp_peephole
      intros a b
      rw [Nat.zero_add]
    }

example : rewritePeepholeAt p4 5 ex3 = (
  .lete (.cst 1) <|
  .lete (.cst 0) <|
  .lete (.cst 2) <|
  .lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete (.add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete (.add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete (.add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩) := rfl