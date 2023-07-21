-- Investigations on asymptotic behavior of representing programs with large explicit contexts

-- import SSA.Experimental.IntrinsicAsymptotics.Ctxt
import SSA.Experimental.ErasedContext

noncomputable section

/-
  ## Datastructures
-/

/-- A very simple intrinsically typed expression. -/
inductive IExpr : Ctxt → Ty → Type
  | add (a b : Γ.Var .nat) : IExpr Γ .nat
  /-- Nat literals. -/
  | nat (n : Nat) : IExpr Γ .nat

/-- A very simple intrinsically typed program: a sequence of let bindings. -/
inductive ICom : Ctxt → Ty → Type where
  | ret {Γ : Ctxt} : Γ.Var t → ICom Γ t
  | lete (e : IExpr Γ α) (body : ICom (Γ.snoc α) β) : ICom Γ β

/-- A ExprRec is a (recursive) expression tree where the free variables are meta-variables -/
inductive IExprRec (Γ : Ctxt) : Ty → Type where
  | cst (n : Nat) : IExprRec Γ .nat
  | add (a : IExprRec Γ .nat) (b : IExprRec Γ .nat) : IExprRec Γ .nat
  | var (v : Γ.Var t) : IExprRec Γ t
  deriving DecidableEq

/-- `Lets Γ₁ Γ₂` is a sequence of lets which are well-formed under context `Γ₁` and result in 
    context `Γ₂`. The sequence grows downwards, so that each new let may refer to all existing lets
    (but not vice-versa), hence it grows the output context `Γ₂` -/
inductive Lets : Ctxt → Ctxt → Type where
  | nil {Γ : Ctxt} : Lets Γ Γ
  | lete (body : Lets Γ₁ Γ₂) (e : IExpr Γ₂ t) : Lets Γ₁ (Γ₂.snoc t)

/-- `RevLets' Γ₁ Γ₂` is a sequence of lets which are well-formed under context `Γ₁` and result in 
    context `Γ₁`. In contrast to `Lets`, this sequence grows upwards, so that each new let binds an
    free variable of the existing lets, i.e., it shrinks the input context `Γ₁`.
    Prefer `Lets` for APIs, `RevLets` may be used as an implementation detail.
-/
inductive RevLets : Ctxt → Ctxt → Type where
  | nil {Γ : Ctxt} : RevLets Γ Γ
  | lete (body : RevLets (Γ₁.snoc α) Γ₂) (e : IExpr Γ₁ t) : RevLets Γ₁ Γ₂

/-- A zipper representation of a program `ICom Γ t`, in terms of a prefix list of lets, and a suffix
    program. This represents a spefic position in the program, with `Δ` being the context at this
    position.
-/
structure LetZipper (Γ : Ctxt) (ty : Ty) where
  {Δ : Ctxt}
  lets : Lets Γ Δ 
  com : ICom Δ ty



/-!

  An implementation sketch of `rewrite`

  matching/rewriting is implemented on `LetZipper`, with ExprRecs being in the shape of trees (i.e., 
  `ExprRec`).

  Specifically, we call `advanceCursor` to move the cursor right, each time trying to match the ExprRec 
  against the prefix list `lets`.

  Now, because ExprRecs are tree-shaped, there are no free variables in the traditional sense, only
  meta-variables. So, we don't differentiate between a normal context, and a meta-context, we just
  parameterize the ExprRec by a `Ctxt` and `Ty`
com := z.com.changeVars (fun _ => Ctxt.Var.toSnoc)d `IExprRec Δ ty`.

  This concretized pattern can then be inserted into the zipper at the cursor position.
  Finally, `zip` is called to stitch the zipper back into an `ICom`
-/

/-
  ## Definitions
-/

def LetZipper.ofICom (com : ICom Γ t) : LetZipper Γ t :=
  ⟨.nil, com⟩

/-- Move a single let from `com` to `lets` -/
def LetZipper.advanceCursor (z : LetZipper Γ ty) : LetZipper Γ ty :=
  match z.com with
    | .lete e com => {
        lets := .lete z.lets e
        com := com
      }
    | .ret .. => z

def addLetsAtTop {Γ₁ Γ₂ : Ctxt} :
    (lets : Lets Γ₁ Γ₂) → (inputProg : ICom Γ₂ t₂) → ICom Γ₁ t₂
  | Lets.nil, inputProg => inputProg
  | Lets.lete body e, inputProg => 
    addLetsAtTop body (.lete e inputProg)

/-- Turn a `LetZipper` into the corresponding `ICom`  -/
def LetZipper.zip : LetZipper Γ t → ICom Γ t := 
  fun z => addLetsAtTop z.lets z.com






-- A simple first program
-- Observation: without the type annotation, we accumulate an exponentially large tree of nested contexts and `List.get`s.
-- By repeatedly referring to the last variable in the context, we force proof (time)s to grow linearly, resulting in
-- overall quadratic elaboration times.
-- def ex : ICom Array.empty .nat :=
--   ICom.let (.nat 0) <|
--   ICom.let (α := .nat) (.add ⟨⟨0, by decide⟩, by decide⟩ ⟨⟨0, by decide⟩, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨1, by decide⟩ ⟨1, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨2, by decide⟩ ⟨2, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨3, by decide⟩ ⟨3, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨4, by decide⟩ ⟨4, by decide⟩) <|
--   ICom.let (α := .nat) (.add ⟨5, by decide⟩ ⟨5, by decide⟩) <|
--   ICom.ret (.add ⟨0, by decide⟩ ⟨0, by decide⟩)





