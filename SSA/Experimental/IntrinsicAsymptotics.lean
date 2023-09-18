-- Investigations on asymptotic behavior of representing programs with large explicit contexts

import SSA.Experimental.ErasedContext
import SSA.Experimental.HVector
import Mathlib.Data.List.AList
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Fintype.Basic
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open Ctxt (Var VarSet)
open Goedel (toType)

/-
  # Classes
-/

class OpSignature (Op : Type) (Ty : outParam (Type)) where
  sig : Op → List Ty
  outTy : Op → Ty

class OpDenote (Op Ty : Type) [Goedel Ty] [OpSignature Op Ty] where
  denote : (op : Op) → HVector toType (OpSignature.sig op) → (toType <| OpSignature.outTy op)

/-
  # Datastructures
-/

variable (Op : Type) {Ty : Type} [OpSignature Op Ty]

/-- A very simple intrinsically typed expression. -/
structure IExpr (Γ : Ctxt Ty) (ty : Ty) : Type :=
  (op : Op)
  (ty_eq : ty = OpSignature.outTy op)
  (args : HVector (Ctxt.Var Γ) <| OpSignature.sig op)
  deriving Repr

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive ICom : Ctxt Ty → Ty → Type where
  | ret (v : Γ.Var t) : ICom Γ t
  | lete (e : IExpr Op Γ α) (body : ICom (Γ.snoc α) β) : ICom Γ β
  deriving Repr

/-- `Lets Op Γ₁ Γ₂` is a sequence of lets which are well-formed under context `Γ₂` and result in
    context `Γ₁`-/
inductive Lets : Ctxt Ty → Ctxt Ty → Type where
  | nil {Γ : Ctxt Ty} : Lets Γ Γ
  | lete (body : Lets Γ₁ Γ₂) (e : IExpr Op Γ₂ t) : Lets Γ₁ (Γ₂.snoc t)
  deriving Repr

/-
  # Definitions
-/

variable {Op Ty : Type} [OpSignature Op Ty]

-- TODO: the following `variable` probably means we include these assumptions also in definitions
-- that might not strictly need them, we can look into making this more fine-grained
variable [Goedel Ty] [OpDenote Op Ty] [DecidableEq Ty]

def IExpr.denote : {ty : Ty} → (e : IExpr Op Γ ty) → (Γv : Γ.Valuation) → (toType ty)
  | _, ⟨op, Eq.refl _, args⟩, Γv => OpDenote.denote op <| args.map (fun _ v => Γv v)

def ICom.denote : ICom Op Γ ty → (Γv : Γ.Valuation) → (toType ty)
  | .ret e, Γv => Γv e
  | .lete e body, Γv => body.denote (Γv.snoc (e.denote Γv))

def Lets.denote : Lets Op Γ₁ Γ₂ → Γ₁.Valuation → Γ₂.Valuation
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
    {ty : Ty} → (e : IExpr Op Γ ty) → IExpr Op Γ' ty
  | _, ⟨op, Eq.refl _, args⟩ => ⟨op, rfl, args.map varsMap⟩

