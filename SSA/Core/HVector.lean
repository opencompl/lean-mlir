/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Batteries.Tactic.Basic
import Mathlib.Tactic.TypeStar
import Qq

/-- An heterogeneous vector -/
inductive HVector {α : Type*} (f : α → Type*) : List α → Type _
  | nil : HVector f []
  | cons {a : α} : (f a) → HVector f as → HVector f (a :: as)

namespace HVector

variable {α : Type u} {A B : α → Type*} {as : List α}

/-
  # Definitions
-/

--TODO: this should be derived when this becomes possible
protected instance decidableEq [∀ a, DecidableEq (A a)] :
    ∀ {l : List α}, DecidableEq (HVector A l)
  | _, .nil, .nil => isTrue rfl
  | _, .cons x₁ v₁, .cons x₂ v₂ =>
    letI d := HVector.decidableEq v₁ v₂
    decidable_of_iff (x₁ = x₂ ∧ v₁ = v₂) (by simp)

def head : HVector A (a :: as) → A a
  | .cons x _ => x

def tail : HVector A (a :: as) → HVector A as
  | .cons _ xs => xs

def map (f : ∀ (a : α), A a → B a) :
    ∀ {l : List α}, HVector A l → HVector B l
  | [],   .nil        => .nil
  | t::_, .cons a as  => .cons (f t a) (map f as)

/-- An alternative to `map` which also maps a function over the index list -/
def map' {A : α → Type*} {B : β → Type*} (f' : α → β) (f : ∀ (a : α), A a → B (f' a)) :
    ∀ {l : List α}, HVector A l → HVector B (l.map f')
  | [],   .nil        => .nil
  | t::_, .cons a as  => .cons (f t a) (map' f' f as)

def foldl {B : Type*} (f : ∀ (a : α), B → A a → B) :
    ∀ {l : List α}, B → HVector A l → B
  | [],   b, .nil       => b
  | t::_, b, .cons a as => foldl f (f t b a) as

def get {as} : HVector A as → (i : Fin as.length) → A (as.get i)
  | .nil, i => i.elim0
  | .cons x  _, ⟨0,   _⟩  => x
  | .cons _ xs, ⟨i+1, h⟩  => get xs ⟨i, Nat.succ_lt_succ_iff.mp h⟩

/-- To be used as an auto-tactic to prove that the index of getN is within bounds -/
macro "hvector_get_elem_tactic" : tactic =>
  `(tactic|
      (
      simp [List.length]
      )
   )

/-- `x.getN i` indexes into a `HVector` with a `Nat`.

Note that we cannot define a proper instance of `GetElem` for `HVector`,
since `GetElem` requires us to specify a type `elem` such that `xs[i] : elem`,
but `elem` is *not* allowed to depend on the concrete index `i`.
Thus, `GetElem` does not properly support heterogeneous container types like `HVector`
-/
abbrev getN (x : HVector A as) (i : Nat) (hi : i < as.length := by hvector_get_elem_tactic) :
    A (as.get ⟨i, hi⟩) :=
  x.get ⟨i, hi⟩

def ToTupleType (A : α → Type*) : List α → Type _
  | [] => PUnit
  | [a] => A a
  | a :: as => A a × (ToTupleType A as)

/--
  Turns a `HVector A [a₁, a₂, ..., aₙ]` into a tuple `(A a₁) × (A a₂) × ... × (A aₙ)`
-/
def toTuple {as} : HVector A as → ToTupleType A as
  | .nil => ⟨⟩
  | .cons x .nil => x
  | .cons x₁ <| .cons x₂ xs => (x₁, (cons x₂ xs).toTuple)

abbrev toSingle : HVector A [a₁] → A a₁ := toTuple
abbrev toPair   : HVector A [a₁, a₂] → A a₁ × A a₂ := toTuple
abbrev toTriple : HVector A [a₁, a₂, a₃] → A a₁ × A a₂ × A a₃ := toTuple

section Repr
open Std (Format format)

private def reprInner [∀ a, Repr (f a)] (prec : Nat) : ∀ {as}, HVector f as → List Format
  | _, .nil => []
  | _, .cons x xs => (reprPrec x prec) :: (reprInner prec xs)

instance [∀ a, Repr (f a)] : Repr (HVector f as) where
  reprPrec xs prec := f!"[{(xs.reprInner prec).intersperse f!","}]"

end Repr

/-
  # Theorems
-/

theorem map_map {A B C : α → Type*} {l : List α} (t : HVector A l)
    (f : ∀ a, A a → B a) (g : ∀ a, B a → C a) :
    (t.map f).map g = t.map (fun a v => g a (f a v)) := by
  induction t <;> simp_all [map]

theorem eq_of_type_eq_nil {A : α → Type*} {l : List α}
    {t₁ t₂ : HVector A l} (h : l = []) : t₁ = t₂ := by
  cases h; cases t₁; cases t₂; rfl
syntax "[" withoutPosition(term,*) "]ₕ"  : term

@[simp]
theorem cons_get_zero {A : α → Type*} {a: α} {as : List α} {e : A a} {vec : HVector A as} :
   (HVector.cons e vec).get (@OfNat.ofNat (Fin (as.length + 1)) 0 Fin.instOfNat) = e := by
  rfl

-- Copied from core for List
macro_rules
  | `([ $elems,* ]ₕ) => do
    let rec expandListLit (i : Nat) (skip : Bool) (result : Lean.TSyntax `term) : Lean.MacroM Lean.Syntax := do
      match i, skip with
      | 0,   _     => pure result
      | i+1, true  => expandListLit i false result
      | i+1, false => expandListLit i true  (← ``(HVector.cons $(⟨elems.elemsAndSeps.get! i⟩) $result))
    if elems.elemsAndSeps.size < 64 then
      expandListLit elems.elemsAndSeps.size false (← ``(HVector.nil))
    else
      `(%[ $elems,* | List.nil ])

infixl:50 "::ₕ" => HVector.cons

/-
  # ToExpr
-/
section ToExpr
open Lean Qq

class ToExpr {α : Type u} (A : α → Type v) [∀ a, ToExpr (A a)] where
  /-- The expression representing `A` -/
  toTypeExpr : Expr

variable {A : α → Type v}

instance [Lean.ToExpr α] [∀ a, Lean.ToExpr (A a)] [HVector.ToExpr A]
    [Lean.ToLevel.{u}] [Lean.ToLevel.{v}] :
    Lean.ToExpr (HVector A as) :=
  let α := toTypeExpr α
  let AE := ToExpr.toTypeExpr A
  let us := [toLevel.{u}, toLevel.{v}]
  let rec toExpr : {as : List _} → HVector A as → Lean.Expr
  | [], .nil =>
    mkApp2 (.const ``HVector.nil us) α AE
  | a::as, .cons x xs =>
    let a := Lean.toExpr a
    let as := Lean.toExpr as
    let x := Lean.toExpr x
    let xs := toExpr xs
    mkApp6 (.const ``HVector.cons us) α AE as a x xs
  { toTypeExpr :=
      let as := Lean.toExpr as
      mkApp2 (.const ``HVector us) AE as
    toExpr }

end ToExpr


end HVector