def IExpr.changeVars (varsMap : (t : Ty) → Γ.Var t → Option (Γ'.Var t)) : 
    (e : IExpr Γ ty) → Option (IExpr Γ' ty)
  | .nat n => some <| .nat n
  | .add a b => do 
      let a ← varsMap _ a
      let b ← varsMap _ b
      some <| .add a b


def ICom.changeVars 
    (varsMap : (t : Ty) → Γ.Var t → Option (Γ'.Var t)) : 
    ICom Γ ty → Option (ICom Γ' ty)
  | .ret e => do some <| .ret (←varsMap _ e)
  | .lete e body => do
      let e ← e.changeVars varsMap
      let body ← body.changeVars (fun t v => v.snocMap? varsMap)
      some <| .lete e body


-- Find a let somewhere in the program. Replace that let with
-- a sequence of lets each of which might refer to higher up variables.

/-- 
  Given a map from free variables of a program `rhs` to the free variables of another program 
  `inputProg`, append these programs together, while substituting the free variable `v` in 
  `inputProg` for the output of `rhs`.
  This map is allowed to be partial, to account for variables in the context that are not used.
  Returns `none` if any variable that is used is mapped to `none` -/
def addProgramAtTop {Γ Γ' : Ctxt} (v : Γ'.Var t₁)
    (map : (t : Ty) → Γ.Var t → Option (Γ'.Var t)) :
    (rhs : ICom Γ t₁) → (inputProg : ICom Γ' t₂) → Option (ICom Γ' t₂)
  | .ret e, inputProg => do
      let e ← map _ e
      inputProg.changeVars 
        (fun t' v' => 
          if h : ∃ h : t₁ = t', h ▸ v = v' 
          then h.fst ▸ e
          else v')
  | .lete e body, inputProg => do
      let inputProg ← inputProg.changeVars (fun _ v => some <| v.toSnoc) -- TODO: this operation is actually infallible, since the map is total. Maybe we want to have a separate (total) changeVars and (partial) changeVars?
      let newBody ← addProgramAtTop v.toSnoc
        (fun _ v => Ctxt.Var.snocMap? map _ v)
        body 
        inputProg
        
      let newExpr ← e.changeVars map
      some <| .lete newExpr newBody
      





def addProgramInMiddle {Γ₁ Γ₂ Γ₃ : Ctxt} (v : Γ₂.Var t₁)
    (map : (t : Ty) → Γ₃.Var t → Option (Γ₂.Var t))
    (l : Lets Γ₁ Γ₂) (rhs : ICom Γ₃ t₁) 
    (inputProg : ICom Γ₂ t₂) : Option (ICom Γ₁ t₂) := do
  addLetsAtTop l (←addProgramAtTop v map rhs inputProg)


def IExprRec.bind {Γ₁ Γ₂ : Ctxt} 
    (f : (t : Ty) → Γ₁.Var t → IExprRec Γ₂ t) : 
    (e : IExprRec Γ₁ t) → IExprRec Γ₂ t
  | .var v => f _ v
  | .cst n => .cst n
  | .add e₁ e₂ => .add (bind f e₁) (bind f e₂)

def IExpr.toExprRec : {Γ : Ctxt} → {t : Ty} → IExpr Γ t → IExprRec Γ t
  | _, _, .nat n => .cst n
  | _, _, .add e₁ e₂ => .add (.var e₁) (.var e₂)

def ICom.toExprRec : {Γ : Ctxt} → {t : Ty} → ICom Γ t → IExprRec Γ t
  | _, _, .ret e => .var e
  | _, _, .lete e body => 
    let e' := e.toExprRec
    body.toExprRec.bind 
    (fun t v => by
      cases v using Ctxt.Var.casesOn with
      | toSnoc v => exact .var v
      | last => exact e')



def IExprRec.varsBool : IExprRec Γ t → (t : Ty) → Γ.Var t → Bool
  | .var v, _, w   => v.1 = w.1
  | .cst _, _, _   => False
  | .add x y, _, w => x.varsBool _ w || y.varsBool _ w

/-- A set of variables of potentially different types -/
abbrev Ctxt.VarSet (Γ : Ctxt) : Type :=
  (t : Ty) → Set (Γ.Var t)

namespace Ctxt.VarSet
variable {Γ : Ctxt}

instance : Union Γ.VarSet where
  union V₁ V₂ := fun t => V₁ t ∪ V₂ t

instance : EmptyCollection Γ.VarSet where
  emptyCollection := fun _ => ∅

instance : Singleton (Σt, Γ.Var t) Γ.VarSet where
  singleton := fun v _ w => v.2.1 = w.1

instance : CoeOut (Γ.Var t) (Σt, Γ.Var t) where
  coe v := ⟨t, v⟩

end Ctxt.VarSet


def IExprRec.vars : IExprRec Γ t → Γ.VarSet :=
  fun e t v => e.varsBool t v

instance (e : IExprRec Γ t) (v : Γ.Var u) : Decidable (v ∈ e.vars _) := 
  inferInstanceAs <| Decidable (IExprRec.varsBool e _ v = true)


  


/-
  ## Matching
-/

def Mapping.Pair (Γ Δ : Ctxt) := Σ t, Γ.Var t × Δ.Var t

/-- `Mapping Γ Δ` is an incrementally built a mapping from variables in `Γ` to variables in `Δ` -/
def Mapping (Γ Δ : Ctxt) := List (Mapping.Pair Γ Δ)

/-- `map.insert v v'` asserts that `v` maps to `v'`
    * if `v` and `w` have different types, return `none`
    * if `v` is not present in the map yet, insert the pair `(v, v')` into the map
    * otherwise, if there is a pair `(v, w)`, with `v` on the left hand side, then 
        - return the map unchanged if `w = v'`, or
        - return `none` otherwise
-/
def Mapping.insert (map : Mapping Γ Δ) (v₁ : Γ.Var t₁) (v₂ : Δ.Var t₂) : Option (Mapping Γ Δ) :=
  if h : t₁ = t₂ then
    go map v₁ <| cast (by rw[h]) v₂
  else
    none
where
  go {t} (map : Mapping Γ Δ) (v₁ : Γ.Var t) (v₂ : Δ.Var t) : Option (Mapping Γ Δ) :=
  match map with
    | [] => some [⟨t, v₁, v₂⟩]
    | origMap@(⟨t', w₁, w₂⟩ :: map) =>
        if w₁.1 = v₁.1 then
          if w₂.1 = v₂.1 then
            some origMap
          else
            none          
        else
          (go map v₁ v₂).map (⟨t', w₁, w₂⟩ :: ·)

/-- The empty mapping -/
def Mapping.empty : Mapping Γ Δ := []

/--
  Create a new mapping, and add an assignment, after checking that the types match.
  This operation can fail, since the types might be different
-/
def Mapping.new (v₁ : Γ.Var t₁) (v₂ : Δ.Var t₂) : Option (Mapping Γ Δ) :=
  if h : t₁ = t₂ then
    let v₂ := cast (by rw[h]) v₂
    some [⟨t₁, v₁, v₂⟩]
  else
    none


/-- Lookup the assignment for a specific variable -/
def Mapping.lookup : Mapping Γ Δ → (t : Ty) → Γ.Var t → Option (Δ.Var t)
  | [],             _, _  => none
  | ⟨t, v, w⟩::map, t', v' =>
      if h : v.1 = v'.1 then
        have t_eq_t' := Ctxt.Var.type_eq_of_index_eq h
        some <| cast (by rw[t_eq_t']) w
      else
        lookup map t' v'


structure TotalMapping (Γ Δ : Ctxt) (V : Γ.VarSet) where
  inner : Mapping Γ Δ
  -- isTotal : ∀ t, ∀ v ∈ expr.vars, (inner.lookup t v).isSome
  isTotal : ∀ t, ∀ v ∈ V t, (inner.lookup t v).isSome

def TotalMapping.empty : TotalMapping Γ Δ ∅ :=
  ⟨[], by intros; contradiction⟩

/-- Every mapping is total for a constant, since a constant has no variables -/
def TotalMapping.cst (map : TotalMapping Γ Δ V) : 
    TotalMapping Γ Δ (V ∪ (IExprRec.cst n).vars) where
  inner := map.inner
  isTotal t v h := by 
    apply map.isTotal
    simp[Membership.mem, Set.Mem, IExprRec.vars, IExprRec.varsBool, Union.union, Set.union] at h
    apply h


/-- After `insert`ing a variable mapping, `lookup` is guaranteed to return `some` -/
theorem Mapping.lookup_insert (map mapInsert : Mapping Γ Δ) {v : Γ.Var t₁} (w : Δ.Var t₂)
    (h : map.insert v w = some mapInsert) :
    (mapInsert.lookup _ v).isSome := by
  unfold insert at h
  unfold Option.isSome
  split_ifs at h
  induction map generalizing mapInsert
  next =>
    simp only [insert.go, Option.some.injEq] at h 
    simp [←h, Option.isSome, lookup]
  next m map ih =>
    simp only [insert.go, Prod.mk.eta, Sigma.eta] at h    
    split_ifs at h <;> simp at h
    . cases h
      simp only [lookup]
      split_ifs
      rfl
    . rcases h with ⟨tl, ⟨h₁, ⟨⟩⟩⟩
      simp[lookup]
      split_ifs
      apply ih
      apply h₁

def TotalMapping.insert (map : TotalMapping Γ Δ V) (v : Γ.Var t₁) (w : Δ.Var t₂) : 
    Option (TotalMapping Γ Δ (V ∪ {⟨_, v⟩})) := 
  match hm : map.inner.insert v w with
    | .some mapI => some {
        inner := mapI
        isTotal := by 
          intro t' v' h
          rcases map with ⟨map, isTotal⟩          
          
          dsimp[IExprRec.vars, IExprRec.varsBool, Membership.mem, Set.Mem, Union.union, Set.union, 
                setOf] at h
          cases h
          next h => 
            sorry
          next h =>
            apply Mapping.lookup_insert map mapI w
            simp at h
            cases (Ctxt.Var.type_eq_of_index_eq h)
            rcases v with ⟨v, hv⟩
            rcases v' with ⟨v', hv'⟩
            cases h
            apply hm
      }
    | .none => none
      
def TotalMapping.coerceDomain {Γ : Ctxt} {V V' : Γ.VarSet} (h : V = V') : 
    TotalMapping Γ Δ V → TotalMapping Γ Δ V' 
  | ⟨inner, isTotal⟩ => ⟨inner, by simp_all⟩

def TotalMapping.optCoerceDomain {Γ : Ctxt} {V V' : Γ.VarSet} (h : V = V') : 
    Option (TotalMapping Γ Δ V) → Option (TotalMapping Γ Δ V') :=
  Option.map (coerceDomain h)


  


/-- We order a pair of variables by the index of the first variable -/
instance : Ord (Mapping.Pair Γ Δ) where
  compare := fun ⟨_, v, _⟩ ⟨_, w, _⟩ => compare v.1 w.1

/-- We order a pair of variables by the index of the first variable -/
instance : LE (Mapping.Pair Γ Δ) := leOfOrd

/--
  Check whether a `Mapping` is total (i.e., assigns something to each variable of the domain) by
  ordering the pairs by descending index of the first variable, and then checking that indeed each
  index is present.
  This requires the size of the domain to be known at runtime, hence we take a `SizedCtxt`.
-/
def Mapping.checkTotal {Γ : SizedCtxt} {Δ : Ctxt} (map : Mapping Γ Δ) : Bool :=
  let map := map.mergeSort GE.ge -- sort in descending order
  go Γ.size map
where
  go : Nat → Mapping Γ Δ → Bool
    | 0, [] => true
    | n+1, ⟨_, ⟨m, _⟩, _⟩ :: map => n = m && go n map
    | _, _ => false
   

structure GetVarResult (Γ₁ Γ₂ : Ctxt) (t : Ty) where
  {Δ : Ctxt}
  lets : Lets Γ₁ (Δ.snoc t) 
  embedVars : (t : Ty) → Δ.Var t → Γ₂.Var t 

def GetVarResult.coe_snoc : GetVarResult Γ₁ Γ₂ t → GetVarResult Γ₁ (Γ₂.snoc t') t
  | ⟨lets, embed⟩ => ⟨lets, fun t v => embed t v |>.toSnoc⟩

/-- Drop bindings from `lets` until the binding corresponding to `v` is at the head.
    This can fail, since `v` might be a free variable originating from `Γ₁`.
    Returns the new `lets`, plus a proof that it's context is a prefix of the original context -/
def Lets.getVar : {Γ₁ Γ₂ : Ctxt} → (lets : Lets Γ₁ Γ₂) → {t : Ty} →
    (v : Γ₂.Var t) → Option (GetVarResult Γ₁ Γ₂ t)
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
    Option (TotalMapping Γ' Δ matchExpr.vars) :=
  TotalMapping.optCoerceDomain (by 
    simp[Union.union, Set.union, EmptyCollection.emptyCollection, Membership.mem, Set.Mem]
    rfl
  ) <| 
    go lets matchExpr .empty (fun _ t => t)
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
                funext _ _
                simp[Membership.mem, Set.Mem, IExprRec.vars, IExprRec.varsBool, Union.union, Set.union, setOf]
                constructor
                . intro h; cases h
                  next h => exact Or.inl h
                  next h => exact Or.inr h

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
  (lhs rhs : ICom Γ t)

def tryRewriteAtCursor {Γ Γ' Δ : Ctxt}
    (rw : Rewrite Γ' t) (lets : Lets Γ (Δ.snoc u)) (com : ICom (Δ.snoc u) t') : 
    Option (ICom Γ t') := do
  if h : u = t then
    let map ← rw.lhs.toExprRec.matchAgainstLets lets -- match
    let rhs := cast (by rw[h]) rw.rhs
    addProgramInMiddle (Ctxt.Var.last _ u) (map.lookup) lets rhs com
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

     

#exit

-- let's automate
macro "mk_lets" n:num init:term : term =>
  n.getNat.foldRevM (fun n stx => `(ICom.let (α := .nat) (.nat ⟨$(Lean.quote n), by decide⟩) $stx)) init

macro "mk_com" n:num : term =>
`(show ICom [] .nat from
  ICom.let (.nat 0) <|
  mk_lets $n
  ICom.ret (.var ⟨0, by decide⟩))

macro "mk_ex" n:num : command =>
`(theorem t : ICom [] .nat :=
  mk_com $n)


-- type checking took 146ms
-- elaboration took 327ms
-- mk_ex 50
-- type checking took 574ms
-- elaboration took 1.41s
-- mk_ex 100
-- type checking took 911ms
-- elaboration took 2.26s
-- mk_ex 120

-- Clearly not linear!

-- Apart from proving transformations of specific (sub)programs, we are also interested in applying such
-- verified transformations to larger programs parsed at run time.

-- /-- An untyped expression as an intermediate step of input processing. -/

-- structure Absolute where
--   v : Nat
--   deriving Repr, Inhabited, DecidableEq

-- def Absolute.ofNat (n: Nat) : Absolute :=
--   {v := n}

-- instance : OfNat Absolute n where
--   ofNat := Absolute.ofNat n

-- abbrev VarRel := Nat

-- def formatVarRel : VarRel → Nat → Std.Format
--   | x, _ => repr x

-- instance : Repr VarRel where
--   reprPrec :=  formatVarRel

-- def VarRel.ofNat (n: Nat) : VarRel :=
--   n

-- instance : OfNat VarRel n where
-- --   ofNat := VarRel.ofNat n

-- inductive Expr : Type
--   | cst (n : Nat)
--   | add (a : VarRel) (b : VarRel)
--   deriving Repr, Inhabited, DecidableEq

-- abbrev LeafVar := Nat

-- inductive ExprRec : Type
--   | cst (n : Nat)
--   | add (a : ExprRec) (b : ExprRec)
--   | var (idx : LeafVar)
--   deriving Repr, Inhabited, DecidableEq

-- inductive RegTmp : Type
--   | concreteRegion (c : Com)
--   | regionVar (n : Nat)

-- /-- An untyped command; types are always given as in MLIR. -/
-- inductive Com : Type where
--   | let (ty : Ty) (e : Expr) (body : Com): Com
--   | ret (e : VarRel) : Com
--   deriving Repr, Inhabited, DecidableEq

-- def ex' : Com :=
--   Com.let .nat (.cst 0) <|
--   Com.let .nat (.add 0 0) <|
--   Com.let .nat (.add 1 0) <|
--   Com.let .nat (.add 2 0) <|
--   Com.let .nat (.add 3 3) <|
--   Com.let .nat (.add 4 4) <|
--   Com.let .nat (.add 5 5) <|
--   Com.ret 0

-- open Lean in

-- def formatCom : Com → Nat → Std.Format
--   | .ret v, _=> "  .ret " ++ (repr v)
--   | .let ty e body, n=> "  .let " ++ (repr ty) ++ " " ++ (repr e) ++ " <|\n" ++ (formatCom body n)

-- instance : Repr Com where
--   reprPrec :=  formatCom

-- abbrev Mapping := List (LeafVar × Nat)
-- abbrev Lets := List Expr

-- def ex0 : Com :=
--   Com.let .nat (.cst 0) <|
--   Com.let .nat (.add 0 0) <|
--   Com.let .nat (.add 1 0) <|
--   Com.let .nat (.add 2 0) <|
--   Com.let .nat (.add 3 0) <|
--   Com.ret 0

-- def getPos (v : VarRel) (currentPos: Nat) : Nat :=
--   v + currentPos + 1

/-- Apply `matchExpr` on a sequence of `lets` and return a `mapping` from
free variables to their absolute position in the lets array.
-/
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

-- example: matchVar [.add 2 0, .add 1 0, .add 0 0, .cst 1] 0
--          (.add (.var 0) (.add (.var 1) (.var 2))) =
--   some [(2, 2), (1, 3), (0, 3)]:= rfl

def getVarAfterMapping (var : LeafVar) (lets : Lets) (m : Mapping) (inputLets : Nat) : Nat :=
 match m with
 | x :: xs => if var = x.1 then
                 x.2 + (lets.length - inputLets)
              else
                 getVarAfterMapping var lets xs inputLets
 | _ => panic! "var should be in mapping"

def getRel (v : Nat) (array: List Expr): VarRel :=
  VarRel.ofNat (array.length - v - 1)

def applyMapping  (ExprRec : ExprRec) (m : Mapping) (lets : Lets) (inputLets : Nat := lets.length): (Lets × Nat) :=
match ExprRec with
    | .var v =>
      (lets, getVarAfterMapping v lets m inputLets)
    | .add a b =>
      let res := applyMapping a m lets inputLets
      let res2 := applyMapping b m (res.1) inputLets
      let l := VarRel.ofNat (res.2 + (res2.1.length - res.1.length))
      let r := VarRel.ofNat res2.2
      ((Expr.add l r) :: res2.1, 0)
    | .cst n => ((.cst n) :: lets, 0)

/-- shift variables after `pos` by `delta` -/
def shiftVarBy (v : VarRel) (delta : ℕ) (pos : ℕ) : VarRel :=
    if v >= pos then
      VarRel.ofNat (v + delta)
    else
      v

def Expr.changeVars (f : VarRel → VarRel) (e : Expr) : Expr :=
  match e with
  | .add a b => .add (f a) (f b)
  | .cst x => (.cst x)

/-- shift variables after `pos` by `delta` in expr -/
def shiftExprBy (e : Expr) (delta : ℕ) (pos : ℕ) : Expr :=
 match e with
    | .add a b => .add (shiftVarBy a delta pos) (shiftVarBy b delta pos)
    | .cst x => (.cst x)

def Com.changeVars (f : VarRel → VarRel) (c : Com) : Com :=
  match c with
  | .ret x => .ret (f x)
  | .let ty e body => .let ty (e.changeVars f) (body.changeVars f)

/-- shift variables after `pos` by `delta` in com -/
def shiftComBy (inputProg : Com) (delta : ℕ) (pos : ℕ := 0): Com :=
  match inputProg with
  | .ret x => .ret (shiftVarBy x delta (pos+1))
  | .let ty e body => .let ty (shiftExprBy e delta pos) (shiftComBy body delta (pos+1))

def VarRel.inc (v : VarRel) : VarRel :=
  v + 1

def replaceUsesOfVar (inputProg : Com) (old: VarRel) (new : VarRel) : Com :=
  let replace (v : VarRel) : VarRel :=
     if old = v then new else v
  match inputProg with
  | .ret x => .ret (replace x)
  | .let ty e body => match e with
    | .add a b =>
      .let ty (Expr.add (replace a) (replace b)) (replaceUsesOfVar body (old.inc) (new.inc))
    | .cst x => .let ty (.cst x) (replaceUsesOfVar body (old.inc) (new.inc))

def addLetsToProgram (newLets : Lets) (oldProgram : Com) : Com :=
  newLets.foldl (λ acc e => Com.let .nat e acc) oldProgram

/-- unfolding lemma for `addLetsToProgram` -/
theorem addLetsToProgram_cons (e : Expr) (ls : Lets) (c : Com) :
  addLetsToProgram (e :: ls) c = addLetsToProgram ls (Com.let .nat e c) := by {
    simp[addLetsToProgram]
}

/-- unfolding lemma for `addLetsToProgram` -/
theorem addLetsToProgram_snoc (e : Expr) (ls : Lets) (c : Com) :
  addLetsToProgram (List.concat ls e) c =
  Com.let .nat e (addLetsToProgram ls c) := by {
    simp[addLetsToProgram]
}

def applyRewrite (lets : Lets) (inputProg : Com) (rewrite: ExprRec × ExprRec) : Option Com := do
  let varPos := 0
  let mapping ← matchVar lets varPos rewrite.1
  let (newLets, newVar) := applyMapping (rewrite.2) mapping lets
  let newProgram := inputProg
  let newProgram := shiftComBy newProgram (newLets.length - lets.length)
  let newProgram := replaceUsesOfVar newProgram (VarRel.ofNat (newLets.length - lets.length)) (VarRel.ofNat (newVar))
  let newProgram := addLetsToProgram newLets newProgram

  some newProgram

def rewriteAt' (inputProg : Com) (depth : Nat) (lets: Lets) (rewrite: ExprRec × ExprRec) : Option Com :=
  match inputProg with
    | .ret _ => none
    | .let _ expr body =>
        let lets := expr :: lets
        if depth = 0 then
           applyRewrite lets body rewrite
        else
           rewriteAt' body (depth - 1) lets rewrite

def rewriteAt (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Option Com :=
    rewriteAt' inputProg depth [] rewrite

def rewrite (inputProg : Com) (depth : Nat) (rewrite: ExprRec × ExprRec) : Com :=
    let x := rewriteAt inputProg depth rewrite
    match x with
      | none => inputProg
      | some y => y

def getVal (s : State) (v : VarRel) : Nat :=
  get_nat (s.get! v)

def Expr.denote (e : Expr) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .add a b => .nat ((getVal s a) + (getVal s b))

def Com.denote (c : Com) (s : State) : Value :=
  match c with
    | .ret v => .nat (getVal s v)
    | .let _ e body => denote body (e.denote s :: s) -- introduce binder.

def denote (p: Com) : Value :=
  p.denote []

def Lets.denote (lets : Lets) (s : State := []): State :=
  List.foldr (λ v s => (v.denote s) :: s) s lets

structure ComFlat where
  lets : Lets -- sequence of let bindings.
  ret : VarRel -- return value.

def ComFlat.denote (prog: ComFlat) : Value :=
  let s := prog.lets.denote
  .nat (getVal s prog.ret)

def flatToTree (prog: ComFlat) : Com :=
  addLetsToProgram prog.lets (Com.ret prog.ret)

def ExprRec.denote (e : ExprRec) (s : State) : Value :=
  match e with
    | .cst n => .nat n
    | .add a b => let a_val := get_nat (a.denote s)
                     let b_val := get_nat (b.denote s)
                     Value.nat (a_val + b_val)
    | .var v => s.get! v

theorem key_lemma :
    (addLetsToProgram lets xs).denote s = xs.denote (lets.denote s) := by
  induction lets generalizing xs <;> simp_all [addLetsToProgram, Com.denote, Lets.denote]

theorem denoteFlatDenoteTree : denote (flatToTree flat) = flat.denote := by
  unfold flatToTree denote; simp [key_lemma]; rfl



theorem denoteVar_shift_zero: (shiftVarBy v 0 pos) = v := by
  simp[shiftVarBy]
  intros _H
  simp[VarRel.ofNat]


theorem denoteExpr_shift_zero: Expr.denote (shiftExprBy e 0 pos) s = Expr.denote e s := by  {
  induction e
  case cst => {
    simp[Expr.denote, shiftExprBy]
  }
  case add => {
    simp[Expr.denote, shiftExprBy, denoteVar_shift_zero]
  }
}

theorem denoteCom_shift_zero: Com.denote (shiftComBy com 0 pos) s = Com.denote com s := by {
 revert pos s
 induction com;
 case ret => {
   simp[Com.denote, denoteVar_shift_zero]
 }
 case _ ty e body IH => {
   simp[Com.denote]
   simp[IH]
   simp[denoteExpr_shift_zero]
 }
}

/-
theorem denoteCom_shift_snoc :
  Com.denote (addLetsToProgram (List.concat ls e) c) σ =
  Com.denote (addLetsToProgram ls c) () := by {
}
-/

/-
theorem denoteCom_shift_cons :
  Com.denote (addLetsToProgram (List.concat ls e) c) σ =
  Com.denote (addLetsToProgram ls c) () := by {
}
-/

/-- @sid: this theorem statement is wrong. I need to think properly about what shift is saying.
Anyway, proof outline: prove a theorem that tells us how the index changes when we add a single let
binding. Push the `denote` through and then rewrite across the single index change. -/
theorem shifting :
    Com.denote (addLetsToProgram lets (shiftComBy p (lets.length))) s =
      Com.denote p s := by
  rw [addLetsToProgram]
  induction lets using List.reverseRecOn
  case H0 =>
    cases p <;> simp [shiftComBy, shiftExprBy, Com.denote]

  
      
#exit

theorem letsTheorem
 (matchExpr : ExprRec) (lets : Lets)
 (h1: matchVar lets pos matchExpr m₀ = some m)
 (hlets: lets.length > 0)
 (hm₀: denote (addLetsToProgram lets (Com.ret (VarRel.ofNat (lets.length - pos - 1) ))) =
       denote (addLetsToProgram (applyMapping matchExpr m₀ lets).1
              (Com.ret 0))):

   denote (addLetsToProgram (lets) (Com.ret (VarRel.ofNat (lets.length - pos - 1)))) =
   denote (addLetsToProgram (applyMapping matchExpr m lets).1 (Com.ret 0)) := by
      induction matchExpr generalizing m₀ m pos
      unfold applyMapping
      case cst n =>
        simp [applyMapping, hm₀]

      case add a b a_ih b_ih =>
        simp [matchVar] at h1
        split at h1
        case h_1 x avar bvar heq =>
          erw [Option.bind_eq_some] at h1; rcases h1 with ⟨m_intermediate, ⟨h1, h2⟩⟩
          have a_fold := a_ih h1
          have b_fold := b_ih h2
          rw [hm₀]
          dsimp [VarRel.ofNat]

          unfold applyMapping
          sorry

        case h_2 x x' =>
          contradiction

      case var idx =>
        simp [applyMapping, hm₀]


-- We probably need to know 'Com.denote body env' is well formed. We want to say that if
-- body succeeds at env, then it succeeds in a larger env.
-- Actually this is not even true, we need to shift body.
-- @grosser: since this theorem cannot be true, we see that denoteAddLetsToProgram
-- also cannot possibly be true.
theorem Com_denote_invariant_under_extension_false_theorem :
   Com.denote body s = Com.denote  body (v :: s) := by {
   revert s
   induction body;
   case ret => {
    intros env; simp[Com.denote];
    simp[getVal];
    sorry
   }
   case _ => sorry
}

theorem denoteAddLetsToProgram:
  denote (addLetsToProgram lets body) = denote (addLetsToProgram lets (Com.let ty e body)) := by
  simp[denote]
  simp[key_lemma (lets := lets) (xs := body)]
  simp[key_lemma]
  simp[Com.denote]
  generalize H : (Lets.denote lets) = env'
  -- we know that this theorem must be false, because it asserts that
  -- ⊢ Com.denote body env' = Com.denote body (Expr.denote e env' :: env')
  -- but this is absurd, because if body were a variable, we need to at least shift the
  -- variables in the RHS.
  sorry -- The statement is likely not complete enough to be proven.


theorem rewriteAtApplyRewriteCorrect
 (hpos: pos = 0) :
 rewriteAt' body pos lets rwExpr = applyRewrite (lets ++ [e]) body rwExpr := by
  sorry

theorem rewriteAtAppend:
  rewriteAt' body pos lets rwExpr = rewriteAt' body (pos - 1) (lets ++ [e]) rwExpr := sorry

theorem rewriteAtCorrect'
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt' p pos lets rwExpr = some p'):
  denote p' = denote (addLetsToProgram lets p) := by
  induction pos
  case zero =>
    unfold rewriteAt' at successful
    split at successful
    · contradiction
    · simp at successful
      rename_i inputProg ty e body
      sorry
  sorry



theorem rewriteAtCorrect
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s)
  (lets : Lets) (successful : rewriteAt' p pos lets rwExpr = some p'):
  denote p' = denote (addLetsToProgram lets p) := by
  induction p
  case «let» ty e body body_ih =>
    unfold rewriteAt' at successful
    split at successful
    case inl hpos =>
      rw [body_ih]
      · rw [denoteAddLetsToProgram] --weak
      · rw [←successful]
        dsimp
        sorry
        -- rw [rewriteAtApplyRewriteCorrect] -- weak

    case inr hpos =>
      dsimp
      rw [body_ih]
      · rw [denoteAddLetsToProgram] -- weak
      · rw [←successful]
        dsimp
        simp at successful
        simp at body_ih
        simp_all
        unfold rewriteAt'
        simp
        cases body
        simp_all
        · simp_all
          sorry


        · simp_all
          contradiction
  case ret v =>
    unfold rewriteAt' at successful
    contradiction

theorem preservesSemantics
  (p : Com) (pos: Nat) (rwExpr : ExprRec × ExprRec)
  (rewriteCorrect : ∀ s : State, rwExpr.1.denote s = rwExpr.2.denote s):
  denote (rewrite p pos rwExpr) = denote p := by
  unfold rewrite
  unfold rewriteAt
  simp
  split
  · rfl
  · rw [rewriteAtCorrect (successful := by assumption)]
    simp [addLetsToProgram]
    apply rewriteCorrect

def ex1 : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.ret 0

def ex2 : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 1 1) <|
  Com.let .nat (.add 1 1) <|
  Com.ret 0

/-
def ex22 : ComFlat :=
  { lets := #[
     (.cst 1),
     (.add 0 0),
     (.add 1 0),
     (.add 1 1),
     (.add 1 1)]
   , ret := 0 }

#eval ex22.denote = denote ex2
-/


/-
def prog_map_before : Com :=
  %0 := cst [0, 1, 2] : !list
  %1 := map %0 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      yield %l2
  })

  %2 := map %1 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      yield %l2
  })

def prog_map_after : Com :=
  %0 := cst [0, 1, 2] : !list
  %2 := map %0 ({
    bb^(%l1)
      %l2 = addi %l1, 1
      %l3 = addi %l2, 1
      yield %l3
  })

def match_strip_mining := ExprRec.map (.map (.var 0) (.rgn 0)) (.rgn 1))

-/

theorem addLets: addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 0) = (
  Com.let .nat (Expr.cst 1) <|
  Com.let .nat (Expr.add 0 0) <|
  Com.ret 0) := rfl

theorem letsDenoteZero: Lets.denote [] = [] := rfl
theorem letsComDenoteZero: (addLetsToProgram [] (Com.ret 0)).denote [] = Value.nat 0 := rfl

theorem letsDenoteOne: Lets.denote [Expr.cst 0] [] = [Value.nat 0] := rfl
theorem letsComDenoteOne: (addLetsToProgram [Expr.cst 0] (Com.ret 0)).denote [] = Value.nat 0 := rfl

theorem letsDenoteTwo:
  Lets.denote [Expr.add 0 0, Expr.cst 1] [] = [Value.nat 2, Value.nat 1] := rfl

theorem letsComDenoteTwo:
  (addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 0)).denote [] = Value.nat 2 := by
  rfl
theorem letsComDenoteTwo':
  (addLetsToProgram [Expr.add 0 0, Expr.cst 1] (Com.ret 1)).denote [] = Value.nat 1 := by
  rfl

theorem letsDenoteThree:
  Lets.denote [Expr.cst 0, Expr.cst 1, Expr.cst 2] [] =
  [Value.nat 0, Value.nat 1, Value.nat 2] := rfl
theorem letsComDenoteThree:
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 0)).denote [] = Value.nat 0 := by
  rfl
theorem letsComDenoteThree':
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 1)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteThree'':
  (addLetsToProgram [Expr.cst 0, Expr.cst 1, Expr.cst 2] (Com.ret 2)).denote [] = Value.nat 2 := by
  rfl

theorem letsDenoteFour:
  Lets.denote [Expr.add 0 1, Expr.cst 3, Expr.cst 5, Expr.cst 7] [] =
  [Value.nat 8, Value.nat 3, Value.nat 5, Value.nat 7] := rfl
theorem letsComDenoteFour:
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 0)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteFour':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 1)).denote [] = Value.nat 0 := by
  rfl
theorem letsComDenoteFour'':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 2)).denote [] = Value.nat 1 := by
  rfl
theorem letsComDenoteFour''':
  (addLetsToProgram [Expr.add 0 1, Expr.cst 0, Expr.cst 1, Expr.cst 2, Expr.add 0 1] (Com.ret 3)).denote [] = Value.nat 2 := by
  rfl

def lets1 : Lets := [Expr.cst 1]
theorem letsDenote1: (addLetsToProgram lets1 xs).denote [] = xs.denote (lets1.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets2 : Lets := [Expr.cst 1, Expr.cst 2]
theorem letsDenote2: (addLetsToProgram lets2 xs).denote [] = xs.denote (lets2.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets3 : Lets := [Expr.cst 1, Expr.cst 2, Expr.cst 3]
theorem letsDenote3: (addLetsToProgram lets3 xs).denote [] = xs.denote (lets3.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

def lets4 : Lets := [Expr.cst 1, Expr.cst 2, Expr.cst 3, Expr.add 0 1]
theorem letsDenote4: (addLetsToProgram lets4 xs).denote [] = xs.denote (lets4.denote []) := by
  simp [Com.denote, Lets.denote, addLetsToProgram, Expr.denote, Com.denote]

-- a + b => b + a
def m := ExprRec.add (.var 0) (.var 1)
def r := ExprRec.add (.var 1) (.var 0)

def lets := [Expr.add 2 0, .add 1 0 , .add 0 0, .cst 1]
def m2 := ExprRec.add (.var 0) (.add (.var 1) (.var 2))

theorem mv3:
  matchVar lets 3 m = none := rfl

theorem mv2:
  matchVar lets 2 m = some [(1, 3), (0, 3)]:= rfl

theorem mv1:
  matchVar lets 1 m = some [(1, 2), (0, 3)]:= rfl

theorem mv0:
  matchVar lets 0 m = some [(1, 1), (0, 3)]:= rfl

theorem mv23:
  matchVar lets 3 m2 = none := rfl

theorem mv22:
  matchVar lets 2 m2 = none := rfl

theorem mv21:
  matchVar lets 1 m2 =
  some [(2, 3), (1, 3), (0, 3)] := rfl

theorem mv20:
  matchVar lets 0 m2 =
  some [(2, 2), (1, 3), (0, 3)]:= rfl

def testRewrite (p : Com) (r : ExprRec) (pos : Nat) : Com :=
  let new := rewriteAt p pos (m, r)
  dbg_trace "# Before"
  dbg_trace repr p
  match new with
    | none => (Com.ret 0) -- Failure
    | some y =>
      dbg_trace ""
      dbg_trace "# After"
      dbg_trace repr y
      dbg_trace ""
      y

example : rewriteAt ex1 1 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)    <|
     .let Ty.nat (Expr.add 0 0)  <|
     .let Ty.nat (Expr.add 1 1)  <|
     .ret 0) := by rfl
example : denote ex1 = denote (testRewrite ex1 r 1) := by rfl

-- a + b => b + a

example : rewriteAt ex2 0 (m, r) = none := by rfl
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

example : rewriteAt ex2 1 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 1) := by rfl

example : rewriteAt ex2 2 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 2) <|
     .let Ty.nat (Expr.add 2 2) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 2) := by rfl

example : rewriteAt ex2 3 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 2) <|
     .let Ty.nat (Expr.add 2 2) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 3) := by rfl

example : rewriteAt ex2 4 (m, r) = (
  Com.let Ty.nat (Expr.cst 1)   <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 2 2) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r 4) := by rfl

def ex2' : Com :=
  Com.let .nat (.cst 1) <|
  Com.let .nat (.add 0 0) <|
  Com.let .nat (.add 1 0) <|
  Com.let .nat (.add 1 1) <|
  Com.let .nat (.add 1 1) <|
  Com.ret 0

-- a + b => b + (0 + a)
def r2 := ExprRec.add (.var 1) (.add (.cst 0) (.var 0))

example : rewriteAt ex2 1 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 2) <|
     .let Ty.nat (Expr.add 3 0) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 1) := by rfl

example : rewriteAt ex2 2 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 3 0) <|
     .let Ty.nat (Expr.add 4 4) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 2) := by rfl

example : rewriteAt ex2 3 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 4 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 3) := by rfl

example : rewriteAt ex2 4 (m, r2) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r2 4) := by rfl

-- a + b => (0 + a) + b
def r3 := ExprRec.add (.add (.cst 0 ) (.var 0)) (.var 1)

example : rewriteAt ex2 1 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 2) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 1) := by rfl

example : rewriteAt ex2 2 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 4 4) <|
     .let Ty.nat (Expr.add 1 1) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 2) := by rfl

example : rewriteAt ex2 3 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 4) <|
     .let Ty.nat (Expr.add 4 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 3) := by rfl

example : rewriteAt ex2 4 (m, r3) = (
  Com.let Ty.nat (Expr.cst 1) <|
     .let Ty.nat (Expr.add 0 0) <|
     .let Ty.nat (Expr.add 1 0) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.add 1 1) <|
     .let Ty.nat (Expr.cst 0) <|
     .let Ty.nat (Expr.add 0 3) <|
     .let Ty.nat (Expr.add 0 4) <|
     .ret 0) := by rfl
example : denote ex2 = denote (testRewrite ex2 r3 4) := by rfl
 