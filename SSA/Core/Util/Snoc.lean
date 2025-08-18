import Lean

/-!
# Generic cons & snoc notation

This file sets up generic, typeclass-driven `:>` and `:<` notations for adding
an element to the front (resp. end) of an ordered, potentially heterogenous,
collection, also known as `cons` and `snoc`.

The specific notation chosen is inspired by Idris2.
-/

/-! ## Cons -/
/--
Heterogeneous snoc operation, for adding an element to the front of an ordered
collection.

- `γ` is the type of the collection
- `β : α → Type _` is a type function whose codomain are the types which can
    be prepended to the collection. We phrase it in this way, rather than having
    a separate `HCons` instance for each prepend-able type, so that `β` can be
    an outParam, which helps type inference.
- `γ'` is the type of the resulting collection
-/
class HCons (γ : Type u₁) {α : outParam (Type u₂)} (β : outParam (α → Type u₃)) (γ' : outParam (α → Type u₁)) where
  /-- Add an element to the front of an ordered collection. -/
  hCons {a : α} : β a → γ → γ' a

attribute [match_pattern] HCons.hCons

/-!
NOTE: we implement a custom elaborator for the `:>` notation so that type
inference is properly guided by the outParams of the `HCons` instance.

If we use a plain `infix_` notation, then there are occurences where `γ'` or `β`
will be (wrongly) inferred before synthesis, which then means that typeclass
synthesis fails. Thus, the elaborator below ensures that only `γ` is inferred,
before synthesis, and all other types are guided by the canonical `HCons γ ..`
instance.
-/
open Lean Meta Elab.Term in
@[inherit_doc HCons.hCons]
elab x:term:50 " :> " xs:term:51 : term => do
  let xs ← elabTerm xs none
  let γ ← inferType xs
  let α ← mkFreshExprMVar none
  let β ← mkFreshExprMVar none
  let γ' ← mkFreshExprMVar none
  let us ← mkFreshLevelMVars 3
  let inst ← synthInstance <| mkApp4 (.const ``HCons us) γ α β γ'
  let a ← mkFreshExprMVar α
  let x ← elabTermEnsuringType x (mkApp β a)

  return mkAppN (.const ``HCons.hCons us) #[γ, α, β, γ', inst, a, x, xs]

/-- Homogenous cons operation; this is a convenience wrapper for defining an
`HCons` instance without all the generality. -/
class Cons (α : Type u) (β : outParam (Type v)) where
  cons : β → α → α

-- Snoc implies HSnoc
instance [Cons α β] : HCons α (fun () => β) (fun () => α) where
  hCons xs x := Cons.cons xs x

/-! ## Snoc -/

/--
Heterogeneous snoc operation, for adding an element to the end of an ordered
collection.

- `γ` is the type of the collection
- `β : α → Type _` is a type function whose codomain are the types which can
    be appended to the collection. We phrase it in this way, rather than having
    a separate `HSnoc` instance for each append-able type, so that `β` can be
    an outParam, which helps type inference.
- `γ'` is the type of the resulting collection
-/
class HSnoc (γ : Type u₁) {α : outParam (Type u₂)} (β : outParam (α → Type u₃))
    (γ' : outParam (α → Type u₁)) where
  hSnoc {a : α} : γ → β a → γ' a

infixl:50 " :< " => HSnoc.hSnoc

/-- Homogenous snoc operation; this is a convenience wrapper for defining an
`HSnoc` instance without all the generality. -/
class Snoc (α : Type u) (β : outParam (Type v)) where
  snoc : α → β → α

-- Snoc implies HSnoc
instance [Snoc α β] : HSnoc α (fun () => β) (fun () => α) where
  hSnoc xs x := Snoc.snoc xs x


/-! ### Instances on existing types -/
section Instances

instance : Snoc (List α) α where
  snoc := List.concat
instance : HSnoc (Vector α n) (fun () => α) (fun () => Vector α (n+1)) where
  hSnoc := Vector.push

end Instances

instance : HSnoc (Vector α n) (fun () => α) (fun () => Vector α (n+1)) where
  hSnoc := Vector.push
