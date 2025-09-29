import Blase.AutoStructs.ForMathlib
import Blase.FinEnum

structure NFA' (n : Nat) where
  σ : Type
  M : NFA (BitVec n) σ
  -- all reachable? complete? etc

namespace NFA'

/--
The encoded tuples of bit vectors accepted by an automaton.
-/
def accepts' (M : NFA' n) : Set (BitVecs' n) := M.M.accepts

/--
The tuples of bit vectors accepted by an automaton.
-/
def accepts (M : NFA' n) : Set (BitVecs n) := dec '' M.accepts'


noncomputable def complete (M : NFA' n) : NFA' n where
  σ := _
  M := M.M.complete


def product (final? : Prop → Prop → Prop) (M N : NFA' n) : NFA' n where
  σ := _
  M := M.M.product final? N.M

def inter (M N : NFA' n) : NFA' n := ⟨_, M.M.inter N.M⟩

lemma inter_eq (M N : NFA' n) : M.inter N = NFA'.product And M N := by
  simp [inter, product, NFA.inter]

@[simp]
lemma inter_accepts (M N : NFA' n) :
    (M.inter N).accepts = M.accepts ∩ N.accepts := by
  simp [accepts, accepts', inter, Set.image_inter dec_inj]

def union (M N : NFA' n) : NFA' n := ⟨_, M.M.union N.M⟩

lemma union_eq (M N : NFA' n) : M.union N = NFA'.product Or M.complete N.complete := by
  simp [union, product, NFA.union, NFA.union', complete]

@[simp]
lemma union_accepts (M N : NFA' n) :
    (M.union N).accepts = M.accepts ∪ N.accepts := by
  simp [accepts, accepts', union]; rw [Set.image_union]

def flipAccept (M : NFA' n) : NFA' n where
  σ := _
  M := M.M.flipAccept

def neg (M : NFA' n) : NFA' n where
  σ := _
  M := M.M.neg

@[simp]
lemma neg_accepts (M : NFA' n) :
    M.neg.accepts = M.acceptsᶜ:= by
  simp [accepts, accepts', neg, Set.image_compl_eq (dec_bij)]

def reduce (M : NFA' n) : NFA' n where
  σ := _
  M := M.M.reduce

@[simp]
lemma reduce_accepts {M : NFA' n} : M.reduce.accepts = M.accepts := by
  simp [reduce, accepts, accepts']


def determinize (M : NFA' n) : NFA' n where
  σ := _
  M := M.M.toDFA.toNFA

lemma neg_eq {M : NFA' n} : M.neg = M.determinize.flipAccept := by rfl

def reverse (M : NFA' n) : NFA' n where
  σ := _
  M := M.M.reverse

def lift (f : Fin n → Fin m) (M : NFA' n) : NFA' m where
  σ := _
  M := M.M.lift f

def proj (f : Fin m → Fin n) (M : NFA' n) : NFA' m where
  σ := _
  M := M.M.proj f

@[simp]
lemma lift_accepts (M : NFA' n) (f : Fin n → Fin m) :
    (M.lift f).accepts = BitVecs.transport f ⁻¹' M.accepts := by
  simp [accepts, accepts', lift]

@[simp]
lemma proj_accepts (M : NFA' m) (f : Fin n → Fin m) :
    (M.proj f).accepts = BitVecs.transport f '' M.accepts := by
  simp [accepts, accepts', proj]

end NFA'

class DecidableNFA' (M : NFA' α) [Fintype M.σ] [DecidableEq M.σ] [DecidableNFA M.M]
