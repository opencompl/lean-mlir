import SSA.Experimental.IntrinsicAsymptotics.Basic
import SSA.Experimental.IntrinsicAsymptotics.Semantics


/-!
  # Matching & Rewriting
-/ 

structure GetVarResult {Γ₁ Γ₂ : Ctxt} {t : Ty} (lets₀ : Lets Γ₁ Γ₂) (v : Γ₂.Var t) where
  {Δ : Ctxt}
  lets : Lets Γ₁ Δ
  expr : IExpr Δ t
  embedVars : (t' : Ty) → (Δ.snoc t).Var t' → Γ₂.Var t' 
  /-- The returned `expr` is semantically equivalent to the requested var -/
  semantics : ∀ (ll : Γ₁.Sem), lets₀.denote ll v = expr.denote (lets.denote ll)

def GetVarResult.coe_snoc (lets : Lets Γ₁ Γ₂) (v : Γ₂.Var t) : 
    GetVarResult lets v → GetVarResult (.lete lets e) v.toSnoc
  | ⟨lets, expr, embed, sem⟩ => ⟨lets, expr, fun t v => embed t v |>.toSnoc, sem⟩

/-- Drop bindings from `lets` until the binding corresponding to `v` is at the head.
    This can fail, since `v` might be a free variable originating from `Γ₁`.
    Returns the new `lets`, plus a proof that it's context is a prefix of the original context -/
def Lets.getVar {Γ₁ Γ₂ : Ctxt} {t : Ty} : 
    (lets : Lets Γ₁ Γ₂) → (v : Γ₂.Var t) → Option (GetVarResult lets v)
  | .nil,  _ => none
  | .lete body e,  v => by
    cases v using Ctxt.Var.casesOn with
    | last => exact some ⟨body, e, fun _ v => v, fun _ => rfl⟩ 
    | toSnoc v => exact (getVar body v).map (·.coe_snoc)



def IMatchPattern (Γ : Ctxt) (t : Ty) : Type :=
  {e : IExprRec Γ t // e.vars.IsComplete}

namespace IMatchPattern

structure MatchAtVarArgs where
  {Γ₀ Δ₀ : Ctxt}    -- the top-level (in/out) contexts
  {Γ₁ Δ₁ : Ctxt}    -- the (in/out) contexts of the current subprogram
  {Γ' : Ctxt}       -- the context of the matchpattern
  {t t' : Ty}
  (lets : Lets Γ₁ Δ₁)                   -- the current subprogram
  (pattern : IMatchPattern Γ' t')       -- the current match expression
  {cs : List <| Γ'.VarSet × Δ₀.VarSet}
  (map : TotalMapping Γ' Δ₀ cs)         -- the assingment so far
  (embedVars : (t : Ty) → Δ₁.Var t → Δ₀.Var t)
  (v : Δ₁.Var t)

/-- The domain constraint of the mapping returned from matching with these arguments -/
@[simp]
protected abbrev MatchAtVarArgs.V (args : MatchAtVarArgs) : args.Γ'.VarSet := 
  args.pattern.val.vars

/-- 
  The *co*domain constraint of the mapping returned from matching with these arguments,
  which is that each target variable should be "in" `Δ₁`, where "in" means there is some variable
  of `Δ₁` that `embedVars` maps to the target variable.
-/
@[simp]
protected abbrev MatchAtVarArgs.W (args : MatchAtVarArgs) : args.Δ₀.VarSet :=
  fun t => { w₀ : args.Δ₀.Var t | ∃ w₁, args.embedVars _ w₁ = w₀}


@[simp]
protected noncomputable abbrev MatchAtVarArgs.patternAfterSubstition (args : MatchAtVarArgs) 
    (map : TotalMapping args.Γ' args.Δ₀ ((args.V, args.W) :: args.cs)) : 
    IExprRec args.Δ₁ args.t' :=
  let varsMap : (t : Ty) → (v : args.Γ'.Var t) → v ∈ args.pattern.val.vars t → Ctxt.Var args.Δ₁ t := 
    fun t v h => 
      Subtype.val <| Ctxt.Var.extractWitnessOfExists <| by
        rcases map.isTotal _ args.W (List.Mem.head _) t v h with ⟨w, ⟨⟨w', h'⟩, h⟩⟩
        rw [←h'] at h
        exact ⟨w', h⟩
      
  args.pattern.val.changeVarsMem varsMap

structure MatchAtVarResult (args : MatchAtVarArgs) where
  map : TotalMapping args.Γ' args.Δ₀ ((args.V, args.W) :: args.cs)
  semantics : ∀ (ll : args.Γ₁.Sem), 
    (args.lets.denote ll v) = ((args.patternAfterSubstition map).denote (args.lets.denote ll))

def matchAtVar : (args : MatchAtVarArgs) → Option (MatchAtVarResult args) 
  | ⟨lets, ⟨matchExpr, _⟩, map, embedVars, v⟩ => do
    let ⟨lets, expr, embed, _sem⟩ ← lets.getVar v
    let embedVars := fun t v => embedVars t <| embed t v
    let map := map.newConstraint fun _ => { w₀ | ∃ w₁, embedVars _ w₁ = w₀}

    match matchExpr, expr with
    | .var v, _ => do
        let map ← map.insert v (embedVars _ <| Ctxt.Var.last ..)
        let map := map.coerceDomain (by simp[IExprRec.vars, IExprRec.varsBool]; rfl) rfl

        return ⟨map, sorry⟩
    | .cst n, .nat m =>
        if n = m then
          let map := map.coerceDomain (by
            simp[Membership.mem, Set.Mem, IExprRec.vars, IExprRec.varsBool, Union.union, 
                Set.union]
            rfl
          )
          return ⟨map, sorry⟩
        else
          none
    | .add lhs rhs, .add v₁ v₂ => do
        let embedVars : (t : Ty) → Ctxt.Var Δ'' t → Ctxt.Var Δ t := 
          fun u v => embedVars u <| cast (by simp_all) (v.toSnoc (t' := .nat))
        let ⟨map, _⟩ ← go lets lhs map embedVars v₁
        let ⟨map, _⟩ ← go lets rhs map embedVars v₂

        let map := map.coerceDomain <| by
          simp[Membership.mem, Set.Mem, IExprRec.vars, IExprRec.varsBool, Union.union,
                Set.union, setOf, or_assoc]
        return ⟨map, sorry⟩
    | _, _ => none


end IMatchPattern














structure IExprRec.MatchResult (lets : Lets Γ Δ) (matchExpr : IExprRec Γ' t') (v : Δ.Var t) where
  varsMap : (t : Ty) → Γ'.Var t → Δ.Var t
  -- TODO: prove that if matching succeeds the following holds
  semantics : ∀ (ll : Γ.Sem), 
    HEq (lets.denote ll v) ((matchExpr.changeVars varsMap).denote (lets.denote ll))


structure IExprRec.MatchResultAux (Δ : Ctxt) (lets : Lets Γ Δ') (matchExpr : IExprRec Γ' t') 
    (V : Γ'.VarSet) (v : Δ'.Var t) (c : matchExpr.vars.IsComplete) where
  map : TotalMapping Γ' Δ (V ∪ matchExpr.vars)
  -- TODO: prove that if matching succeeds the following holds
  semantics : ∀ (ll : Γ.Sem), 
    HEq (lets.denote ll v) 
        ((matchExpr.changeVarsMem fun t v h => map.lookupMem t v sorry)
          |>.denote (lets.denote ll))


/--
  Given a sequence of `Lets`, try to match a pattern against the bottom-most let
  * If the match fails, return `none`
  * Otherwise, return an assignment of meta-variables of `matchExpr` to variables in `Δ`
-/
def IExprRec.matchAgainstLets {Γ Δ : Ctxt} (lets : Lets Γ (Δ.snoc t)) (matchExpr : IExprRec Γ' t') 
    (is_complete : matchExpr.vars.IsComplete) : 
    Option (MatchResult lets matchExpr (Ctxt.Var.last ..)) := do
  let ⟨map, _⟩ ← go lets matchExpr .empty (fun _ t => t) (Ctxt.Var.last ..)
  let map := map.coerceDomain <| by 
    simp[Union.union, Set.union, EmptyCollection.emptyCollection, Membership.mem, Set.Mem]
    rfl
  return ⟨map.lookup is_complete, sorry⟩
where  
  /--
    Match `matchExpr` against the let at position `v` in `lets`
  -/
  go {Γ Δ' Δ : Ctxt} {t t'} 
      (lets : Lets Γ Δ')
      (matchExpr : IExprRec Γ' t')
      {V : (t : Ty) → Set (Γ'.Var t)}
      (map : TotalMapping Γ' Δ V) 
      (embedVars : (t : Ty) → Δ'.Var t → Δ.Var t)
      (v : Δ'.Var t) : 
      Option (MatchResultAux Δ lets matchExpr V v) := do
    let ⟨lets, embed, semantics⟩ ← lets.getVar v
    let embedVars := fun t v => embedVars t <| embed t v

    match _h : lets with
      | .nil => none
      | @Lets.lete _ Δ'' _ lets e =>
        match matchExpr, e with
          | .var v, _ => do
              let map ← map.insert v (embedVars _ <| Ctxt.Var.last ..)
              let map := map.coerceDomain (by simp[IExprRec.vars, IExprRec.varsBool]; rfl)

              return ⟨map, sorry⟩
          | .cst n, .nat m =>
              if n = m then
                let map := map.coerceDomain (by
                  simp[Membership.mem, Set.Mem, IExprRec.vars, IExprRec.varsBool, Union.union, 
                      Set.union]
                  rfl
                )
                return ⟨map, sorry⟩
              else
                none
          | .add lhs rhs, .add v₁ v₂ => do
              let embedVars : (t : Ty) → Ctxt.Var Δ'' t → Ctxt.Var Δ t := 
                fun u v => embedVars u <| cast (by simp_all) (v.toSnoc (t' := .nat))
              let ⟨map, _⟩ ← go lets lhs map embedVars v₁
              let ⟨map, _⟩ ← go lets rhs map embedVars v₂

              let map := map.coerceDomain <| by
                simp[Membership.mem, Set.Mem, IExprRec.vars, IExprRec.varsBool, Union.union,
                     Set.union, setOf, or_assoc]
              return ⟨map, sorry⟩
          | _, _ => none


--
--  ## Alternative rewrite
-- The following code implements rewrites by adding new let-bindings to the prefix `lets`
-- This is considerably more copmlex, because we are adding an arbitrary number of types to the
-- output context, hence, we have to reason about the noncomputable `append`.

-- However, it has the benefit that we can then update variable references in a single pass, where
-- `addProgramAtTop` will do a pass over `inputProg` for every new let-binding, each time only
-- incrementing each variable index by one.
--
-- structure InsertLetsResult (Γ Δ : Ctxt) (t : Ty) where
--   (Δ' : Ctxt)
--   (len : Δ'.Size)
--   (lets : Lets Γ (Δ ++ Δ'))
--   (var : Ctxt.Var (Δ ++ Δ') t)

-- /--
--   Given an assignment of meta-variables in `matchExpr`, insert new let-bindings into an existing
--   sequence
-- -/
-- def IExprRec.insertLets (lets : Lets Γ Δ) (pattern : IExprRec Γ' t) (assignment : Mapping Γ' Δ) :
--     Option (InsertLetsResult Γ Δ t) :=
--   match pattern with
--     | .cst n => some (
--         let Δ' := .snoc ∅ Ty.nat
--         let lets := Lets.lete lets (.nat n)          
--         ⟨Δ', ⟨1, by simp⟩, cast (by simp) lets, cast (by simp) <| Ctxt.Var.last Δ Ty.nat⟩
--       )
--     | .var v => do
--         let v ← assignment.lookup _ v
--         some ⟨∅, ⟨0, by simp⟩, cast (by simp) lets, cast (by simp) v⟩
--     | .add lhs rhs => do
--         let ⟨Δ₁, length₁, lets₁, v₁⟩ ← insertLets lets lhs assignment
--         let ⟨Δ₂, length₂, lets₂, v₂⟩ ← insertLets lets₁ rhs (assignment.growCodomain length₁)

--         let lets₃ := Lets.lete lets₂ (.add (.inl length₂ v₁) v₂)
--         let Δ' := (Δ₁ ++ Δ₂)
--         some ⟨
--           Δ'.snoc Ty.nat, 
--           ⟨length₁.val + length₂.val + 1, by 
--             rcases length₁ with ⟨_, ⟨⟩⟩
--             rcases length₂ with ⟨_, ⟨⟩⟩
--             simp[(· ++ ·), Append.append, Ctxt.append]
--             apply Nat.add_comm
--           ⟩,
--           cast (by simp[Ctxt.append_assoc]) lets₃, 
--           cast (by simp) <| Ctxt.Var.last (Δ ++ Δ') Ty.nat
--         ⟩  




/-
  ## Rewriting
-/

structure Rewrite (Γ : Ctxt) (t : Ty) : Type where
  /-- The left-hand-side of a rewrite is the pattern being matched against -/
  lhs : ICom Γ t
  /-- The right-hand-side of a rewrite describes what a matched program will be rewritten to -/
  rhs : ICom Γ t
  /-- 
    We require that the left-hand-side of a rewrite uses all the variable in its context.
    This ensures that all variables of the right-hand-side are assigned after a succesfull match.
    Every well-behaved rewrite (i.e., rewrites where all variables of `rhs` also occur in `lhs`)
    can be made to satisfy this property by picking an appropriate context.
   -/
  complete : lhs.vars.IsComplete
  /-- A rewrite should preserve semantics -/
  preserves_semantics : lhs.denote = rhs.denote

def tryRewriteAtCursor {Γ Γ' Δ : Ctxt}
    (rw : Rewrite Γ' t) (lets : Lets Γ (Δ.snoc u)) (com : ICom (Δ.snoc u) t') : 
    Option (ICom Γ t') := do
  if h : u = t then
    let ⟨varsMap, _⟩ ← rw.lhs.toExprRec.matchAgainstLets lets rw.complete -- match
    let rhs := cast (by rw[h]) rw.rhs
    addProgramInMiddle (Ctxt.Var.last _ u) varsMap lets rhs com
  else
    none


def tryRewriteRecursive (rw : Rewrite Γ' t') (lets : Lets Γ Δ) : ICom Δ t → Option (ICom Γ t)
  | .ret _ => none
  | .lete e com =>
      let lets := Lets.lete lets e
      (tryRewriteAtCursor rw lets com).orElse fun _ =>
        tryRewriteRecursive rw lets com


/-- The size of a program is the number of let-bindings -/
def ICom.size : ICom Γ t → Nat
  | .ret _ => 0
  | .lete _ body => body.size + 1


/-- Advance the cursor `n` times -/
def LetZipper.advanceCursorN (zip : LetZipper Γ t) : Nat → LetZipper Γ t
  | 0   => zip
  | n+1 => advanceCursorN (zip.advanceCursor) n

/-- Return a cursor pointed directly *after* the `n`th let-binding -/
def ICom.splitAt (com : ICom Γ t) (n : Nat) : LetZipper Γ t :=
  LetZipper.ofICom com
    |>.advanceCursorN (n+1)


/-- Try to rewrite at the specified position.
    If a match is found, return the rewritten program
    Otherwise, return `none`
-/
def tryRewriteAtPos (rw : Rewrite Γ' t') (com : ICom Γ t) (pos : Nat) : Option (ICom Γ t) :=
  let ⟨lets, com⟩ := com.splitAt pos
  -- The following match seems superfluous, but it is needed because it asserts that the out context
  -- of `lets` is non-empty, and changes the types accordingly.
  match lets with
    | .nil => none
    | lets@(.lete _ _) => tryRewriteAtCursor rw lets com




/-
  ## Theorems
-/
  

theorem denote_tryRewriteAtCursor :
    tryRewriteAtCursor rw lets com = some com' → com'.denote = LetZipper.denote ⟨lets, com⟩ := by
  simp [tryRewriteAtCursor, Bind.bind, Option.bind]
  split_ifs
  next h =>
    cases h
    cases h_match : (IExprRec.matchAgainstLets lets (ICom.toExprRec rw.lhs) _)
    case none => simp
    case some res =>
      rcases res with ⟨varsMap, sem⟩
      simp at sem ⊢
      intro h; rw[←h]; clear h

      funext ll
      simp[LetZipper.denote, LetZipper.zip, addProgramInMiddle, denote_addLetsAtTop, denote_addProgramAtTop]
      congr
      funext t' v'
      split_ifs
      next h =>
        rcases h with ⟨⟨⟩, v_eq⟩
        simp only at v_eq 
        simp[←v_eq, sem, rw.preserves_semantics]
      next =>
        rfl
  next =>
    apply False.elim
      








