import Batteries.Data.Array.Pairwise
import Batteries.Data.Array.Merge
import Mathlib.Data.Fintype.Defs

structure OrdArray (α : Type) [LT α] where
  arr : Array α
  is_sorted : arr.Pairwise (· < ·)
deriving DecidableEq

section defs

variable {α : Type} [LT α] [Ord α] [∀ (x y : α), Decidable (x < y)]

def OrdArray.fromArray (a : Array α) : OrdArray α where
  arr := a.qsortOrd
  is_sorted := sorry -- missing API

def OrdArray.empty : OrdArray α where
  arr := Array.emptyWithCapacity 128
  is_sorted := by exact Array.pairwise_empty

def OrdArray.insertMany (xs ys : OrdArray α) : OrdArray α where
  arr := xs.arr.mergeDedup ys.arr
  is_sorted := sorry

def OrdArray.contains (xs : OrdArray α) (x : α) : Bool := xs.arr.binSearchContains x (· < ·)

instance : Membership α (OrdArray α) where
  mem xs x := xs.contains x

instance (x : α) (xs : OrdArray α) : Decidable (x ∈ xs) :=
  if h : xs.contains x then .isTrue h else .isFalse h

instance [Fintype α] [LT α] : Fintype (OrdArray α) :=
  sorry

instance [LT α] [BEq α] : BEq (OrdArray α) where
  beq xs ys := xs.arr == ys.arr

instance [LT α] [Hashable α] : Hashable (OrdArray α) where
  hash xs := hash xs.arr

instance [LT α] [BEq α] [LawfulBEq α] : LawfulBEq (OrdArray α) :=
  sorry
end defs
