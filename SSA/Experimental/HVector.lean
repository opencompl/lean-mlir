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

def head : HVector A (a :: as) → A a
  | .cons x _ => x

def tail : HVector A (a :: as) → HVector A as
  | .cons _ xs => xs

def map (f : ∀ (a : α), A a → B a) :
    ∀ {l : List α}, HVector A l → HVector B l
  | [],   .nil        => .nil
  | t::_, .cons a as  => .cons (f t a) (map f as)

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

/-
  # Theorems
-/

theorem map_map {A B C : α → Type*} {l : List α} (t : HVector A l)
    (f : ∀ a, A a → B a) (g : ∀ a, B a → C a) :
    (t.map f).map g = t.map (fun a v => g a (f a v)) := by
  induction t <;> simp_all [map]

end HVector