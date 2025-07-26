import SSA.Core.Framework
import SSA.Core.Transforms.Rewrite.Mapping

import Mathlib.Data.QPF.Univariate.Basic

/-!
# Matching

This file defines `matchVar` and `matchArg`, which take in a program and the
pattern of a peephole rewrite, and attempt to find a location in the program
where the peephole is applicable.

-/
set_option deprecated.oldSectionVars true

open Ctxt (Var VarSet Valuation)

variable {d} [DialectSignature d] [DecidableEq d.Ty]
variable {Γ : Ctxt d.Ty} {ty : d.Ty}

/-!
## MatchVarM Monad
-/

abbrev MatchVarM (Δ Γ : Ctxt d.Ty) := (StateT (Mapping Δ Γ) Option)
abbrev MatchVar (Δ Γ : Ctxt d.Ty)  := MatchVarM Δ Γ Unit

/--
Given two variables `v` and `w`, ensure the mapping state maps `w` to `v`,
or fail if `w` is already assigned to a different variable.
-/
def MatchVarM.unifyVars {Δ Γ : Ctxt d.Ty} (v : Δ.Var t) (w : Γ.Var t) : MatchVar Δ Γ :=
  fun ma =>
    match ma.lookup ⟨_, v⟩ with
    | some v =>
      if v = w then
        some ((), ma)
      else
        none
    | none =>
      some ((), AList.insert ⟨_, v⟩ w ma)
open MatchVarM

/-!
## Core Matching Algorithm
-/

mutual
variable [DecidableEq d.Op]

