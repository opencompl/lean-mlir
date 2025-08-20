import SSA.Core.Framework
import SSA.Core.Transforms.Rewrite.Mapping

/-!
# Matching

This file defines `matchVar` and `matchArg`, which take in a program and the
pattern of a peephole rewrite, and attempt to find a location in the program
where the peephole is applicable.

-/
set_option deprecated.oldSectionVars true

open Ctxt (Var VarSet Valuation Hom)

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
  termination_by l => (sizeOf matchLets, l.length + 1)

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
  | @Lets.var _ _ _ _ Δ_out ts matchLets matchExpr, w => by
      cases h : w using Var.appendCases with
      | left w =>
        exact matchVar lets v matchLets w
      | right w => exact do
        let ⟨ts', w', ie⟩ ← lets.getPureExpr v
        if hs : ∃ h : ie.op = matchExpr.op, ie.regArgs = (h ▸ matchExpr.regArgs) then
          have hts : Ctxt.ofList ts' = ts := by
            rw [ie.ty_eq, matchExpr.ty_eq, hs.1]
          if w = w'.castCtxt hts then
            matchArg lets matchLets ie.args (hs.1 ▸ matchExpr.args)
          else
            none
        else
          none
  | .nil, w => -- The match expression is just a free (meta) variable
      unifyVars w v
  termination_by matchLets => (sizeOf matchLets, 0)
end

/-!
## Semantics Theorems
-/
section MatchVar
variable [DecidableEq d.Op] {Γ_in Γ_out Δ_in Δ_out t te}
          {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t}
          {matchLets : Lets d Δ_in .pure Δ_out}
          {matchExpr : Expr d Δ_out .pure te}

@[simp] lemma matchVar_appendInl (w : Δ_out.Var t) :
    matchVar lets v (.var matchLets matchExpr) w.appendInl
    = matchVar lets v matchLets w := by
  simp [matchVar]

@[simp]
theorem unifyVars_eq_some_iff :
    unifyVars w v mapIn = some ((), mapOut)
    ↔ ( mapIn.lookup ⟨t, w⟩ = none ∧ mapIn.insert ⟨t, w⟩ v = mapOut
        ∨ mapIn.lookup ⟨t, w⟩ = v ∧ mapIn = mapOut
      ) := by
  simp only [unifyVars]
  split <;> simp_all

@[simp] lemma matchVar_nil_eq {lets : Lets d Γ_in eff Γ_out} :
    matchVar lets v (.nil : Lets d Δ .pure Δ) w = unifyVars w v := by
  simp only [matchVar]

theorem matchVar_nil {lets : Lets d Γ_in eff Γ_out} :
    matchVar lets v (.nil : Lets d Δ .pure Δ) w ma = some ((), ma') →
    ma'.lookup ⟨_, w⟩ = some v := by
  simp only [matchVar_nil_eq, unifyVars_eq_some_iff]
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

theorem matchVar_appendInr {w : Var ⟨te⟩ t} :
    matchVar lets v (.var matchLets matchExpr) w.appendInr ma = some ma' →
    ∃ args,
      lets.getPureExpr v
        = some ⟨_, w, matchExpr.op, matchExpr.ty_eq, matchExpr.eff_le, args, matchExpr.regArgs⟩
      ∧ matchArg lets matchLets args matchExpr.args ma = some ma' := by
  unfold matchVar
  simp only [Var.appendCases_appendInr]
  simp only [MatchVar.liftM_bind_eq_some_iff, forall_exists_index]
  generalize h_e? : lets.getPureExpr v = e?
  intro h_isSome h
  split_ifs at h
  case neg => contradiction
  case neg => contradiction
  case pos h_e? hw =>
    rcases matchExpr with ⟨mOp, _, _, mArgs, mRegArgs⟩
    rcases h_e? with ⟨(rfl : _ = mOp), (rfl : _ = mRegArgs)⟩
    rcases Option.isSome_iff_exists.mp h_isSome with ⟨⟨tys', w', e'⟩, rfl⟩
    simp only [Option.get_some, Expr.op_mk, Expr.regArgs_mk, Option.some.injEq, Sigma.mk.injEq,
      Expr.args_mk]
    obtain rfl : te = tys' := by
      simpa [e'.ty_eq]
    rcases e' with ⟨_op, _ty_eq, _eff_le, args, regArgs⟩
    obtain rfl : w = w' := by
      simp_all [Option.get_some]

    exact ⟨args, ⟨rfl, by rfl⟩, h⟩

/-!
### Subtypes
-/
attribute [refl] List.Subset.refl -- TODO: upstream somewhere

variable (lets v matchLets w) (mapIn : Mapping _ _) in
def MatchVarResult := { mapOut : Mapping _ _ //
  ∃ (mapIn' mapOut' : Mapping _ _),
    mapIn.entries ⊆ mapIn'.entries
    ∧ mapOut'.entries ⊆ mapOut.entries
    ∧  matchVar lets v matchLets w mapIn' = some ((), mapOut') }

variable (lets matchLets) {tys} (vs ws : HVector _ tys) (mapIn : Mapping _ _) in
def MatchArgResult := { mapOut : Mapping _ _ //
  ∃ (mapIn' mapOut' : Mapping _ _),
    mapIn.entries ⊆ mapIn'.entries
    ∧ mapOut'.entries ⊆ mapOut.entries
    ∧ matchArg lets matchLets vs ws mapIn' = some ((), mapOut') }

