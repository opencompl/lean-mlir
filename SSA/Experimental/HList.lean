import Mathlib.Tactic.Basic
import Mathlib.Tactic.LibrarySearch


inductive HList {α : Type*} (f : α → Type*) : List α → Type _
  | nil : HList f []
  | cons {a : α} : (f a) → HList f as → HList f (a :: as)

namespace HList

variable {A B : α → Type*} {as : List α}

/-
  # Definitions
-/

def head : HList A (a :: as) → A a
  | .cons x _ => x

def tail : HList A (a :: as) → HList A as
  | .cons _ xs => xs

def map (f : ∀ (a : α), A a → B a) :
    ∀ {l : List α}, HList A l → HList B l
  | [],   .nil        => .nil
  | t::_, .cons a as  => .cons (f t a) (map f as)

def foldl {B : Type*} (f : ∀ (a : α), B → A a → B) :
    ∀ {l : List α}, B → HList A l → B
  | [],   b, .nil       => b
  | t::_, b, .cons a as => foldl f (f t b a) as

def get {as} : HList A as → (i : Fin as.length) → A (as.get i)
  | .nil, i => i.elim0
  | .cons x  _, ⟨0,   _⟩  => x
  | .cons _ xs, ⟨i+1, h⟩  => get xs ⟨i, Nat.succ_lt_succ_iff.mp h⟩


def ToTupleType (A : α → Type*) : List α → Type _
  | [] => PUnit
  | [a] => A a
  | a :: as => A a × (ToTupleType A as)

/-- 
  Turns a `HList A [a₁, a₂, ..., aₙ]` into a tuple `(A a₁) × (A a₂) × ... × (A aₙ)`
-/
def toTuple {as} : HList A as → ToTupleType A as
  | .nil => ⟨⟩
  | .cons x .nil => x
  | .cons x₁ <| .cons x₂ xs => (x₁, (cons x₂ xs).toTuple)

abbrev toSingle : HList A [a₁] → A a₁ := toTuple
abbrev toPair   : HList A [a₁, a₂] → A a₁ × A a₂ := toTuple
abbrev toTriple : HList A [a₁, a₂, a₃] → A a₁ × A a₂ × A a₃ := toTuple

/-
  # Theorems
-/

theorem map_map {A B C : α → Type*} {l : List α} (t : HList A l)
    (f : ∀ a, A a → B a) (g : ∀ a, B a → C a) :
    (t.map f).map g = t.map (fun a v => g a (f a v)) := by
  induction t <;> simp_all [map]

end HList