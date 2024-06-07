/-
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Fin.Basic
import Mathlib.Data.Vector.Basic
import Cli
import Lean

@[simp]
def uncurry (f : α → β → γ) (pair : α × β) : γ := f pair.fst pair.snd

@[simp]
def pairBind [Monad m] (f : α → β → m γ) (pair : (m α × m β)) : m γ := do
  let fst ← pair.fst
  let snd ← pair.snd
  f fst snd

@[simp]
def tripleBind [Monad m] (f : α → β → γ → m δ) (triple : (m α × m β × m γ)) : m δ := do
  let (fstM,sndM,trdM) := triple
  let (fst,snd,trd) := (← fstM,← sndM,← trdM)
  f fst snd trd

@[simp]
def pairMapM [Monad m] (f : α → β → γ) (pair : (m α × m β)) : m γ := do
  let fst ← pair.fst
  let snd ← pair.snd
  return f fst snd

@[simp]
def tripleMapM [Monad m] (f : α → β → γ → δ) (triple : (m α × m β × m γ)) : m δ := do
  let (fstM,sndM,trdM) := triple
  let (fst,snd,trd) := (← fstM,← sndM,← trdM)
  return f fst snd trd

def Fin.coeLt {n m : Nat} : n ≤ m → Fin n → Fin m :=
  fun h i => match i with
    | ⟨i, h'⟩ => ⟨i, Nat.lt_of_lt_of_le h' h⟩


inductive LengthIndexedList (α : Type u) : Nat → Type u where
   | nil : LengthIndexedList α 0
   | cons : α → LengthIndexedList α n → LengthIndexedList α (n + 1)
  deriving Repr, DecidableEq

namespace LengthIndexedList

def fromList {α : Type u} (l : List α) : LengthIndexedList α (List.length l) :=
  match l with
  | [] => LengthIndexedList.nil
  | x :: xs => LengthIndexedList.cons x (LengthIndexedList.fromList xs)

def map {α β : Type u} (f : α → β) {n : Nat} : LengthIndexedList α n → LengthIndexedList β n
  | nil => nil
  | cons x xs => cons (f x) (map f xs)


@[simp]
def foldl {α β : Type u} {n : Nat} (f : β → α → β) (acc : β) : LengthIndexedList α n → β
  | nil => acc
  | cons x xs => LengthIndexedList.foldl f (f acc x) xs

@[simp]
def zipWith {α β γ : Type u} {n : Nat} (f : α → β → γ) :
    LengthIndexedList α n → LengthIndexedList β n → LengthIndexedList γ n
  | nil, nil => nil
  | cons x xs, cons y ys => cons (f x y) (zipWith f xs ys)

def nth {α : Type u} {n : Nat} (l : LengthIndexedList α n) (i : Fin n) : α :=
  match l, i with
  | LengthIndexedList.cons x _, ⟨0, _⟩ => x
  | LengthIndexedList.cons _ xs, ⟨i + 1, h⟩ => nth xs ⟨i, Nat.succ_lt_succ_iff.1 h⟩

instance : GetElem (LengthIndexedList α n) Nat α fun _xs i => LT.lt i n where
  getElem xs i h := nth xs ⟨i, h⟩

def NatEq {α : Type u} {n m : Nat} : n = m → LengthIndexedList α n → LengthIndexedList α m :=
  fun h l => match h, l with
    | rfl, l => l

def finRange (n : Nat) : LengthIndexedList (Fin n) n :=
  match n with
    | 0 => LengthIndexedList.nil
    | m + 1 =>
      let coeFun : Fin m → Fin (m + 1) := Fin.coeLt (Nat.le_succ m)
    LengthIndexedList.cons ⟨m, Nat.lt_succ_self m⟩ (LengthIndexedList.map coeFun (LengthIndexedList.finRange m))

end LengthIndexedList

elab "print_goal_as_error " : tactic => do
  let target ← Lean.Elab.Tactic.getMainTarget
  throwError target
  pure ()

-- TODO: should these go into Std?
def Vector.ofList {α : Type u} (l : List α) : Vector α l.length :=
⟨l, rfl⟩

def Vector.ofArray {α : Type u} (a : Array α) : Vector α a.size :=
 Vector.ofList a.data

instance [inst : Cli.ParseableType τ] {n : ℕ} : Cli.ParseableType (Vector τ n) where
  name := s!"Vector ({inst.name}) {n}"
  parse? str := do
    let arr : Array τ ← Cli.ParseableType.parse? str
    if h : arr.size = n then
      return h ▸ Vector.ofArray arr
    else
      none

/-- productsList [xs, ys] = [(x, y) for x in xs for y in ys],
extended to arbitary number of arrays. -/
def productsList : List (List α) -> List (List α)
| [] => [[]] -- empty product returns empty tuple.
| (xs::xss) => Id.run do
  let mut out := []
  let xss' := productsList xss -- make tuples of the other columns.
  for x in xs do  -- for every element in this column, take product with all other tuples.
    out := out.append (xss'.map (fun xs => x :: xs))
  return out

example : productsList [["a"], ["x", "y", "z"]] = [["a", "x"], ["a", "y"], ["a", "z"]] := rfl
example : productsList [["a"], ["p", "q"], ["x", "y", "z"]] =
  [["a", "p", "x"], ["a", "p", "y"], ["a", "p", "z"],
   ["a", "q", "x"], ["a", "q", "y"], ["a", "q", "z"]] := rfl

/-- Builds the cartesian product of all arrays in the input.
    Pretty inefficient right now, as it converts back and forth to lists... -/
def productsArr : Array (Array α) -> Array (Array α) :=
  fun arr =>
     let ls : List (List α) := List.map Array.toList ∘ Array.toList <| arr
     let prods := productsList ls
     List.map List.toArray prods |>.toArray
