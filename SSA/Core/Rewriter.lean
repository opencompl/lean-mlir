/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import SSA.Core.Framework

/-!
# Verified Peephole Rewriter
-/

open Ctxt (Var VarSet Valuation)
open TyDenote (toType)
open EffectKind (liftEffect)
open AList

variable {d} [s : DialectSignature d] [TyDenote d.Ty] [DialectDenote d] [DecidableEq d.Ty]
  [Monad d.m] [LawfulMonad d.m]

set_option deprecated.oldSectionVars true

/-!
## Matching
-/

mutual

/-- `matchArg lets matchLets args matchArgs map` tries to extends the partial substition `map` by
calling `matchVar lets args[i] matchLets matchArgs[i]` for each pair of corresponding variables,
returning the final partial substiution, or `none` on conflicting assigments -/
def matchArg [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (matchLets : Lets d Δ_in .pure Δ_out) :
    {l : List d.Ty} → HVector (Var Γ_out) l → HVector (Var Δ_out) l →
    Mapping Δ_in Γ_out → Option (Mapping Δ_in Γ_out)
  | _, .nil, .nil, ma => some ma
  | t::l, .cons vₗ vsₗ, .cons vᵣ vsᵣ, ma => do
      let ma ← matchVar (t := t) lets vₗ matchLets vᵣ ma
      matchArg lets matchLets vsₗ vsᵣ ma



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
    (ma : Mapping Δ_in Γ_out := ∅) →
--   ^^ TODO: find better name for `ma`
    Option (Mapping Δ_in Γ_out)
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
  | .var matchLets _, ⟨w+1, h⟩, ma => -- w† = Var.toSnoc w
      let w := ⟨w, by simp_all[Ctxt.snoc]⟩
      matchVar lets v matchLets w ma
  | @Lets.var _ _ _ _ Δ_out _ matchLets matchExpr , ⟨0, _⟩, ma => do -- w† = Var.last
      let ie ← lets.getPureExpr v
      if hs : ∃ h : ie.op = matchExpr.op, ie.regArgs = (h ▸ matchExpr.regArgs)
      then
        matchArg lets matchLets ie.args (hs.1 ▸ matchExpr.args) ma
      else none
  | .nil, w, ma => -- The match expression is just a free (meta) variable
      match ma.lookup ⟨_, w⟩ with
      | some v₂ =>
        by
          exact if v = v₂
            then some ma
            else none
      | none => some (AList.insert ⟨_, w⟩ v ma)
end

/-- how matchVar behaves on `var` at a successor variable -/
theorem matchVar_var_succ_eq {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t te : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out)
    (matchE : Expr d Δ_out .pure te)
    (w : ℕ)
    (hw : Ctxt.get? Δ_out w = .some t)
    (ma : Mapping Δ_in Γ_out) :
  matchVar lets v (matchLets := .var matchLets matchE)
    ⟨w + 1, by simp only [Ctxt.get?, Ctxt.snoc, List.getElem?_cons_succ];
               simp only [Ctxt.get?] at hw; apply hw⟩ ma =
  matchVar lets v matchLets ⟨w, hw⟩ ma := by
    conv =>
      lhs
      unfold matchVar

/-- how matchVar behaves on `var` at the last variable. -/
theorem matchVar_var_last_eq {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty} [DecidableEq d.Op]
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out)
    (matchE : Expr d Δ_out .pure t)
    (ma : Mapping Δ_in Γ_out) :
  matchVar lets v (matchLets := .var matchLets matchE) (Var.last _ _) ma =
  (do -- w† = Var.last
    let ie ← lets.getPureExpr v
    if hs : ∃ h : ie.op = matchE.op, ie.regArgs = (h ▸ matchE.regArgs)
    then
      matchArg lets matchLets ie.args (hs.1 ▸ matchE.args) ma
    else none) := by
  conv =>
    lhs
    unfold matchVar

section SubsetEntries

