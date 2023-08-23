import Mathlib.Tactic.Basic


inductive HList {α : Type*} (f : α → Type*) : List α → Type _
  | nil : HList f []
  | cons {a : α} : (f a) → HList f as → HList f (a :: as)

namespace HList

/-
  # Definitions
-/

def map {A B : α → Type*} (f : ∀ (a : α), A a → B a) :
    ∀ {l : List α}, HList A l → HList B l
  | [], .nil => .nil
  | t::_, .cons a as => .cons (f t a) (map f as)

def foldl {A : α → Type*} {B : Type*} (f : ∀ (a : α), B → A a → B) :
    ∀ {l : List α}, B → HList A l → B
  | [], b, .nil => b
  | t::_, b, .cons a as => foldl f (f t b a) as

/-
  # Theorems
-/

theorem map_map {A B C : α → Type*} {l : List α} (t : HList A l)
    (f : ∀ a, A a → B a) (g : ∀ a, B a → C a) :
    (t.map f).map g = t.map (fun a v => g a (f a v)) := by
  induction t <;> simp_all [map]

end HList