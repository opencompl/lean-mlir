import SSA.Experimental.IntrinsicAsymptotics.Basic
import SSA.Experimental.IntrinsicAsymptotics.Semantics


/-!
  # Matching & Rewriting
-/ 

structure GetVarResult {Γ₁ Γ₂ : Ctxt} {t : Ty} (lets : Lets Γ₁ Γ₂) (v : Γ₂.Var t) where
  {Δ : Ctxt}
  lets : Lets Γ₁ (Δ.snoc t) 
  embedVars : (t : Ty) → Δ.Var t → Γ₂.Var t 
  -- semantics : ∀ (ll : Γ.Sem)

def GetVarResult.coe_snoc (lets : Lets Γ₁ Γ₂) (v : Γ₂.Var t) : 
    GetVarResult lets v → GetVarResult (.lete lets e) v.toSnoc
  | ⟨lets, embed⟩ => ⟨lets, fun t v => embed t v |>.toSnoc⟩

/-- Drop bindings from `lets` until the binding corresponding to `v` is at the head.
    This can fail, since `v` might be a free variable originating from `Γ₁`.
    Returns the new `lets`, plus a proof that it's context is a prefix of the original context -/
def Lets.getVar : {Γ₁ Γ₂ : Ctxt} → (lets : Lets Γ₁ Γ₂) → {t : Ty} →
    (v : Γ₂.Var t) → Option (GetVarResult lets v)
  | _, _, .nil, _, _ => none
  | Γ₁, _, lets@(@Lets.lete _ _ _ body _), _, v => by
    cases v using Ctxt.Var.casesOn with
    | last => exact some ⟨lets, fun _ => Ctxt.Var.toSnoc⟩ 
    | toSnoc v => exact (getVar body v).map (·.coe_snoc)



/--
  Given a sequence of `Lets`, try to match a pattern against the bottom-most let
  * If the match fails, return `none`
  * Otherwise, return an assignment of meta-variables of `matchExpr` to variables in `Δ`
-/
def IExprRec.matchAgainstLets {Γ Δ : Ctxt} (lets : Lets Γ Δ) (matchExpr : IExprRec Γ' t) : 
    Option (TotalMapping Γ' Δ matchExpr.vars) := do
  let res ← go lets matchExpr .empty (fun _ t => t)
  some <| res.coerceDomain <| by 
    simp[Union.union, Set.union, EmptyCollection.emptyCollection, Membership.mem, Set.Mem]
    rfl
where
  go {Γ Δ' t} (lets : Lets Γ Δ') (matchExpr : IExprRec Γ' t) {V : (t : Ty) → Set (Γ'.Var t)}
      (map : TotalMapping Γ' Δ V) (embedVars : (t : Ty) → Δ'.Var t → Δ.Var t) : 
      Option (TotalMapping Γ' Δ (fun t => V t ∪ (matchExpr.vars t))) :=
    match lets with
      | .nil => none
      | .lete lets e =>
        match matchExpr, e with
          | .var v, _ => do
              let map ← map.insert v (embedVars _ <| Ctxt.Var.last ..)
              return map.coerceDomain (by simp[IExprRec.vars, IExprRec.varsBool]; rfl)
          | .cst n, .nat m =>
              if n = m then
                some <| map.coerceDomain (by
                  simp[Membership.mem, Set.Mem, IExprRec.vars, IExprRec.varsBool, Union.union, Set.union]
                  rfl
                )
              else
                none
          | .add lhs rhs, .add v₁ v₂ => do
              /-
                Sketch: to match `lhs`, we drop just enough variables from `lets` so that the 
                declaration corresponding to `v₁` is at the head. Then, we recursively call 
                `matchAgainstLets` again.
              -/
              let ⟨lets₁, embed₁⟩ ← lets.getVar v₁
              let map ← go lets₁ lhs map (fun t v => 
                embedVars t <| (Ctxt.Var.snocMap embed₁) t v 
              )

              let ⟨lets₂, embed₂⟩ ← lets.getVar v₂
              let map ← go lets₂ rhs map (fun t v => 
                embedVars t <| (Ctxt.Var.snocMap embed₂) t v 
              )

              return map.coerceDomain <| by
                simp[Membership.mem, Set.Mem, IExprRec.vars, IExprRec.varsBool, Union.union,
                     Set.union, setOf, or_assoc]
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

def tryRewriteAtCursor {Γ Γ' Δ : Ctxt}
    (rw : Rewrite Γ' t) (lets : Lets Γ (Δ.snoc u)) (com : ICom (Δ.snoc u) t') : 
    Option (ICom Γ t') := do
  if h : u = t then
    let map ← rw.lhs.toExprRec.matchAgainstLets lets -- match
    let rhs := cast (by rw[h]) rw.rhs
    addProgramInMiddle (Ctxt.Var.last _ u) (map.lookup rw.complete) lets rhs com
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