@[simp]
theorem IExpr.denote_changeVars {Γ Γ' : Ctxt Ty}
    (varsMap : Γ.Hom Γ')
    (e : IExpr Op Γ ty)
    (Γ'v : Γ'.Valuation) :
    (e.changeVars varsMap).denote Γ'v =
    e.denote (fun t v => Γ'v (varsMap v)) := by
  rcases e with ⟨_, rfl, _⟩
  simp [IExpr.denote, IExpr.changeVars, HVector.map_map]

def ICom.changeVars
    (varsMap : Γ.Hom Γ') :
    ICom Op Γ ty → ICom Op Γ' ty
  | .ret e => .ret (varsMap e)
  | .lete e body => .lete (e.changeVars varsMap)
      (body.changeVars (fun t v => varsMap.snocMap v))

@[simp]
theorem ICom.denote_changeVars
    (varsMap : Γ.Hom Γ') (c : ICom Op Γ ty)
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


variable (Op : _) {Ty : _} [OpSignature Op Ty] in
/-- The result returned by `addProgramToLets` -/
structure addProgramToLets.Result (Γ_in Γ_out : Ctxt Ty) (ty : Ty) where
  /-- The new out context -/
  {Γ_out_new : Ctxt Ty}
  /-- The new `lets`, with the program added to it -/
  lets : Lets Op Γ_in Γ_out_new
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
def addProgramToLets (lets : Lets Op Γ_in Γ_out) (varsMap : Δ.Hom Γ_out) : ICom Op Δ ty →
    addProgramToLets.Result Op Γ_in Γ_out ty
  | .ret v => ⟨lets, .zero _, varsMap v⟩
  | .lete (α:=α) e body =>
      let lets := Lets.lete lets (e.changeVars varsMap)
      let ⟨lets', diff, v'⟩ := addProgramToLets lets (varsMap.snocMap) body
      ⟨lets', diff.unSnoc, v'⟩

theorem denote_addProgramToLets_lets (lets : Lets Op Γ_in Γ_out) {map} {com : ICom Op Δ t}
    (ll : Γ_in.Valuation) ⦃t⦄ (var : Γ_out.Var t) :
    (addProgramToLets lets map com).lets.denote ll ((addProgramToLets lets map com).diff.toHom var)
    = lets.denote ll var := by
  induction com generalizing lets Γ_out
  next =>
    rfl
  next e body ih =>
    simp[addProgramToLets, ih, Lets.denote]

theorem denote_addProgramToLets_var {lets : Lets Op Γ_in Γ_out} {map} {com : ICom Op Δ t} :
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
def addLetsAtTop : (lets : Lets Op Γ₁ Γ₂) → (inputProg : ICom Op Γ₂ t₂) → ICom Op Γ₁ t₂
  | Lets.nil, inputProg => inputProg
  | Lets.lete body e, inputProg =>
    addLetsAtTop body (.lete e inputProg)

theorem denote_addLetsAtTop :
    (lets : Lets Op Γ₁ Γ₂) → (inputProg : ICom Op Γ₂ t₂) →
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
def addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt Ty} (v : Γ₂.Var t₁)
    (map : Γ₃.Hom Γ₂)
    (lets : Lets Op Γ₁ Γ₂) (rhs : ICom Op Γ₃ t₁)
    (inputProg : ICom Op Γ₂ t₂) : ICom Op Γ₁ t₂ :=
  let r := addProgramToLets lets map rhs
  addLetsAtTop r.lets <| inputProg.changeVars (r.diff.toHom.with v r.var)

theorem denote_addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt Ty}
    (v : Γ₂.Var t₁) (s : Γ₁.Valuation)
    (map : Γ₃.Hom Γ₂)
    (lets : Lets Op Γ₁ Γ₂) (rhs : ICom Op Γ₃ t₁)
    (inputProg : ICom Op Γ₂ t₂) :
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

structure FlatICom (Op : _) {Ty : _} [OpSignature Op Ty] (Γ : Ctxt Ty) (t : Ty) where
  {Γ_out : Ctxt Ty}
  /-- The let bindings of the original program -/
  lets : Lets Op Γ Γ_out
  /-- The return variable -/
  ret : Γ_out.Var t

def ICom.toLets {t : Ty} : ICom Op Γ t → FlatICom Op Γ t :=
  go .nil
where
  go {Γ_out} (lets : Lets Op Γ Γ_out) : ICom Op Γ_out t → FlatICom Op Γ t
    | .ret v => ⟨lets, v⟩
    | .lete e body => go (lets.lete e) body

@[simp]
theorem ICom.denote_toLets_go (lets : Lets Op Γ_in Γ_out) (com : ICom Op Γ_out t) (s : Γ_in.Valuation) :
    (toLets.go lets com).lets.denote s (toLets.go lets com).ret = com.denote (lets.denote s) := by
  induction com
  . rfl
  next ih =>
    simp [toLets.go, denote, ih]
    congr
    funext _ v
    cases v using Ctxt.Var.casesOn <;> simp[Lets.denote]

@[simp]
theorem ICom.denote_toLets (com : ICom Op Γ t) (s : Γ.Valuation) :
    com.toLets.lets.denote s com.toLets.ret = com.denote s :=
  denote_toLets_go ..

/-- Get the `IExpr` that a var `v` is assigned to in a sequence of `Lets`,
    without adjusting variables
-/
def Lets.getIExprAux {Γ₁ Γ₂ : Ctxt Ty} {t : Ty} : Lets Op Γ₁ Γ₂ → Γ₂.Var t →
    Option ((Δ : Ctxt Ty) × IExpr Op Δ t)
  | .nil, _ => none
  | .lete lets e, v => by
    cases v using Ctxt.Var.casesOn with
      | toSnoc v => exact (Lets.getIExprAux lets v)
      | last => exact some ⟨_, e⟩

/-- If `getIExprAux` succeeds,
    then the orignal context `Γ₁` is a prefix of the local context `Δ`, and
    their difference is exactly the value of the requested variable index plus 1
-/
def Lets.getIExprAuxDiff {lets : Lets Op Γ₁ Γ₂} {v : Γ₂.Var t}
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

theorem Lets.denote_getIExprAux {Γ₁ Γ₂ Δ : Ctxt Ty} {t : Ty}
    {lets : Lets Op Γ₁ Γ₂} {v : Γ₂.Var t} {e : IExpr Op Δ t}
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
def Lets.getIExpr {Γ₁ Γ₂ : Ctxt Ty} (lets : Lets Op Γ₁ Γ₂) {t : Ty} (v : Γ₂.Var t) :
    Option (IExpr Op Γ₂ t) :=
  match h : getIExprAux lets v with
  | none => none
  | some r => r.snd.changeVars (getIExprAuxDiff h).toHom

theorem Lets.denote_getIExpr {Γ₁ Γ₂ : Ctxt Ty} : {lets : Lets Op Γ₁ Γ₂} → {t : Ty} →
    {v : Γ₂.Var t} → {e : IExpr Op Γ₂ t} → (he : lets.getIExpr v = some e) → (s : Γ₁.Valuation) →
    e.denote (lets.denote s) = (lets.denote s) v := by
  intros lets _ v e he s
  simp [getIExpr] at he
  split at he
  . contradiction
  . rw[←Option.some_inj.mp he, denote_getIExprAux]



/-
  ## Matching
-/

abbrev Mapping (Γ Δ : Ctxt Ty) : Type :=
  @AList (Σ t, Γ.Var t) (fun x => Δ.Var x.1)

def HVector.toVarSet : {l : List Ty} → (T : HVector (Ctxt.Var Γ) l) → Γ.VarSet
  | [], .nil => ∅
  | _::_, .cons v vs => insert ⟨_, v⟩ vs.toVarSet

def HVector.vars {l : List Ty}
    (T : HVector (Ctxt.Var Γ) l) : VarSet Γ :=
  T.foldl (fun _ s a => insert ⟨_, a⟩ s) ∅

@[simp]
theorem HVector.vars_nil :
    (HVector.nil : HVector (Ctxt.Var Γ) ([] : List Ty)).vars = ∅ := by
  simp [HVector.vars, HVector.foldl]

@[simp]
theorem HVector.vars_cons {t  : Ty} {l : List Ty}
    (v : Ctxt.Var Γ t) (T : HVector (Ctxt.Var Γ) l) :
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
def Lets.vars : Lets Op Γ_in Γ_out → Γ_out.Var t → Γ_in.VarSet
  | .nil, v => VarSet.ofVar v
  | .lete lets e, v => by
      cases v using Ctxt.Var.casesOn with
      | toSnoc v => exact lets.vars v
      -- this is wrong
      | last => exact (e.args.vars).biUnion (fun v => lets.vars v.2)

theorem HVector.map_eq_of_eq_on_vars {A : Ty → Type*}
    {T : HVector (Ctxt.Var Γ) l}
    {s₁ s₂ : ∀ (t), Γ.Var t → A t}
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

theorem Lets.denote_eq_of_eq_on_vars (lets : Lets Op Γ_in Γ_out)
    (v : Γ_out.Var t)
    {s₁ s₂ : Γ_in.Valuation}
    (h : ∀ w, w ∈ lets.vars v → s₁ w.2 = s₂ w.2) :
    lets.denote s₁ v = lets.denote s₂ v := by
  induction lets generalizing t
  next =>
    simp [vars] at h
    simp [denote, h]
  next lets e ih =>
    cases v using Ctxt.Var.casesOn
    . simp [vars] at h
      simp [denote]
      apply ih
      simpa
    . rcases e with ⟨op, rfl, args⟩
      simp [denote, IExpr.denote]
      congr 1
      apply HVector.map_eq_of_eq_on_vars
      intro v h'
      apply ih
      intro v' hv'
      apply h
      rw [vars, Var.casesOn_last]
      simp
      use v.1, v.2

def ICom.vars : ICom Op Γ t → Γ.VarSet :=
  fun com => com.toLets.lets.vars com.toLets.ret

/--
  Given two sequences of lets, `lets` and `matchExpr`,
  and variables that indicate an expression, of the same type, in each sequence,
  attempt to assign free variables in `matchExpr` to variables (free or bound) in `lets`, such that
  the original two variables are semantically equivalent.
  If this succeeds, return the mapping.
-/

def matchVar {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty} {t : Ty} [DecidableEq Op]
    (lets : Lets Op Γ_in Γ_out) (v : Γ_out.Var t) :
    (matchLets : Lets Op Δ_in Δ_out) →
    (w : Δ_out.Var t) →
    (ma : Mapping Δ_in Γ_out := ∅) →
    Option (Mapping Δ_in Γ_out)
  | .lete matchLets _, ⟨w+1, h⟩, ma => -- w† = Var.toSnoc w
      let w := ⟨w, by simp_all[Ctxt.snoc]⟩
      matchVar lets v matchLets w ma
  | @Lets.lete _ _ _ _ Δ_out _ matchLets matchExpr, ⟨0, _⟩, ma => do -- w† = Var.last
      let ⟨op, _, args⟩ ← lets.getIExpr v
      let ⟨op', _, args'⟩ := matchExpr
      if hs : op = op'
      then
        -- hack to make a termination proof work
        let matchVar' := fun t vₗ vᵣ ma =>
            matchVar (t := t) lets vₗ matchLets vᵣ ma
        let rec matchArg : ∀ {l : List Ty}
            (_Tₗ : HVector (Var Γ_out) l) (_Tᵣ :  HVector (Var Δ_out) l),
            Mapping Δ_in Γ_out → Option (Mapping Δ_in Γ_out)
          | _, .nil, .nil, ma => some ma
          | t::l, .cons vₗ vsₗ, .cons vᵣ vsᵣ, ma => do
              let ma ← matchVar' _ vₗ vᵣ ma
              matchArg vsₗ vsᵣ ma
        matchArg args (hs ▸ args') ma
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

/-- For mathlib -/
theorem _root_.AList.mem_of_mem_entries {α : Type _} {β : α → Type _} {s : AList β}
    {k : α} {v : β k} :
    ⟨k, v⟩ ∈ s.entries → k ∈ s := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp [(· ∈ ·), keys] at h ⊢
  clear nd
  induction h
  next    => apply List.Mem.head
  next ih => apply List.Mem.tail _ ih

theorem _root_.AList.mem_entries_of_mem {α : Type _} {β : α → Type _} {s : AList β} {k : α} :
    k ∈ s → ∃ v, ⟨k, v⟩ ∈ s.entries := by
  intro h
  rcases s with ⟨entries, nd⟩
  simp [(· ∈ ·), keys, List.keys] at h ⊢
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

theorem subset_entries_matchVar_matchArg_aux
    {Γ_out Δ_in Δ_out  : Ctxt Ty}
    {matchVar' : (t : Ty) → Var Γ_out t → Var Δ_out t →
      Mapping Δ_in Γ_out → Option (Mapping Δ_in Γ_out)} :
    {l : List Ty} → {argsₗ : HVector (Var Γ_out) l} →
    {argsᵣ : HVector (Var Δ_out) l} → {ma : Mapping Δ_in Γ_out} →
    {varMap : Mapping Δ_in Γ_out} →
    (hmatchVar : ∀ vMap (t : Ty) (vₗ vᵣ) ma,
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
theorem subset_entries_matchVar [DecidableEq Op]
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets Op Γ_in Γ_out} {v : Γ_out.Var t} :
    {matchLets : Lets Op Δ_in Δ_out} → {w : Δ_out.Var t} →
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
      · subst op
        dsimp at h
        exact subset_entries_matchVar_matchArg_aux
          (fun vMap t vₗ vᵣ ma hvMap => subset_entries_matchVar hvMap) h

theorem subset_entries_matchVar_matchArg [DecidableEq Op]
    {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty} {lets : Lets Op Γ_in Γ_out}
    {matchLets : Lets Op Δ_in Δ_out} :
    {l : List Ty} → {argsₗ : HVector (Var Γ_out) l} →
    {argsᵣ : HVector (Var Δ_out) l} → {ma : Mapping Δ_in Γ_out} →
    {varMap : Mapping Δ_in Γ_out} →
    (hvarMap : varMap ∈ matchVar.matchArg Δ_out
        (fun t vₗ vᵣ ma =>
            matchVar (t := t) lets vₗ matchLets vᵣ ma) argsₗ argsᵣ ma) →
    ma.entries ⊆ varMap.entries :=
  subset_entries_matchVar_matchArg_aux (fun _ _ _ _ _ => subset_entries_matchVar)

-- TODO: this assumption is too strong, we also want to be able to model non-inhabited types
variable [∀ (t : Ty), Inhabited (toType t)] [DecidableEq Op]

theorem denote_matchVar_matchArg [DecidableEq Op]
    {Γ_out Δ_in Δ_out : Ctxt Ty} {lets : Lets Op Γ_in Γ_out}
    {matchLets : Lets Op Δ_in Δ_out} :
    {l : List Ty} →
    {args₁ : HVector (Var Γ_out) l} →
    {args₂ : HVector (Var Δ_out) l} →
    {ma varMap₁ varMap₂ : Mapping Δ_in Γ_out} →
    (h_sub : varMap₁.entries ⊆ varMap₂.entries) →
    (f₁ : (t : Ty) → Var Γ_out t → toType t) →
    (f₂ : (t : Ty) → Var Δ_out t → toType t) →
    (hf : ∀ t v₁ v₂ (ma : Mapping Δ_in Γ_out) (ma'),
      (ma ∈ matchVar lets v₁ matchLets v₂ ma') →
      ma.entries ⊆ varMap₂.entries → f₂ t v₂ = f₁ t v₁) →
    (hmatchVar : ∀ vMap (t : Ty) (vₗ vᵣ) ma,
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
    {lets : Lets Op Γ_in Γ_out} {v : Γ_out.Var t}
    {varMap₁ varMap₂ : Mapping Δ_in Γ_out}
    {s₁ : Γ_in.Valuation}
    {ma : Mapping Δ_in Γ_out} :
    {matchLets : Lets Op Δ_in Δ_out} → {w : Δ_out.Var t} →
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
      rcases e with ⟨op₁, rfl, args₁⟩
      rcases matchExpr with ⟨op₂, h, args₂⟩
      dsimp at h_mv
      split_ifs at h_mv
      · subst op₁
        simp [Lets.denote, IExpr.denote]
        rw [← Lets.denote_getIExpr he]
        clear he
        dsimp [IExpr.denote]
        congr 1
        apply denote_matchVar_matchArg (hvarMap := h_mv) h_sub
        · intro t v₁ v₂ ma ma' hmem hma
          apply denote_matchVar_of_subset hma
          apply hmem
        · exact (fun _ _ _ _ _ h => subset_entries_matchVar h)

theorem denote_matchVar {lets : Lets Op Γ_in Γ_out} {v : Γ_out.Var t} {varMap : Mapping Δ_in Γ_out}
    {s₁ : Γ_in.Valuation}
    {ma : Mapping Δ_in Γ_out}
    {matchLets : Lets Op Δ_in Δ_out}
    {w : Δ_out.Var t} :
    varMap ∈ matchVar lets v matchLets w ma →
    matchLets.denote (fun t' v' => by
        match varMap.lookup ⟨_, v'⟩  with
        | some v' => exact lets.denote s₁ v'
        | none => exact default
        ) w =
      lets.denote s₁ v :=
  denote_matchVar_of_subset (List.Subset.refl _)

theorem lt_one_add_add (a b : ℕ) : b < 1 + a + b := by
  simp (config := { arith := true }); exact Nat.zero_le _

@[simp]
theorem zero_eq_zero : (Zero.zero : ℕ) = 0 := rfl

attribute [simp] lt_one_add_add

macro_rules | `(tactic| decreasing_trivial) => `(tactic| simp (config := {arith := true}))

mutual

theorem mem_matchVar_matchArg
    {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty} {lets : Lets Op Γ_in Γ_out}
    {matchLets : Lets Op Δ_in Δ_out} :
    {l : List Ty} → {argsₗ : HVector (Var Γ_out) l} →
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
    {lets : Lets Op Γ_in Γ_out} {v : Γ_out.Var t} :
    {matchLets : Lets Op Δ_in Δ_out} → {w : Δ_out.Var t} →
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
    cases w using Ctxt.Var.casesOn
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
        subst h
        exact hl

end
termination_by
  mem_matchVar_matchArg _ _ _ _ _ matchLets args _ _ _ _ _ _ _ => (sizeOf matchLets, sizeOf args)
  mem_matchVar _ _ _ _ matchLets _ _ _ _ => (sizeOf matchLets, 0)

/-- A version of `matchVar` that returns a `Hom` of `Ctxt`s instead of the `AList`,
provided every variable in the context appears as a free variable in `matchExpr`. -/
def matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty} {t : Ty}
    (lets : Lets Op Γ_in Γ_out) (v : Γ_out.Var t) (matchLets : Lets Op Δ_in Δ_out) (w : Δ_out.Var t)
    (hvars : ∀ t (v : Δ_in.Var t), ⟨t, v⟩ ∈ matchLets.vars w) :
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

theorem denote_matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt Ty}
    {lets : Lets Op Γ_in Γ_out}
    {t : Ty} {v : Γ_out.Var t}
    {matchLets : Lets Op Δ_in Δ_out}
    {w : Δ_out.Var t}
    {hvars : ∀ t (v : Δ_in.Var t), ⟨t, v⟩ ∈ matchLets.vars w}
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
def splitProgramAtAux : (pos : ℕ) → (lets : Lets Op Γ₁ Γ₂) →
    (prog : ICom Op Γ₂ t) →
    Option (Σ (Γ₃ : Ctxt Ty), Lets Op Γ₁ Γ₃ × ICom Op Γ₃ t × (t' : Ty) × Γ₃.Var t')
  | 0, lets, .lete e body => some ⟨_, .lete lets e, body, _, Ctxt.Var.last _ _⟩
  | _, _, .ret _ => none
  | n+1, lets, .lete e body =>
    splitProgramAtAux n (lets.lete e) body

theorem denote_splitProgramAtAux : {pos : ℕ} → {lets : Lets Op Γ₁ Γ₂} →
    {prog : ICom Op Γ₂ t} →
    {res : Σ (Γ₃ : Ctxt Ty), Lets Op Γ₁ Γ₃ × ICom Op Γ₃ t × (t' : Ty) × Γ₃.Var t'} →
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
def splitProgramAt (pos : ℕ) (prog : ICom Op Γ₁ t) :
    Option (Σ (Γ₂ : Ctxt Ty), Lets Op Γ₁ Γ₂ × ICom Op Γ₂ t × (t' : Ty) × Γ₂.Var t') :=
  splitProgramAtAux pos .nil prog

theorem denote_splitProgramAt {pos : ℕ} {prog : ICom Op Γ₁ t}
    {res : Σ (Γ₂ : Ctxt Ty), Lets Op Γ₁ Γ₂ × ICom Op Γ₂ t × (t' : Ty) × Γ₂.Var t'}
    (hres : res ∈ splitProgramAt pos prog) (s : Γ₁.Valuation) :
    res.2.2.1.denote (res.2.1.denote s) = prog.denote s :=
  denote_splitProgramAtAux hres s



/-
  ## Rewriting
-/

/-- `rewriteAt lhs rhs hlhs pos target`, searches for `lhs` at position `pos` of
`target`. If it can match the variables, it inserts `rhs` into the program
with the correct assignment of variables, and then replaces occurences
of the variable at position `pos` in `target` with the output of `rhs`.  -/
def rewriteAt (lhs rhs : ICom Op Γ₁ t₁)
    (hlhs : ∀ t (v : Γ₁.Var t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : ICom Op Γ₂ t₂) :
    Option (ICom Op Γ₂ t₂) := do
  let ⟨Γ₃, lets, target', t', vm⟩ ← splitProgramAt pos target
  if h : t₁ = t'
  then
    let flatLhs := lhs.toLets
    let m ← matchVarMap lets vm flatLhs.lets (h ▸ flatLhs.ret)
      (by subst h; exact hlhs)
    return addProgramInMiddle vm m lets (h ▸ rhs) target'
  else none

theorem denote_rewriteAt (lhs rhs : ICom Op Γ₁ t₁)
    (hlhs : ∀ t (v : Γ₁.Var t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : ICom Op Γ₂ t₂)
    (hl : lhs.denote = rhs.denote)
    (rew : ICom Op Γ₂ t₂)
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

variable (Op : _) {Ty : _} [OpSignature Op Ty] [Goedel Ty] [OpDenote Op Ty] in
/--
  Rewrites are indexed with a concrete list of types, rather than an (erased) context, so that
  the required variable checks become decidable
-/
structure PeepholeRewrite (Γ : List Ty) (t : Ty) where
  lhs : ICom Op (.ofList Γ) t
  rhs : ICom Op (.ofList Γ) t
  correct : lhs.denote = rhs.denote

instance {Γ : List Ty} {t' : Ty} {lhs : ICom Op (.ofList Γ) t'} :
    Decidable (∀ (t : Ty) (v : Ctxt.Var (.ofList Γ) t), ⟨t, v⟩ ∈ lhs.vars) :=
  decidable_of_iff
    (∀ (i : Fin Γ.length),
      let v : Ctxt.Var (.ofList Γ) (Γ.get i) := ⟨i, by simp [List.get?_eq_get, Ctxt.ofList]⟩
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

def rewritePeepholeAt (pr : PeepholeRewrite Op Γ t)
    (pos : ℕ) (target : ICom Op Γ₂ t₂) :
    (ICom Op Γ₂ t₂) := if hlhs : ∀ t (v : Ctxt.Var (.ofList Γ) t), ⟨_, v⟩ ∈ pr.lhs.vars then
      match rewriteAt pr.lhs pr.rhs hlhs pos target
      with
        | some res => res
        | none => target
      else target

theorem denote_rewritePeepholeAt (pr : PeepholeRewrite Op Γ t)
    (pos : ℕ) (target : ICom Op Γ₂ t₂) :
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



/-
  ## Examples
-/

namespace Examples

/-- A very simple type universe. -/
inductive ExTy
  | nat
  | bool
  deriving DecidableEq, Repr

@[reducible]
instance : Goedel ExTy where
  toType
    | .nat => Nat
    | .bool => Bool

inductive ExOp :  Type
  | add : ExOp
  | beq : ExOp
  | cst : ℕ → ExOp
  deriving DecidableEq

instance : OpSignature ExOp ExTy where
  outTy
    | .add => .nat
    | .beq => .bool
    | .cst _ => .nat
  sig
    | .add => [.nat, .nat]
    | .beq => [.nat, .nat]
    | .cst _ => []

@[reducible]
instance : OpDenote ExOp ExTy where
  denote
    | .cst n, _ => n
    | .add, .cons (a : Nat) (.cons b .nil) => a + b
    | .beq, .cons (a : Nat) (.cons b .nil) => a == b

def cst {Γ : Ctxt _} (n : ℕ) : IExpr ExOp Γ .nat  :=
  { op := .cst n
    ty_eq := rfl
    args := .nil }

def add {Γ : Ctxt _} (e₁ e₂ : Var Γ .nat) : IExpr ExOp Γ .nat :=
  { op := .add
    ty_eq := rfl
    args := .cons e₁ <| .cons e₂ .nil }

macro "simp_peephole": tactic =>
  `(tactic|
      (
      funext ll
      simp only [ICom.denote, IExpr.denote, Var.zero_eq_last, Var.succ_eq_toSnoc,
        Ctxt.snoc, Ctxt.Valuation.snoc_last, Ctxt.Valuation.snoc_toSnoc, add,
        cst, HVector.map, OpDenote.denote]
      generalize ll { val := 0, property := _ } = a;
      generalize ll { val := 1, property := _ } = b;
      generalize ll { val := 2, property := _ } = c;
      generalize ll { val := 3, property := _ } = d;
      generalize ll { val := 4, property := _ } = e;
      generalize ll { val := 5, property := _ } = f;
      simp [Goedel.toType] at a b c d e f;
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

def ex1 : ICom ExOp ∅ .nat :=
  ICom.lete (cst 1) <|
  ICom.lete (add ⟨0, by simp [Ctxt.snoc]⟩ ⟨0, by simp [Ctxt.snoc]⟩ ) <|
  ICom.ret ⟨0, by simp [Ctxt.snoc]⟩

def ex2 : ICom ExOp ∅ .nat :=
  ICom.lete (cst 1) <|
  ICom.lete (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  ICom.lete (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  ICom.lete (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
  ICom.lete (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
  ICom.ret ⟨0, by simp⟩

-- a + b => b + a
def m : ICom ExOp (.ofList [.nat, .nat]) .nat :=
  .lete (add ⟨0, by simp⟩ ⟨1, by simp⟩) (.ret ⟨0, by simp⟩)
def r : ICom ExOp (.ofList [.nat, .nat]) .nat :=
  .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩) (.ret ⟨0, by simp⟩)

def p1 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := m, rhs := r, correct :=
    by
      simp_peephole
      intros a b
      rw [Nat.add_comm]
    }

example : rewritePeepholeAt p1 1 ex1 = (
  ICom.lete (cst 1)  <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩)  <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩)  <|
     .ret ⟨0, by simp⟩) := by rfl

-- a + b => b + a
example : rewritePeepholeAt p1 0 ex1 = ex1 := by rfl

example : rewritePeepholeAt p1 1 ex2 = (
  ICom.lete (cst 1)   <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .lete (add ⟨2, by simp⟩ ⟨0, by simp⟩) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩ ) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewritePeepholeAt p1 2 ex2 = (
  ICom.lete (cst 1)   <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
     .lete (add ⟨1, by simp⟩ ⟨2, by simp⟩) <|
     .lete (add ⟨2, by simp⟩ ⟨2, by simp⟩) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩) <|
     .ret ⟨0, by simp⟩) := by rfl

example : rewritePeepholeAt p1 3 ex2 = (
  ICom.lete (cst 1)   <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p1 4 ex2 = (
  ICom.lete (cst 1)   <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (add ⟨2, by simp⟩ ⟨2, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

def ex2' : ICom ExOp ∅ .nat :=
  ICom.lete (cst 1) <|
  ICom.lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
  ICom.lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
  ICom.lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
  ICom.lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
  ICom.ret ⟨0, by simp⟩

-- a + b => b + (0 + a)
def r2 : ICom ExOp (.ofList [.nat, .nat]) .nat :=
  .lete (cst 0) <|
  .lete (add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .lete (add ⟨3, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p2 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := m, rhs := r2, correct :=
    by
      simp_peephole
      intros a b
      rw [Nat.zero_add]
      rw [Nat.add_comm]
    }

example : rewritePeepholeAt p2 1 ex2' = (
     .lete (cst 1) <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (cst 0) <|
     .lete (add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 2 ex2 = (
  ICom.lete (cst  1) <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (cst  0) <|
     .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (add ⟨3, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 3 ex2 = (
  ICom.lete (cst  1) <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (cst  0) <|
     .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p2 4 ex2 = (
  ICom.lete (cst  1) <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (cst  0) <|
     .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

-- a + b => (0 + a) + b
def r3 : ICom ExOp (.ofList [.nat, .nat]) .nat :=
  .lete (cst 0) <|
  .lete (add ⟨0, by simp⟩ ⟨1, by simp⟩) <|
  .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p3 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := m, rhs := r3, correct :=
    by
      simp_peephole
      intros a b
      rw [Nat.zero_add]
    }

example : rewritePeepholeAt p3 1 ex2 = (
  ICom.lete (cst  1) <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (cst  0) <|
     .lete (add ⟨0, by simp⟩ ⟨2, by simp⟩  ) <|
     .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (add ⟨4, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 2 ex2 = (
  ICom.lete (cst  1) <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (cst  0) <|
     .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 3 ex2 = (
  ICom.lete (cst  1) <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (cst  0) <|
     .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .lete (add ⟨4, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

example : rewritePeepholeAt p3 4 ex2 = (
  ICom.lete (cst  1) <|
     .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (add ⟨1, by simp⟩ ⟨1, by simp⟩  ) <|
     .lete (cst  0) <|
     .lete (add ⟨0, by simp⟩ ⟨3, by simp⟩  ) <|
     .lete (add ⟨0, by simp⟩ ⟨4, by simp⟩  ) <|
     .ret ⟨0, by simp⟩  ) := by rfl

def ex3 : ICom ExOp ∅ .nat :=
  .lete (cst 1) <|
  .lete (cst 0) <|
  .lete (cst 2) <|
  .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩) <| --here
  .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩

def p4 : PeepholeRewrite ExOp [.nat, .nat] .nat:=
  { lhs := r3, rhs := m, correct :=
    by
      simp_peephole
      intros a b
      rw [Nat.zero_add]
    }

example : rewritePeepholeAt p4 5 ex3 = (
  .lete (cst 1) <|
  .lete (cst 0) <|
  .lete (cst 2) <|
  .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete (add ⟨1, by simp⟩ ⟨0, by simp⟩) <|
  .lete (add ⟨3, by simp⟩ ⟨1, by simp⟩) <|
  .lete (add ⟨0, by simp⟩ ⟨0, by simp⟩) <|
  .ret ⟨0, by simp⟩) := rfl

end Examples