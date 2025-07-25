import SSA.Core.Framework

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
theorem matchVar_var_succ_eq {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t te : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out)
    (matchE : Expr d Δ_out .pure te)
    (w : ℕ)
    (hw : Ctxt.get? Δ_out w = .some t)
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
    simp only [Ctxt.get?, matchVar, isMonotone_bind_liftM, Option.mem_def]
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

variable [Monad d.m] [LawfulMonad d.m] [DialectDenote d]

section DenoteIntoSubtype

/- TODO: we might not need `denoteIntoSubtype`, if we can prove that `V ∈ supp (lets.denote _)`
implies `lets.getPureExpr v = some e → e.denote V = V v` -/

/-- `e.IsDenotationForPureE Γv x` holds if `x` is the pure value obtained from `e` under valuation
`Γv`, assuming that `e` has a pure operation.
If `e` has an impure operation, the property holds vacuously. -/
abbrev Expr.IsDenotationForPureE (e : Expr d Γ eff ty) (Γv : Valuation Γ) (x : ⟦ty⟧) : Prop :=
  ∀ (ePure : Expr d Γ .pure ty), e.toPure? = some ePure → ePure.denote Γv = x

def Expr.denoteIntoSubtype (e : Expr d Γ_in eff ty) (Γv : Valuation Γ_in) :
    eff.toMonad d.m {x : ⟦ty⟧ // e.IsDenotationForPureE Γv x} :=
  match h_pure : e.toPure? with
    | some ePure => pure ⟨ePure.denote Γv, by simp [IsDenotationForPureE, h_pure]⟩
    | none => (Subtype.mk · (by simp [IsDenotationForPureE, h_pure])) <$> (e.denote Γv)

/-- An alternative version of `Lets.denote`, whose returned type carries a proof that the valuation
agrees with the denotation of every pure expression in `lets`.

Strongly prefer using `Lets.denote` in definitions, but you can use `denoteIntoSubtype` in proofs.
The subtype allows us to carry the property with us when doing congruence proofs inside a bind. -/
def Lets.denoteIntoSubtype (lets : Lets d Γ_in eff Γ_out) (Γv : Valuation Γ_in) :
    eff.toMonad d.m {
      V : Valuation Γ_out // ∀ {t} (v : Var _ t) e, lets.getPureExpr v = some e → e.denote V = V v
    } :=
  match lets with
    | .nil => return ⟨Γv, by simp⟩
    | @Lets.var _ _ _ _ Γ_out eTy body e => do
        let ⟨Vout, h⟩ ← body.denoteIntoSubtype Γv
        let v ← e.denoteIntoSubtype Vout
        return ⟨Vout.snoc v.val, by
          intro t' v'; cases v' using Var.casesOn
          · simpa using h _
          · simpa using v.prop
          ⟩

theorem Expr.denote_eq_denoteIntoSubtype (e : Expr d Γ eff ty) (Γv : Valuation Γ) :
    e.denote Γv = Subtype.val <$> e.denoteIntoSubtype Γv := by
  simp only [denoteIntoSubtype, EffectKind.return_impure_toMonad_eq]
  split
  next h_pure =>
    simp only [denote_toPure? h_pure, map_pure, EffectKind.return_impure_toMonad_eq]
    split <;> rfl
  next => simp

theorem Lets.denote_eq_denoteIntoSubtype (lets : Lets d Γ_in eff Γ_out) (Γv : Valuation Γ_in) :
    lets.denote Γv = Subtype.val <$> (lets.denoteIntoSubtype Γv) := by
  induction lets
  case nil => simp [denoteIntoSubtype]
  case var body e ih =>
    simp [denote, denoteIntoSubtype, ih, Expr.denote_eq_denoteIntoSubtype]


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


@[simp] lemma Lets.denote_var_last_pure (lets : Lets d Γ_in .pure Γ_out)
    (e : Expr d Γ_out .pure ty) (V_in : Valuation Γ_in) :
    Lets.denote (var lets e) V_in (Var.last ..) = e.denote (lets.denote V_in) := by
  apply Id.ext
  simp [Lets.denote]
  congr

@[simp] lemma Expr.denote_eq_denote_of {e₁ : Expr d Γ eff ty} {e₂ : Expr d Δ eff ty}
    {Γv : Valuation Γ} {Δv : Valuation Δ}
    (op_eq : e₁.op = e₂.op)
    (h_regArgs : HEq e₁.regArgs e₂.regArgs)
    (h_args : HVector.map (fun _ v => Γv v) (op_eq ▸ e₁.args)
              = HVector.map (fun _ v => Δv v) e₂.args) :
    e₁.denote Γv = e₂.denote Δv := by
  rcases e₁ with ⟨op₁, ty_eq, _, args₁, regArgs₁⟩
  rcases e₂ with ⟨_, _, _, args₂, _⟩
  cases op_eq
  simp_all only [op_mk, regArgs_mk, heq_eq_eq, args_mk]
  subst ty_eq h_regArgs
  rw [denote, denote, h_args]

theorem denote_matchVar2_of_subset
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t}
    {varMap₁ varMap₂ : Mapping Δ_in Γ_out}
    {s₁ : Valuation Γ_in}
    {ma : Mapping Δ_in Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out} {w : Var Δ_out t}
    (h_sub : varMap₁.entries ⊆ varMap₂.entries)
    (h_matchVar : ((), varMap₁) ∈ matchVar lets v matchLets w ma)
    (f : Γ_out.Valuation → _ → eff.toMonad d.m α) :
    (lets.denote s₁ >>= (fun Γ_out_lets =>f Γ_out_lets <| (matchLets.denote (fun t' v' =>
        match varMap₂.lookup ⟨t', v'⟩ with
        | .some mappedVar => by exact (Γ_out_lets mappedVar)
        | .none => by exact default)) w))
    = (lets.denote s₁ >>= fun Γ_out_lets => f Γ_out_lets (Γ_out_lets v)) := by
  simp only [lets.denote_eq_denoteIntoSubtype, EffectKind.toMonad_pure, map_eq_pure_bind,
    EffectKind.return_impure_toMonad_eq, bind_assoc, pure_bind]
  congr; funext Vout; congr; next => -- `next` is needed to consume the tags generated by `congr`
  clear s₁ f

  induction matchLets generalizing v ma varMap₁ varMap₂ t
  case nil =>
    simp only [Lets.denote, Id.pure_eq']
    rw [AList.mem_lookup_iff.mpr ?_]
    apply h_sub <| AList.mem_lookup_iff.mp <| matchVar_nil h_matchVar
  case var t' matchLets matchExpr ih =>
    match w with
    | ⟨w+1, h⟩ =>
      simp only [Option.mem_def, Ctxt.get?, Var.succ_eq_toSnoc, Lets.denote,
        EffectKind.toMonad_pure, Id.pure_eq', Id.bind_eq', Valuation.snoc_toSnoc] at *
      rw [Var.toSnoc, matchVar_var_succ_eq] at h_matchVar
      apply ih h_sub h_matchVar

    | ⟨0, h_w⟩ =>
      obtain rfl : t = t' := by
        symm; simpa using h_w
      have ⟨args, h_pure, h_matchArgs⟩ := matchVar_var_last h_matchVar
      rw [← Vout.property v _ h_pure]
      simp only [Ctxt.get?, Var.zero_eq_last, Lets.denote_var_last_pure]
      apply Expr.denote_eq_denote_of <;> (try rfl)
      simp only [Expr.op_mk, Expr.args_mk]

      apply denote_matchVar_matchArg (hvarMap := h_matchArgs) h_sub
      · intro t v₁ v₂ ma ma' hmem h_ma_sub
        apply ih h_ma_sub hmem
      · intro _ _ _ _ _ h
        exact isMonotone_matchVar _ _ h
/--
if matchVar lets v matchLets w ma = .some varMap,
then informally:

   Γ_in --⟦lets⟧--> Γ_out --comap ma--> Δ_in --⟦matchLets⟧ --> Δ_out --w--> t =
     Γ_in ⟦lets⟧ --> Γ_out --v--> t
-/
theorem denote_matchVar2 {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t}
    {varMap : Mapping Δ_in Γ_out}
    {s₁ : Valuation Γ_in}
    {ma : Mapping Δ_in Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {w : Var Δ_out t} {f : Γ_out.Valuation → _ → eff.toMonad d.m α} :
    ((), varMap) ∈ matchVar lets v matchLets w ma →
    lets.denote s₁ >>= (fun Γvlets =>
          f Γvlets (matchLets.denote (fun t' v' =>
             match varMap.lookup ⟨t', v'⟩ with
             | .some mappedVar => by exact (Γvlets mappedVar)
             | .none => default) w))
    = lets.denote s₁ >>= (fun Γv => f Γv (Γv v)) := by
  apply denote_matchVar2_of_subset (s₁ := s₁) (f := f) (List.Subset.refl _)

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

theorem mem_matchVar_matchArg
    {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
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
theorem mem_matchVar
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
      (w := ⟨w, by simpa[Ctxt.snoc] using hw'⟩)
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
    simp only [Lets.vars, Ctxt.get?, Var.zero_eq_last, Var.casesOn_last, Finset.mem_biUnion,
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
      apply @mem_matchVar_matchArg (matchLets := matchLets) (hvarMap := he₂)
      simp only [Finset.mem_biUnion, Sigma.exists]
      refine ⟨_, _, ?_, h_v'⟩
      exact hl
end

/-- A version of `matchVar` that returns a `Hom` of `Ctxt`s instead of the `AList`,
provided every variable in the context appears as a free variable in `matchExpr`. -/
def matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty}
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out) (w : Var Δ_out t)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w) :
    Option (Δ_in.Hom Γ_out) := do
  match hm : matchVar lets v matchLets w ∅ with
  | none => none
  | some ⟨_, m⟩ => do
    return fun t v' =>
      match h : m.lookup ⟨t, v'⟩ with
      | some v' => by exact v'
      | none => by
        have := AList.lookup_isSome.2
          (mem_matchVar
              (lets := lets)
              (v := v)
              (w := w)
              (matchLets := matchLets)
              (hvarMap := by simp; apply hm) (hvars t v'))
        simp_all

/-- if matchVarMap lets v matchLets w hvars = .some map,
then ⟦lets; matchLets⟧ = ⟦lets⟧(v)
-/
theorem denote_matchVarMap2 [LawfulMonad d.m] {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in eff Γ_out}
    {t : d.Ty} {v : Var Γ_out t}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {w : Var Δ_out t}
    {hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w}
    {map : Δ_in.Hom Γ_out}
    (hmap : map ∈ matchVarMap lets v matchLets w hvars) (s₁ : Valuation Γ_in)
    (f : Valuation Γ_out → ⟦t⟧ → eff.toMonad d.m α) :
    (lets.denote s₁ >>= (fun Γ_out_v => f Γ_out_v <|
      matchLets.denote (Valuation.comap Γ_out_v map) w))
    = (lets.denote s₁ >>= (fun Γ_out_v => f Γ_out_v <| Γ_out_v v)) := by
  rw [matchVarMap] at hmap
  split at hmap
  next => simp_all
  next hm =>
    rw [← denote_matchVar2 hm]
    simp only [Option.mem_def, Option.some.injEq, pure] at hmap
    subst hmap
    congr
    funext Γ_out_v
    rw [← Lets.denotePure]
    congr
    funext t v
    simp only [Valuation.comap]
    split
    · split <;> simp_all
    · have := AList.lookup_isSome.2 (mem_matchVar hm (hvars _ v))
      simp_all

end DenoteLemmas
