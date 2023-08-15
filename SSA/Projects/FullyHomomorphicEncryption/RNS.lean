import Mathlib.Data.Vector
import Mathlib.Data.ZMod.Basic
import Mathlib.Init.Function
import Std.Data.List.Lemmas

/-- RNS is Resuidue Number System. It decomposes  -/
abbrev RNS (m : Nat) := Vector Nat m

def RNS.toModulus {m : Nat} (n : RNS m) : Nat := n.val.foldl Nat.mul 1

/-- We use the notation of the paper, so the level is the logical definition
minus one -/
def RNS.level {m : Nat} (_ : RNS m) : Nat := m - 1

theorem RNS.level_length {m : Nat} (n : RNS m) : n.level = n.val.length - 1 := by
  rw [n.property, RNS.level]

-- confusing because of the off by one counting
def RNS.toLevel {m : Nat} (p : RNS m) (l : Nat) (h : l < m) : RNS (l+1) :=
  let h' : l+1 ≤ m := Nat.succ_le_of_lt h
  min_eq_left h' ▸ Vector.take (l+1) p

theorem RNS.toLevel_level {m : Nat} (p : RNS m) (l : Nat) (h : l < m) :
  (p.toLevel l h).level = l := by simp [level, toLevel]

def RNS.add {m : Nat} (p q : RNS m) : RNS m := Vector.map₂ Nat.add p q

def RNS.mul {m : Nat} (p q : RNS m) : RNS m := Vector.map₂ Nat.mul p q

-- Note: Using `Q` as a variable name to use the same notation as in the paper
def RNS.natMod {m : Nat} (x : Nat) (Q : RNS m) : RNS m :=
  Vector.map (fun q => x % q) Q


instance {n : Nat} : Add (RNS n) := ⟨RNS.add⟩
instance {n : Nat} : Mul (RNS n) := ⟨RNS.mul⟩
instance {n : Nat} : HMod Nat (RNS n) (RNS n) := ⟨RNS.natMod⟩

def RNS.pairwiseCoprime {m : Nat} (Q : RNS m) : Prop :=
  ∀ i j : Fin m, i ≠ j → Nat.coprime (Q.get i) (Q.get j)

def RNS.get {m : Nat} (p : RNS m) (i : Fin m) : Nat := Vector.get p i

-- how can this be well-typed? \bigtimes_{i = 1}^m Z_{q_i}
-- Needs some sort of heterogeneous vector
-- abbrev RNSMod (m : Nat) (Q : RNS m) := Vector (ZMod Q.toModulus) m

inductive HList {α : Type v} (β : α → Type u) : List α → Type (max u v)
  | nil  : HList β []
  | cons : β i → HList β is → HList β (i::is)
infix:67 " :: " => HList.cons

theorem List.range_isLt (n : Nat) : ∀ i ∈ List.range n, i < n := by
  intro i h
  apply List.mem_range.mp h

def List.rangeFin (n : Nat) : List (Fin n) := sorry -- should be List.range n

/-- RNSMod is the elementwise modulo of an RNS, i.e. $\bigtimes_{i = 1}^m Z_{q_i}$ -/
abbrev RNSMod {m : Nat} (Q : RNS m) := HList (fun i : Fin m => ZMod (Q.get i)) (List.rangeFin m)

-- do we care?
theorem RNS.natMod_bijective {m : Nat} (Q : RNS m)
  : Function.Bijective (fun (x : Fin Q.toModulus) => x.val % Q) := sorry

theorem RNS.chineseRemainder {m : Nat} (Q : RNS m) (h : Q.pairwiseCoprime) : RNSMod Q ≃+* ZMod Q.toModulus := sorry -- use
