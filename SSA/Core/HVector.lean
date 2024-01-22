import Mathlib.Tactic.Basic
import Mathlib.Tactic.LibrarySearch


/-- An heterogeneous vector -/
inductive HVector {α : Type*} (f : α → Type*) : List α → Type _
  | nil : HVector f []
  | cons {a : α} : (f a) → HVector f as → HVector f (a :: as)

namespace HVector

variable {A B : α → Type*} {as : List α}

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

end HVector
