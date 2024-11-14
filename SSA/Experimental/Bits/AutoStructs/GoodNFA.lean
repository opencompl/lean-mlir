import Batteries.Data.Fin.Basic
import Mathlib.Computability.NFA
import Mathlib.Data.FinEnum
import Mathlib.Data.Vector.Basic
import Mathlib.Data.Vector.Defs
import SSA.Experimental.Bits.AutoStructs.ForLean
import SSA.Experimental.Bits.AutoStructs.ForMathlib

structure GoodNFA (n : Nat) where
  σ : Type
  M : NFA (BitVec n) σ
  -- all reachable? complete? etc

namespace GoodNFA

/--
The encoded tuples of bit vectors accepted by an automaton.
-/
def accepts' (M : GoodNFA n) : Set (BitVecs' n) := M.M.accepts

/--
The tuples of bit vectors accepted by an automaton.
-/
def accepts (M : GoodNFA n) : Set (BitVecs n) := dec '' M.accepts'


noncomputable def complete (M : GoodNFA n) : GoodNFA n where
  σ := _
  M := M.M.complete


def product (final? : Prop → Prop → Prop) (M N : GoodNFA n) : GoodNFA n where
  σ := _
  M := M.M.product final? N.M

def inter (M N : GoodNFA n) : GoodNFA n := ⟨_, M.M.inter N.M⟩

lemma inter_eq (M N : GoodNFA n) : M.inter N = GoodNFA.product And M N := by
  simp [inter, product, NFA.inter]

@[simp]
lemma inter_accepts (M N : GoodNFA n) :
    (M.inter N).accepts = M.accepts ∩ N.accepts := by
  simp [accepts, accepts', inter, Set.image_inter dec_inj]

def union (M N : GoodNFA n) : GoodNFA n := ⟨_, M.M.union N.M⟩

lemma union_eq (M N : GoodNFA n) : M.union N = GoodNFA.product Or M.complete N.complete := by
  simp [union, product, NFA.union, NFA.union', complete]

@[simp]
lemma union_accepts (M N : GoodNFA n) :
    (M.union N).accepts = M.accepts ∪ N.accepts := by
  simp [accepts, accepts', union]; rw [Set.image_union]

def neg (M : GoodNFA n) : GoodNFA n where
  σ := _
  M := M.M.neg

@[simp]
lemma neg_accepts (M : GoodNFA n) :
    M.neg.accepts = M.acceptsᶜ:= by
  simp [accepts, accepts', neg, Set.image_compl_eq (dec_bij)]

def reduce (M : GoodNFA n) : GoodNFA n where
  σ := _
  M := M.M.reduce

@[simp]
lemma reduce_accepts {M : GoodNFA n} : M.reduce.accepts = M.accepts := by
  simp [reduce, accepts, accepts']


def determinize (M : GoodNFA n) : GoodNFA n where
  σ := _
  M := M.M.toDFA.toNFA

def lift (f : Fin n → Fin m) (M : GoodNFA n) : GoodNFA m where
  σ := _
  M := M.M.lift f

def proj (f : Fin m → Fin n) (M : GoodNFA n) : GoodNFA m where
  σ := _
  M := M.M.proj f

@[simp]
lemma lift_accepts (M : GoodNFA n) (f : Fin n → Fin m) :
    (M.lift f).accepts = BitVecs.transport f ⁻¹' M.accepts := by
  simp [accepts, accepts', lift]

@[simp]
lemma proj_accepts (M : GoodNFA m) (f : Fin n → Fin m) :
    (M.proj f).accepts = BitVecs.transport f '' M.accepts := by
  simp [accepts, accepts', proj]