def MatchVarResult.mk {mapOut : Mapping _ _}
    (h : matchVar lets v matchLets w mapIn = some ((), mapOut) := by simp_all) :
    MatchVarResult lets v matchLets w mapIn :=
  ⟨mapOut, mapIn, mapOut, ⟨by rfl, by rfl, h⟩⟩

def MatchArgResult.mk {mapOut : Mapping _ _}
    (h : matchArg lets matchLets vs ws mapIn = some ((), mapOut) := by simp_all) :
    MatchArgResult lets matchLets vs ws mapIn :=
  ⟨mapOut, mapIn, mapOut, ⟨by rfl, by rfl, h⟩⟩

/-!
### Subtype-based lemmas
-/

@[simp] lemma lookup_matchVar_nil (m : MatchVarResult lets v .nil w ma) :
    m.val.lookup ⟨_, w⟩ = some v := by
  rcases m with ⟨m, -, m', -, h_entries_out, hm'⟩
  rw [← Option.mem_def, AList.mem_lookup_iff]
  apply h_entries_out
  simp [← AList.mem_lookup_iff, matchVar_nil hm']

namespace MatchVarResult

theorem ofSubsetEntries {varMap₁ : MatchVarResult lets v matchLets w ma} {varMap₂ : Mapping _ _}
    (h_sub : varMap₁.val.entries ⊆ varMap₂.entries) :
    ∃ varMap₃ : MatchVarResult lets v matchLets w ma, varMap₂ = varMap₃.val := by
  rcases varMap₁ with ⟨varMap₁, mapIn', map', h₁, h₂, h₃⟩
  refine ⟨⟨varMap₂, mapIn', map', h₁, ?_, h₃⟩, rfl⟩
  trans; exact h₂; exact h_sub

/-! ### nil lemmas -/

variable [TyDenote d.Ty] [∀ (t : d.Ty), Inhabited ⟦t⟧] in
@[simp] lemma mapValuation_nil (mapOut : MatchVarResult lets v .nil w mapIn) (V) :
    mapOut.val.mapValuation V w = V v := by
  simp [Mapping.mapValuation]

/-! ### var_appendInl lemmas -/
section Left
variable {w : Δ_out.Var t}

def eqvVarLeft  :
    MatchVarResult lets v (.var matchLets matchExpr) w.appendInl ma
    ≃ MatchVarResult lets v matchLets w ma where
  toFun := fun ⟨x, h⟩ => ⟨x, by simp_all⟩
  invFun := fun ⟨x, h⟩ => ⟨x, by simp_all⟩

@[simp, defeq]
lemma entries_symm_eqvVar (varMap : MatchVarResult lets v matchLets w ma) :
  (eqvVarLeft (matchExpr:=matchExpr) |>.symm  varMap).val.entries = varMap.val.entries := rfl

variable {mapIn} (mapOut : MatchVarResult lets v (.var matchLets matchExpr) w.appendInl mapIn)

@[simp, defeq] lemma entries_eqvVar : (eqvVarLeft mapOut).val.entries = mapOut.val.entries := rfl

end Left
/-! ### var_appendInr lemmas -/
variable {w : Var ⟨te⟩ _} {mapIn}

-- def elimNil {v : Γ_in.Var t} {w} {α : Sort u} :
--     MatchVarResult (Lets.nil (Γ_in:=Γ_in) (eff:=eff)) v matchLets w mapIn
--     → α
--   | ⟨_, h⟩ => False.elim <| by
--       simp [matchVar] at h
--       sorry
-- def eqvVarRight  :
--     MatchVarResult lets v (.var matchLets matchExpr) w.appendInr ma
--     ≃ MatchVarResult lets v matchLets w ma where
--   toFun := fun ⟨x, h⟩ => ⟨x, by simp_all⟩
--   invFun := fun ⟨x, h⟩ => ⟨x, by simp_all⟩

theorem getPureExpr_eq_some
    (mapOut : MatchVarResult lets v (.var matchLets matchExpr) w.appendInr mapIn) :
    ∃ args, lets.getPureExpr v = some ⟨te, w, ⟨
        matchExpr.op,
        matchExpr.ty_eq,
        matchExpr.eff_le,
        args,
        matchExpr.regArgs
      ⟩⟩ := by
  rcases mapOut with ⟨mapOut, _, map', _, _, h⟩
  obtain ⟨args, h₁, h₂⟩ := matchVar_appendInr h
  use args, h₁



noncomputable def toArgResult
    (mapOut : MatchVarResult lets v (.var matchLets matchExpr) w.appendInr mapIn) :
    let args := mapOut.getPureExpr_eq_some.choose
    MatchArgResult lets matchLets args matchExpr.args mapIn :=
  ⟨mapOut.1, by
    rcases mapOut with ⟨mapOut, mapIn', mapOut', h₁, h₂, h₃⟩
    use mapIn', mapOut', h₁, h₂
    have ⟨args, h'₁, h'₂⟩ := matchVar_appendInr h₃
    simp [*]
  ⟩

noncomputable instance :
  CoeDep (MatchVarResult lets v (.var matchLets matchExpr) w.appendInr mapIn)
        mapOut
        (let args := mapOut.getPureExpr_eq_some.choose
         MatchArgResult lets matchLets args matchExpr.args mapIn) where
  coe := mapOut.toArgResult

-- noncomputable def toArgResult :
--     MatchVarResult lets v (.var matchLets matchExpr) w.appendInr mapIn
--     → Σ (ts : _) (ePure : { ePure //
--           lets.getPureExpr v = some ⟨ts, ePure⟩
--           ∧ ePure.op = matchExpr.op
--         }),
--         MatchArgResult lets matchLets ePure.val.args (cast (by rw[ePure.prop.2]) matchExpr.args) mapIn := by
--   rintro ⟨mapOut, h⟩

@[simp] lemma val_toArgResult (mapOut : MatchVarResult lets v (.var matchLets matchExpr) w.appendInr mapIn) :
    mapOut.toArgResult.val = mapOut.val := rfl

end MatchVarResult

end MatchVar

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

@[simp] theorem MatchVar.isMonotone_none : IsMonotone (none : MatchVar Δ Γ) := by
  intro mapIn mapOut (h : _ ∈ none); contradiction

section UnifyVars
variable {Δ Γ : Ctxt d.Ty} {t} (w : Δ.Var t) (v : Γ.Var t)

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
  · intro _ _ mapIn ⟨(), mapOut⟩ hvarMap
    obtain rfl : mapIn = mapOut := by
      simp only [matchArg] at hvarMap
      change some ((), _) = some ((), _) at hvarMap
      simp_all
    exact Set.Subset.refl _

  · intros
    simp only [matchArg]
    apply isMonotone_bind <;> assumption

  · intro _ _ Δ_out u matchLets matchExpr l h ih
    cases l using Var.appendCases
    · simp [h]
    · simp only [matchVar, Var.appendCases_appendInr, isMonotone_bind_liftM,
      Option.mem_def]
      intro ⟨_, e⟩ h_getPureExpr
      split_ifs
      · apply ih; assumption
      · exact isMonotone_none
      · exact isMonotone_none

  · simp [isMonotone_unifyVars]



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

/-! ## MatchArgResult -/
namespace MatchArgResult
variable [DecidableEq d.Op] {Γ_in Γ_out Δ_in Δ_out te}
          {lets : Lets d Γ_in eff Γ_out}
          {matchLets : Lets d Δ_in .pure Δ_out}
          {matchExpr : Expr d Δ_out .pure te}
          {u us}
          {v : Γ_out.Var u} {vs : HVector Γ_out.Var us}
          {w : Δ_out.Var u} {ws : HVector Δ_out.Var us}
          {mapIn : Mapping _ _}
          (mapOut : MatchArgResult lets matchLets (v ::ₕ vs) (w ::ₕ ws) mapIn)

def consLeft : MatchVarResult lets v matchLets w mapIn :=
  ⟨mapOut.val, by
    rcases mapOut with ⟨mapOut, ⟨mapIn', mapOut', h_entries_in, h_entries_out, h⟩⟩
    change StateT.run _ _ = _ at h
    obtain ⟨⟨⟩, mapOut'', h₁, h₂⟩ := by
      simpa only [matchArg, StateT.run_bind, Option.bind_eq_bind, Option.bind_eq_some_iff,
        Prod.exists] using h
    refine ⟨mapIn', mapOut'', h_entries_in, ?_, h₁⟩
    trans mapOut'.entries
    · exact isMonotone_matchArg _ _ h₂
    · exact h_entries_out
  ⟩

def consRight : MatchArgResult lets matchLets vs ws mapIn :=
  ⟨mapOut.val, by
    rcases mapOut with ⟨mapOut, ⟨mapIn', mapOut', h_entries_in, h_entries_out, h⟩⟩
    change StateT.run _ _ = _ at h
    obtain ⟨⟨⟩, mapOut'', h₁, h₂⟩ := by
      simpa only [matchArg, StateT.run_bind, Option.bind_eq_bind, Option.bind_eq_some_iff,
        Prod.exists] using h
    refine ⟨_, _, ?_, h_entries_out, h₂⟩
    trans mapIn'.entries
    · exact h_entries_in
    · exact isMonotone_matchVar _ _ h₁
  ⟩

@[simp, grind=] lemma val_consLeft : mapOut.consLeft.val = mapOut.val := rfl
@[simp, grind=] lemma val_consRight : mapOut.consRight.val = mapOut.val := rfl

end MatchArgResult

/-!
## Semantics Preservation
-/
section DenoteLemmas

-- TODO: this assumption is too strong, we also want to be able to model non-inhabited types
variable [TyDenote d.Ty] [DecidableEq d.Op]
variable [∀ (t : d.Ty), Inhabited ⟦t⟧]

theorem HVector.map_eq_map_of_matchArg
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {ma : Mapping Δ_in Γ_out}
    {l : List d.Ty} {args₁ : HVector _ l} {args₂ : HVector _ l}
    (mapOut : MatchArgResult lets matchLets args₁ args₂ ma)
    (f₁ f₂ : (t : d.Ty) → Var _ t → ⟦t⟧)
    (hf : ∀ {t v₁ v₂},
      (mapOut' : MatchVarResult lets v₁ matchLets v₂ ma)
      → mapOut'.val = mapOut.val
      → f₂ t v₂ = f₁ t v₁) :
    HVector.map f₂ args₂ = HVector.map f₁ args₁ := by
  induction args₁ <;> cases args₂
  case nil.nil => rfl
  case cons.cons _ _ ih _ _ =>
    simp only [map_cons, cons.injEq]
    and_intros
    · apply hf mapOut.consLeft (by rfl)
    · apply ih mapOut.consRight hf

variable [Monad d.m] [LawfulMonad d.m] [DialectDenote d]

section DenoteIntoSubtype

/- TODO: we might not need `denoteIntoSubtype`, if we can prove that `V ∈ supp (lets.denote _)`
implies `lets.getPureExpr v = some e → e.denote V = V v` -/

/-- `e.IsDenotationForPureE Γv x` holds if `x` is the pure value obtained from `e` under valuation
`Γv`, assuming that `e` has a pure operation.
If `e` has an impure operation, the property holds vacuously. -/
abbrev Expr.IsDenotationForPureE (e : Expr d Γ eff tys) (Γv : Valuation Γ)
    (x : HVector toType tys) : Prop :=
  ∀ (ePure : Expr d Γ .pure tys), e.toPure? = some ePure → ePure.denoteOp Γv = x

def Expr.denoteOpIntoSubtype (e : Expr d Γ_in eff tys) (Γv : Valuation Γ_in) :
    eff.toMonad d.m {x // e.IsDenotationForPureE Γv x} :=
  match h_pure : e.toPure? with
    | some ePure => pure ⟨ePure.denoteOp Γv, by simp [IsDenotationForPureE, h_pure]⟩
    | none => (Subtype.mk · (by simp [IsDenotationForPureE, h_pure])) <$> (e.denoteOp Γv)

def Lets.ValidDenotation (lets : Lets d Γ_in eff Γ_out) :=
  { V // ∀ {t ts} {v : Var _ t} {w : Var ⟨ts⟩ t} {e} ,
          lets.getPureExpr v = some ⟨ts, w, e⟩
          → (e.pdenoteOp V)[w] = V v }

/-- An alternative version of `Lets.denote`, whose returned type carries a proof that the valuation
agrees with the denotation of every pure expression in `lets`.

Strongly prefer using `Lets.denote` in definitions, but you can use `denoteIntoSubtype` in proofs.
The subtype allows us to carry the property with us when doing congruence proofs inside a bind. -/
def Lets.denoteIntoSubtype (lets : Lets d Γ_in eff Γ_out) (Γv : Valuation Γ_in) :
    eff.toMonad d.m lets.ValidDenotation :=
  match lets with
    | .nil => return ⟨Γv, by simp⟩
    | @Lets.var _ _ _ _ Γ_out eTy body e => do
        let ⟨Vout, h⟩ ← body.denoteIntoSubtype Γv
        let Ve ← e.denoteOpIntoSubtype Vout
        return ⟨Vout ++ Ve.val, by
          intro t' _ v' w ePure h_getPureExpr
          induction v' using Var.appendCases
          · obtain ⟨tys', w', ePure', h_ePure', rfl, h_ePure⟩ := by
              simp only [getPureExpr_var_appendInl, Option.map_eq_map, Option.map_eq_some_iff,
                Sigma.mk.injEq, Sigma.exists, Prod.exists] at h_getPureExpr
              exact h_getPureExpr
            clear h_getPureExpr
            obtain ⟨(rfl : w' = w), (rfl : ePure'.changeVars e.contextHom = ePure)⟩ := by
              simpa using h_ePure
            clear h_ePure
            simpa using h h_ePure'
          · simp only [getPureExpr_var_appendInr, Option.map_eq_some_iff,
            Sigma.mk.injEq] at h_getPureExpr
            rcases h_getPureExpr with ⟨ePure', h_toPure?, rfl, h_ePure⟩
            obtain ⟨(rfl : _ = w), (rfl : ePure'.changeVars e.contextHom = ePure)⟩ := by
              simpa using h_ePure
            simp [Ve.prop _ h_toPure?]
        ⟩

theorem Expr.denoteOp_eq_denoteOpIntoSubtype (e : Expr d Γ eff tys) (V : Valuation Γ) :
    e.denoteOp V = Subtype.val <$> e.denoteOpIntoSubtype V := by
  simp only [denoteOpIntoSubtype]
  split
  next h_pure =>
    simp only [toPure?, Option.dite_none_right_eq_some, Option.some.injEq] at h_pure
    rcases h_pure with ⟨_, rfl⟩
    simpa using (pure_denoteOp_toPure ..).symm
  next => simp

theorem Lets.denote_eq_denoteIntoSubtype (lets : Lets d Γ_in eff Γ_out) (Γv : Valuation Γ_in) :
    lets.denote Γv = Subtype.val <$> (lets.denoteIntoSubtype Γv) := by
  induction lets
  case nil => simp [denoteIntoSubtype]
  case var body e ih =>
    simp [ValidDenotation, denote, denoteIntoSubtype, ih,
      Expr.denote_unfold, Expr.denoteOp_eq_denoteOpIntoSubtype]

end DenoteIntoSubtype

@[simp] lemma Lets.denote_var_appendInr_pure (lets : Lets d Γ_in .pure Γ_out)
    (e : Expr d Γ_out .pure tys) (V_in : Valuation Γ_in) (v : Var _ u) :
    Lets.denote (var lets e) V_in (v.appendInr)
    = let xs : HVector .. := e.denoteOp (lets.denote V_in)
      xs[v] := by
  show e.denote (lets.denote _) _ = _
  simp [Expr.denote_unfold, Id.map_eq']

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
    (mapOut : MatchVarResult lets v matchLets w mapIn)
    (V : lets.ValidDenotation) :
    (matchLets.denote (mapOut.val.mapValuation V.val) w)
    = V.val v := by
  induction matchLets generalizing v mapIn t
  case nil => simp [Id.pure_eq']
  case var t' matchLets matchExpr ih =>
    cases w using Var.appendCases with
    | left w =>
      specialize ih mapOut.eqvVarLeft
      simpa [Id.bind_eq'] using ih
    | right w =>
      -- specialize ih _
      let mapOut' := mapOut.toArgResult
      have h := Exists.choose_spec mapOut.getPureExpr_eq_some

      rw [← V.prop h]
      simp
      congr 1

      apply Expr.denoteOp_eq_denoteOp_of (by rfl)
      · simp only [Expr.op_mk, Expr.args_mk]
        rw [HVector.map_eq_map_of_matchArg (f₁ := V.val) (mapOut := mapOut')]
        · intro t v₁ v₂ mapOut'' mapOut_eq
          simp [← ih mapOut'', mapOut_eq, mapOut']
      · rfl

theorem denote_matchArg
    {vs ws : HVector (Var _) ts}
    (mapOut : MatchArgResult lets matchLets vs ws mapIn)
    (V : lets.ValidDenotation) :
    HVector.map (matchLets.denote (mapOut.val.mapValuation V.val)) ws = HVector.map (V.val) vs := by
  apply HVector.map_eq_map_of_matchArg mapOut
  intro t v₁ v₂ mapOut' mapOut_eq
  simp [← mapOut_eq, denote_matchVar]
  -- TODO: there is a little bit of duplication between the last bit of the `denote_matchVar` proof
  --       and the `denote_matchArg` proof, but resolving it is not worth the hassle of introducing
  --       a mutual theorem block.


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

theorem mem_matchArg {Δ_out}
    {lets : Lets d Γ_in eff Γ_out}
    {matchLets : Lets d Δ_in .pure Δ_out}
    {l : List d.Ty} {argsₗ : HVector (Var Γ_out) l}
    {argsᵣ : HVector (Var Δ_out) l} {ma : Mapping Δ_in Γ_out}
    {varMap : Mapping Δ_in Γ_out}
    (hvarMap : ((), varMap) ∈ matchArg lets matchLets argsₗ argsᵣ ma)
    {t' v'} : ⟨t', v'⟩ ∈ matchLets.varsOfVec argsᵣ → ⟨t', v'⟩ ∈ varMap :=
  match l, argsₗ, argsᵣ/- , ma, varMap, hvarMap -/ with
  | .nil, .nil, .nil /- , _, varMap, _ -/ => by simp [Lets.varsOfVec]
  | .cons t ts, .cons vₗ argsₗ, .cons vᵣ args /-, ma, varMap, h -/ => by
    simp only [matchArg, bind, Option.mem_def, StateT.bind, Option.bind_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨ma', h₁, h₂⟩
    simp only [HVector.vars_cons, Finset.biUnion_insert, Finset.mem_union,
      Finset.mem_biUnion, Sigma.exists, Lets.varsOfVec]
    rintro (h | ⟨a, b, hab⟩)
    · exact AList.keys_subset_keys_of_entries_subset_entries
        (isMonotone_matchArg _ _ h₂)
        (mem_matchVar (matchLets := matchLets) h₁ h)
    · apply mem_matchArg h₂
      unfold Lets.varsOfVec
      apply Finset.mem_biUnion.mpr ⟨_, hab.1, hab.2⟩

/-- All variables containing in `matchExpr` are assigned by `matchVar`. -/
theorem mem_matchVar {Δ_out}
    {varMap : Mapping Δ_in Γ_out} {ma : Mapping Δ_in Γ_out}
    {lets : Lets d Γ_in eff Γ_out} {v : Var Γ_out t} /- : -/
    {matchLets : Lets d Δ_in .pure Δ_out}  {w : Var Δ_out t}
    (hvarMap : ((), varMap) ∈ matchVar lets v matchLets w ma)
    {t': _ } {v' : _}
    (hMatchLets : ⟨t', v'⟩ ∈ matchLets.vars w) :
  ⟨t', v'⟩ ∈ varMap :=
  match matchLets /- , hvarMap, t', v' -/ with
  | .nil => by
    revert hMatchLets
    simp only [Lets.vars, VarSet.ofVar, Finset.mem_singleton, Sigma.mk.inj_iff, and_imp]
    rintro ⟨⟩ ⟨⟩
    simp only [matchVar, Option.mem_def, unifyVars_eq_some_iff] at hvarMap
    rcases hvarMap with ⟨_, rfl⟩ | ⟨h_lookup, rfl⟩
    · simp
    · simp [← AList.lookup_isSome, h_lookup]

  | .var matchLets matchE => by
    simp only [matchVar, Option.mem_def] at hvarMap
    cases w using Var.appendCases with
    | left w =>
        simp only [Var.appendCases_appendInl] at hvarMap
        apply mem_matchVar hvarMap
        simpa [Lets.vars] using hMatchLets
    | right w =>
        simp only [Var.appendCases_appendInr, MatchVar.liftM_bind_eq_some_iff] at hvarMap
        rcases hvarMap with ⟨h_isSome, hvarMap⟩
        split_ifs at hvarMap with h_pure h_var <;> (try contradiction)
        subst h_var
        apply mem_matchArg hvarMap
        rcases matchE with ⟨matchOp, _⟩
        obtain rfl : matchOp = _ := h_pure.1.symm
        simpa [Lets.vars] using hMatchLets

end

/--
`matchVarRes` is an alternative version of `matchVar'` which wraps the returned
map as a `MatchVarResult`, and drops the accumulator map input (instead setting
it to the default empty map).
-/
def matchArgRes (lets : Lets d Γ_in eff Γ_out)
    (matchLets : Lets d Δ_in .pure Δ_out)
    (vs : HVector Γ_out.Var ts)
    (ws : HVector Δ_out.Var ts) :
    Option (MatchArgResult lets matchLets vs ws ∅) := do
  (matchArg lets matchLets vs ws ∅).attach.map fun ⟨⟨_, _⟩, h⟩ => .mk h

/--
If a `matchLets` contains all variables in context `Δ_in`, the corresponding
`matchVar` result mapping is in fact a total context morphism.
-/
def MatchVarResult.isTotal_of
    (map : MatchVarResult lets v matchLets w mapIn)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w) :
    map.val.IsTotal := by
  intro t v
  have ⟨_, map', _, h_entries, h_matchVar⟩ := map.prop
  apply AList.keys_subset_keys_of_entries_subset_entries h_entries
  apply mem_matchVar h_matchVar (hvars _ v)

/-- Wrapper around `Mapping.toHom` and `MatchVarResult.isTotal_of`. -/
def MatchVarResult.toHom
    (map : MatchVarResult lets v matchLets w mapIn)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.vars w) :
    Δ_in.Hom Γ_out :=
  map.val.toHom <| map.isTotal_of hvars

/--
If a `matchLets` contains all variables in context `Δ_in`, the corresponding
`matchVar` result mapping is in fact a total context morphism.
-/
def MatchArgResult.isTotal_of
    (map : MatchArgResult lets matchLets vs ws mapIn)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.varsOfVec ws) :
    map.val.IsTotal := by
  intro t v
  have ⟨_, map', _, h_entries, h_match⟩ := map.prop
  apply AList.keys_subset_keys_of_entries_subset_entries h_entries
  apply mem_matchArg h_match (hvars _ v)

/-- Wrapper around `Mapping.toHom` and `MatchArgResult.isTotal_of`. -/
def MatchArgResult.toHom
    (map : MatchArgResult lets matchLets vs ws mapIn)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.varsOfVec ws) :
    Δ_in.Hom Γ_out :=
  map.val.toHom <| map.isTotal_of hvars

variable
  {Γ_in Γ_out Δ_in Δ_out : Ctxt d.Ty}
  {lets : Lets d Γ_in eff Γ_out}
  {matchTy}
  {v : Var Γ_out matchTy}
  {matchLets : Lets d Δ_in .pure Δ_out}
  {w : Var Δ_out matchTy}
in
theorem denote_matchLets_of
    (map : MatchArgResult lets matchLets vs ws mapIn)
    (hvars : ∀ t (v : Var Δ_in t), ⟨t, v⟩ ∈ matchLets.varsOfVec ws)
    (V : lets.ValidDenotation) :
    ws.map (matchLets.denote (V.val.comap <| map.toHom h)) = vs.map V.val := by
  unfold MatchArgResult.toHom
  rw [Mapping.toHom_eq_mapValuation (map.isTotal_of hvars)]
  apply denote_matchArg


end DenoteLemmas