/-- `matchArg lets matchLets args matchArgs map` tries to extends the partial substition `map` by
calling `matchVar lets args[i] matchLets matchArgs[i]` for each pair of corresponding variables,
returning the final partial substiution, or `none` on conflicting assigments -/
def matchArg [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (matchLets : Lets d Δ_in .pure Δ_out) :
    {l : List d.Ty} → HVector (Var Γ_out) l → HVector (Var Δ_out) l →
    MatchVar Δ_in Γ_out
  | _, .nil, .nil => return
  | t::l, .cons vₗ vsₗ, .cons vᵣ vsᵣ => do
      matchVar (t := t) lets vₗ matchLets vᵣ
      matchArg lets matchLets vsₗ vsᵣ
  termination_by l => (Δ_out.length, l.length + 1)

/-- `matchVar lets v matchLets w map` tries to extend the partial substition `map`, such that the
transitive expression trees represented by variables `v` and `w` become syntactically equal,
returning the final partial substitution `map'` on success , or `none` on conflicting assignments.

Diagramatically, the contexts are related as follows:
Γ_in --[lets]--> Γ_out <--[map]-- Δ_in --[matchLets]--> Δ_out
                  [v]             [w]

Informally, we want to find a `map` that glues the program `matchLets` to the
end of `lets` such that the expression tree of `v` (in `lets`) is syntactically unified with
the expression tree of `w` (in `matchLets`).

This obeys the hypothetical equation: `(matchLets.exprTreeAt w).changeVars map = lets.exprTreeAt v`
where `exprTreeAt` is a hypothetical definition that gives the expression tree.

NOTE: this only matches on *pure* let bindings in both `matchLets` and `lets`. -/
def matchVar {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t) :
    (matchLets : Lets d Δ_in .pure Δ_out) →
    (w : Var Δ_out t) →
    MatchVar Δ_in Γ_out
  /- `matchVar` simultaneously recurses on both `matchLets` and `w`:
    * If the `matchLets` are just `nil`, then the variable `w` is a free variable.
      We update the map with `map[v := w]`, by following the equation:

      (matchLets.exprTreeAt w).changeVars map = lets.exprTreeAt v
      (nil.exprTreeAt w).changeVars map       = lets.exprTreeAt v [matchLets is nil]
      (nil.exprTreeAt w).changeVars map       = lets.exprTreeAt v [w ∈ Δ_out = Δ_in is a free var]
      (w).changeVars map                      = lets.exprTreeAt v [w ∈ Δ_in is a free variable]
      map[w] := v [w ∈ Δ_in is a free variable]

      map : Δ → Γ_out

      (w) : ExprTree Δ
      (w).changeVars (map.toExprTreeMapUsing lets) = lets.exprTreeAt (map w) : ExprTree Γ_in
      lets.exprTreeAt v : ExprTree Γ_in t

    * If `matchLets = .var matchLets' e`, and `w` is `Var.last` (which is to say, `0`), then we
      attempt to unify `e` with `lets.getPureExpr v`.

    * If `matchLets = .var matchLets' e`, and `w` is `w' + 1`, then we recurse and try to
      `matchVar lets v matchLets' w' map` -/
  | @Lets.var _ _ _ _ Δ_out _ matchLets matchExpr, w => do
      match w with
      | ⟨w+1, h⟩ =>
        let w := ⟨w, by simp_all⟩
        matchVar lets v matchLets w
      | ⟨0, _⟩ => do
        let ie ← lets.getPureExpr v
        if hs : ∃ h : ie.op = matchExpr.op, ie.regArgs = (h ▸ matchExpr.regArgs)
        then
          matchArg lets matchLets ie.args (hs.1 ▸ matchExpr.args)
        else none
  | .nil, w => -- The match expression is just a free (meta) variable
      unifyVars w v
  termination_by (Δ_out.length, 0)
end

/-!
## Semantics Theorems
-/

/-- how matchVar behaves on `var` at a successor variable -/
theorem matchVar_var_succ_eq {t te : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out)
    (matchE : Expr d Δ_out .pure te)
    (w : ℕ)
    (hw : Δ_out[w]? = .some t)
    (ma : Mapping Δ_in Γ_out) :
  matchVar lets v (matchLets := .var matchLets matchE)
    ⟨w + 1, by simpa using hw⟩ ma =
  matchVar lets v matchLets ⟨w, hw⟩ ma := by
    conv =>
      lhs
      unfold matchVar

/-!
## Monotonicity
First, we prove that `matchVar` and `matchArg` only ever add more entries to
the mapping. That is, the resulting mapping is always a superset of the initial
mapping.
-/

section SubsetEntries

@[simp] theorem MatchVarM.liftM_eq_some_iff (x? : Option α) :
    (liftM x? : no_index MatchVarM Δ Γ α) mapIn = some (x, mapOut)
    ↔ x? = some x ∧ mapIn = mapOut := by
  cases x?
  · simp only [reduceCtorEq, false_and, iff_false]
    show none ≠ some _
    simp
  · simp only [Option.some.injEq]
    show some (_, mapIn) = _ ↔ _
    simp

def MatchVar.IsMonotone (f : MatchVar Δ Γ) : Prop :=
    ∀ mapIn, ∀ mapOut ∈ f mapIn,
      mapIn.entries ⊆ mapOut.2.entries
open MatchVar

@[simp]
theorem MatchVar.isMonotone_bind {f : MatchVar Δ Γ} {g : Unit → MatchVar Δ Γ} :
    f.IsMonotone → (g ()).IsMonotone → IsMonotone (f >>= g) := by
  intro hf hg mapIn ⟨(), mapOut⟩ hvarMap
  obtain ⟨⟨⟨⟩, mapMid⟩, hMid⟩ :
      ∃ mapMid, f mapIn = some mapMid ∧ g () mapMid.2 = some ((), mapOut) := by
    simpa [bind, StateT.bind, Option.bind_eq_some_iff] using hvarMap
  apply List.Subset.trans
  · apply hf mapIn ((), mapMid) hMid.1
  · apply hg mapMid ((), mapOut) hMid.2

@[simp]
theorem MatchVar.isMonotone_bind_liftM {x? : Option α} {g : α → MatchVar Δ Γ} :
    IsMonotone (liftM x? >>= g) ↔ (∀ x ∈ x?, (g x).IsMonotone) := by
  rcases x? with _|x
  · simp only [Option.mem_def, reduceCtorEq, IsEmpty.forall_iff, implies_true, iff_true]
    intro _ _ (h : _ ∈ none)
    contradiction
  · simp only [Option.mem_def, Option.some.injEq, forall_eq']
    exact Iff.rfl

theorem MatchVar.isMonotone_none : IsMonotone (none : MatchVar Δ Γ) := by
  intro mapIn mapOut (h : _ ∈ none); contradiction

section UnifyVars
variable {Δ Γ : Ctxt d.Ty} {t} (w : Δ.Var t) (v : Γ.Var t)

@[simp]
theorem unifyVars_eq_some_iff :
    unifyVars w v mapIn = some ((), mapOut)
    ↔ ( mapIn.lookup ⟨t, w⟩ = none ∧ mapIn.insert ⟨t, w⟩ v = mapOut
        ∨ mapIn.lookup ⟨t, w⟩ = v ∧ mapIn = mapOut
      ) := by
  simp only [unifyVars]
  split <;> simp_all

theorem MatchVar.isMonotone_unifyVars  : IsMonotone (unifyVars w v) := by
  intro mapIn ⟨(), mapOut⟩ hMapOut
  simp only [Option.mem_def, unifyVars_eq_some_iff] at hMapOut
  rcases hMapOut with ⟨h_lookup, rfl⟩ | ⟨_, rfl⟩
  · rw [AList.entries_insert_of_notMem (AList.lookup_eq_none.mp h_lookup)]
    apply List.subset_cons_of_subset
    exact Set.Subset.refl _
  · simp_all

end UnifyVars

variable [DecidableEq d.Op]

/--
Auxiliary mutual induction for `subset_entries_matchArg`
and `subset_entries_matchVar`
-/
theorem isMonotone_matchVarArg_aux (lets : Lets d Γ_in eff Γ_out) :
    (
     ∀  (Δ_out : Ctxt d.Ty)
        (matchLets : Lets d Δ_in EffectKind.pure Δ_out) (l : List d.Ty)
        (argsl : HVector Γ_out.Var l) (argsr : HVector Δ_out.Var l),
        (matchArg lets matchLets argsl argsr).IsMonotone
    )
    ∧ (
      ∀ (Δ_out : Ctxt d.Ty) (t : d.Ty) (v : Γ_out.Var t)
        (matchLets : Lets d Δ_in EffectKind.pure Δ_out)
        (w : Var Δ_out t),
        (matchVar lets v matchLets w).IsMonotone
    ) := by
  apply matchArg.mutual_induct (d:=d)
  <;> intro Δ_out lets
  · intro mapIn ⟨(), mapOut⟩ hvarMap
    obtain rfl : mapIn = mapOut := by
      simp only [matchArg] at hvarMap
      change some ((), _) = some ((), _) at hvarMap
      simp_all
    exact Set.Subset.refl _

  · intro t inst vl argsl matchLets argsr ih_matchVar ih_matchArg
    simp only [matchArg]
    apply isMonotone_bind ih_matchVar ih_matchArg

  · intro Δ_out u matchLets matchExpr l h
    simp only [matchVar]
    exact id

  · intro Δ_out t_1 matchLets
    intro matchExpr property? ih_matchArg
    simp only [matchVar, isMonotone_bind_liftM, Option.mem_def]
    intro e he
    split
    next h =>
      apply ih_matchArg
      apply h
    next e _ =>
      apply isMonotone_none

  · simp [matchVar, isMonotone_unifyVars]

theorem isMonotone_matchArg [DecidableEq d.Op]
    {Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {l : List d.Ty}
    {argsl : HVector (Var Γ_out) l}
    {argsr : HVector (Var Δ_out) l} :
    (matchArg lets matchLets argsl argsr).IsMonotone :=
  (@isMonotone_matchVarArg_aux _ _ _ _ _ _ _ _ _).1 _ _ _ _ _

/--
matchVar only adds new entries:
  if matchVar lets v matchLets w ma = .some varMap,
  then ma is a subset of varMap.
Said differently, The output mapping of `matchVar` extends the input mapping when it succeeds.
-/
theorem isMonotone_matchVar
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {w : Var Δ_out t} :
    (matchVar lets v matchLets w).IsMonotone :=
  (@isMonotone_matchVarArg_aux _ _ _ _ _ _ _ _ _).2 _ _ _ _ _

end SubsetEntries

/-!
## Semantics Preservation
-/
section DenoteLemmas

-- TODO: this assumption is too strong, we also want to be able to model non-inhabited types
variable [TyDenote d.Ty] [DecidableEq d.Op]
variable [∀ (t : d.Ty), Inhabited (toType t)]

theorem denote_matchVar_matchArg
    {Γ_out Δ_in Δ_out : Ctxt d.Ty} {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out} :
    {l : List d.Ty} →
    {args₁ : HVector (Var Γ_out) l} →
    {args₂ : HVector (Var Δ_out) l} →
    {ma varMap₁ varMap₂ : Mapping Δ_in Γ_out} →
    (h_sub : varMap₁.entries ⊆ varMap₂.entries) →
    (f₁ : (t : d.Ty) → Var Γ_out t → toType t) →
    (f₂ : (t : d.Ty) → Var Δ_out t → toType t) →
    (hf : ∀ t v₁ v₂ (ma : Mapping Δ_in Γ_out) (ma'),
      (((), ma) ∈ matchVar lets v₁ matchLets v₂ ma') →
      ma.entries ⊆ varMap₂.entries → f₂ t v₂ = f₁ t v₁) →
    (hmatchVar : ∀ vMap (t : d.Ty) (vₗ vᵣ) ma,
      ((), vMap) ∈ matchVar (t := t) lets vₗ matchLets vᵣ ma →
      ma.entries ⊆ vMap.entries) →
    (hvarMap : ((), varMap₁) ∈ matchArg lets matchLets args₁ args₂ ma) →
      HVector.map f₂ args₂ = HVector.map f₁ args₁
  | _, .nil, .nil, _, _ => by simp [HVector.map]
  | _, .cons v₁ T₁, .cons v₂ T₂, ma, varMap₁ => by
    intro h_sub f₁ f₂ hf hmatchVar hvarMap
    simp only [HVector.map, HVector.cons.injEq]
    simp only [matchArg, bind, Option.mem_def, Option.bind_eq_some_iff,
      StateT.bind] at hvarMap
    rcases hvarMap with ⟨⟨⟨⟩, ma'⟩, h₁, h₂⟩
    refine ⟨hf _ _ _ _ _ h₁ (List.Subset.trans ?_ h_sub), ?_⟩
    · exact isMonotone_matchArg _ _ h₂
    apply denote_matchVar_matchArg (hvarMap := h₂) (hf := hf)
    · exact h_sub
    · exact hmatchVar

variable [Monad d.m] [LawfulMonad d.m]
         [QPF d.m] [UniformQPF d.m]
         [DialectDenote d]
-- #synth Monad d.m
-- #synth LMonad d.m

section DenoteIntoSubtype

/- TODO: we might not need `denoteIntoSubtype`, if we can prove that `V ∈ supp (lets.denote _)`
implies `lets.getPureExpr v = some e → e.denote V = V v` -/

-- example {e : Expr d Γ eff t}
--     {V_out : e.outContext.Valuation}
--     (h : V_out ∈ Functor.supp (e.denote V_in))
--     (v : Γ.Var u) :
--     V_out v.toSnoc = V_in v := by
--   simp [Functor.supp] at h
--   apply h
--   rw [Expr.denote_unfold]
--   apply Functor.Liftp_map
--   simp

def Expr.ValidOpDenotation (e : Expr d Γ eff ty) (V : Γ.Valuation) :=
  { x // x ∈ Functor.supp (e.denoteOp V) }

def Expr.ValidDenotation (e : Expr d Γ eff ty) (V : Γ.Valuation) :=
  { V_out // V_out ∈ Functor.supp (e.denote V) }

def Lets.ValidDenotation (lets : Lets d Γ_in eff Γ_out) (V : Γ_in.Valuation) :=
  { V_out // V_out ∈ Functor.supp (lets.denote V) }

noncomputable def Expr.validDenoteOp (e : Expr d Γ eff ty) (V : Γ.Valuation) :
    eff.toMonad d.m (e.ValidOpDenotation V) :=
  QPF.attachSupp (e.denoteOp V)

noncomputable def Expr.validDenote (e : Expr d Γ_in eff ty) (V : Valuation Γ_in) :
    eff.toMonad d.m (e.ValidDenotation V) :=
  QPF.attachSupp (e.denote V)

noncomputable def Lets.validDenote (lets : Lets d Γ_in eff Γ_out) (V : Γ_in.Valuation) :
    eff.toMonad d.m (lets.ValidDenotation V) :=
  QPF.attachSupp (lets.denote V)

/--
The pullback of a valuation resulting from `Expr.denote` (of a pure expression)
via `scocRight` is just the original valuation passed to `Expr.denote`.
-/
@[simp] lemma Valuation.comap_denote_snocRight (e : Expr d Γ .pure ty) (V : Γ.Valuation) :
    Valuation.comap (e.denote V) (.snocRight f) = V.comap f := by
  sorry

-- TODO: move to Utils/QPF file
variable {G} [QPF G] [UniformQPF G]
@[simp] lemma QPF.val_attachSupp (x : G α) :
    Subtype.val <$> (QPF.attachSupp x) = x := by
  simp [QPF.attachSupp]
  sorry

theorem Expr.denote_eq_denoteIntoSubtype (e : Expr d Γ eff ty) (V : Valuation Γ) :
    e.denote V = Subtype.val <$> e.validDenote V := by
  simp [validDenote]

theorem Lets.denote_eq_denoteIntoSubtype (lets : Lets d Γ_in eff Γ_out) (V : Valuation Γ_in) :
    lets.denote V = Subtype.val <$> (lets.validDenote V) := by
  simp [validDenote]

end DenoteIntoSubtype

theorem matchVar_nil {lets : Lets d Γ_in eff Γ_out} :
    matchVar lets v (.nil : Lets d Δ .pure Δ) w ma = some ((), ma') →
    ma'.lookup ⟨_, w⟩ = some v := by
  simp only [matchVar, unifyVars_eq_some_iff]
  rintro (⟨_, rfl⟩ | ⟨h_lookup, rfl⟩)
  · simp
  · exact h_lookup

@[simp]
theorem MatchVar.liftM_bind_eq_some_iff (x? : Option α)
    (f : α → MatchVarM Δ Γ β) :
    ((liftM x? >>= f) mapIn = some mapOut)
    ↔ ( ∃ h : x?.isSome,
        f (x?.get h) mapIn = some mapOut ) := by
  rcases x? with _|x
  · simp only [Option.isSome_none, Bool.false_eq_true, IsEmpty.exists_iff, iff_false]
    show none ≠ some _
    simp
  · simp; exact Iff.rfl

theorem matchVar_var_last {lets : Lets d Γ_in eff Γ_out} {matchLets : Lets d Δ_in .pure Δ_out}
    {matchExpr : Expr d Δ_out .pure ty} :
    matchVar lets v (.var matchLets matchExpr) (Var.last ..) ma = some ma' →
    ∃ args,
      lets.getPureExpr v
        = some ⟨matchExpr.op, matchExpr.ty_eq, matchExpr.eff_le, args, matchExpr.regArgs⟩
      ∧ matchArg lets matchLets args matchExpr.args ma = some ma' := by
  unfold matchVar
  simp [-MatchVar.liftM_bind_eq_some_iff]
  simp only [MatchVar.liftM_bind_eq_some_iff, forall_exists_index]
  intro h_isSome h
  split_ifs at h with h'
  · rcases matchExpr with ⟨mOp, _, _, mArgs, mRegArgs⟩
    rcases h' with ⟨(rfl : _ = mOp), (rfl : _ = mRegArgs)⟩
    refine ⟨
      (lets.getPureExpr v |>.get _ |>.args),
      ?_, h
    ⟩
    rcases Option.isSome_iff_exists.mp h_isSome with ⟨⟨_⟩, h_eq⟩
    simp only [h_eq, Expr.op_mk, Expr.regArgs_mk, Option.some.injEq, Expr.mk.injEq, Option.get_some,
      true_and]
    rw [Option.get_of_eq_some _ h_eq]
    simp
  · contradiction


-- @[simp] lemma Lets.denote_var_last_pure (lets : Lets d Γ_in .pure Γ_out)
--     (e : Expr d Γ_out .pure ty) (V_in : Valuation Γ_in) :
--     Lets.denote (var lets e) V_in (Var.last ..) = e.denote (lets.denote V_in) := by
--   apply Id.ext
--   simp [Lets.denote]
--   congr

@[simp] lemma Expr.denoteOp_eq_denoteOp_of {e₁ : Expr d Γ eff ty} {e₂ : Expr d Δ eff ty}
    {Γv : Valuation Γ} {Δv : Valuation Δ}
    (op_eq : e₁.op = e₂.op)
    (h_regArgs : HEq e₁.regArgs e₂.regArgs)
    (h_args : HVector.map Γv (op_eq ▸ e₁.args)
              = HVector.map Δv e₂.args) :
    e₁.denoteOp Γv = e₂.denoteOp Δv := by
  rcases e₁ with ⟨op₁, rfl, _, args₁, regArgs₁⟩
  rcases e₂ with ⟨op₂, _, _, args₂, _⟩
  obtain rfl : op₁ = op₂ := op_eq
  simp_all only [op_mk, regArgs_mk, heq_eq_eq, args_mk]
  subst h_regArgs
  simp [denoteOp, h_args]

variable {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}

/--
if matchVar lets v matchLets w ma = .some varMap,
then informally:

   Γ_in --⟦lets⟧--> Γ_out --comap ma--> Δ_in --⟦matchLets⟧ --> Δ_out --w--> t =
     Γ_in ⟦lets⟧ --> Γ_out --v--> t
-/
theorem denote_matchVar
    {v w : Var _ t}
    (h_matchVar : ((), varMap₁) ∈ matchVar lets v matchLets w ma)
    (V : lets.ValidDenotation) :
    (matchLets.denote (fun t' v' =>
        match varMap₁.lookup ⟨t', v'⟩ with
        | .some mappedVar => by exact (V.val mappedVar)
        | .none => default) w)
    = V.val v := by
  suffices ∀ {varMap₂ : Mapping _ _}, varMap₁.entries ⊆ varMap₂.entries →
    (matchLets.denote (fun t' v' =>
        match varMap₂.lookup ⟨t', v'⟩ with
        | .some mappedVar => by exact (V.val mappedVar)
        | .none => default) w)
    = V.val v
  by
    apply this (List.Subset.refl _)

  intro varMap₂ h_sub
  induction matchLets generalizing v ma varMap₁ varMap₂ t
  case nil =>
    simp only [Lets.denote, Id.pure_eq']
    rw [AList.mem_lookup_iff.mpr ?_]
    apply h_sub <| AList.mem_lookup_iff.mp <| matchVar_nil h_matchVar
  case var t' matchLets matchExpr ih =>
    match w with
    | ⟨w+1, h⟩ =>
      simp only [Option.mem_def, Var.succ_eq_toSnoc, Lets.denote,
        EffectKind.toMonad_pure, Id.pure_eq', Id.bind_eq', Valuation.snoc_toSnoc] at *
      rw [Var.toSnoc, matchVar_var_succ_eq] at h_matchVar
      apply ih h_matchVar h_sub

    | ⟨0, h_w⟩ =>
      obtain rfl : t = t' := by
        symm; simpa using h_w
      have ⟨args, h_pure, h_matchArgs⟩ := matchVar_var_last h_matchVar
      rw [← V.property v _ h_pure]
      simp only [Var.zero_eq_last, Lets.denote_var_last_pure]
      apply Expr.denoteOp_eq_denoteOp_of <;> (try rfl)
      simp only [Expr.op_mk, Expr.args_mk]

      apply denote_matchVar_matchArg (hvarMap := h_matchArgs) h_sub
      · intro t v₁ v₂ ma ma' hmem h_ma_sub
        apply ih hmem h_ma_sub
      · intro _ _ _ _ _ h
        exact isMonotone_matchVar _ _ h

/-!
## Post-match membership

Finally, we show that when matching succeeds, the returned mapping is defined
on all free variables in the match pattern. As a corollary, we define
`matchVarMap` as a wrapper around `matchVar` that returns a context morphism
on successfull match, instead of a mapping.

-/

local macro_rules | `(tactic| decreasing_trivial) => `(tactic| simp +arith)
-- ^^ This is needed for the following mutual block to be recognized as terminating


mutual

theorem mem_matchVar_matchArg {Δ_out}
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {l : List d.Ty} {argsₗ : HVector (Var Γ_out) l}
    {argsᵣ : HVector (Var Δ_out) l} {ma : Mapping Δ_in Γ_out}
    {varMap : Mapping Δ_in Γ_out}
    (hvarMap : ((), varMap) ∈ matchArg lets matchLets argsₗ argsᵣ ma)
    {t' v'} : ⟨t', v'⟩ ∈ (argsᵣ.vars).biUnion (fun v => matchLets.vars v.2) → ⟨t', v'⟩ ∈ varMap :=
  match l, argsₗ, argsᵣ/- , ma, varMap, hvarMap -/ with
  | .nil, .nil, .nil /- , _, varMap, _ -/ => by simp
  | .cons t ts, .cons vₗ argsₗ, .cons vᵣ args /-, ma, varMap, h -/ => by
    simp only [matchArg, bind, Option.mem_def, StateT.bind, Option.bind_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨ma', h₁, h₂⟩
    simp only [HVector.vars_cons, Finset.biUnion_insert, Finset.mem_union,
      Finset.mem_biUnion, Sigma.exists]
    rintro (h | ⟨a, b, hab⟩)
    · exact AList.keys_subset_keys_of_entries_subset_entries
        (isMonotone_matchArg _ _ h₂)
        (mem_matchVar (matchLets := matchLets) h₁ h)
    · exact mem_matchVar_matchArg (l := ts) h₂
        (Finset.mem_biUnion.2 ⟨⟨_, _⟩, hab.1, hab.2⟩)

/-- All variables containing in `matchExpr` are assigned by `matchVar`. -/
theorem mem_matchVar {Δ_out}
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t} /- : -/
    {matchLets : Lets d Δ_in .pure Δ_out}  {w : Var Δ_out t}
    (hvarMap : ((), varMap) ∈ matchVar lets v matchLets w ma)
    {t': _ } {v' : _}
    (hMatchLets : ⟨t', v'⟩ ∈ matchLets.vars w) :
  ⟨t', v'⟩ ∈ varMap :=
  match matchLets, w /- , hvarMap, t', v' -/ with
  | .nil, w /-, h, t', v' -/ => by
    revert hMatchLets
    simp only [Lets.vars, VarSet.ofVar, Finset.mem_singleton, Sigma.mk.inj_iff, and_imp]
    rintro ⟨⟩ ⟨⟩
    simp only [matchVar, Option.mem_def, unifyVars_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨_, rfl⟩ | ⟨h_lookup, rfl⟩
    · simp
    · simp [← AList.lookup_isSome, h_lookup]

  | .var matchLets matchE, ⟨w+1, hw'⟩ /-, h, t', v' -/ => by
    have hvar' := matchVar_var_succ_eq
      (lets := lets) (v := v) (matchLets := matchLets) (w := w) (hw := hw')
      (matchE := matchE)
      (ma := ma)
    apply mem_matchVar
      (lets := lets)
      (matchLets := matchLets)
      (w := ⟨w, by simpa [Ctxt.snoc] using hw'⟩)
      (ma := ma)
      (v := v)
      (hMatchLets := by
        have hmatchLets' :=
          Lets.vars_var_eq (lets := matchLets)
            (e := matchE) (w := w) (wh := hw') ▸ hMatchLets
        apply hmatchLets'
      )
    have hvarMap' := hvar' ▸ hvarMap
    apply hvarMap'
  | .var (t := t') matchLets matchE, ⟨0, hw⟩ /-, h, t', v' -/ => by
    revert hMatchLets
    obtain rfl : t = t' := by
      symm; simpa using hw
    simp only [Lets.vars, Var.zero_eq_last, Var.casesOn_last, Finset.mem_biUnion,
      Sigma.exists, forall_exists_index, and_imp]
    intro _ _ hl h_v'
    obtain ⟨
        (⟨ope, rfl, _eff_le, args, _regArgs⟩ : Expr ..),
        he₁, he₂ ⟩ := by
      unfold matchVar at hvarMap
      simp only [bind, Option.mem_def, Option.bind_eq_some_iff, StateT.bind] at hvarMap
      have h := by simpa [pure, bind] using hvarMap
      exact h
    rcases matchE with ⟨op', _, _, args', regArgs'⟩
    split at he₂
    case isFalse => contradiction
    case isTrue h =>
      rcases h with ⟨(rfl : ope = op'), (rfl : _regArgs = regArgs')⟩
      change matchArg lets matchLets args args' ma = some ((), varMap) at he₂
      apply @mem_matchVar_matchArg (hvarMap := he₂)
      simp only [Finset.mem_biUnion, Sigma.exists]
      refine ⟨_, _, ?_, h_v'⟩
      exact hl
end

/--
`matchVarMap` is an alternative version of `matchVar` that returns a context
morphism (`Hom`) instead of a partial `Mapping`, provided that every variable in
the domain context appears as a free variable in `matchExpr`.
-/
def matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty}
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out) (w : Var Δ_out t)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w) :
    Option (Δ_in.Hom Γ_out) := do
  match hm : matchVar lets v matchLets w ∅ with
  | none => none
  | some ⟨_, m⟩ => do
    m.toHom <| fun v =>
      mem_matchVar (by simpa using hm) (hvars _ v)

variable
  {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
  {lets : Lets d Γ_in eff Γ_out}
  {matchTy}
  {v : Var Γ_out matchTy}
  {matchLets : Lets d Δ_in .pure Δ_out}
  {w : Var Δ_out matchTy}
in
theorem denote_matchLets_of_matchVarMap
    {hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w}
    {map : Δ_in.Hom Γ_out}
    (hmap : map ∈ matchVarMap lets v matchLets w hvars)
    (V : lets.ValidDenotation) :
    matchLets.denote (V.val.comap map) w = V.val v := by
  rw [matchVarMap] at hmap
  split at hmap
  next => contradiction
  next m hm =>
    obtain rfl : m.toHom _ = map := by
      simpa using hmap

    rw [← denote_matchVar hm]
    apply congrFun; apply congrFun; apply congrArg

    funext t' v'
    have := AList.lookup_isSome.2 (mem_matchVar hm (hvars _ v'))
    split <;> simp_all [Mapping.toHom]


end DenoteLemmas