theorem subset_entries (lets : Lets d Γ_in eff Γ_out) [DecidableEq d.Op] :
    (
     ∀  (Δ_out : Ctxt d.Ty)
        (matchLets : Lets d Δ_in EffectKind.pure Δ_out) (l : List d.Ty)
        (argsl : HVector Γ_out.Var l) (argsr : HVector Δ_out.Var l) (ma : Mapping Δ_in Γ_out),
      ∀ varMap ∈ matchArg lets matchLets argsl argsr ma, ma.entries ⊆ varMap.entries
    )
    ∧ (
      ∀ (Δ_out : Ctxt d.Ty) (t : d.Ty) (v : Γ_out.Var t)
        (matchLets : Lets d Δ_in EffectKind.pure Δ_out)
        (w : Var Δ_out t) (ma : Mapping Δ_in Γ_out),
      ∀ varMap ∈ matchVar lets v matchLets w ma, ma.entries ⊆ varMap.entries
    ) := by
  apply matchArg.mutual_induct (d:=d)
  <;> intro Δ_out lets
  · intro ma varMap hvarMap
    simp [matchArg, Option.mem_def, Option.some.injEq] at hvarMap
    subst hvarMap
    exact Set.Subset.refl _

  · intro t inst vl argsl matchLets argsr ma ih_matchVar ih_matchArg varMap hvarMap
    simp only [matchArg, bind, Option.mem_def, Option.bind_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨ma', h1, h2⟩
    have hind : ma'.entries ⊆ _ := ih_matchArg ma' varMap <| by
      simp; exact h2
    have hmut := ih_matchVar ma' <| by simp; exact h1
    apply List.Subset.trans hmut hind

  · intro Δ_out u matchLets matchExpr l h ma
    intro ih_matchVar motive
    intros varMap hvarMap
    simp only [Ctxt.get?, Var.succ_eq_toSnoc, Option.mem_def] at *
    unfold matchVar at hvarMap
    apply motive (varMap := varMap) hvarMap

  · intro Δ_out t_1 matchLets
    intro matchExpr property? ma ih_matchArg varMap ih_matchVar
    simp only [Ctxt.get?, matchVar, bind, Option.bind, Option.mem_def] at *
    split at ih_matchVar
    next     => contradiction
    next e _ =>
      simp only at ih_matchVar
      split_ifs at ih_matchVar with hop
      apply ih_matchArg e hop _ ih_matchVar
  · intro w v₂ b? varMap hvarMap x hx
    simp only [matchVar, Option.mem_def] at *
    split at hvarMap
    case h_1 _p q r _s =>
      split_ifs at hvarMap
      · simp_all
    case h_2 _a _b _c _d e f =>
      simp only [Option.some.injEq] at hvarMap
      subst hvarMap
      rcases x with ⟨x, y⟩
      simp only [← AList.mem_lookup_iff] at *
      by_cases hx : x = ⟨Δ_out, w⟩
      · subst hx; simp_all
      · rwa [AList.lookup_insert_ne hx]
  · intro w ma v₂
    intro b? c? varMap hvarMap
    simp only [Ctxt.get?, Var.succ_eq_toSnoc, Option.mem_def] at *
    unfold matchVar at hvarMap
    split at hvarMap
    split_ifs at hvarMap
    · simp at hvarMap
      simp [hvarMap]
    · simp at hvarMap
      rename_i a b c
      rw [c] at b?
      contradiction
  · intro ma w
    intro b? varMap hvarMap
    simp only [Ctxt.get?, Var.succ_eq_toSnoc, Option.mem_def] at *
    unfold matchVar at hvarMap
    split at hvarMap
    case h_1 _p q r _s =>
      split_ifs at hvarMap
      · simp_all
    case h_2 _a _b _c _d e f =>
      simp only [Option.some.injEq] at hvarMap
      subst hvarMap
      intros x hx
      rcases x with ⟨x, y⟩
      simp only [← AList.mem_lookup_iff] at *
      by_cases hx : x = ⟨Δ_out, w⟩
      · subst hx; simp_all
      · rwa [AList.lookup_insert_ne hx]

theorem subset_entries_matchArg [DecidableEq d.Op]
    {Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {l : List d.Ty}
    {argsl : HVector (Var Γ_out) l}
    {argsr : HVector (Var Δ_out) l}
    {ma : Mapping Δ_in Γ_out}
    {varMap : Mapping Δ_in Γ_out}
    (hvarMap : varMap ∈ matchArg lets matchLets argsl argsr ma) :
    ma.entries ⊆ varMap.entries :=
  (@subset_entries _ _ _ _ _ _ _ _ _).1 _ _ _ _ _ _ _ hvarMap

/--
matchVar only adds new entries:
  if matchVar lets v matchLets w ma = .some varMap,
  then ma is a subset of varMap.
Said differently, The output mapping of `matchVar` extends the input mapping when it succeeds.
-/
theorem subset_entries_matchVar [DecidableEq d.Op]
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {w : Var Δ_out t}
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma) :
    ma.entries ⊆ varMap.entries :=
  (@subset_entries _ _ _ _ _ _ _ _ _).2 _ _ _ _ _ _ _ hvarMap

end SubsetEntries


-- TODO: this assumption is too strong, we also want to be able to model non-inhabited types
variable [∀ (t : d.Ty), Inhabited (toType t)] [DecidableEq d.Op]

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
      (ma ∈ matchVar lets v₁ matchLets v₂ ma') →
      ma.entries ⊆ varMap₂.entries → f₂ t v₂ = f₁ t v₁) →
    (hmatchVar : ∀ vMap (t : d.Ty) (vₗ vᵣ) ma,
      vMap ∈ matchVar (t := t) lets vₗ matchLets vᵣ ma →
      ma.entries ⊆ vMap.entries) →
    (hvarMap : varMap₁ ∈ matchArg lets matchLets args₁ args₂ ma) →
      HVector.map f₂ args₂ = HVector.map f₁ args₁
  | _, .nil, .nil, _, _ => by simp [HVector.map]
  | _, .cons v₁ T₁, .cons v₂ T₂, ma, varMap₁ => by
    intro h_sub f₁ f₂ hf hmatchVar hvarMap
    simp only [HVector.map, HVector.cons.injEq]
    simp only [matchArg, bind, Option.mem_def, Option.bind_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨ma', h₁, h₂⟩
    refine ⟨hf _ _ _ _ _ h₁ (List.Subset.trans ?_ h_sub), ?_⟩
    · apply subset_entries_matchArg (d:=d)
      assumption
    apply denote_matchVar_matchArg (hvarMap := h₂) (hf := hf)
    · exact h_sub
    · exact hmatchVar

variable [LawfulMonad d.m]

section DenoteIntoSubtype

/- TODO: we might not need `denoteIntoSubtype`, if we can prove that `V ∈ supp (lets.denote _)`
implies `lets.getPureExpr v = some e → e.denote V = V v` -/

/-- `e.IsDenotationForPureE Γv x` holds if `x` is the pure value obtained from `e` under valuation
`Γv`, assuming that `e` has a pure operation.
If `e` has an impure operation, the property holds vacuously. -/
abbrev Expr.IsDenotationForPureE (e : Expr d Γ eff t) (Γv : Valuation Γ) (x : ⟦t⟧) : Prop :=
  ∀ (ePure : Expr d Γ .pure t), e.toPure? = some ePure → ePure.denote Γv = x

def Expr.denoteIntoSubtype (e : Expr d Γ_in eff t) (Γv : Valuation Γ_in) :
    eff.toMonad d.m {x : ⟦t⟧ // e.IsDenotationForPureE Γv x} :=
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

theorem Expr.denote_eq_denoteIntoSubtype (e : Expr d Γ eff t) (Γv : Valuation Γ) :
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
    matchVar lets v (.nil : Lets d Δ .pure Δ) w ma = some ma' →
    ma'.lookup ⟨_, w⟩ = some v := by
  unfold matchVar
  split
  next h_lookup =>
    split_ifs with v_eq
    · intro h
      injection h with h
      subst v_eq h
      exact h_lookup
    · exact False.elim
  next =>
    intro h
    injection h with h
    simp [← h]

theorem matchVar_var_last {lets : Lets d Γ_in eff Γ_out} {matchLets : Lets d Δ_in .pure Δ_out}
    {matchExpr : Expr d Δ_out .pure ty} :
    matchVar lets v (.var matchLets matchExpr) (Var.last ..) ma = some ma' →
    ∃ args,
      lets.getPureExpr v
        = some ⟨matchExpr.op, matchExpr.ty_eq, matchExpr.eff_le, args, matchExpr.regArgs⟩
      ∧ matchArg lets matchLets args matchExpr.args ma = some ma' := by
  unfold matchVar
  simp only [Option.bind_eq_bind, Option.bind_eq_some_iff, forall_exists_index, and_imp]
  rintro ⟨op', ty_eq', eff_le', args', regArgs'⟩ h_pure h
  rw [h_pure]
  split_ifs at h with regArgs_eq
  simp at regArgs_eq
  rcases regArgs_eq with ⟨rfl, regArgs_eq⟩
  simp at regArgs_eq
  subst regArgs_eq
  simpa using h

@[simp] lemma Lets.denote_var_last_pure (lets : Lets d Γ_in .pure Γ_out)
    (e : Expr d Γ_out .pure ty) (V_in : Valuation Γ_in) :
    Lets.denote (var lets e) V_in (Var.last ..) = e.denote (lets.denote V_in) := by
  simp [Lets.denote]

@[simp] lemma Expr.denote_eq_denote_of {e₁ : Expr d Γ eff t} {e₂ : Expr d Δ eff t}
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
    (h_matchVar : varMap₁ ∈ matchVar lets v matchLets w ma)
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
    simp only [Lets.denote, Id.pure_eq]
    rw [mem_lookup_iff.mpr ?_]
    apply h_sub <| mem_lookup_iff.mp <| matchVar_nil h_matchVar
  case var matchLets matchExpr ih =>
    match w with
    | ⟨w+1, h⟩ =>
      simp only [Option.mem_def, Ctxt.get?, Var.succ_eq_toSnoc, Lets.denote,
        EffectKind.toMonad_pure, Id.pure_eq, Id.bind_eq, Valuation.snoc_toSnoc] at *
      rw [Var.toSnoc, matchVar_var_succ_eq] at h_matchVar
      apply ih h_sub h_matchVar

    | ⟨0, h_w⟩ =>
      obtain rfl : t = _ := by simp only [Ctxt.get?, Ctxt.snoc, List.length_cons, Nat.zero_lt_succ,
        List.getElem?_eq_getElem, List.getElem_cons_zero, Option.some.injEq] at h_w; apply h_w.symm
      have ⟨args, h_pure, h_matchArgs⟩ := matchVar_var_last h_matchVar
      rw [← Vout.property v _ h_pure]
      simp only [Ctxt.get?, Var.zero_eq_last, Lets.denote_var_last_pure]
      apply Expr.denote_eq_denote_of <;> (try rfl)
      simp only [Expr.op_mk, Expr.args_mk]

      apply denote_matchVar_matchArg (hvarMap := h_matchArgs) h_sub
      · intro t v₁ v₂ ma ma' hmem h_ma_sub
        apply ih h_ma_sub hmem
      · exact (fun _ _ _ _ _ h => subset_entries_matchVar h)
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
    varMap ∈ matchVar lets v matchLets w ma →
    lets.denote s₁ >>= (fun Γvlets =>
          f Γvlets (matchLets.denote (fun t' v' =>
             match varMap.lookup ⟨t', v'⟩ with
             | .some mappedVar => by exact (Γvlets mappedVar)
             | .none => default) w))
    = lets.denote s₁ >>= (fun Γv => f Γv (Γv v)) := by
  apply denote_matchVar2_of_subset (s₁ := s₁) (f := f) (List.Subset.refl _)

--TODO: these simp lemmas should probably be `local`
@[simp] theorem lt_one_add_add (a b : ℕ) : b < 1 + a + b := by
  simp (config := { arith := true })
@[simp] theorem zero_eq_zero : (Zero.zero : ℕ) = 0 := rfl

macro_rules | `(tactic| decreasing_trivial) => `(tactic| simp (config := {arith := true}))


mutual


theorem mem_matchVar_matchArg
    {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {l : List d.Ty} {argsₗ : HVector (Var Γ_out) l}
    {argsᵣ : HVector (Var Δ_out) l} {ma : Mapping Δ_in Γ_out}
    {varMap : Mapping Δ_in Γ_out}
    (hvarMap : varMap ∈ matchArg lets matchLets argsₗ argsᵣ ma)
    {t' v'} : ⟨t', v'⟩ ∈ (argsᵣ.vars).biUnion (fun v => matchLets.vars v.2) → ⟨t', v'⟩ ∈ varMap :=
  match l, argsₗ, argsᵣ/- , ma, varMap, hvarMap -/ with
  | .nil, .nil, .nil /- , _, varMap, _ -/ => by simp
  | .cons t ts, .cons vₗ argsₗ, .cons vᵣ args /-, ma, varMap, h -/ => by
    simp only [matchArg, bind, Option.mem_def, Option.bind_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨ma', h₁, h₂⟩
    simp only [HVector.vars_cons, Finset.biUnion_insert, Finset.mem_union,
      Finset.mem_biUnion, Sigma.exists]
    rintro (h | ⟨a, b, hab⟩)
    · exact AList.keys_subset_keys_of_entries_subset_entries
        (subset_entries_matchArg h₂)
        (mem_matchVar (matchLets := matchLets) h₁ h)
    · exact mem_matchVar_matchArg (l := ts) h₂
        (Finset.mem_biUnion.2 ⟨⟨_, _⟩, hab.1, hab.2⟩)

/-- All variables containing in `matchExpr` are assigned by `matchVar`. -/
theorem mem_matchVar
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t} /- : -/
    {matchLets : Lets d Δ_in .pure Δ_out}  {w : Var Δ_out t}
    (hvarMap : varMap ∈ matchVar lets v matchLets w ma)
    {t': _ } {v' : _}
    (hMatchLets : ⟨t', v'⟩ ∈ matchLets.vars w) :
  ⟨t', v'⟩ ∈ varMap :=
  match matchLets, w /- , hvarMap, t', v' -/ with
  | .nil, w /-, h, t', v' -/ => by
    revert hMatchLets
    simp only [Lets.vars, VarSet.ofVar, Finset.mem_singleton, Sigma.mk.inj_iff, and_imp]
    rintro ⟨⟩ ⟨⟩
    simp [matchVar] at hvarMap
    split at hvarMap
    · split_ifs at hvarMap
      · simp at hvarMap
        subst hvarMap
        subst v
        exact AList.lookup_isSome.1 (by simp_all)
    · simp at hvarMap
      subst hvarMap
      simp
-- hl: { fst := x✝¹, snd := x✝ } ∈ HVector.vars (Expr.args matchE)
-- h_v': { fst := t', snd := v' } ∈ Lets.vars matchLets x✝

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
  | .var matchLets matchE, ⟨0, hw⟩ /-, h, t', v' -/ => by
    revert hMatchLets
    simp only [Ctxt.get?, Ctxt.snoc, List.getElem?_cons_zero, Option.some.injEq] at hw
    subst hw
    simp only [Lets.vars, Ctxt.get?, Var.zero_eq_last, Var.casesOn_last, Finset.mem_biUnion,
      Sigma.exists, forall_exists_index, and_imp]
    intro _ _ hl h_v'
    obtain ⟨⟨ope, h, args⟩, he₁, he₂⟩ := by
      unfold matchVar at hvarMap
      simp only [bind, Option.mem_def, Option.bind_eq_some_iff] at hvarMap
      simpa [pure, bind] using hvarMap
    subst h
    rw [← Option.dite_none_right_eq_some] at he₂
    split_ifs at he₂ with h
    · dsimp only [Expr.op_mk, Expr.regArgs_mk] at h
      simp only [Expr.op_mk, Expr.args_mk, Option.some.injEq] at he₂
      apply @mem_matchVar_matchArg (matchLets := matchLets) (hvarMap := he₂)
      simp only [Expr.op_mk, Finset.mem_biUnion, Sigma.exists]
      refine ⟨_, _, ?_, h_v'⟩
      rcases matchE  with ⟨_, _, _⟩
      dsimp only [Expr.op_mk, Expr.regArgs_mk] at h
      rcases h with ⟨rfl, _⟩
      exact hl
    exact inferInstance
end

/-- A version of `matchVar` that returns a `Hom` of `Ctxt`s instead of the `AList`,
provided every variable in the context appears as a free variable in `matchExpr`. -/
def matchVarMap {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty} {t : d.Ty}
    (lets : Lets d Γ_in eff Γ_out) (v : Var Γ_out t)
    (matchLets : Lets d Δ_in .pure Δ_out) (w : Var Δ_out t)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w) :
    Option (Δ_in.Hom Γ_out) := do
  match hm : matchVar lets v matchLets w with
  | none => none
  | some m =>
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


/-- `splitProgramAtAux pos lets prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAtAux : (pos : ℕ) → (lets : Lets d Γ₁ eff Γ₂) →
    (prog : Com d Γ₂ eff t) →
    Option (Σ (Γ₃ : Ctxt d.Ty), Lets d Γ₁ eff Γ₃ × Com d Γ₃ eff t × (t' : d.Ty) × Var Γ₃ t')
  | 0, lets, .var e body => some ⟨_, .var lets e, body, _, Var.last _ _⟩
  | _, _, .ret _ => none
  | n+1, lets, .var e body =>
    splitProgramAtAux n (lets.var e) body

theorem denote_splitProgramAtAux [LawfulMonad d.m] : {pos : ℕ} → {lets : Lets d Γ₁ eff Γ₂} →
    {prog : Com d Γ₂ eff t} →
    {res : Σ (Γ₃ : Ctxt d.Ty), Lets d Γ₁ eff Γ₃ × Com d Γ₃ eff t × (t' : d.Ty) × Var Γ₃ t'} →
    (hres : res ∈ splitProgramAtAux pos lets prog) →
    (s : Valuation Γ₁) →
    (res.2.1.denote s) >>= res.2.2.1.denote  = (lets.denote s) >>= prog.denote
  | 0, lets, .var e body, res, hres, s => by
    simp only [splitProgramAtAux, Option.mem_def, Option.some.injEq] at hres
    subst hres
    simp only [Lets.denote, eq_rec_constant, Com.denote]
    simp only [EffectKind.return_impure_toMonad_eq, bind_assoc, pure_bind, Com.denote_var]
  | _+1, _, .ret _, res, hres, s => by
    simp [splitProgramAtAux, Option.mem_def] at hres
  | n+1, lets, .var e body, res, hres, s => by
    rw [splitProgramAtAux] at hres
    cases eff
    case pure =>
      rw [denote_splitProgramAtAux hres s]
      simp [Lets.denote, eq_rec_constant, Ctxt.Valuation.snoc]
    case impure =>
      rw [denote_splitProgramAtAux hres s]
      simp [Lets.denote, eq_rec_constant, Ctxt.Valuation.snoc]

-- TODO: have `splitProgramAt` return a `Zipper`
/-- `splitProgramAt pos prog`, will return a `Lets` ending
with the `pos`th variable in `prog`, and an `Com` starting with the next variable.
It also returns, the type of this variable and the variable itself as an element
of the output `Ctxt` of the returned `Lets`.  -/
def splitProgramAt (pos : ℕ) (prog : Com d Γ₁ eff t) :
    Option (Σ (Γ₂ : Ctxt d.Ty), Lets d Γ₁ eff Γ₂ × Com d Γ₂ eff t × (t' : d.Ty) × Var Γ₂ t') :=
  splitProgramAtAux pos .nil prog

theorem denote_splitProgramAt [LawfulMonad d.m] {pos : ℕ} {prog : Com d Γ₁ eff t}
    {res : Σ (Γ₂ : Ctxt d.Ty), Lets d Γ₁ eff Γ₂ × Com d Γ₂ eff t × (t' : d.Ty) × Var Γ₂ t'}
    (hres : res ∈ splitProgramAt pos prog) (s : Valuation Γ₁) :
     (res.2.1.denote s) >>= res.2.2.1.denote = prog.denote s := by
  rw [denote_splitProgramAtAux hres s]
  cases eff <;> simp

/-
  ## Rewriting
-/

/-- `rewriteAt lhs rhs hlhs pos target`, searches for `lhs` at position `pos` of
`target`. If it can match the variables, it inserts `rhs` into the program
with the correct assignment of variables, and then replaces occurences
of the variable at position `pos` in `target` with the output of `rhs`.  -/
def rewriteAt (lhs rhs : Com d Γ₁ .pure t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    Option (Com d Γ₂ eff t₂) := do
  let ⟨Γ₃, targetLets, target', t', vm⟩ ← splitProgramAt pos target
  if h : t₁ = t'
  then
    let flatLhs := lhs.toFlatCom
    let m ← matchVarMap targetLets vm flatLhs.lets (flatLhs.ret.cast h)
      (by subst h; exact hlhs)
    let zip : Zipper .. := ⟨targetLets, target'⟩;
    let zip := zip.insertPureCom vm (h ▸ rhs.changeVars m)
    return zip.toCom
  else none

@[simp] lemma Com.denote_toFlatCom_lets [LawfulMonad d.m] (com : Com d Γ .pure t) :
    com.toFlatCom.lets.denote = com.denoteLets := by
  funext Γv; simp [toFlatCom, Com.denoteLets_eq]

@[simp] lemma Com.toFlatCom_ret [LawfulMonad d.m] (com : Com d Γ .pure t) :
    com.toFlatCom.ret = com.returnVar := by
  simp [toFlatCom]

theorem denote_rewriteAt [LawfulMonad d.m] (lhs rhs : Com d Γ₁ .pure t₁)
    (hlhs : ∀ t (v : Var Γ₁ t), ⟨t, v⟩ ∈ lhs.vars)
    (pos : ℕ) (target : Com d Γ₂ eff t₂)
    (hl : lhs.denote = rhs.denote)
    (rew : Com d Γ₂ eff t₂)
    (hrew : rew ∈ rewriteAt lhs rhs hlhs pos target) :
    rew.denote = target.denote := by
  funext Γ₂v
  rw [rewriteAt] at hrew
  simp only [bind, pure, Option.bind] at hrew
  split at hrew
  next => simp at hrew
  next a b c hs =>
    simp only [Option.mem_def] at hrew
    split_ifs at hrew
    subst t₁
    split at hrew
    · simp at hrew
    · simp only [Option.some.injEq] at hrew
      subst hrew
      rename_i _ _ h
      simp only [Zipper.denote_toCom, Zipper.denote_insertPureCom, ← hl,
        ← denote_splitProgramAt hs Γ₂v, Valuation.comap_with,
        Valuation.comap_outContextHom_denoteLets, Com.denoteLets_returnVar_pure,
        Com.denote_changeVars, Function.comp_apply]
      have this1 := denote_matchVarMap2 (hmap := h) (s₁ := Γ₂v)
        (f := fun Vtop x =>
            Com.denote c.2.2.1 (Valuation.reassignVar Vtop c.2.2.2.snd x)) -- x : ⟦t'⟧
      simp only [Com.toFlatCom_ret, Var.cast_rfl, Com.denote_toFlatCom_lets,
        Com.denoteLets_returnVar_pure] at this1
      rw [this1]
      congr; funext Γ_out_v; congr
      apply Valuation.reassignVar_eq_of_lookup

variable (d : Dialect) [DialectSignature d] [TyDenote d.Ty] [DialectDenote d] [Monad d.m] in
/--
  Rewrites are indexed with a concrete list of types, rather than an (erased) context, so that
  the required variable checks become decidable
-/
structure PeepholeRewrite (Γ : List d.Ty) (t : d.Ty) where
  lhs : Com d (.ofList Γ) .pure t
  rhs : Com d (.ofList Γ) .pure t
  correct : lhs.denote = rhs.denote

instance {Γ : List d.Ty} {t' : d.Ty} {lhs : Com d (.ofList Γ) .pure t'} :
    Decidable (∀ (t : d.Ty) (v : Var (.ofList Γ) t), ⟨t, v⟩ ∈ lhs.vars) :=
  decidable_of_iff
    (∀ (i : Fin Γ.length),
      let v : Var (.ofList Γ) (Γ.get i) := ⟨i, by simp [List.getElem?_eq_getElem, Ctxt.ofList]⟩
      ⟨_, v⟩ ∈ lhs.vars) <|  by
  constructor
  · intro h t v
    rcases v with ⟨i, hi⟩
    try simp only [Erased.out_mk] at hi
    rcases List.getElem?_eq_some_iff.1 hi with ⟨h', rfl⟩
    simp at h'
    convert h ⟨i, h'⟩
  · intro h i
    apply h

def rewritePeepholeAt (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    (Com d Γ₂ eff t₂) := if hlhs : ∀ t (v : Var (.ofList Γ) t), ⟨_, v⟩ ∈ pr.lhs.vars then
      match rewriteAt pr.lhs pr.rhs hlhs pos target
      with
        | some res => res
        | none => target
      else target


theorem denote_rewritePeepholeAt (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂  eff t₂) :
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

/-- info: 'denote_rewritePeepholeAt' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms denote_rewritePeepholeAt

/- repeatedly apply peephole on program. -/
section SimpPeepholeApplier

/-- rewrite with `pr` to `target` program, at location `ix` and later, running
at most `fuel` steps. -/
def rewritePeephole_go (fuel : ℕ) (pr : PeepholeRewrite d Γ t)
    (ix : ℕ) (target : Com d Γ₂ eff t₂) : (Com d Γ₂ eff t₂) :=
  match fuel with
  | 0 => target
  | fuel' + 1 =>
     let target' := rewritePeepholeAt pr ix target
     rewritePeephole_go fuel' pr (ix + 1) target'

/-- rewrite with `pr` to `target` program, running at most `fuel` steps. -/
def rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) : (Com d Γ₂ eff t₂) :=
  rewritePeephole_go fuel pr 0 target

/-- `rewritePeephole_go` preserve semantics -/
theorem denote_rewritePeephole_go (pr : PeepholeRewrite d Γ t)
    (pos : ℕ) (target : Com d Γ₂ eff t₂) :
    (rewritePeephole_go fuel pr pos target).denote = target.denote := by
  induction fuel generalizing pr pos target
  case zero =>
    simp[rewritePeephole_go, denote_rewritePeepholeAt]
  case succ fuel' hfuel =>
    simp[rewritePeephole_go, denote_rewritePeepholeAt, hfuel]

/-- `rewritePeephole` preserves semantics. -/
theorem denote_rewritePeephole (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) :
    (rewritePeephole fuel pr target).denote = target.denote := by
  simp[rewritePeephole, denote_rewritePeephole_go]

/-- info: 'denote_rewritePeephole' depends on axioms: [propext, Classical.choice, Quot.sound] -/
#guard_msgs in #print axioms denote_rewritePeephole

theorem Expr.denote_eq_of_region_denote_eq (op : d.Op)
    (ty_eq : t = DialectSignature.outTy op)
    (eff' : DialectSignature.effectKind op ≤ eff)
    (args : HVector (Var Γ) (DialectSignature.sig op))
    (regArgs regArgs' : HVector (fun t => Com d t.1 EffectKind.impure t.2)
      (DialectSignature.regSig op))
    (hregArgs' : regArgs'.denote = regArgs.denote) :
  (Expr.mk op ty_eq eff' args regArgs').denote = (Expr.mk op ty_eq eff' args regArgs).denote := by
  funext Γv
  cases eff
  case pure =>
    subst ty_eq
    have heff' : DialectSignature.effectKind op = EffectKind.pure := by simp [eff']
    simp [heff', Expr.denote, hregArgs']
  case impure =>
    subst ty_eq
    simp [Expr.denote, hregArgs']

mutual

def rewritePeepholeRecursivelyRegArgs (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) {ts :  List (Ctxt d.Ty × d.Ty)}
    (args : HVector (fun t => Com d t.1 EffectKind.impure t.2) ts)
    : { out : HVector (fun t => Com d t.1 EffectKind.impure t.2) ts // out.denote = args.denote} :=
  match ts with
  | .nil =>
    match args with
    | .nil => ⟨HVector.nil, rfl⟩
  | .cons .. =>
    match args with
    | .cons com coms =>
      let ⟨com', hcom'⟩ := (rewritePeepholeRecursively fuel pr com)
      let ⟨coms', hcoms'⟩ := (rewritePeepholeRecursivelyRegArgs fuel pr coms)
      ⟨.cons com' coms', by simp [hcom', hcoms']⟩

def rewritePeepholeRecursivelyExpr (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) {ty : d.Ty}
    (e : Expr d Γ₂ eff ty) : { out : Expr d Γ₂ eff ty // out.denote = e.denote } :=
  match e with
  | Expr.mk op ty eff' args regArgs =>
    let ⟨regArgs', hregArgs'⟩ := rewritePeepholeRecursivelyRegArgs fuel pr regArgs
    ⟨Expr.mk op ty eff' args regArgs', by
      apply Expr.denote_eq_of_region_denote_eq op ty eff' args regArgs regArgs' hregArgs'⟩

/-- A peephole rewriter that recurses into regions, allowing
peephole rewriting into nested code. -/
def rewritePeepholeRecursively (fuel : ℕ)
    (pr : PeepholeRewrite d Γ t) (target : Com d Γ₂ eff t₂) :
    { out : Com d Γ₂ eff t₂ // out.denote = target.denote } :=
  match fuel with
  | 0 => ⟨target, rfl⟩
  | fuel + 1 =>
    let target' := rewritePeephole fuel pr target
    have htarget'_denote_eq_htarget : target'.denote = target.denote := by
      apply denote_rewritePeephole
    match htarget : target' with
    | .ret v => ⟨target', by
      simp [htarget, htarget'_denote_eq_htarget]⟩
    | .var (α := α) e body =>
      let ⟨e', he'⟩ := rewritePeepholeRecursivelyExpr fuel pr e
      let ⟨body', hbody'⟩ :=
        -- decreases because 'body' is smaller.
        rewritePeepholeRecursively fuel pr body
      ⟨.var e' body', by
        rw [← htarget'_denote_eq_htarget]
        simp [he', hbody']⟩
end

/--
info: 'rewritePeepholeRecursively' depends on axioms: [propext, Classical.choice, Quot.sound]
-/
#guard_msgs in #print axioms rewritePeepholeRecursively

end SimpPeepholeApplier
